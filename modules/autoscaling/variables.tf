variable "vpc_private_subnets" {
  description = "List of private subnets in the VPC"
  type        = list(string)
}

variable "target_group_arn" {
  description = "Target group ARN for the load balancer"
  type        = string
}
