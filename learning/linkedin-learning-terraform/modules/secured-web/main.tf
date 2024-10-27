module "vpc_external_module" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.14.0"
  name    = "VPC-for-${var.environment.name}"

  cidr           = "10.0.0.0/16"
  azs            = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
  public_subnets = ["${var.environment.network_prefix}.101.0/24", "${var.environment.network_prefix}.102.0/24", "${var.environment.network_prefix}.103.0/24"]

  tags = {
    Terraform   = "true"
    DeployedBy  = var.deployed_by_terraform
    Environment = var.environment.name
  }
}

module "security_group_external_module" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.2.0"
  name    = "test-learning-sg-${var.environment.name}"

  vpc_id              = module.vpc_external_module.vpc_id
  ingress_rules       = ["https-443-tcp", "http-80-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules        = ["all-all"]
  egress_cidr_blocks  = ["0.0.0.0/0"]

  tags = {
    Terraform   = "true"
    DeployedBy  = var.deployed_by_terraform
    Environment = var.environment.name
  }
}

module "alb_external_module" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 6.0"
  name    = "test-alb-${var.environment.name}"

  load_balancer_type = "application"
  security_groups    = [module.security_group_external_module.security_group_id]
  subnets            = module.vpc_external_module.public_subnets
  vpc_id             = module.vpc_external_module.vpc_id

  target_groups = [
    {
      name_prefix      = "${var.environment.name}-"
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
    DeployedBy  = var.deployed_by_terraform
    Environment = var.environment.name
  }
}

module "autoscaling_external_module" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "6.5.2"
  name    = "example-autoscaling"

  min_size = 1
  max_size = 2

  image_id            = var.ami_linux_2023_free_tier
  instance_type       = "t2.micro"
  security_groups     = [module.security_group_external_module.security_group_id]
  vpc_zone_identifier = module.vpc_external_module.public_subnets
  target_group_arns   = module.alb_external_module.target_group_arns

  tags = {
    Terraform   = "true"
    DeployedBy  = var.deployed_by_terraform
    Environment = var.environment.name
  }
}
