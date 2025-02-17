resource "aws_db_instance" "postgresql_db" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "postgres"
  engine_version         = "13.3"
  instance_class         = "db.t3.micro"
  db_subnet_group_name   = aws_db_subnet_group.postgresql_db.name
  vpc_security_group_ids = [aws_security_group.sg_backend.id]
  multi_az               = false
  username               = "admin"
  password               = "password"
  db_name                = "mydatabase"
  backup_retention_period = 7
  publicly_accessible    = false
}

# Create Subnet Group for RDS
resource "aws_db_subnet_group" "db_subnet_group" {
  name        = "db-subnet-group"
  subnet_ids  = [module.cloud_vpc.private_subnet_id]
  description = "Subnet group for RDS"
}

resource "aws_security_group" "postgresql_db" {
  name        = "postgresql_db"
  vpc_id      = module.cloud_vpc.vpc_id
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