# Specify missing or incomplete arguments according to documentation:
# Docs: https://www.terraform.io/docs/providers/aws/r/launch_configuration.html
resource "aws_launch_configuration" "launch_configuration" {
  security_groups = [ ]
  user_data = file("user-data.txt")
  instance_type = "t2.nano"

  # Keep these arguments
  image_id = data.aws_ami.amazon_linux_2.id
  key_name = aws_key_pair.ec2_key.key_name
  lifecycle { create_before_destroy = true }
}

# Specify missing or incomplete arguments according to documentation:
# Docs: https://www.terraform.io/docs/providers/aws/r/autoscaling_group.html
resource "aws_autoscaling_group" "workshop_autoscaling_group" {
  launch_configuration = ""
  
  health_check_type = "EC2"
  health_check_grace_period = 300

  # Attach ELB to ASG here:
  # Find whatever you need in terraform documentation
  load_balancers = [ ]

  # Keep these arguments
  vpc_zone_identifier = [ var.subnet_id ]
  lifecycle { create_before_destroy = true }

  tag {
    key = "Name"
    value = "workshop3"
    propagate_at_launch = true
  }
}

