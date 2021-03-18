# Uncomment resources below and add required arguments.

# resource "aws_key_pair" "deployer" {
#   public_key = file("../shared/id_rsa.pub")
# }

resource "aws_security_group" "w1_security_group" {
  # 1. Define logical names (identifiers) for resource.
  #    E.g.: resource "type" "resource_logical_name" {}
  #    Docs: https://www.terraform.io/docs/providers/aws/r/security_group.html

  # 2. Set psysical name of your security group below in format "yourname-"
  name = ""

  description = "Test security group."
  vpc_id = ""
  tags = merge(var.resource_tags, {
    Name: "w1_security_group"
  })
}

# To reference attributes of resources use syntax TYPE.NAME.ATTRIBUTE
#   for example, in order to create rule in specific secrurity group you will have to
#   refer security group by its name :
#     security_group_id = "${aws_security_group.mysecuritygroup.id}"
#
# Reference: https://www.terraform.io/docs/configuration/interpolation.html


resource "aws_security_group_rule" "ssh_ingress_access" {
  # 1. Add required arguments to open ingress(incoming) traffic to TCP port 22 - we'll use it later to ssh into instance.
  # 2. Add argument to reference Security Group resource.
  # Docs: https://www.terraform.io/docs/providers/aws/r/security_group_rule.html
  
  # ...
 
  security_group_id = aws_security_group.w1_security_group.id
  cidr_blocks = [ "0.0.0.0/0" ]
  type = "ingress"
  protocol = "tcp"
  from_port = 22
  to_port = 22
}


resource "aws_security_group_rule" "egress_access" {
  # 1. Add required arguments to open outgoing traffic to all ports (0-65535) 
  # 2. Add argument to reference Security Group resource.
  # Docs: https://www.terraform.io/docs/providers/aws/r/security_group_rule.html
  
  # ...
  
  security_group_id = aws_security_group.w1_security_group.id
  cidr_blocks = [ "0.0.0.0/0" ]
  type = "egress"
  protocol = "tcp"
  from_port = 0
  to_port = 65535
}


resource "aws_instance" "w1_instance" {
  # 1. Add resource name.
  # 2. Specify VPC subnet ID
  # 3. Specify EC2 instance type.
  # 4. Specify Security group for this instance (use one that we create above).
  # Docs: https://www.terraform.io/docs/providers/aws/r/instance.html

  # subnet_id = ""

  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.w1_security_group.id]
  associate_public_ip_address = true
  user_data = file("../shared/user-data.txt")
  tags = merge(var.resource_tags, {
    Name = "w1-instance"
  })
  
  # Keep these arguments as is:
  ami = data.aws_ami.amazon_linux_2.id
  availability_zone = "eu-west-1c"
  key_name = aws_key_pair.ec2_key.key_name
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

variable "resource_tags" {
  description = "Tags to set for all resources"
  type        = map(string)
  default = {
    workshop_name = "aws-terraform-base"
    workshop_lab = "workshop1-ec2"
    worshop_user = "vincenzo delloste"
  }
}