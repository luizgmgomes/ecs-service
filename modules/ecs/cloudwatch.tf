resource "aws_cloudwatch_log_group" "ecs_logs" {
  name              = "ecs_logs"
  retention_in_days = 5
}

resource "aws_cloudwatch_metric_alarm" "ecs_cpu_metric" {
  alarm_name                = "cpu_higher_80"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = "3"
  metric_name               = "CpuUtilized"
  namespace                 = "ECS/ContainerInsights"
  period                    = "60"
  statistic                 = "Average"
  threshold                 = "80"
  alarm_description         = "This metric monitors ECS for CPU utilization "
}


resource "aws_cloudwatch_metric_alarm" "ecs_ram_metric" {
  alarm_name                = "cpu_memory_80"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = "3"
  metric_name               = "MemoryUtilization"
  namespace                 = "ECS/ContainerInsights"
  period                    = "60"
  statistic                 = "Average"
  threshold                 = "80"
  alarm_description         = "This metric monitors ECS for RAM utilization "
}


resource "aws_cloudwatch_metric_alarm" "alb_request_count_metric" {
  alarm_name                = "request_count"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = "3"
  metric_name               = "RequestCount"
  namespace                 = "AWS/ApplicationELB"
  period                    = "60"
  statistic                 = "Sum"
  threshold                 = "80"
  alarm_description         = "This metric monitors the number of access to LB in a short period"
}