provider "aws" {
    profile = "test"
    access_key = ""
    secret_key = ""
    region = "eu-west-1"
}

# Get latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}