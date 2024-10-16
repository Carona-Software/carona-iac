variable "subnet_id" {
  type        = string
}

variable "route_table_id" {
  type        = string
}

variable "tags_association_tr_subnet" {
  type        = map(string)
  default     = {}
}
