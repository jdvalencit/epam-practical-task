# Security Group for RDS (allows traffic from the backend)
resource "aws_security_group" "rds_sg" {
  name   = "${terraform.workspace}-rds-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.backend_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${terraform.workspace}-rds-sg"
  }
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "${terraform.workspace}-rds-subnet-group"
  subnet_ids = var.private_subnets[*]

  tags = {
    Name = "${terraform.workspace}-rds-subnet-group"
  }
}

resource "aws_db_instance" "rds_instance" {
  identifier             = "${terraform.workspace}-rds-instance"
  engine                 = "mysql"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  skip_final_snapshot    = terraform.workspace == "prod" ? false : true
  storage_encrypted      = terraform.workspace == "prod" ? true : false
  deletion_protection    = terraform.workspace == "prod" ? true : false

  tags = {
    Name = "${terraform.workspace}-rds-instance"
  }
}

