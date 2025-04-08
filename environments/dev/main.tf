provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.cluster.token
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


module "vpc" {
  source      = "../../modules/vpc"
  vpc_name    = "eks-dev-vpc"
  vpc_cidr    = "10.0.0.0/16"
  azs         = ["us-east-2a", "us-east-2b", "us-east-2c"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]
  environment = "dev"
}

module "eks" {
  source = "../../modules/eks"

  cluster_name         = var.cluster_name
  vpc_id               = module.vpc.vpc_id
  subnet_ids           = module.vpc.subnet_ids
  node_group_min_size  = 1
  node_group_max_size  = 3
  node_group_desired   = 2
}

data "aws_eks_cluster" "cluster" {
  name = var.cluster_name
}

data "aws_eks_cluster_auth" "cluster" {
  name = var.cluster_name
}

module "cronjob_hello" {
  source     = "../../modules/cronjob"
  name       = "hello-cron"
  namespace  = "default"
  schedule   = "*/5 * * * *"
  image      = "busybox"
  args       = ["echo", "Hello from dev!"]
}
