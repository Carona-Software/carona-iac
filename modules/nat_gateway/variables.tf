variable "allocation_id" {
  type        = string
  default     = ""
  description = "IP público do NAT gateway de acesso à internet"
}

variable "subnet_id" {
  type        = string
  default     = ""
  description = "ID da subnet para associação"
}
