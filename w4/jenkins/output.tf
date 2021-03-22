output "jenkins_public" {
  value = aws_instance.jenkins_ec2_instance.public_dns
}

output "jenkins_ec2" {
  value = aws_instance.jenkins_ec2_instance.id
}