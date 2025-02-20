resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins-sg"
  description = "Security group for Jenkins"
  vpc_id      = module.on_prem.vpc_id

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
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
  subnet_id     = module.on_prem.private_subnet_ids[0]
  vpc_security_group_ids = [aws_security_group.jenkins_sg.name]

  user_data = <<-EOF
              #!/bin/bash
    
              apt update -y
              apt install openjdk-11-jre -y
              wget -q -O - https://pkg.jenkins.io/keys/jenkins.io.key | sudo tee /etc/apt/trusted.gpg.d/jenkins.asc
              sh -c 'echo deb http://pkg.jenkins.io/debian/ stable main > /etc/apt/sources.list.d/jenkins.list'
              apt update -y
              apt install jenkins -y
              systemctl start jenkins
              systemctl enable jenkins
              EOF

  tags = {
    Name = var.jenkins_server_instance_name
    #Environment = var.env
  }
}