module "prod" {
  source = "../modules/secured-web"
  environment = {
    name           = "prod"
    network_prefix = "10.2"
  }
}
