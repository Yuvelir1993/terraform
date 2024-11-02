variable "tags_default" {
  type = object({
    Environment = string
    ManagedBy   = string
  })
  description = "Default tags for the whole VPC proejct."
  default = {
    Environment = "Learning"
    ManagedBy   = "LocalTerraformCLI"
  }
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "Public Subnet CIDR values"
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "Private Subnet CIDR values"
  default     = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}

variable "availability_zones_eu_central_1" {
  type        = list(string)
  description = "List of 'eu-central-1' availability zones."
  default     = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
}
