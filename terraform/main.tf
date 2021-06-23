terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.40.0"
    }
  }
  backend "s3" {
    bucket         = "terraform-state-infra-repository"
    key            = "infraRepository/state"
    region         = "sa-east-1"
    dynamodb_table = "terraform-state-locking"
  }
}

provider "aws" {
  region = "sa-east-1"
}


resource "aws_s3_bucket" "state" {
  bucket        = "terraform-state-infra-repository"
  acl           = "private"
  force_destroy = false
  tags = {
    "terraform" = ""
  }
}

resource "aws_dynamodb_table" "lockState" {
  name     = "terraform-state-locking"
  hash_key = "LockID"
  tags = {
    "terraform" = ""
  }
  attribute {
    name = "LockID"
    type = "S"
  }
  write_capacity = 5
  read_capacity  = 5
}

resource "aws_iam_user" "bia" {
  name = "BeatrizTantow"
}

resource "aws_iam_user" "canellas" {
  name = "EduardoCanellas"
}

resource "aws_iam_user" "petrolifero" {
  name = "petrolifero"
}


module "CI" {
  source = "./CI"
}

module "authentication" {
  source = "./ldap"
}

