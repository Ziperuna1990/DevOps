resource "aws_security_group" "sg_backend" {
  name        = "sg_backend"
  vpc_id      = module.cloud_vpc.id
  description = "Allow access to EC2 and RDS from private subnet"
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "backend_api" {
  ami                    = var.backend_server_ami
  instance_type          = var.backend_instance_type
  subnet_id              = module.cloud_vpc.private_subnet_id
  security_groups        = [aws_security_group.sg_backend.name]
  
  tags = {
    Name = "Backend API"
  }
}