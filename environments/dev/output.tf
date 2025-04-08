output "vpc_id" {
  value = data.aws_vpc.dev.id
}

output "subnet_ids" {
  value = data.aws_subnets.dev.ids
}
