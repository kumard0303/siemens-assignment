output "sns_topic_arn" {
  value = aws_sns_topic.email.arn
}

output "aws_sns_topic_subscription_arn" {
  value = aws_sns_topic_subscription.sns_subscription.arn
}