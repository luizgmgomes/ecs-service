resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.ecs_cluster_name
  capacity_providers = [aws_ecs_capacity_provider.capacity.name]

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}


resource "aws_ecs_service" "web_app" {
  name            = var.ecs_service_name
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.ecs_task_definition.arn
  desired_count   = var.ecs_service_desired_count

  depends_on = [aws_alb_target_group.main]


  load_balancer {
    target_group_arn = aws_alb_target_group.main.arn
    container_name   = var.ecs_container_name
    container_port   = var.container_port
  }

}

resource "aws_ecs_capacity_provider" "capacity" {
  name = "capacity-provider-test"
  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.ecs_app.arn
    managed_termination_protection = "ENABLED"

    managed_scaling {
      status          = "ENABLED"
      target_capacity = 85
    }
  }
}


resource "aws_ecs_task_definition" "ecs_task_definition" {
  family                = var.ecs_container_name
  container_definitions = data.template_file.task_webapp.rendered

  execution_role_arn       = aws_iam_role.exec.arn
  task_role_arn            = aws_iam_role.task.arn

}


data "template_file" "task_webapp" {
    template= file("./${var.container_template_file}")

    vars = {
        webapp_docker_image = var.container_image
    }
}