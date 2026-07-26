variable "aws_region" {
  default = "us-east-1"
}

variable "environment" {
  default = "dev"
}

variable "project_name" {
  default = "enterprise-landing-zone"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}
variable "ami_id" {

  description = "Amazon Linux 2023 AMI"

  type = string

  default = "ami-0fe1c77f5f951a0ad"

}
variable "db_username" {

  default = "postgres"

}

variable "domain_name" {

    default = "example.com"

}

variable "notification_email" {

    default = "your-email@example.com"

}