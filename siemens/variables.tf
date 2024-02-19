variable "region" {
  description = "Region of AWS account"
  type = string
}

variable "profile" {
  description = "profile of AWS account"
  type = string
}

variable "project_name" {
  description = "Name of the project"
  type = string
}

variable "image_id" {
  description = "Name of the project"
  type = string
}

variable "instance_type" {
  description = "Name of the project"
  type = string
}

variable "vpc_cidr" {
  description = "Name of the project"
  type = string
}

variable "public_subnet_az1_cidr" {
  description = "Name of the project"
  type = string
}

variable "public_subnet_az2_cidr" {
  description = "Name of the project"
  type = string
}

variable "private_subnet_az1_cidr" {
  description = "Name of the project"
  type = string
}

variable "private_subnet_az2_cidr" {
  description = "Name of the project"
  type = string
}

variable "sns_endpoint" {
  description = "endpoint for notification"
  type = string
}