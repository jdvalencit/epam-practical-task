module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "vpc-${terraform.workspace}"
  cidr = var.cidr_block

  azs             = var.az_list
  private_subnets = var.private_subnet_ips
  public_subnets  = var.public_subnet_ips

  enable_nat_gateway = true

  #If the workspace is set to qa there will only be 1 nat deployed
  single_nat_gateway = terraform.workspace == "qa" ? true : false
}