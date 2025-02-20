module "on_prem" {
  source = "/mnt/c/Users/AndriiRevkach/Desktop/test/DevOps/Terraform/modules/vpc"

  vpc_name         = var.on_prem_vpc_name
  cidr_block       = var.on_prem_vpc_cidr
  azs              = var.on_prem_az

  private_subnets  = var.on_prem_private_subnets
  #enable_internet_gateway = true

  tags = {
    env     = "dev"
    project = "my-project"
  }
}

module "cloud" {
  source = "/mnt/c/Users/AndriiRevkach/Desktop/test/DevOps/Terraform/modules/vpc"

  vpc_name         = var.cloud_vpc_name
  cidr_block       = var.cloud_vpc_cidr
  azs              = var.cloud_az

  private_subnets  = var.cloud_private_subnets
  #enable_internet_gateway = true

  tags = {
    env     = "dev"
    project = "my-project"
  }

}

# ---------------- VPC Peering ---------------- #
resource "aws_vpc_peering_connection" "peer" {
  vpc_id      = module.cloud.vpc_id   
  peer_vpc_id = module.on_prem.vpc_id 
  auto_accept = true

  tags = {
    Name = "cloud-to-onprem-peering"
  }
}

# ---------------- Route Tables ---------------- #
resource "aws_route_table" "cloud" {
  vpc_id = module.cloud.vpc_id

  tags = {
    Name = "cloud-route-table"
  }
}

resource "aws_route_table" "on_prem" {
  vpc_id = module.on_prem.vpc_id

  tags = {
    Name = "onprem-route-table"
  }
}

# ---------------- Route Tables Associations ---------------- #
resource "aws_route_table_association" "cloud_private_1" {
  subnet_id      = module.cloud.private_subnet_ids[0]
  route_table_id = aws_route_table.cloud.id
}

resource "aws_route_table_association" "cloud_private_2" {
  subnet_id      = module.cloud.private_subnet_ids[1]
  route_table_id = aws_route_table.cloud.id
}

resource "aws_route_table_association" "onprem_private_1" {
  subnet_id      = module.on_prem.private_subnet_ids[1]
  route_table_id = aws_route_table.on_prem.id
}

resource "aws_route_table_association" "onprem_private_2" {
  subnet_id      = module.on_prem.private_subnet_ids[1]
  route_table_id = aws_route_table.on_prem.id
}

# ---------------- Route Tables Update ---------------- #
resource "aws_route" "cloud_to_onprem" {
  route_table_id         = aws_route_table.cloud.id
  destination_cidr_block = var.on_prem_vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}


resource "aws_route" "onprem_to_cloud" {
  route_table_id         = aws_route_table.on_prem.id
  destination_cidr_block = var.cloud_vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}