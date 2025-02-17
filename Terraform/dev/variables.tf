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

variable "jenkins_server_instance_name" {
  type = string
  description = "instance name"
}

variable "env" {
  type = string
  description = "ENV"  
}

variable "on_prem_cidr" {
  default = "10.0.0.0/16"
}

variable "cloud_cidr" {
  default = "10.1.0.0/16"
}

variable "availability_zones" {
  default = ["us-east-1a"]
}