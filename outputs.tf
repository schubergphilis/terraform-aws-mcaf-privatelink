output "private_dns_name" {
  value       = aws_vpc_endpoint_service.default.private_dns_name
  description = "Name of the private DNS to access the service"
}

output "service_name" {
  value       = aws_vpc_endpoint_service.default.service_name
  description = "Service name of the Endpoint Service"
}
