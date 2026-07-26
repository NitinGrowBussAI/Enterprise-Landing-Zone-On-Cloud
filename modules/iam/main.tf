data "aws_iam_policy_document" "ec2_assume_role" {

  statement {

    actions = [
      "sts:AssumeRole"
    ]

    principals {

      type = "Service"

      identifiers = [
        "ec2.amazonaws.com"
      ]

    }

  }

}

resource "aws_iam_role" "ec2_role" {

  name = "${var.project_name}-${var.environment}-ec2-role"

  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json

}

resource "aws_iam_role_policy_attachment" "ssm" {

  role = aws_iam_role.ec2_role.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"

}

resource "aws_iam_role_policy_attachment" "cloudwatch" {

  role = aws_iam_role.ec2_role.name

  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"

}

resource "aws_iam_role_policy_attachment" "s3" {

  role = aws_iam_role.ec2_role.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"

}

resource "aws_iam_instance_profile" "ec2" {

  name = "${var.project_name}-${var.environment}-instance-profile"

  role = aws_iam_role.ec2_role.name

}