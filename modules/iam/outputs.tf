output "instance_profile" {

  value = aws_iam_instance_profile.ec2.name

}

output "role_name" {

  value = aws_iam_role.ec2_role.name

}