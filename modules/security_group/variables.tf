variable "name" {
  type        = string
}

variable "description" {
  type        = string
  default     = ""
}

variable "vpc_id" {
  type        = string
}

variable "ingress" {
  type = list(object({
    from_port          = number
    to_port            = number
    protocol           = string
    cidr_blocks        = list(string)
    description        = optional(string)  # Descrição opcional
    ipv6_cidr_blocks   = list(string)  # Deixe vazio se não for necessário
    prefix_list_ids    = list(string) # Deixe vazio se não for necessário
    security_groups     = list(string)  # Deixe vazio se não for necessário
    self                = bool  # Ou true, se a regra se aplica a este grupo
  }))
}

variable "egress" {
  type = list(object({
    from_port          = number
    to_port            = number
    protocol           = string
    cidr_blocks        = list(string)
    description        = optional(string)  # Descrição opcional
    ipv6_cidr_blocks   = list(string)  # Deixe vazio se não for necessário
    prefix_list_ids    = list(string) # Deixe vazio se não for necessário
    security_groups     = list(string) # Deixe vazio se não for necessário
    self                = bool# Ou true, se a regra se aplica a este grupo
  }))
}

variable "tags_security_group" {
  type        = map(string)
  default = {}
}
