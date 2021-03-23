output "lb_public" {
  value = aws_elb.w5.dns_name
}

output "sns_topic" {
  value = aws_sns_topic.w5.arn
}
