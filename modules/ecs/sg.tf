resource "aws_security_group" "ALB" {
  name = "load-balancer"
  vpc_id = var.vpc_id
  description = "ELB for component"

  ingress {
    from_port = var.container_port
    to_port = var.container_port
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "open_to_load_balancer" {
  name = "open-to-elb-"
  vpc_id = var.vpc_id
  description = "Open to ELB for component"

  ingress {
    from_port = var.container_port
    to_port = var.container_port
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "tcp"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}