# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0
# Defines Blue environment as a part of Blue-Green deployment strategy

resource "aws_lb_target_group" "blue" {
  name     = "blue-tg-${random_pet.app.id}-lb"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id

  health_check {
    port     = 80
    protocol = "HTTP"
    timeout  = 5
    interval = 10
  }

  tags = var.tags_deployments
}

resource "aws_lb_target_group_attachment" "blue" {
  count            = length(aws_instance.blue)
  target_group_arn = aws_lb_target_group.blue.arn
  target_id        = aws_instance.blue[count.index].id
  port             = 80
}

resource "aws_instance" "blue" {
  count = var.enable_blue_env ? var.blue_instance_count : 0

  ami                    = var.ami_linux_2023_free_tier
  instance_type          = "t2.micro"
  subnet_id              = module.vpc.private_subnets[count.index % length(module.vpc.private_subnets)]
  vpc_security_group_ids = [module.app_security_group.security_group_id]
  user_data = templatefile("${path.module}/init-script.sh", {
    file_content = "Blue: version 1.0 from replica #${count.index}"
  })

  tags = merge(var.tags_deployments, {
    Name = "blue-replica-#${count.index}"
  })
}
