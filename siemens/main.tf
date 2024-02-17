
provider "aws" {
    region = var.region
    profile = var.profile
}

# Create vpc
module "vpc" {
  source                    = "../modules/vpc"
  region                    = var.region
  project_name              = var.project_name
  vpc_cidr                  = var.vpc_cidr
  public_subnet_az1_cidr    = var.public_subnet_az1_cidr
  public_subnet_az2_cidr    = var.public_subnet_az2_cidr
  private_subnet_az1_cidr   = var.private_subnet_az1_cidr
  private_subnet_az2_cidr   = var.private_subnet_az2_cidr
}

module "security_group" {
  source = "../modules/security-groups"
  vpc_id = module.vpc.vpc_id
}

module "alb" {
  source = "../modules/alb"
  project_name = module.vpc.project_name
  alb_sg_id = module.security_group.alb_sg_id
  public_subnet_az1_id = module.vpc.public_subnet_az1_id
  public_subnet_az2_id = module.vpc.public_subnet_az2_id
  vpc_id = module.vpc.vpc_id
}

module "asg" {
  source = "../modules/asg"
  project_name = module.vpc.project_name
  image_id = var.image_id
  instance_type = var.instance_type
  instance_sg_id = module.security_group.instance_sg_id
  private_subnet_az1_id = module.vpc.private_subnet_az1_id
  private_subnet_az2_id = module.vpc.private_subnet_az2_id
  alb_tg_arn = module.alb.alb_tg_arn
  # key_name = "${path.module}./ec2_key.pub"
}

module "bastion" {
  source = "../modules/ec2-bastion"
  public_subnet_az1_id = module.vpc.public_subnet_az1_id
  bastion_sg_id = module.security_group.bastion_sg_id
  PUBLIC_KEY = "${path.module}./bastion_rsa.pub"
}

module "route53" {
  source = "../modules/route53"
  vpc_id = module.vpc.vpc_id
  alias_name = module.alb.alb_dns_name
  alias_zone_id = module.alb.alb_zone_id
}

module "alarm" {
  source = "../modules/cloudwatch-alarm"
  project_name = module.vpc.project_name
  auto_scaling_down_policy_arn = module.asg.auto_scaling_down_policy_arn
  auto_scaling_group_name =  module.asg.auto_scaling_group_name
  auto_scaling_up_policy_arn = module.asg.auto_scaling_up_policy_arn
}

module "natgw" {
  source = "../modules/nat-gw"
  public_subnet_az1_id = module.vpc.public_subnet_az1_id
  internet_gateway = module.vpc.internet_gateway
  public_subnet_az2_id = module.vpc.public_subnet_az2_id
  vpc_id = module.vpc.vpc_id
  private_subnet_az1_id = module.vpc.private_subnet_az1_id
  private_subnet_az2_id = module.vpc.private_subnet_az2_id
}