resource "aws_instance" "nomad" {
  ami           = "ami-0f9575d3d509bae0c" 
  instance_type = "t2.medium"
  key_name      = "nomadkey"
  
  tags = {
    Name = "nomad-server"
  }

  security_groups = [aws_security_group.nomad_sg.name]
}

resource "aws_instance" "consul" {
  ami           = "ami-0f9575d3d509bae0c" 
  instance_type = "t2.medium"
  key_name      = "consulkey"
  
  tags = {
    Name = "consul-server"
  }

  security_groups = [aws_security_group.consul_sg.name]
}

resource "aws_security_group" "nomad_sg" {
  name        = "nomad_sg"
  description = "Security group for Nomad"

  ingress {
    from_port   = 4647 
    to_port     = 4647
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 4646
    to_port     = 4646
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "consul_sg" {
  name        = "consul_sg"
  description = "Security group for Consul"

  ingress {
    from_port   = 8500 
    to_port     = 8500
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8300 
    to_port     = 8300
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
