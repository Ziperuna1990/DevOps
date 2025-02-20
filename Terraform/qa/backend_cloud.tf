resource "aws_security_group" "sg_backend_cloud" {
  name          = "sg_backend_cloud"
  vpc_id        = module.cloud.vpc_id
  description   = "Allow access to EC2 and RDS from private subnet"
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.1.0.0/16"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["10.1.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "backend_to_rds" {
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  security_group_id        = aws_security_group.rds_sg.id
  source_security_group_id = aws_security_group.sg_backend_cloud.id
}

resource "aws_security_group_rule" "backend_to_redis" {
  type                     = "ingress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  security_group_id        = aws_security_group.redis_sg.id
  source_security_group_id = aws_security_group.sg_backend_cloud.id
}

resource "aws_instance" "backend_api_cloud" {
  ami                           = var.backend_server_ami
  instance_type                 = var.backend_instance_type
  subnet_id                     = module.cloud.private_subnet_ids[0]
  vpc_security_group_ids        = [aws_security_group.sg_backend_cloud.name]
  
  tags = {
    Name = var.backend_instance_name
    #Environment = var.env
  }
}

#resource "aws_launch_configuration" "backend_api_config" {
#  name = "backend-api-config"
#  image_id = var.backend_server_ami  
#  instance_type = var.backend_instance_type
#  
#  security_groups = [aws_security_group.sg_backend.id]
#}

#resource "aws_autoscaling_group" "backend_api_asg" {
#  desired_capacity     = 2
#  max_size             = 5
#  min_size             = 2
#  launch_configuration = aws_launch_configuration.backend_api_config.id
#  vpc_zone_identifier  = [module.cloud.vpc_id]
#  health_check_type    = "EC2"
#  health_check_grace_period = 300
#  force_delete         = true
#}
