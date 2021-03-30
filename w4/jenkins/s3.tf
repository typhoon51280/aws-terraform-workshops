# 1. Create bucket for jenkins instance boostrap script
# 2. Save mentioned script as object at S3

resource "aws_s3_bucket" "bootstrap_scripts" {
  bucket_prefix = "workshop4-jenkins-"

  # Keep this argument as is
  acl = "private"
}

resource "aws_s3_bucket_object" "jenkins_bootstrap_script" {
  bucket = aws_s3_bucket.bootstrap_scripts.bucket
  key = "bootstrap-scripts/jenkins_bootstrap_script.sh"
  content = file("files/jenkins_bootstrap_script.sh")
}

resource "aws_s3_bucket_object" "jenkins_configuration_script" {
  bucket = aws_s3_bucket.bootstrap_scripts.bucket
  key = "bootstrap-scripts/jenkins.yaml"
  content = templatefile("files/jenkins.yaml.tmpl", {
    username = var.jenkins_username
    password = bcrypt(var.jenkins_password)
  })
}
