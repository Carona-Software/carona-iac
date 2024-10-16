variable "vpc_id" {
  type        = string
}

variable "tags_rt" {
  type        = map(string)
  default     = {}
}
