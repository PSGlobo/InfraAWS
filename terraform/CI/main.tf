resource "aws_vpc" "jenkins" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    "terraform" = ""
    "component" = "CI"
  }
}

resource "aws_subnet" "guiJenkins" {
  vpc_id            = aws_vpc.jenkins.id
  availability_zone = "sa-east-1a"
  cidr_block        = "10.0.1.0/24"
}

resource "aws_subnet" "buildersJenkins" {
  vpc_id            = aws_vpc.jenkins.id
  availability_zone = "sa-east-1b"
  cidr_block        = "10.0.2.0/24"
}