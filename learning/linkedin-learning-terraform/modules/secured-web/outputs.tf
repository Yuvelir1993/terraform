output "environment_url" {
  description = "For easy access EC2 instance."
  value       = module.alb_external_module.lb_dns_name
}
