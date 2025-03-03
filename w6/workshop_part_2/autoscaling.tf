# keep as is.

resource "aws_autoscaling_group" "w6-asg" {
  launch_configuration = aws_launch_configuration.w6-lc.name
  load_balancers = [ aws_elb.w6-elb.name ]

  vpc_zone_identifier = [ var.subnet_id ]
  lifecycle { create_before_destroy = true }
  min_size = 1
  max_size = 1
}

resource "aws_launch_configuration" "w6-lc" {
  name_prefix = "w6-"
  iam_instance_profile = aws_iam_instance_profile.w6-instance-profile.id
  security_groups = [ aws_security_group.w6-sg.id ]

  user_data = templatefile("files/user-data.txt.tmpl", {
    cluster_name = aws_ecs_cluster.w6-ecs-cluster.name
  })

  depends_on = [ aws_iam_instance_profile.w6-instance-profile ]

  image_id = data.aws_ami.amazon_linux_2.id
  key_name = aws_key_pair.ec2_key.key_name
  instance_type = "t2.micro"
  lifecycle { create_before_destroy = true }
}
