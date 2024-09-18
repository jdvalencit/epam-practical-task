variable "vpc_id" {
  type        = string
  description = "ID of the created VPC"
}

variable "public_subnets" {
  type        = list(string)
  description = "List of public subnets in the VPC"
}

variable "private_subnets" {
  type        = list(string)
  description = "List of private subnets in the VPC"
}

variable "bastion_ami" {
  type        = string
  default     = "ami-0e86e20dae9224db8"
  description = "AMI ID for bastion host instance"
}

variable "frontend_ami" {
  type        = string
  default     = "ami-0e86e20dae9224db8"
  description = "AMI ID for bastion front-end instances"
}

variable "backend_ami" {
  type        = string
  default     = "ami-0e86e20dae9224db8"
  description = "AMI ID for back-end instance"
}

variable "bastion_instance_type" {
  type        = string
  default     = "t2.micro"
  description = "Instance type for bastion host instance"
}

variable "frontend_instance_type" {
  type        = string
  default     = "t2.micro"
  description = "Instance type for frontend instance"
}

variable "backend_instance_type" {
  type        = string
  default     = "t2.micro"
  description = "Instance type for backend instance"
}

variable "bastion_key_pair" {
  type        = string
  default     = "ansible"
  description = "Key pair for bastion host instance"
}

variable "frontend_instances_count" {
  type        = number
  default     = 1
  description = "Number of frontend instances to be created"
}

variable "backend_instances_count" {
  type        = number
  default     = 1
  description = "Number of backend instances to be created"
}