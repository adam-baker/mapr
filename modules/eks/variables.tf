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
