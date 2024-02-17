output "region" {
  value = var.region
  description = "region for AWS account"
}

output "project_name" {
  value = var.project_name
  description = "Project name"
}

output "vpc_id" {
  value = aws_vpc.vpc.id
  description = "vpc id"
}

output "public_subnet_az1_id" {
  value = aws_subnet.public_subnet_az1.id
  description = "public subnet id from az1"
}

output "public_subnet_az2_id" {
  value = aws_subnet.public_subnet_az2.id
  description = "public subnet from az2"
}

output "private_subnet_az1_id" {
  value = aws_subnet.private_app_subnet_az1.id
  description = "private subnet id from az1"
}

output "private_subnet_az2_id" {
  value = aws_subnet.private_app_subnet_az2.id
  description = "private subnet id from az2"
}

output "internet_gateway" {
  value = aws_internet_gateway.internet_gateway
  description = "internet gw"
}