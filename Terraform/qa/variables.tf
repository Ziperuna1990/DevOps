variable "on_prem_vpc_name" {
  type = string
}

variable "cloud_vpc_name" {
  type = string
}

variable "on_prem_vpc_cidr" {
  type = string
}

variable "cloud_vpc_cidr" {
  type = string
}

variable "on_prem_az" {
  type = list(string)
}

variable "cloud_az" {
  type = list(string)
}

variable "on_prem_private_subnets" {
  type = list(string)
}

variable "cloud_private_subnets" {
  type = list(string)
}

variable "region" {
  type = string
  default = "us-east-1"
}

variable "jenkins_server_ami" {
  type = string
  description = "AMI code for Jenkins ec2 server"
}

variable "backend_server_ami" {
  type = string
  description = "AMI code for backend ec2 server"
}

variable "jenkins_server_instance_type" {
  type = string
  description = "Type of instance fro Jenkins"
}

variable "backend_instance_type" {
  type = string
  description = "Type of instance for Backend"
}

variable "backend_instance_name" {
  type = string
  description = "backend instance name"
}

variable "jenkins_server_instance_name" {
  type = string
  description = "instance name"
}

variable "rds_name" {
  type = string
}

#variable "env" {
#  type = string
#  description = "ENV"  
#}