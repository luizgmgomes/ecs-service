resource "aws_key_pair" "my_key" {
    key_name = var.instance_key_name
    public_key = file("./${var.instance_public_key}")
}

resource "aws_launch_configuration" "ecs_app" {
    instance_type = var.instance_type
    image_id = var.instance_ami_id
    iam_instance_profile = aws_iam_instance_profile.ecs_instance_profile.name
    key_name = aws_key_pair.my_key.key_name
    security_groups = [ aws_security_group.ALB.id ]
    user_data       = <<EOF
#! /bin/bash
sudo apt-get update
sudo echo "ECS_CLUSTER=${var.ecs_cluster_name}" >> /etc/ecs/ecs.config
EOF

    associate_public_ip_address = true

    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_autoscaling_group" "ecs_app" {
    name = var.asg_name
    max_size = var.asg_max_size
    min_size = var.asg_min_size
    desired_capacity = var.asg_desired_size
    health_check_grace_period = 300
    health_check_type = "ELB"
    force_delete = true
    launch_configuration = aws_launch_configuration.ecs_app.id
    vpc_zone_identifier = var.public_subnet

    target_group_arns = [aws_alb_target_group.main.arn]
    protect_from_scale_in = true

    lifecycle {
        create_before_destroy = true
    }
}