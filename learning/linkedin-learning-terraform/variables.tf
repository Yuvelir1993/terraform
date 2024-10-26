variable "ami_linux_2023_free_tier" {
  description = "value"
  default     = "ami-08ec94f928cf25a9d"
}

variable "deployed_by" {
  description = "Tells what was used to deploy"
  type        = string
  default     = "tf-cloud"
}
