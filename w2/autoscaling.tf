# Get latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

# Specify missing arguments according to documentation:
# https://www.terraform.io/docs/providers/aws/r/launch_configuration.html
resource "aws_launch_configuration" "launch_configuration" {
  security_groups = [aws_security_group.w2_security_group.id]
  user_data = file("../shared/user-data.txt")

  # Keep below arguments 
  lifecycle { create_before_destroy = true }
  instance_type = "t2.micro"
  image_id = data.aws_ami.amazon_linux_2.id
  key_name = aws_key_pair.ec2_key.key_name
}

# Specify missing arguments according to documentation:
# https://www.terraform.io/docs/providers/aws/r/autoscaling_group.html
resource "aws_autoscaling_group" "autoscaling_group" {
  min_size = 1
  max_size = 3
  launch_configuration = aws_launch_configuration.launch_configuration.name
  default_cooldown = 60

  # Keep below arguments
  # availability_zones = [ var.availability_zone_id ]
  vpc_zone_identifier = [ var.subnet_id ]

  tag {
    key = "Name"
    value = "workshop2"
    propagate_at_launch = true
  }

  lifecycle { create_before_destroy = true }
}


# Uncomment and specify arguments according to documentation and workshop guide:
# https://www.terraform.io/docs/providers/aws/r/autoscaling_policy.html
resource "aws_autoscaling_policy" "autoscale_group_policy_up_x1" {
  name = "autoscale_group_policy_up_x1"
  scaling_adjustment = 1
  adjustment_type = "ChangeInCapacity"
  cooldown = 60
  autoscaling_group_name = aws_autoscaling_group.autoscaling_group.name
}

resource "aws_autoscaling_policy" "autoscale_group_policy_down_x1" {
  name = "autoscale_group_policy_down_x1"
  scaling_adjustment = -1
  adjustment_type = "ChangeInCapacity"
  cooldown = 60
  autoscaling_group_name = aws_autoscaling_group.autoscaling_group.name
}