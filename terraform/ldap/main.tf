resource "aws_iam_user" "HR" {
  name = "HR"
}

resource "aws_vpc" "ldap" {
  cidr_block       = "10.1.0.0/16"
  instance_tenancy = "default"

  tags = {
    "terraform" = ""
    "component" = "HR"
  }
}

resource "aws_subnet" "ldap1" {
  vpc_id            = aws_vpc.ldap.id
  availability_zone = "sa-east-1a"
  cidr_block        = "10.1.1.0/24"
}

resource "aws_subnet" "ldap2" {
  vpc_id            = aws_vpc.ldap.id
  availability_zone = "sa-east-1b"
  cidr_block        = "10.1.2.0/24"
}

resource "aws_subnet" "PKIRoot" {
  vpc_id            = aws_vpc.ldap.id
  availability_zone = "sa-east-1c"
  cidr_block        = "10.1.3.0/24"
}

resource "aws_directory_service_directory" "ldap" {
  name     = "corp.bbbfake.com"
  password = "SuperSecretPassw0rd"
  edition  = "Standard"
  type     = "MicrosoftAD"

  vpc_settings {
    vpc_id     = aws_vpc.ldap.id
    subnet_ids = [aws_subnet.ldap1.id, aws_subnet.ldap2.id]
  }

  tags = {
    "terraform" = ""
    "component" = "HR"
  }
}

resource "aws_instance" "microsoftPKIRoot" {
  ami           = "ami-03ea5c5403c5bcc24"
  instance_type = "t2.medium"
  subnet_id     = aws_subnet.PKIRoot.id
}