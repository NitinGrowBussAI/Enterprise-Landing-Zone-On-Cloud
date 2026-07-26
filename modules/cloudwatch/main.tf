resource "aws_sns_topic" "alerts" {

  name = "${var.project_name}-${var.environment}-alerts"

}

resource "aws_sns_topic_subscription" "email" {

  topic_arn = aws_sns_topic.alerts.arn

  protocol = "email"

  endpoint = var.notification_email

}

resource "aws_cloudwatch_metric_alarm" "cpu" {

  alarm_name = "${var.project_name}-cpu"

  comparison_operator = "GreaterThanThreshold"

  evaluation_periods = 2

  metric_name = "CPUUtilization"

  namespace = "AWS/EC2"

  period = 300

  statistic = "Average"

  threshold = 80

  alarm_actions = [
      aws_sns_topic.alerts.arn
  ]

  dimensions = {

      AutoScalingGroupName = var.asg_name

  }

}

resource "aws_cloudwatch_metric_alarm" "alb_5xx" {

  alarm_name = "${var.project_name}-alb-5xx"

  namespace = "AWS/ApplicationELB"

  metric_name = "HTTPCode_ELB_5XX_Count"

  statistic = "Sum"

  threshold = 10

  comparison_operator = "GreaterThanThreshold"

  evaluation_periods = 1

  period = 300

  alarm_actions = [

      aws_sns_topic.alerts.arn

  ]

  dimensions = {

      LoadBalancer = var.alb_arn_suffix

  }

}

resource "aws_cloudwatch_metric_alarm" "rds_cpu" {

  alarm_name = "${var.project_name}-rds"

  namespace = "AWS/RDS"

  metric_name = "CPUUtilization"

  statistic = "Average"

  threshold = 80

  period = 300

  evaluation_periods = 2

  comparison_operator = "GreaterThanThreshold"

  alarm_actions = [

      aws_sns_topic.alerts.arn

  ]

  dimensions = {

      DBInstanceIdentifier = var.db_identifier

  }

}

resource "aws_cloudwatch_dashboard" "dashboard" {

  dashboard_name = "${var.project_name}-${var.environment}"

  dashboard_body = templatefile(

      "${path.module}/dashboard.json.tpl",

      {

          asg = var.asg_name

          db = var.db_identifier

      }

  )

}

