terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.40.0"
    }
  }
  backend "s3" {
    bucket = "terraform-state-infra-repository"
    key    = "infraRepository/state"
    region = "sa-east-1"
    dynamodb_table = "terraform-state-locking"
  }
}

provider "aws" {
  profile = "default"
  region = "sa-east-1"
}