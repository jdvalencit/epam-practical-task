module "landing_zone" {
  source = "./modules/landing_zone"

  cidr_block         = var.cidr_block
  az_list            = var.az_list
  public_subnet_ips  = var.public_subnet_ips
  private_subnet_ips = var.private_subnet_ips
}