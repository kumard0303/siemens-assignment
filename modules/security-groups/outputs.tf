output "alb_sg_id" {
  value = aws_security_group.alb_security_group.id
  description = "id of application load balancer"
}

output "instance_sg_id" {
  value = aws_security_group.instance.id
  description = "id of instance security group"
}

output "bastion_sg_id" {
  value = aws_security_group.bastion_security_group.id
  description = "id of bastion security group"
}