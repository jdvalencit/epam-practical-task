resource "aws_vpc" "vpc-task" {
  cidr_block = var.cidr_block
  tags = {
    "Name" = "vpc-${terraform.workspace}"
  }

}