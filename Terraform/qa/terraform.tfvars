on_prem_vpc_cidr = "10.0.0.0/16"
cloud_vpc_cidr   = "10.1.0.0/16"


on_prem_az = ["us-east-1a", "us-east-1b"]

cloud_az = ["us-east-1a" , "us-east-1b"]

on_prem_private_subnets = ["10.0.1.0/24","10.0.2.0/24"]

cloud_private_subnets = ["10.1.1.0/24","10.1.2.0/24"]

on_prem_vpc_name = "on_prem_vpc"
cloud_vpc_name   = "cloud_vpc"

region = "us-east-1"

#Jenkins
jenkins_server_ami = "ami-0f9575d3d509bae0c"
jenkins_server_instance_type = "t2.micro"
jenkins_server_instance_name = "jenkins_server"

#Backend server
backend_server_ami = "ami-0f9575d3d509bae0c"
backend_instance_type = "t2.micro"
backend_instance_name = "backend_server"

#env = "qa"