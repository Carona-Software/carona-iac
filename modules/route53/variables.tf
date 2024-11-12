variable "domain_name" {
  description = "The domain name for the Route 53 zone"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "private_ip_address" {
  description = "The private IP address for the A record"
  type        = string
}
