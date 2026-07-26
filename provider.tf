provider "aws" {

  alias  = "us-east-1"
  region = "us-east-1"

  default_tags {

    tags = {

      Project     = "Enterprise Landing Zone"
      Environment = var.environment
      ManagedBy   = "Terraform"
      Owner       = "GrowBiss"

    }

  }

}
