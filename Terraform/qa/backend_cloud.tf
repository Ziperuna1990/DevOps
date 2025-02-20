resource "aws_security_group" "sg_backend" {
  name          = "sg_backend"
  vpc_id        = module.cloud.vpc_id
  description   = "Allow access to EC2 and RDS from private subnet"
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
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
  subnet_id              = module.cloud.private_subnet_ids[0]
  security_groups        = [aws_security_group.sg_backend.name]
  
  tags = {
    Name = var.backend_instance_name
    #Environment = var.env
  }
}