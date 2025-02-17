module "on_prem_vpc" {
  source = "../../modules/vpc"

  vpc_cidr = var.on_prem_cidr
  vpc_name = "On-Premises-VPC-Dev"

  private_subnets = {
    subnet1 = {
      cidr              = "10.0.1.0/24"
      availability_zone = "us-east-1a"
    }
  }
}

module "cloud_vpc" {
  source = "../../modules/vpc"

  vpc_cidr = var.cloud_cidr
  vpc_name = "Cloud-VPC-Dev"

  private_subnets = {
    subnet1 = {
      cidr              = "10.0.1.0/24"
      availability_zone = "us-east-1a"
    }
  }
}

resource "aws_vpc_peering_connection" "vpc_peering" {
  vpc_id      = module.on_prem_cidr.vpc_id
  peer_vpc_id = module.cloud_vpc.vpc_id

  auto_accept = false

  tags = {
    Name = "VPC-Peering-Connection"
  }
}

resource "aws_vpc_peering_connection_options" "vpc1_options" {
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id

  accepter {
    allow_remote_vpc_dns_resolution  = true
  }
}

# Додати маршрути в таблиці маршрутизації для з'єднання між VPC
resource "aws_route" "route_vpc1_to_vpc2" {
  route_table_id         = aws_vpc.vpc1.main_route_table_id
  destination_cidr_block = "10.0.1.0/24"
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id
}

resource "aws_route" "route_vpc2_to_vpc1" {
  route_table_id         = aws_vpc.vpc2.main_route_table_id
  destination_cidr_block = "10.0.1.0/24"
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id
}