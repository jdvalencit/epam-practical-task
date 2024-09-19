output "vpc_id" {
  value = module.landing_zone.vpc_id
}

output "public_subnets" {
  value = module.landing_zone.public_subnets
}

output "private_subnets" {
  value = module.landing_zone.private_subnets
}

output "rds_endpoint" {
  value = module.resources.rds_endpoint
}