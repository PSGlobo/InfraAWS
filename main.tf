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

resource "aws_s3_bucket" "state" {
  bucket = "terraformstateinfrarepository"
  acl = "private"
  force_destroy = false
  tags = {
    "terraform" = ""
  }
}

resource "aws_iam_user" "bia" {
  name = "BeatrizTantow"
}

resource "aws_iam_user" "luan" {
  name = "LuanBraga"
}

resource "aws_iam_user" "camille" {
  name = "CamilleTantow"
}

resource "aws_iam_user" "petrolifero" {
  name = "petrolifero"
}