resource "aws_security_group" "alb_front_sg" {
  name   = "${terraform.workspace}-alb-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 3030
    to_port     = 3030
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

resource "aws_lb" "front-lb" {
  name               = "${terraform.workspace}-alb"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_front_sg.id]
  subnets            = var.public_subnets
}

resource "aws_lb_target_group" "frontend_tg" {
  name     = "${terraform.workspace}-frontend-tg"
  port     = 3030
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path = "/"
  }
}

resource "aws_lb_listener" "frontend_listener" {
  load_balancer_arn = aws_lb.front-lb.arn
  port              = 3030
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend_tg.arn
  }
}

resource "aws_lb_target_group_attachment" "frontend_attachment" {
  count            = var.frontend_instances_count
  target_group_arn = aws_lb_target_group.frontend_tg.arn
  target_id        = aws_instance.frontend_instance[count.index].id
  port             = 3030
}

#Internal load balancer
resource "aws_security_group" "alb_internal_sg" {
  name   = "${terraform.workspace}-internal-alb-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 3000
    to_port     = 3000
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

resource "aws_lb" "internal_lb" {
  name               = "${terraform.workspace}-internal-alb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_internal_sg.id]
  subnets            = var.private_subnets
}

resource "aws_lb_target_group" "backend_tg" {
  name     = "${terraform.workspace}-backend-tg"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path = "/"
  }
}

resource "aws_lb_listener" "backend_listener" {
  load_balancer_arn = aws_lb.internal_lb.arn
  port              = 3000
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backend_tg.arn
  }
}

resource "aws_lb_target_group_attachment" "backend_attachment" {
  count            = var.backend_instances_count
  target_group_arn = aws_lb_target_group.backend_tg.arn
  target_id        = aws_instance.backend_instance[count.index].id
  port             = 3000
}