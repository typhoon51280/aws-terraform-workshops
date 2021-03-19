# Get latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

# Specify missing or incomplete arguments according to documentation:
# Docs: https://www.terraform.io/docs/providers/aws/r/launch_configuration.html
resource "aws_launch_configuration" "launch_configuration" {
  security_groups = [ aws_security_group.workshop_security_group.id ]
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
  min_size = 2
  max_size = 2
  launch_configuration = aws_launch_configuration.launch_configuration.name
  
  health_check_type = "ELB"
  health_check_grace_period = 300

  # Attach ELB to ASG here:
  # Find whatever you need in terraform documentation
  load_balancers = [ aws_elb.workshop_elb.name ]

  # Keep these arguments
  # availability_zones = [ var.availability_zone_id ]
  vpc_zone_identifier = [ var.subnet_id ]
  lifecycle { create_before_destroy = true }

  tag {
    key = "Name"
    value = var.ec2_tag_name
    propagate_at_launch = true
  }
}

# Specify arguments according to documentation
# Docs: https://www.terraform.io/docs/providers/aws/r/autoscaling_notification.html
resource "aws_autoscaling_notification" "autoscaling_notification" {
  group_names = [ aws_autoscaling_group.workshop_autoscaling_group.name ]
  topic_arn = aws_sns_topic.workshop-sns.arn
  notifications  = [ "autoscaling:EC2_INSTANCE_LAUNCH", "autoscaling:EC2_INSTANCE_TERMINATE" ]
}

