variable "allowed_principals" {
  type        = list(string)
  description = "List of allowed AWS principals to access the PrivateLink endpoint service"
}

variable "domain_name" {
  type        = string
  description = "Domain name of the DNS Zone to use for the private DNS name"
}

variable "zone_id" {
  type        = string
  description = "ID of the DNS Zone"
}

variable "name" {
  type        = string
  description = "Name to use for the PrivateLink resources"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs assigned to the Network Load Balancer"
}

variable "target_ip" {
  default     = null
  description = "The target IP address of the service shared using PrivateLink"
  type        = string
}

variable "target_port" {
  type        = number
  description = "The target port of the service shared using PrivateLink"
}

variable "target_protocol" {
  default     = "TCP"
  description = "The target protocol of the service shared using PrivateLink"
  type        = string
}

variable "target_security_group_id" {
  description = "The target security group ID used to find the ENI of the service shared using PrivateLink"
  type        = string
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resources"
}

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC"
}
