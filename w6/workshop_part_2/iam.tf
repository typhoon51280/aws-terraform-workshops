# Uncomment and add missing arguments here. Keep rest configuration as is.

resource "aws_iam_instance_profile" "w6-instance-profile" {
  # name =
  role = aws_iam_role.w6-role.name
}

resource "aws_iam_role" "w6-role" {
  # name =
  assume_role_policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    },
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    },
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "s3-policy" {
  name = "aws-limited-access"
  role = aws_iam_role.w6-role.id
  policy = <<EOF
{
  "Statement": [{
    "Effect": "Allow",
    "Action": [
      "elasticloadbalancing:*",
      "autoscaling:DescribeAutoScalingGroups",
      "ec2-instance-connect:*",
      "ecs:*",
      "logs:*"
    ],
    "Resource": "*"
  }]
}
EOF
}
