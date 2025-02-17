resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins-sg"
  description = "Security group for Jenkins"
  vpc_id      = module.on_prem_vpc.vpc_id

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Відкриваємо порт для Jenkins Web UI
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # SSH доступ до Jenkins
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "jenkins-sg"
  }
}

resource "aws_instance" "jenkins_server" {
  ami           = var.jenkins_server_ami
  instance_type = var.jenkins_server_instance_type
  subnet_id     = module.on_prem_vpc.private_subnet_id
  security_groups = [aws_security_group.jenkins_sg.name]

  tags = {
    Name = var.jenkins_server_instance_type
    Environment = var.env
  }
}