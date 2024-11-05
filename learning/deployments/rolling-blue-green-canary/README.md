# Learn Terraform Advanced Deployment Strategies

Learn how to use Terraform and AWS's Application Load Balancers for canary tests and blue/green deployments. Learn how to add feature flags to your Terraform configuration by using variables and conditionals. Follow along with [this
tutorial](https://learn.hashicorp.com/tutorials/terraform/blue-green-canary-tests-deployments) on HashiCorp Learn.

# Deployment
Test traffic distribution:
`terraform apply -var 'traffic_distribution=blue-90'`

Verify the traffic:
```bash
for i in `seq 1 10`; do curl $(terraform output -raw lb_dns_name); done
```

Increase traffic to green environment:
`terraform apply -var 'traffic_distribution=split'`

Promote green environment:
`terraform apply -var 'traffic_distribution=green'`

Disable blue environment:
`terraform apply -var 'traffic_distribution=green' -var 'enable_blue_env=false'`

Destroy blue environment:
`terraform destroy -var 'traffic_distribution=blue'`