# Terraform version and engine constraints
terraform {
  required_version = ">= 1.8.0"

  required_providers {

    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.60"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }

    tls = {
      source = "hashicorp/tls"
      version = "~>4.0"
    }

  }
}