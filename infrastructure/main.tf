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

module "website_s3_bucket" {
  source = "./modules/aws-s3-static-website-bucket"

  bucket_name = "my.static.cv.website.14.07"

  tags = {
    Terraform   = "true"
    Environment = "test"
  }
}
