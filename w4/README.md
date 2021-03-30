## This directory contains terraform configuration for Smartling AWS/Terraform workshop #4 covered in blog post at [AWS/Terraform Workshop #4: S3, IAM, Terraform remote state, Jenkins](https://tech.smartling.com/aws-terraform-workshop-4-s3-iam-terraform-remote-state-jenkins-71c0d7512bf1)

---

### **Hands on:**

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
  
    3.4. terraform plan and apply
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
