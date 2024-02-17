output "public_ip" {
  value = aws_instance.bastion_host.public_ip
  description = "public ip of bastion host"
}