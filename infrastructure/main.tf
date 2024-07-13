terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.58"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  shared_config_files      = ["%USERPROFILE%/.aws/conf"]
  shared_credentials_files = ["%USERPROFILE%/.aws/creds"]
  region                   = var.AWS_REGION
}
