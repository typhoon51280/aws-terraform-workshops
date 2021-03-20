# 1. Create bucket for jenkins instance boostrap script
# 2. Save mentioned script as object at S3

resource "aws_s3_bucket" "bootstrap_scripts" {
  bucket = var.jenkins_bucket

  # Keep this argument as is
  acl = "private"
}

resource "aws_s3_bucket_object" "jenkins_bootstrap_script" {
  bucket = aws_s3_bucket.bootstrap_scripts.bucket
  key = "bootstrap-scripts/jenkins_bootstrap_script.sh"
  source = "files/jenkins_bootstrap_script.sh"
}
