output "bastion_host_public_ip" {
  value = module.bastion.public_ip
  description = "public ip of bastion host"
}

output "alb_dns" {
  value = module.alb.alb_dns_name
  description = "dns of alb"
}