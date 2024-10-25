variable "tf_repo_directory" {
  default = "global/prod/main"
}

variable "default_tags" {
  default = {
    environments    = "prod"
    managedBy       = "Terraform"
    TFRepoDirectory = "global/prod/main"
  }
  type = map(string)
}
