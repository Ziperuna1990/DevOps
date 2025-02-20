variable "vpc_name" {
  type        = string
}

variable "cidr_block" {
  type        = string
}

variable "azs" {
  type        = list(string)
}

variable "private_subnets" {
  type        = list(string)
}

#variable "enable_internet_gateway" {
#  type        = bool
#  default     = true
#}

variable "tags" {
  type        = map(string)
  default     = {}
}