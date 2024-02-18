# Create IAM Role for ec2 to use cloudwatch agent policy

resource "aws_iam_role" "cloudwatch_role" {
  name = "cloud-watch-agent-role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "cloud-watch-agent-role"
  }
}

# Attach the cloud watch agent role created above to the policy
resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = aws_iam_role.cloudwatch_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

resource "aws_iam_instance_profile" "cloudwatchProfile" {
  name = "cloudwatch-profile"
  role = aws_iam_role.cloudwatch_role.name
}