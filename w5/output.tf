output "lb_public" {
  value = aws_elb.w5.dns_name
}
