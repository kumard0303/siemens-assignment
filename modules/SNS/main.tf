# Create SNS topic
resource "aws_sns_topic" "email" {
  name = "email"
}

resource "aws_sns_topic_subscription" "sns_subscription" {
  topic_arn = aws_sns_topic.email.arn
  protocol  = "email"
  endpoint  = var.endpoint
}