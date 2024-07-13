# General
Set up basic IAM for further Terraform states to not use 'root' user.

Assumes that IAM are executed using 'root' user security access key. After set up is done, the security access key should be removed manually and local machine's AWS credentials (environment variables and/or ".../username/.aws/credentials?) to be reconfigured.