module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.0.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  vpc_id     = data.aws_vpc.vpc_id
  subnet_ids = data.aws_subnets.subnet_ids

  enable_irsa = true
  eks_managed_node_groups = {
    default = {
      desired_capacity = 3
      instance_types   = ["t3.medium"]
    }
  }
}
