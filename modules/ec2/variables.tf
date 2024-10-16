variable "ami" {
  type        = string
}

variable "instance_type" {
  type        = string
}

variable "key_name" {
  type        = string
}

variable "vpc_security_group_ids" {
  type        = list(string)
}

variable "subnet_id" {
  type        = string
}

variable "tags_ec2" {
  type        = map(string)
  default     = {}
}
