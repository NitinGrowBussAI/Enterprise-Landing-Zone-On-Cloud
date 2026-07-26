variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "private_subnets" {
  type = list(string)
}

variable "rds_security_group" {
  type = string
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "instance_class" {
  default = "db.t3.micro"
}

variable "allocated_storage" {
  default = 20
}