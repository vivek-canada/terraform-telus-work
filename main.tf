provider "aws" {
  region = "ca-central-1"
}


module "vpc" {
  source              = "./modules/vpc"
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
}

module "security_groups" {
  source = "./modules/security_groups"
  vpc_id = module.vpc.vpc_id
}

module "autoscaling" {
  source              = "./modules/autoscaling"
  vpc_private_subnets = module.vpc.private_subnets
  target_group_arn    = module.elb.asg_tg_arn
}

module "elb" {
  source             = "./modules/elb"
  vpc_public_subnets = module.vpc.public_subnets
  vpc_id             = module.vpc.vpc_id
  alb_security_group = module.security_groups.lb_sg_id
}

module "iam" {
  source = "./modules/iam"
}
