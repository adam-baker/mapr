provider "kubernetes" {
  config_path = "~/.kube/config"
}

module "cronjob_hello" {
  source     = "../../modules/cronjob"
  name       = "hello-cron"
  namespace  = "default"
  schedule   = "*/5 * * * *"
  image      = "busybox"
  args       = ["echo", "Hello from dev!"]
}

data "aws_vpc" "dev" {
  filter {
    name   = "tag:Name"
    values = ["dev-vpc"]  # Change to match your actual VPC Name tag
  }
}

data "aws_subnets" "dev" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.dev.id]
  }

  filter {
    name   = "tag:Environment"
    values = ["dev"]
  }
}
