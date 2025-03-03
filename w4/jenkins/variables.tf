variable "vpc_id" {
  description = "VPC ID for AWS resources."
}

variable "availability_zone_id" {
  description = "AZ used to create EC2 instances."
}
variable "subnet_id" {
  description = "Subnet for EC2 instances."
}

variable "jenkins_username" {
  description = "Jenkins Admin username"
  default = "admin"
}

variable "jenkins_password" {
  description = "Jenkins Admin password"
  default = "password"
}
