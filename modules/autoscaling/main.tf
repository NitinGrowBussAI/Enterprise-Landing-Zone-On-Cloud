resource "aws_autoscaling_group" "this" {

  name = "${var.project_name}-${var.environment}-asg"

  min_size = 2

  desired_capacity = 2

  max_size = 4

  health_check_type = "ELB"

  health_check_grace_period = 300

  vpc_zone_identifier = var.private_subnets

  target_group_arns = [
    var.target_group_arn
  ]

  launch_template {

    id = var.launch_template_id

    version = var.launch_template_version

  }

  tag {

    key = "Name"

    value = "${var.project_name}-server"

    propagate_at_launch = true

  }

}

resource "aws_autoscaling_policy" "cpu" {

  name = "${var.project_name}-cpu"

  autoscaling_group_name = aws_autoscaling_group.this.name

  policy_type = "TargetTrackingScaling"

  target_tracking_configuration {

    predefined_metric_specification {

      predefined_metric_type = "ASGAverageCPUUtilization"

    }

    target_value = 60

  }

}