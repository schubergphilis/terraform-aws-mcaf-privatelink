output "private_dns_name" {
  value       = aws_vpc_endpoint_service.default.private_dns_name_configuration[0].name
  description = "Name of the private DNS to access the service"
}
