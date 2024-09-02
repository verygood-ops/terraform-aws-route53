terraform {
  required_version = ">= 1.3.2"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.36.0"
    }
    random = {
      source = "hashicorp/random"
      version = "3.6.2"
    }
  }
}
