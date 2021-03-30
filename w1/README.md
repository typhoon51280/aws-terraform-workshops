## This directory contains terraform configuration for Smartling AWS/Terraform workshop #1 covered in blog post at [Getting started with Terraform and AWS EC2, first steps. Workshop #1](https://tech.smartling.com/getting-started-with-terraform-and-aws-ec2-first-steps-workshop-1-e38607f0fd4c)

---

### **Hands on:**

1. Clone git repository with workshop data, go to w1 directory:
    ```
    $ git clone https://github.com/typhoon51280/aws-terraform-workshops.git
    $ cd aws-terraform-workshops/w1
    ```

2. Configure Terraform with AWS credentials (see pre-requisites) with profile = "test" but if you encounter problems with the aws cli configuration you can fill in the `providers.tf` configuration file with your credentials (not best practice):
    ```
    $ cat creds.tf
    provider "aws" {
    access_key = "THISISEXAMPLETHISISEXAMPLE"
    secret_key = "THISISEXAMPLE/kToJ5qUtCpxr/THISISEXAMPLE"
    region = "eu-west-1"
    }
    ```
3. Follow terraform documentation for EC2 instance and comments in `ec2.tf` to complete configuration: 
       
    3.1. Go to AWS VPC console, write down VPC ID and subnet ID which are required to complete configuration. 
    
    > **Please notice that VPC and subnets are covered in details in the next workshops but they are still required to finish EC2 configuration**

    3.2. Use t2.nano as instance type for EC2 instance.
    
    3.3. You should specify names for AWS resources as well as missing configuration parameters.

    3.4. In this workshop we need to create EC2 instance in its own security group, see documentation [here](https://www.terraform.io/docs/providers/aws/r/security_group.html).
    
    3.5. Run `terraform init` to download locally all necessary plugins.

    3.6. Run `terraform plan` to make sure configuration is ready to be applied.

    3.7. Run `terraform apply` to actually create AWS resources: EC2 security group and EC2 instance.

4. Go to AWS console and find newly created EC2 instance and security group.

5. Open terraform.tfstate to examine its structure and newly created AWS resources. Please don't make any changes into this file. It's managed by terraform so manual changes into this file may break things up.

6. Modify EC2 instance type:

    6.1. Change EC2 instance type from t2.nano to t2.micro.

    6.2. Run `terraform plan` and then `terraform apply` to actually apply changes.

    6.3. Check changes in AWS EC2 web console.

7. Login to EC2 instance via SSH and execute some commands to check if it's working correctly. 

    > In order to do so use the EC2 public dns from the output of the command `terraform apply`. The private key file is automatically generated in the current directory with the filename **id_rsa** (the public key is **id_rsa.pub**)

    7.1. Login to newly created EC2 instance via SSH (replace *<ec2_public>* with your newly created instance public dns):
    ```
    ssh -i id_rsa ec2-user@<ec2_public>
    ```
    
    7.2. Run command `uptime` on the EC2 instance to check it's working.

    8.3. Check that docker works correctly in order to verify that user-data script has been successfully executed:
    ```
    sudo docker run hello-world
    ```

9. Run `terraform destroy` to delete AWS resources which were created during this workshop.


**Hint: in case you got stuck during this workshop you can check the fully working example in the answers\w1 directory.**