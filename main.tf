terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.40.0"
    }
  }
  backend "s3" {
    bucket = "terraformstateinfrarepository"
    key    = "infraRepository/state"
    region = "sa-east-1"
    dynamodb_table = "terraformstatelocking"
  }
}

provider "aws" {
  profile = "default"
  region = "sa-east-1"
}