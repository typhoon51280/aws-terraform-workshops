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
  enable_monitoring = false
}

# Specify missing arguments according to documentation:
# https://www.terraform.io/docs/providers/aws/r/autoscaling_group.html
resource "aws_autoscaling_group" "autoscaling_group" {
  min_size = 1
  max_size = 3
  launch_configuration = ""
  default_cooldown = 60

  # Keep below arguments
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
  autoscaling_group_name = ""
}

resource "aws_autoscaling_policy" "autoscale_group_policy_down_x1" {
  name = "autoscale_group_policy_down_x1"
  scaling_adjustment = -1
  adjustment_type = "ChangeInCapacity"
  cooldown = 60
  autoscaling_group_name = ""
}