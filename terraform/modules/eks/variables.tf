variable "environment" {}

variable "subnet_ids" {
  description = "List of subnet IDs for EKS"
  type        = list(string)
}
variable "cluster_role_arn" {}
variable "node_role_arn" {}
variable "desired_size" {}
variable "min_size" {}
variable "max_size" {}
