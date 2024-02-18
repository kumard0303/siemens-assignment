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

#Creating access log group
resource "aws_cloudwatch_log_group" "access" {
  name = "access.log"
}

#Creating error log group
resource "aws_cloudwatch_log_group" "error" {
  name = "error.log"
}

# Creating matric filter
resource "aws_cloudwatch_log_metric_filter" "filter_error" {
  name           = "ErrorFilter"
  log_group_name = aws_cloudwatch_log_group.error.name
  pattern        = "error"
  metric_transformation {
    name      = "filter_error"
    namespace = "ImportantMetrics"
    value     = "1"
  }
}

# creating alarm
resource "aws_cloudwatch_metric_alarm" "alarm_on_error" {
  alarm_name = "alarm_on_error"
  metric_name         = aws_cloudwatch_log_metric_filter.filter_error.name
  threshold           = "0"
  statistic           = "Sum"
  comparison_operator = "GreaterThanThreshold"
  datapoints_to_alarm = "1"
  evaluation_periods  = "1"
  period              = "60"
  namespace           = "ImportantMetrics"
  alarm_actions       = [var.sns_topic]
}

