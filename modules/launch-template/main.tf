resource "aws_launch_template" "this" {

  name_prefix = "${var.project_name}-${var.environment}-"

  image_id = var.ami_id

  instance_type = var.instance_type

  vpc_security_group_ids = [
    var.ec2_security_group
  ]

  iam_instance_profile {

    name = var.instance_profile

  }

  user_data = base64encode(
    file("${path.module}/userdata.sh")
  )

  monitoring {

    enabled = true

  }

  tag_specifications {

    resource_type = "instance"

    tags = {

      Name = "${var.project_name}-${var.environment}-ec2"

    }

  }

}