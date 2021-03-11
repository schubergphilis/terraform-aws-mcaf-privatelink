variable "allowed_principals" {
  type        = list(string)
  description = "List of allowed AWS principals to access the endpoint service"
}

variable "domain_name" {
  type        = string
  description = "Domain name to use for the private DNS name"
}

variable "name" {
  type        = string
  description = "Name to use for the PrivateLink resources"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs assigned to the network load balancer"
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resources"
}

variable "target_ips" {
  type        = list(string)
  description = "A list of target IP addresses of the endpoint service"
}

variable "target_port" {
  type        = number
  description = "The target port of the endpoint service"
}

variable "target_protocol" {
  type        = string
  default     = "TCP"
  description = "The target protocol of the endpoint service"
}

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC"
}

variable "zone_id" {
  type        = string
  description = "The ID of the DNS Zone"
}
