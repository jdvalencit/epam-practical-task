#Security groups

#Bastion Host sg
resource "aws_security_group" "bastion_sg" {
  name        = "${terraform.workspace}-bastion-sg"
  description = "Security group for bastion host instance"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
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
    "Name" = "${terraform.workspace}-bastion-sg"
  }
}

#Front-end sg
resource "aws_security_group" "frontend_sg" {
  name   = "${terraform.workspace}-frontend-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 3030
    to_port     = 3030
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    #security_groups = [aws_security_group.frontend_sg.id]
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "${terraform.workspace}-frontend-sg"
  }
}

#Back-end sg
resource "aws_security_group" "backend_sg" {
  name   = "${terraform.workspace}-backend-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port       = 3000
    to_port         = 3000
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_internal_sg.id]
  }

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    #security_groups = [aws_security_group.frontend_sg.id]
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "${terraform.workspace}-backend-sg"
  }
}

#Bastion host instance
resource "aws_instance" "bastion_host" {
  ami           = var.bastion_ami
  instance_type = var.bastion_instance_type
  subnet_id     = var.public_subnets[0]
  key_name      = var.key_pair
  #security_groups             = [aws_security_group.bastion_sg.id]
  vpc_security_group_ids      = [aws_security_group.bastion_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "Bastion host"
    Env  = terraform.workspace
  }

  #user_data = file("${path.module}/scripts/bastion_setup.sh")
}

# Front-end instance
resource "aws_instance" "frontend_instance" {
  count         = var.frontend_instances_count
  ami           = var.frontend_ami
  instance_type = var.frontend_instance_type
  subnet_id     = var.public_subnets[1]
  key_name      = var.key_pair
  #security_groups             = [aws_security_group.frontend_sg.id]
  vpc_security_group_ids      = [aws_security_group.frontend_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "Frontend-${count.index}"
    Env  = terraform.workspace
  }
}

# Back-end instance
resource "aws_instance" "backend_instance" {
  count         = var.backend_instances_count
  ami           = var.backend_ami
  instance_type = var.backend_instance_type
  subnet_id     = var.private_subnets[0]
  key_name      = var.key_pair
  #security_groups = [aws_security_group.backend_sg.id]
  vpc_security_group_ids = [aws_security_group.backend_sg.id]

  tags = {
    Name = "Backend-${count.index}"
    Env  = terraform.workspace
  }
}