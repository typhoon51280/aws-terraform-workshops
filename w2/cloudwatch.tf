# Uncomment and specify resource arguments below according to documentation and workshop guide:
# https://www.terraform.io/docs/providers/aws/r/cloudwatch_metric_alarm.html

/*
resource "aws_cloudwatch_metric_alarm" "cpu_high_alarm" {
  alarm_name = "w2-alarm-cpu-high"
  alarm_description = "This alarm triggers when CPU load in Autoscaling group is high."
 
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.autoscaling_group.name
  }
  statistic = "Average"

  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = "1"
  
  period = 
  threshold = 
  
  # Use autoscaling policy ARN as an alarm action here
  # Reference: http://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html
  alarm_actions = [
    
  ]
}
*/

/*
resource "aws_cloudwatch_metric_alarm" "log_high_alarm" {
  alarm_name = "w2-alarm-cpu-low"
  alarm_description = "This alarm triggers when CPU load in Autoscaling group is low."

  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.autoscaling_group.name
  }
  statistic = "Average"

  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods = "1"

  period = 
  threshold = 

  # Use autoscaling policy ARN as an alarm action here
  # Reference: http://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html
  alarm_actions = [
    
  ]
}
*/
