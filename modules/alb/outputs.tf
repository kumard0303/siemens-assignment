output "alb_tg_arn" {
  value = aws_lb_target_group.alb_target_group.arn
  description = "arn of target group"
}

output "alb_dns_name" {
  value = aws_lb.application_load_balancer.dns_name
  description = "dns name of alb"
}

output "alb_zone_id" {
  value = aws_lb.application_load_balancer.zone_id
  description = "zone id of alb"
}