terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.58.0"
    }
  }

  backend "s3" {
    bucket = "value"
    key = "value"
    region = "value"
    encrypt = true
    dynamodb_table = "value"
    
  }

}

provider "aws" {
    access_key = ""
    secret_key = ""
  region = "us-east-1"
}
