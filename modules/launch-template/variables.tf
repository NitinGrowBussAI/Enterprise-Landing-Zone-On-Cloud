variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "instance_profile" {
  type = string
}

variable "ec2_security_group" {
  type = string
}

variable "private_subnets" {
  type = list(string)
}

variable "instance_type" {
  default = "t3.micro"
}

variable "ami_id" {
  type = string
}