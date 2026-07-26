terraform {

  backend "s3" {

    bucket         = "terraform-state-enterprise-demo"
    key            = "landing-zone/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    use_lockfile   = true

  }

}