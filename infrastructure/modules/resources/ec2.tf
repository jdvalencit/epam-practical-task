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
}

#Front-end sg
resource "aws_security_group" "frontend_sg" {
  name   = "${terraform.workspace}-frontend-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
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

#Back-end sg
resource "aws_security_group" "backend_sg" {
  name   = "${terraform.workspace}-backend-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.frontend_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#EC2 Instances
resource "aws_instance" "bastion_host" {
  ami             = var.bastion_ami
  instance_type   = var.bastion_instance_type
  subnet_id       = var.public_subnets[0]
  key_name        = var.bastion_key_pair
  security_groups = [aws_security_group.bastion_sg.name]

  tags = {
    Name = "Bastion host"
    Env  = terraform.workspace
  }
}




/*
resource "aws_security_group_rule" "SG_control_ingress_rule" {
  security_group_id = aws_security_group.SG_control_node.id
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
  protocol  = "tcp"
  from_port = 22
  to_port   = 22
}

resource "aws_security_group_rule" "SG_control_egress_rule" {
  security_group_id = aws_security_group.SG_control_node.id
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
}

#Nodes SG
resource "aws_security_group" "SG_node" {
  name        = "SG-Node"
  description = "Security group for Ansible node"
  vpc_id      = module.vpc.vpc_id
}

resource "aws_security_group_rule" "SG_node_ingress_rule_ip" {
  security_group_id = aws_security_group.SG_node.id
  type              = "ingress"
  cidr_blocks       = ["18.206.107.24/29"]
  protocol          = "tcp"
  from_port         = 22
  to_port           = 22
}

resource "aws_security_group_rule" "SG_node_ingress_rule_sg" {
  security_group_id        = aws_security_group.SG_node.id
  type                     = "ingress"
  source_security_group_id = aws_security_group.SG_control_node.id
  protocol                 = "tcp"
  from_port                = 22
  to_port                  = 22
}

resource "aws_security_group_rule" "SG_node_egress_rule" {
  security_group_id = aws_security_group.SG_node.id
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
}
*/