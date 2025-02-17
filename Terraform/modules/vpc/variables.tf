variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "private_subnets" {
  description = "Map of private subnets to create"
  type = map(object({
    cidr              = string
    availability_zone = string
  }))
}

variable "availability_zones" {
  description = "Availability zone for the subnet"
  type        = string
}

variable "environment" {
  description = "env type"
  type        = string
}

variable "vpc_name" {
  type = string
  description = "Name of the VPC"
}