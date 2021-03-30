# Add missing and/or incomplete arguments to ec2 instance resource below.
# This instance will run Jenkins server, consider this when configuring it.
resource "aws_instance" "jenkins_ec2_instance" {

  # Specify missing arguments here

  vpc_security_group_ids = [ ]
  subnet_id = var.subnet_id
  iam_instance_profile = ""

  tags = {
    Name = "workshop4"
  }

  user_data = templatefile("files/user-data.txt.tmpl", {
    s3_bucket_name = aws_s3_bucket.bootstrap_scripts.bucket
  })

  # Keep these arguments as is:
  ami = data.aws_ami.amazon_linux_2.id
  instance_type = "t2.micro"
  associate_public_ip_address = true
  key_name = aws_key_pair.ec2_key.key_name
  depends_on = [ aws_s3_bucket_object.jenkins_bootstrap_script ]
}