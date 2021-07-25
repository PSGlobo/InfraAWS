resource "aws_vpc" "ldap" {
  cidr_block       = "10.1.0.0/16"
  instance_tenancy = "default"

  tags = {
    "terraform" = ""
    "component" = "HR"
  }
}
