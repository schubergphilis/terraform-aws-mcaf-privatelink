locals {
  tags                    = merge({ Name = "${var.name}-privatelink" }, var.tags)
  use_target_ip_or_eni_ip = var.target_ip != null ? var.target_ip : data.aws_network_interface.default[0].private_ip
}

resource "aws_lb" "default" {
  internal           = true
  load_balancer_type = "network"
  name               = "${var.name}-nlb"
  subnets            = var.private_subnet_ids
  tags               = local.tags
}

resource "aws_lb_listener" "default" {
  load_balancer_arn = aws_lb.default.arn
  port              = var.target_port
  protocol          = var.target_protocol

  default_action {
    target_group_arn = aws_lb_target_group.default.arn
    type             = "forward"
  }
}

resource "aws_lb_target_group" "default" {
  name        = var.name
  port        = var.target_port
  protocol    = var.target_protocol
  tags        = local.tags
  target_type = "ip"
  vpc_id      = var.vpc_id
}

data "aws_network_interface" "default" {
  count = var.target_ip != null ? 0 : 1

  filter {
    name   = "group-id" # security group id
    values = [var.target_security_group_id]
  }
}

resource "aws_lb_target_group_attachment" "default" {
  port             = var.target_port
  target_group_arn = aws_lb_target_group.default.arn
  target_id        = local.use_target_ip_or_eni_ip
}

resource "aws_vpc_endpoint_service" "default" {
  acceptance_required        = true
  allowed_principals         = var.allowed_principals
  network_load_balancer_arns = [aws_lb.default.arn]
  private_dns_name           = "${var.name}.${var.domain_name}"
}

resource "aws_route53_record" "default" {
  allow_overwrite = true
  name            = aws_vpc_endpoint_service.default.private_dns_name_configuration[0].name
  ttl             = 1800
  type            = aws_vpc_endpoint_service.default.private_dns_name_configuration[0].type
  zone_id         = var.zone_id

  records = [
    aws_vpc_endpoint_service.default.private_dns_name_configuration[0].value
  ]
}
