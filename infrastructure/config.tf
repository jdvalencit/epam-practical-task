terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.58.0"
    }
  }

  backend "s3" {
    bucket         = "terraform-state-task"
    key            = "backend.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-state-table"
  }

}

provider "aws" {
  region = "us-east-1"
}
