# Uncomment and add missing arguments here. Keep rest configuration as is.
/*
resource "aws_sns_topic" "scale_notifications" {
  name_prefix = "w6-"
}

resource "aws_autoscaling_notification" "ecs_asg_up_notifications" {
  group_names = 
  notifications  = [
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_TERMINATE"
  ]
  topic_arn = aws_sns_topic.scale_notifications.arn
}
*/
