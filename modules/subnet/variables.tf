variable "cidr_block" {
  type        = string
  default     = ""
  description = "Máscara da subnet pública"
}

variable "vpc_id" {
  type        = string
  default     = ""
  description = "Referência ao id da vpc"
}

variable "tags_subnet" {
  type        = map(string)
  default     = {}
}
