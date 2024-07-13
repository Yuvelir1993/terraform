# General
Terraform states for AWS.

## Docu
[Terraform - official docu](https://www.terraform.io/)
[Terraform - Get Started - AWS](https://developer.hashicorp.com/terraform/tutorials/aws-get-started)
[Terraform - AWS provider docu](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)

## Set credentials
Before executing terraform commands, log in to AWS user with necessary rights to execute services actions in your Terraform code, go to "IAM -> Security credentials" and "Create access key"

```bash
# bash
export AWS_ACCESS_KEY_ID=<>
export AWS_SECRET_ACCESS_KEY=<>
```


> [!WARNING]
> Powershell commands below will set environment variables permanently!

```powershell
# powershell
[System.Environment]::SetEnvironmentVariable('AWS_ACCESS_KEY_ID','<>')
[System.Environment]::SetEnvironmentVariable('AWS_SECRET_ACCESS_KEY','<>')
```