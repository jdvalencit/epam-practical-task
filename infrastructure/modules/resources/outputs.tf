output "bastion_host_ip" {
  value = aws_instance.bastion_host.public_ip
}

output "frontend_ip" {
  value = [for instance in aws_instance.frontend_instance : instance.public_ip]
}

output "backend_ip" {
  value = [for instance in aws_instance.backend_instance : instance.private_ip]
}

output "rds_endpoint" {
  value = aws_db_instance.rds_instance.endpoint
}