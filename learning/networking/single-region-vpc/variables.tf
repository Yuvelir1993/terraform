
variable "availability_zones_eu_central_1" {
  type        = list(string)
  description = "List of 'eu-central-1' Europe (Frankfurt) availability zones."
  default     = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
}

variable "environment" {
  description = "The deployment environment (e.g., dev, qa, prod)"
  type        = string

  validation {
    condition     = contains(["dev", "qa", "prod"], var.environment)
    error_message = "The environment must be one of: dev, qa, or prod."
  }
}

variable "tags_default" {
  type = object({
    Environment = string
    ManagedBy   = string
  })
  description = "Default tags for the whole VPC proejct."
  default = {
    Environment = var.environment
    ManagedBy   = "LocalTerraformCLI"
  }
}

variable "env_cidr_map" {
  description = "Map of environment names to CIDR block second octet"
  type        = map(string)
  default = {
    "dev"  = "10.0.0.0/16"
    "qa"   = "10.10.0.0/16"
    "prod" = "10.20.0.0/16"
  }
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR."
  default     = lookup(var.env_cidr_map, var.environment, "10.0.0.0/16")
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "Public Subnet CIDR values."
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "Private Subnet CIDR values."
  default     = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}
