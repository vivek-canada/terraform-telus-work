variable "vpc_public_subnets" {
  description = "List of public subnets in the VPC"
  type        = list(string)
}

variable "alb_security_group" {
  description = "Security group ID for the ALB"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID"
  type        = string
}
