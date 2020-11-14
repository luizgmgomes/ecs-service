resource "aws_elb" "service" {
  subnets = var.elb_subnets
  security_groups = [
    aws_security_group.open_to_load_balancer.id
  ]

  internal = false

  cross_zone_load_balancing = true
  idle_timeout = 60
  connection_draining = true
  connection_draining_timeout = 60

  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    target = "HTTP:80/health"
    interval = 30
  }

  # tags = {
  #   Name = "elb-${var.component}-${var.deployment_identifier}"
  #   Component = var.component
  #   DeploymentIdentifier = var.deployment_identifier
  #   Service = var.service_name
  # }

  # dynamic "access_logs" {
  #   for_each = var.access_logs_bucket != "" ? [1] : []
  #   content {
  #     bucket = var.access_logs_bucket
  #     bucket_prefix = var.access_logs_bucket_prefix
  #     interval = var.access_logs_interval
  #     enabled = var.store_access_logs == "yes" ? true : false
  #   }
  # }
}

resource "aws_security_group" "ALB" {
  name = "load-balancer"
  vpc_id = module.vpc.vpc_id
  description = "ELB for component"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 1
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = var.private_subnet[*].cidr_block
  }
}

resource "aws_security_group" "open_to_load_balancer" {
  name = "open-to-elb-"
  vpc_id = module.vpc.vpc_id
  description = "Open to ELB for component"

  ingress {
    from_port = 555
    to_port = 555
    protocol = "tcp"
    security_groups = [
      aws_security_group.ALB.id
    ]
  }
}


resource "aws_alb_target_group" "main" {
  name        = "albtargetgroup"
  port        = 555
  protocol    = "HTTP"
  vpc_id      = module.vpc.vpc_id
  target_type = "ip"
}