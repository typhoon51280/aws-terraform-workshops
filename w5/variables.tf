variable "vpc_id" {
  description = "VPC ID for AWS resources."
}

variable "availability_zone_id" {
  description = "AZ used to create EC2 instances."
}

variable "subnet_id" {
  description = "Subnet for EC2 instances."
}

variable "ec2_tag_name" {
  description = "Tag Name for EC2 instances."
  default = "workshop-5"
}