## This directory contains terraform configuration for Smartling AWS/Terraform workshop #5 covered in blog post at [AWS/Terraform Workshop #5: AWS Lambda Functions](https://tech.smartling.com/aws-terraform-workshop-5-aws-lambda-functions-9af79af996b7)

---

### **Hands on:**


1. Go to w5 directory in cloned aws-terraform-workshops git repository.

    1.1. Specify actual IDs of **AWS VPC**, **Subnet** and **Availability Zone** into `terraform.tfvars` file.

    > **Notes**: *Follow instructions in Hands On section of Workshop #2 or just copy values from it.*

2. **Create Autoscaling group** (ASG), attach ELB to ASG (`ec2.tf`,`elb.tf`,`autoscaling.tf`):

    2.1. Finish incomplete terraform configuration and be prepared to *fix mistakes*
  
    2.2. Attach ELB to ASG (do not enable ELB checks for ASG, keep default EC2).

    2.3. Apply terraform configuration:
    ```
    $ terraform plan
    $ terraform apply
    ```

    2.4. Check AWS resources created in this step.

    2.5. Make sure ELB DNS name can be opened with browser -- it should show nginx welcome page.

3. Create Lambda function for monitoring nginx behind ELB, it will send the results to SNS (and to your mailbox).

    3.1. Finish incomplete terraform configuration (`iam.tf`, `lambda.tf`) to create Lambda function triggered by CloudWatch events every 5 minutes.

    3.2. Finish incomplete terraform configuration `sns.tf` to create SNS topic.

    3.3. Apply terraform configuration:
    ```
    $ terraform plan
    $ terraform apply
    ```

    3.4. Subscribe your email to the topic created.

    3.5. Go to AWS Lambda console and change **check URL** and **SNS topic** in Lambda function’s code:

    > **Note:** *Make sure you specified actual DNS name of your ELB (**lb_public**)* and arn of the topic (**sns_topic**).

    3.6. Try to trigger Lambda function in console manually

    3.7. Check lambda function execution logs in CloudWatch.

4. Simulate service outage by stopping nginx at instance in ASG.

    4.1. Login to the ec2 instance (retrieve public dns from the aws console) via SSH and stop docker to shutdown container with nginx:
    ```
    ssh -i id_rsa ec2-user@<ec2_public_dns>
    sudo systemctl stop docker
    ```

    4.2. Check that ELB doesn’t show nginx welcome page in browser anymore.

    4.3. Wait until Lambda function is executed by Cloudwatch schedule. Make sure your received email about failed web check to your mailbox.

5. Destroy AWS resources:
    ```
    $ terraform destroy
    ```
    