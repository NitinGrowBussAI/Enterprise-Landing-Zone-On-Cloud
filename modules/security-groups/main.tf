resource "aws_security_group" "alb" {

  name = "${var.project_name}-${var.environment}-alb"

  vpc_id = var.vpc_id

}
resource "aws_vpc_security_group_ingress_rule" "http" {

  security_group_id = aws_security_group.alb.id

  cidr_ipv4 = "0.0.0.0/0"

  from_port = 80

  to_port = 80

  ip_protocol = "tcp"

}
resource "aws_vpc_security_group_ingress_rule" "https" {

  security_group_id = aws_security_group.alb.id

  cidr_ipv4 = "0.0.0.0/0"

  from_port = 443

  to_port = 443

  ip_protocol = "tcp"

}
resource "aws_vpc_security_group_egress_rule" "alb_out" {

  security_group_id = aws_security_group.alb.id

  cidr_ipv4 = "0.0.0.0/0"

  ip_protocol = "-1"

}
resource "aws_security_group" "ec2" {

  name = "${var.project_name}-${var.environment}-ec2"

  vpc_id = var.vpc_id

}
resource "aws_vpc_security_group_ingress_rule" "alb_to_ec2" {

  security_group_id = aws_security_group.ec2.id

  referenced_security_group_id = aws_security_group.alb.id

  from_port = 80

  to_port = 80

  ip_protocol = "tcp"

}
resource "aws_vpc_security_group_egress_rule" "ec2_out" {

  security_group_id = aws_security_group.ec2.id

  cidr_ipv4 = "0.0.0.0/0"

  ip_protocol = "-1"

}
resource "aws_security_group" "rds" {

  name = "${var.project_name}-${var.environment}-rds"

  vpc_id = var.vpc_id

}
resource "aws_vpc_security_group_ingress_rule" "postgres" {

  security_group_id = aws_security_group.rds.id

  referenced_security_group_id = aws_security_group.ec2.id

  from_port = 5432

  to_port = 5432

  ip_protocol = "tcp"

}
