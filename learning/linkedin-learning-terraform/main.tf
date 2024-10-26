terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.73"
    }
  }

  required_version = ">= 1.9.8"
}

provider "aws" {
  region = "eu-central-1"
}

module "ec2_instance_external_module" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.7.1"

  name = "test-instance"

  instance_type = "t2.micro"
  ami           = "ami-08ec94f928cf25a9d"

  tags = {
    Terraform   = "true"
    DeployedBy  = "tf-cloud"
    Environment = "linkedin"
  }
}
