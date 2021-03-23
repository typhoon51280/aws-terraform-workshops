# Specify missing or incomplete arguments according to documentation:
# Docs: https://www.terraform.io/docs/providers/aws/r/autoscaling_group.html
resource "aws_autoscaling_group" "w5" {
  launch_configuration = aws_launch_configuration.w5.name
  load_balancers = [ aws_elb.w5.name ]

  # availability_zones = [ "${var.availability_zone}" ]
  vpc_zone_identifier = [ var.subnet_id ]
  lifecycle { create_before_destroy = true }
  min_size = 1
  max_size = 1
  tag {
    key = "Name"
    value = var.ec2_tag_name
    propagate_at_launch = true
  }
}

resource "aws_launch_configuration" "w5" {
  security_groups = [ aws_security_group.w5.id ]
  user_data = file("user-data.txt")
  image_id = data.aws_ami.amazon_linux_2.id
  key_name = aws_key_pair.ec2_key.key_name
  instance_type = "t2.micro"
  lifecycle { create_before_destroy = true }
}

