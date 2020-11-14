resource "aws_lb" "main" {
  name               = "ecslb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ALB.id]
  subnets            = var.public_subnet

  enable_deletion_protection = false
}

resource "aws_alb_target_group" "main" {
  name        = "ecs-lb-target-group"
  port        = var.container_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id


  depends_on = [aws_lb.main]

  health_check {
    interval            = "60"
    path                = "/"
    port                = var.container_port
    healthy_threshold   = "3"
    unhealthy_threshold = "3"
    timeout             = "5"
    protocol            = "HTTP"
  }
}

resource "aws_alb_listener" "http" {
  load_balancer_arn = aws_lb.main.id
  port              = var.container_port
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.main.id
    type             = "forward"
  }

  depends_on = [aws_lb.main]
}