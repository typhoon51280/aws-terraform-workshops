# Add missing and/or incomplete arguments to ec2 instance resource below.
# This instance will run Jenkins server, consider this when configuring it.
resource "aws_instance" "jenkins_ec2_instance" {

  # Specify missing arguments here

  vpc_security_group_ids = [ aws_security_group.w4-jenkins.id ]
  subnet_id = var.subnet_id

  tags = {
    Name = var.ec2_tag_name
  }

  user_data = templatefile("files/user-data.txt.tmpl", {
    s3_bucket_name = aws_s3_bucket.bootstrap_scripts.bucket
  })

  # Keep these arguments as is:
  ami = data.aws_ami.amazon_linux_2.id
  instance_type = "t2.micro"
  associate_public_ip_address = true
  iam_instance_profile = aws_iam_instance_profile.w4-profile.name
  key_name = aws_key_pair.ec2_key.key_name
  depends_on = [ aws_s3_bucket_object.jenkins_bootstrap_script ]
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