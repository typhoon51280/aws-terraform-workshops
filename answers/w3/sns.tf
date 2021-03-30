# Specify name of SNS topic
# Docs: https://www.terraform.io/docs/providers/aws/r/sns_topic.html
resource "aws_sns_topic" "workshop-sns" {
  name_prefix = "workshop3-"
}

# Specify arguments according to documentation
# Docs: https://www.terraform.io/docs/providers/aws/r/autoscaling_notification.html
resource "aws_autoscaling_notification" "autoscaling_notification" {
  group_names = [ aws_autoscaling_group.workshop_autoscaling_group.name ]
  topic_arn = aws_sns_topic.workshop-sns.arn
  notifications  = [ "autoscaling:EC2_INSTANCE_LAUNCH", "autoscaling:EC2_INSTANCE_TERMINATE" ]
}