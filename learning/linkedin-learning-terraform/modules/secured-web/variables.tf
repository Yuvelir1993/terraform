variable "ami_linux_2023_free_tier" {
  description = "value"
  default     = "ami-08ec94f928cf25a9d"
}

variable "deployed_by_terraform" {
  description = "Tells what was used to deploy"
  type        = string
  default     = "tf-cloud"
}

variable "environment" {
  description = "Deployment environment"

  type = object({
    name           = string
    network_prefix = string
  })
  default = {
    name           = "dev"
    network_prefix = "10.0"
  }
}
