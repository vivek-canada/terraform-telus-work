output "asg_tg_arn" {
  value = aws_lb_target_group.asg_tg.arn
}

output "alb_dns_name" {
  value = aws_lb.this.dns_name
}


