resource "aws_lb" "this" {

  name               = "${var.project_name}-${var.environment}-alb"

  internal           = false

  load_balancer_type = "application"

  security_groups = [
    var.alb_security_group
  ]

  subnets = var.public_subnets

  enable_deletion_protection = false

  idle_timeout = 60

  tags = {

    Name = "${var.project_name}-${var.environment}-alb"

  }

}

resource "aws_lb_target_group" "this" {

  name = "${var.project_name}-${var.environment}-tg"

  port = 80

  protocol = "HTTP"

  vpc_id = var.vpc_id

  target_type = "instance"

  health_check {

    enabled = true

    path = "/"

    matcher = "200"

    interval = 30

    timeout = 5

    healthy_threshold = 2

    unhealthy_threshold = 2

  }

}

resource "aws_lb_listener" "http" {

  load_balancer_arn = aws_lb.this.arn

  port = 80

  protocol = "HTTP"

  default_action {

    type = "forward"

    target_group_arn = aws_lb_target_group.this.arn

  }

}