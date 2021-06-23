data "amazon-ami" "microsoftPKI" {
  filters = {
    image-id = "ami-03ea5c5403c5bcc24"
  }
}