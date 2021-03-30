terraform {
  backend "s3" {
    bucket = "workshop4-remote-20210330210740341600000001"
    key    = "terraform.tfstate"
    region = "eu-west-1"
    profile = "test"
  }
}