provider "aws" {
  region = "us-east-1"
  access_key = "AKIASVQKHX5RWU7BDR6Z"
  secret_key = "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"
}


module "on_prem" {
  source = "/mnt/c/Users/AndriiRevkach/Desktop/DevOps/DevOps/Terraform/modules/networking"

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
  source = "/mnt/c/Users/AndriiRevkach/Desktop/DevOps/DevOps/Terraform/modules/networking"

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
