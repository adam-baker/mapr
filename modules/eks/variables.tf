variable "cluster_name" {}
variable "subnet_ids" {
  type = list(string)
}
variable "vpc_id" {
  type = string
}
variable "node_group_min_size" {
  default = 1
}
variable "node_group_max_size" {
  default = 3
}
variable "node_group_desired" {
  default = 2
}
variable "cluster_version" {
  type        = string
  description = "The Kubernetes version for the EKS cluster"
  default     = "1.29"
}
variable "vpc_id" {
  type        = string
  description = "The VPC ID to launch the EKS cluster into"
}
variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs to use for the EKS cluster"
}
