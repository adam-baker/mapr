provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.cluster.token
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
    values = ["demo-vpc"]  # Change to match your actual VPC Name tag
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

data "aws_eks_cluster" "cluster" {
  name = var.cluster_name
}

data "aws_eks_cluster_auth" "cluster" {
  name = var.cluster_name
}
