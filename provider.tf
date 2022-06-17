# Terraform Block
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}





# Provider Block
provider "aws" {
  region = "eu-west-2"
  profile = "default"
}