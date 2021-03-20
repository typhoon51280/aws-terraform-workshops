terraform {
  backend "s3" {
    bucket = "terraform-20210320090230438800000001"
    key    = "terraform.tfstate"
    region = "eu-west-1"
    profile = "test"
  }
}