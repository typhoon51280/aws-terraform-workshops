## This directory contains terraform configuration for Smartling AWS/Terraform workshop #5 covered in blog post at [AWS/Terraform Workshop #5: AWS Lambda Functions](https://tech.smartling.com/aws-terraform-workshop-5-aws-lambda-functions-9af79af996b7)

---

### **Hands on:**


1. Go to w5 directory in cloned aws-terraform-workshops git repository.

2. **Create Autoscaling group** (ASG), attach ELB to ASG (`ec2.tf`,`elb.tf`,`autoscaling.tf`):

    2.1. Finish incomplete terraform configuration and be prepared to *fix mistakes*.
  
    2.2. Attach ELB to ASG (do not enable ELB checks for ASG, keep default EC2).

    2.3. Apply terraform configuration:
    ```
    $ terraform plan
    $ terraform apply
    ```

    2.4. Check AWS resources created in this step.

    2.5. Make sure ELB DNS name can be opened with browser -- it should show nginx welcome page.

3. Create SNS topic, subscribe your email to it.

4. Create Lambda function for monitoring nginx behind ELB, it will send the results to SNS (and to your mailbox).

    4.1. Finish incomplete terraform configuration to create Lambda function triggered by CloudWatch events every 5 minutes.

    4.2. Apply terraform configuration:
    ```
    $ terraform plan
    $ terraform apply
    ```

    4.3. Go to AWS Lambda console and change check URL and SNS in Lambda function’s code:

    > **Note:** *Make sure you specified actual DNS name of your ELB (**lb_public**)*

    4.4. Try to trigger Lambda function in console manually

    4.5. Check lambda function execution logs in CloudWatch.

5. Simulate service outage by stopping nginx at instance in ASG.

    5.1. Go to instance via SSH and run ‘sudo service docker stop’ command to shutdown container with nginx.

    5.2. Check that ELB doesn’t show nginx welcome page in browser anymore.

    5.3. Wait until Lambda function is executed by Cloudwatch schedule. Make sure your received email about failed web check to your mailbox.

6. Destroy AWS resources:
    ```
    $ terraform destroy
    ```
    