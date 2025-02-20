# modules/vpc/main.tf
resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true
  
}

resource "aws_subnet" "private" {
  count = length(var.private_subnets)

  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = element(var.azs, count.index)

  tags = merge(var.tags, {
    Name = "${var.vpc_name}-private-${count.index}"
  })
}

#resource "aws_internet_gateway" "gw" {
#  count  = var.enable_internet_gateway ? 1 : 0
#  vpc_id = aws_vpc.this.id

#  tags = merge(var.tags, {
#    Name = "${var.vpc_name}-igw"
#  })
#}


