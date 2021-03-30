## This directory contains terraform configuration for Smartling AWS/Terraform workshop #2 covered in blog post at [AWS/Terraform Workshop #2: EC2 Networking, Autoscaling Groups, CloudWatch](https://tech.smartling.com/aws-terraform-workshop-2-ec2-networking-autoscaling-groups-cloudwatch-12ee08c17)

---

### **Hands on:**

1. Login to AWS console, switch to proper AWS account (if you are using multiple accounts) and go to VPC Management Console.

    1.1. Go to VPC section, select Your VPCs section and write down VPC ID.
    
    1.2. Go to Subnets section, choose private subnet and write down its ID as well as Availability Zone that it's bound to.

2. Specify collected data in terraform configuration:

    2.2. Go to w2 directory in cloned aws-terraform-workshops git repository.

    2.3. Edit file terraform.tfvars: specify VPC ID, Subnet ID and AZ, for example:
    ```
    $ cat terraform.tfvars
    vpc_id = "vpc-1234567"
    subnet_id = "subnet-1234567"
    availability_zone_id = "us-east-1a"
    ```

3. Follow terraform documentation for ASG and comments in `autoscaling.tf` file to complete Auto Scaling Group and Launch Configuration.

    3.1. Add missing names for terraform resources.

    3.2. Configure launch configuration to create one t2.micro instance in security group that is created in `ec2.tf` file.

    3.3. Set min_size = 1 and max_size = 3 in ASG, cooldown 60 seconds.

    3.4. Apply terraform configuration:
    ```
    $ terraform plan
    $ terraform apply
    ```

    > **Note #1:** always run terraform plan before apply and examine what is actually terraform is going to change/create/delete in AWS.
    >
    > **Note #2:** you need to configure terraform with your AWS credentials here. There're multiple ways to do it and you can find one in [AWS/Terraform Workshop #1](../w1/README.md).

    3.5. Check newly created ASG in AWS EC2 Management Console. You should see Auto Scaling group, Launch Configuration and EC2 instance created by ASG.

4. Uncomment code in terraform configuration file `cloudwatch.tf` to create CloudWatch (CW) alarm to trigger ASG scaling up policy if total CPU load in ASG is more than 40%.

    4.1. Enable **EC2 detailed monitoring** for EC2 instances in ASG so that CloudWatch will collect metrics every 1 minute (*Hint: see docs for launch config terraform resource*).
 
    4.2. Configure CW alarm to add +1 instance if CPU load in ASG is more than 40%, cooldown = 60.
  
    4.3. Use CW alarm ARN to reference it in template.
  
    4.4. Apply terraform configuration.
  
    4.5. Check CW alarm in AWS web console.

5. Enable scaling protection for EC2 instance.

    5.1. Find your autoscaling group in AWS EC2 Management Console and go to "Instances" tab.
  
    5.2. Select and instance, click on "Actions->Instance protection->Set scale in protection".

6. Generate CPU load to trigger CloudWatch alarm and ASG scaling up process.
  
    6.1. Login to EC2 instance via SSH and run the following commands (retrieve public dns from aws console):
    ```
    $ ssh -i id_rsa ec2-user@<ec2_public>
    $ dd if=/dev/urandom bs=1M count=200096 | gzip -9 | gzip -9 | gzip -9 >/dev/null
    ```

    6.2. Review ASG events in AWS web console, see +2 instances in 2 minutes. You can see it in Activity History tab for ASG.

7. Add scale down policy to remove 1x Ec2 instance in case CPU load in ASG is less than 35%.
  
    7.1. Create new CW alarm that will trigger scale down ASG policy.
  
    7.2. Apply terraform configuration.

8. Watch scaling activity for Auto Scaling Group.

9. Destroy AWS resources.
  
    9.1. **Disable protection for instance in AWS web console.**
  
    9.2.. Run destroy command:
    ```
    $ terraform destroy
    ```

    *Note: It will take slightly more time to terminate all resources in AWS than in previous workshop.*