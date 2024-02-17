output "auto_scaling_down_policy_arn" {
  value = aws_autoscaling_policy.scale_down.arn
  description = "arn of auto scaling policy"
}

output "auto_scaling_up_policy_arn" {
  value = aws_autoscaling_policy.scale_up.arn
  description = "arn of auto scaling policy"
}


output "auto_scaling_group_name" {
  value = aws_autoscaling_group.asg.name
  description = "name of auto scaling group"
}