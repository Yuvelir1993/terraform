module "qa" {
  source = "../modules/secured-web"
  environment = {
    name           = "qa"
    network_prefix = "10.1"
  }
}
