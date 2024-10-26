output "ec2_instance_external_module_id" {
  description = "Output ID from the external EC2 module."
  value       = module.ec2_instance_external_module.id
}

output "ec2_instance_external_module_ebs_block_device" {
  description = "Output EBS block device from the external EC2 module."
  value       = module.ec2_instance_external_module.ebs_block_device
}
