terraform {
  backend "s3" {
    key            = "global/prod/main/terraform.tfstate"
    region         = "eu-north-1"
    bucket         = "tf-states-linkedin-global-network-learning"
    dynamodb_table = "tf-state-lock"
    encrypt        = true
  }
}
