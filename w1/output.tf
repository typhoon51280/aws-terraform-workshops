output "ec2_public" {
  value = aws_instance.w1-instance.public_dns
}

output "ec2_id" {
  value = aws_instance.w1-instance.id
}