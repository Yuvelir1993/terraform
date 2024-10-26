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

module "vpc_external_module" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.14.0"

  cidr           = "10.0.0.0/16"
  azs            = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
  public_subnets = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  tags = {
    Terraform   = "true"
    DeployedBy  = "tf-cloud"
    Environment = "linkedin"
  }
}

module "security_group_external_module" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.2.0"
  name    = "test-learning-sg"

  vpc_id              = module.vpc_external_module.vpc_id
  ingress_rules       = ["https-443-tcp", "http-80-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules        = ["all-all"]
  egress_cidr_blocks  = ["0.0.0.0/0"]

  tags = {
    Terraform   = "true"
    DeployedBy  = "tf-cloud"
    Environment = "linkedin"
  }
}

module "ec2_instance_external_module" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.7.1"

  instance_type = "t2.micro"
  ami           = "ami-08ec94f928cf25a9d"
  name          = "test-instance"

  subnet_id              = module.vpc_external_module.public_subnets[0]
  vpc_security_group_ids = [module.security_group_external_module.security_group_id]


  tags = {
    Terraform   = "true"
    DeployedBy  = "tf-cloud"
    Environment = "linkedin"
  }
}

module "alb_external_module" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 6.0"
  name    = "test-alb"

  load_balancer_type = "application"
  security_groups    = [module.security_group_external_module.security_group_id]
  subnets            = module.vpc_external_module.public_subnets
  vpc_id             = module.vpc_external_module.vpc_id

  target_groups = [
    {
      name_prefix      = "blog-"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
    }
  ]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]

  tags = {
    Terraform   = "true"
    DeployedBy  = "tf-cloud"
    Environment = "linkedin"
  }
}

module "autoscaling_external_module" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "6.5.2"
  name    = "example-autoscaling"

  min_size         = 1
  max_size         = 3
  desired_capacity = 2

  image_id            = "ami-08ec94f928cf25a9d"
  instance_type       = "t2.micro"
  security_groups     = [module.security_group_external_module.security_group_id]
  vpc_zone_identifier = module.vpc_external_module.public_subnets
  target_group_arns   = module.alb_external_module.target_group_arns

  tags = {
    Terraform   = "true"
    DeployedBy  = "tf-cloud"
    Environment = "linkedin"
  }
}
