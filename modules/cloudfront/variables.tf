variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "bucket_name" {
  type = string
}

variable "bucket_domain_name" {
  type = string
}

variable "certificate_arn" {}

variable "aliases" {

    type = list(string)

}