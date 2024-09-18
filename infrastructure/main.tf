module "landing_zone" {
  source = "./modules/landing_zone"

  cidr_block         = var.cidr_block
  az_list            = var.az_list
  public_subnet_ips  = var.public_subnet_ips
  private_subnet_ips = var.private_subnet_ips
}

module "resources" {
  source = "./modules/resources"

  vpc_id                   = module.landing_zone.vpc_id
  public_subnets           = module.landing_zone.public_subnets
  private_subnets          = module.landing_zone.private_subnets
  frontend_instances_count = 1
  backend_instances_count  = 1
}