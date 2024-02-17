resource "aws_cloudwatch_metric_alarm" "scale_down" {
    alarm_description   = "Monitors CPU utilization for ASG"
    alarm_actions       = [var.auto_scaling_down_policy_arn]
    alarm_name          = "${var.project_name}-asg-down-alarm"
    comparison_operator = "LessThanOrEqualToThreshold"
    namespace           = "AWS/EC2"
    metric_name         = "CPUUtilization"
    threshold           = "10"
    evaluation_periods  = "2"
    period              = "120"
    statistic           = "Average"

  dimensions = {
    AutoScalingGroupName = var.auto_scaling_group_name
    }
}

resource "aws_cloudwatch_metric_alarm" "scale_up" {
    alarm_description   = "Monitors CPU utilization for ASG"
    alarm_actions       = [var.auto_scaling_up_policy_arn]
    alarm_name          = "${var.project_name}-asg-up-alarm"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    namespace           = "AWS/EC2"
    metric_name         = "CPUUtilization"
    threshold           = "80"
    evaluation_periods  = "2"
    period              = "120"
    statistic           = "Average"

  dimensions = {
    AutoScalingGroupName = var.auto_scaling_group_name
    }
}