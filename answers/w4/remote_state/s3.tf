# Create S3 bucket that will be used to store terraform remote state
# Make sure that versioning is enabled for bucket

resource "aws_s3_bucket" "tf-remote-state-bucket" {
  bucket_prefix = var.s3_bucket_prefix
  acl = "private"
  versioning {
    enabled = true
  }
}

output "s3_bucket_name" {
  value = aws_s3_bucket.tf-remote-state-bucket.bucket
}