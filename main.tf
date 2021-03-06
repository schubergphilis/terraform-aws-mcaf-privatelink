locals {
  tags = merge({ Name = "${var.name}-privatelink" }, var.tags)
}

resource "aws_lb" "default" {
  name               = "${var.name}-nlb-privatelink"
  internal           = true
  load_balancer_type = "network"
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
  name        = "${var.name}-privatelink"
  port        = var.target_port
  protocol    = var.target_protocol
  tags        = local.tags
  target_type = "ip"
  vpc_id      = var.vpc_id
}

resource "aws_lb_target_group_attachment" "default" {
  for_each = toset(var.target_ips)

  port             = var.target_port
  target_group_arn = aws_lb_target_group.default.arn
  target_id        = each.key
}

resource "aws_vpc_endpoint_service" "default" {
  acceptance_required        = true
  allowed_principals         = var.allowed_principals
  network_load_balancer_arns = [aws_lb.default.arn]
  private_dns_name           = var.private_dns_name

  tags = {
    "Name" = var.name
  }
}

resource "aws_route53_record" "default" {
  count = var.private_dns_name != null ? 1 : 0

  name            = aws_vpc_endpoint_service.default.private_dns_name_configuration[0].name
  allow_overwrite = true
  ttl             = 1800
  type            = aws_vpc_endpoint_service.default.private_dns_name_configuration[0].type
  zone_id         = var.zone_id

  records = [
    aws_vpc_endpoint_service.default.private_dns_name_configuration[0].value
  ]
}
