## This directory contains terraform configuration for Smartling AWS/Terraform workshop #6 covered in blog post at [AWS/Terraform Workshop #6: EC2 Container Service, AWS Lambda](https://tech.smartling.com/aws-terraform-workshop-6-ec2-container-service-aws-lambda-9e60686c1f71)

---

### **Hands on:**


1. **Create EC2 instance** with IAM role with full access to AWS.

    > **Note:** *there are no intentional mistakes or confusions at this step. But next sections in this workshop still contain some so you'll need to fix them.*

    1.1. Go to w6/workshop_part_1 directory in cloned aws-terraform-workshops git repository.

    1.2. Configure terraform to create IAM role, security group and EC2 instance.

    1.3. Make sure that user data for EC2 instance contains your SSH key.

    1.4. Apply terraform configuration:
    ```
    $ terraform plan
    $ terraform apply
    ```

    1.5. Login to newly created EC2 instance via SSH (retrieve `<ec-public>` from terraform output).
    ```
    $ ssh -i id_rsa ec2-user@<ec2_public>
    ```

    1.6. Checkout git repository with terraform workshops.
    ```
    $ git clone https://github.com/typhoon51280/aws-terraform-workshops
    $ cd aws-terraform-workshops/w6/workshop_part_2
    ```


2. **Create ASG and ECS cluster** with EC2 instance registered in it.

    > **Note:** *Credentials for Terraform are not required for these steps as “terraform apply” will be executed on EC2 instance which has full access to AWS.*

    2.1. Go to w6/workshop_part_2 directory at newly created EC2 instance and configure terraform to create ECS cluster. You may use vim, nano or mcedit command line text editors.

    2.2. Apply terraform configuration:
    ```
    $ terraform plan
    $ terraform apply
    ```
    > **Note:** *At this step you should run terraform in w6/workshop_part_2 directory at newly created EC2 instance.*

    2.3. Go to AWS ECS console to see newly created ECS cluster.

    2.4. Configure terraform to create Auto Scaling Group and instances registered in this ECS cluster.

    2.5. Check AWS ECS web console to see new container instance.

3. **Create ECS service** with ELB attached to it.

    3.1. Configure terraform to create sample ECS service with ELB (*notice ignore_changes configuration in ECS service definition*).
    
    3.2. Apply terraform configuration:
    ```
    $ terraform plan
    $ terraform apply
    ```

    3.3. Use ELB DNS name to open sample service in browser: check events for ECS service in AWS web console to see why tasks aren’t starting at container instance.

    3.4. Adjust terraform configuration and apply it to fix the issue.

4. Initiate **deployment to ECS service**.

    4.1. Change docker image name from **anosulchik/workshop-sample-application:v1.0** to **anosulchik/workshop-sample-application:v2.0** in containers.txt that defines containers in ECS task.

    4.2. Apply Terraform configuration.
    ```
    $ terraform plan
    $ terraform apply
    ```

    4.3. Use ELB DNS name to open sample service in browser: You should see the new version v2.0 of the sample application here.


5. **Create Lambda** function to sync ASG desired EC2 instances capacity with ECS desired tasks count.

    5.1. Configure terraform to bind SNS topic used by ASG to send notifications to trigger Lambda function.

    5.2. Apply Terraform configuration.
    ```
    $ terraform plan
    $ terraform apply
    ```

    5.3. Uncomment resource in lambda.tf and apply terraform configuration.

    5.4. Change min_size = max_size = 2 in ASG configuration.

    5.5. Check Lambda function’s logs and ECS service desired count value in web console (you should see desired_count = 2 here applied by Lambda).

    5.6. Change min_size = max_size = 1 in ASG configuration.

6. **Destroy AWS resources** created in this workshop.
    > **Note:** *Order is extremely important here — run Terraform destroy at EC2 instance first, then locally.*

    6.1. Run `terraform destroy` command on EC2 instance where you logged into via SSH, in the **w6/workshop_part_2** directory.

    6.2. Run `terraform destroy' on your computer in **w6/workshop_part_1** directory.


1. Go to w4 directory in cloned aws-terraform-workshops git repository.

2. **Create S3 bucket** for terraform remote state:
    
    2.1. cd remote_state, edit file `s3.tf`

    2.2. Define S3 bucket in terraform configuration (make sure versioning is enabled for it).
    
    2.3. Apply terraform configuration:
    ```
    $ terraform plan
    $ terraform apply
    ```
    > **Note:** keep track of s3_bucket_name output variable (to be used as remote state).

    2.4. `cd ../jenkins`

    2.5. Configure terraform to use newly created S3 bucket as a remote state, edit `backend.tf` with the s3 bucket information

3. **Deploy Jenkins** using terraform.

    3.1. Specify actual IDs of **AWS VPC**, **Subnet** and **Availability Zone** into `terraform.tfvars` file.

    > **Notes**: *Follow instructions in Hands On section of Workshop #2 or just copy values from it.*

    3.2. Change jenkins username and password in `terraform.tfvars` file.

    3.3. Define missing resources in terraform configuration according to comments ***.tf** files
  
    3.4. Apply terraform configuration:
    ```
    $ terraform plan
    $ terraform apply
    ```
  
    3.5. Get public IP address of EC2 instance that hosts Jenkins (output variable **jenkins_public**) and open *http://<jenkins_public>:8000* in the browser.

    > **Note:** *it takes about 4 minutes for Jenkins to bootstrap before it shows welcome/installation page.*

    3.6. Enter username and password configured in `terraform tfvars` and launch sample job **testjobs/demo**

4. **Destroy AWS resources** using `terraform destroy` command.

    4.1. Destroy EC2 jenkins:
    ```
    $ cd jenkins
    $ terraform destroy
    ```

    4.2. Destroy S3 bucket remote state:

    > **Note:** *terraform can't delete S3 bucket because it’s not empty so you may need to go to S3 web console and delete all files and all their versions for remote tfstate file.*
    
    ```
    $ cd ../remote_state
    $ terraform destroy
    ```
