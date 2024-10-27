module "dev" {
  source = "../modules/secured-web"

  environment = {
    name           = "dev"
    network_prefix = "10.1"
  }
}
