variable "cidr_block" {
  type        = string
  default     = ""
  description = "Máscara da vpc"
}

variable "id" {
  type        = string
  default     = ""
  description = "id da vpc"
}

variable "enable_dns_support" {
  description = "Enable DNS resolution support for the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}