## This directory contains terraform configuration for Smartling AWS/Terraform workshop #3 covered in blog post at [AWS/Terraform Workshop #3: ELB, SNS, AutoScaling](https://tech.smartling.com/aws-terraform-workshop-3-elb-sns-autoscaling-210e2337057f)

---

### **Hands on:**

1. Go to w3 directory in cloned Smartling/aws-terraform-workshops git repository.

2. Specify actual IDs of **AWS VPC**, **Subnet** and **Availability Zone** into `terraform.tfvars` file.

    > **Notes**: *Follow instructions in Hands On section of Workshop #2 or just copy terraform.tfvars file from it.*

3. **Create Autoscaling Group:**

    3.1. Configure security group for instances in ASG to accept incoming connections via 22 and 80 TCP ports from 0.0.0.0/0.

    > **Note:** *This is generally bad idea from security perspective to open access to your resources via 22 port from anywhere -- please avoid such setup in configurations other than workshop.*

    3.2. Add missing arguments for ASG in `autoscaling.tf` file:

    - Min instances limit = 2, max instances = 2
    - Instance type t2.nano
    - Add references between AWS resources: attach ASG launch configuration to autoscaling group etc.

    > **Note:** *Be prepared for mistakes made in terraform configuration intentionally – just fix them.*

    3.3. Apply terraform configuration
    ```
    $ terraform plan
    $ terraform apply
    ```

    3.4. Check newly created AWS resources in AWS web console.

4. **Create AWS ELB and attach it to ASG** created before.

    4.1. Uncomment resources in `elb.tf` and add finish configuration.

    4.2. Configure ELB Listener to accept HTTP connection on port 80 and forward them to port 80.

    4.3. Enable connection draining.
  
    4.4. Configure ELB health checks:

    - Ping Target: "HTTP:80/"
    - Healthy threshold = 3
    - Unhealthy threshold = 3
    - Timeout = 2
    - Interval = 5

    4.5. Put ELB in the same Security Group with instances in ASG.

    4.6. Attach  ELB to ASG in the `autoscaling.tf` file:
    - Update ASG configuration in terraform
    - Configure ASG to use ELB metrics instead of EC2

    4.7. Apply Terraform configuration
    ```
    $ terraform plan
    $ terraform apply
    ```

    4.8. Find ELB endpoint and open it in browser – you should see nginx welcome page.

5. **Create SNS topic** to receive ASG scaling notifications to email.

    5.1. Uncomment SNS topic resource in `sns.tf` file.
    
    5.2. Apply terraform configuration
    ```
    $ terraform plan
    $ terraform apply
    ```
  
    5.3. Go to AWS SNS web console, find newly created SNS topic and create subscription to your email address.
  
    5.4. Update ASG configuration to send its scaling events to SNS topic
  
    5.5. Apply terraform configuration
    ```
    $ terraform plan
    $ terraform apply
    ```
  
    5.6. Login to one of ec2 instances via SSH and stop docker:
    ```
    sudo systemctl stop docker
    ```
    
    5.7. ASG will detect that instance in unhealthy (as it doesn't reply to health checks), will terminate it and will create new. Make sure you received notification from ASG to your email.

6. Destroy AWS resources:
    ```
    $ terraform destroy
    ```
