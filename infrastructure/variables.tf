variable "cidr_block" {
  type        = string
  description = "Valor para el cidr block de la vpc"
}

variable "az_list" {
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
  description = "List of AZs to be deployed"
}

variable "public_subnet_ips" {
  type        = list(string)
  description = "List of ips to be assigned to public subnet"
}

variable "private_subnet_ips" {
  type        = list(string)
  description = "List of ips to be assigned to private subnet"
}

variable "frontend_instances_count" {
  type        = number
  description = "Number of frontend instances to be created"
}

variable "backend_instances_count" {
  type        = number
  description = "Number of backend instances to be created"
}