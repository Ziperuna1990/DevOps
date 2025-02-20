resource "aws_security_group" "redis_sg" {
  name        = "redis-security-group-cloud"
  description = "Allow inbound access to Redis"
  vpc_id      = module.cloud.vpc_id

  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = ["10.1.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "redis-security-group-cloud"
  }
}

resource "aws_elasticache_subnet_group" "redis_subnet_group" {
  name       = "redis-subnet-group-cloud"
  subnet_ids = module.cloud.private_subnet_ids

  tags = {
    Name = "redis-subnet-group-cloud"
  }
}

resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "redis-cloud"
  engine               = "redis"
  engine_version       = "7.0"
  node_type            = "cache.t3.micro"
  num_cache_nodes      = 1
  port                 = 6379
  parameter_group_name = "default.redis7"
  subnet_group_name    = aws_elasticache_subnet_group.redis_subnet_group.name
  security_group_ids   = [aws_security_group.redis_sg.id]

  tags = {
    Name = "redis-cloud"
  }
}