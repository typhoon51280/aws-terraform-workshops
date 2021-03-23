output "ec2_public" {
  value = aws_instance.w6-instance.public_dns
}

output "ec2_id" {
  value = aws_instance.w6-instance.id
}