**Telus Terraform Assignment**
Create an AWS free account and use Terraform to do the following tasks, checking in the code in a public GitHub repo.
Create a s3 and dynamodb table for Terraform backend and use it for the rest of the assessment.
VPC in Canada region with one public subnet and one private subnet
Create route-tables, IGW, Nat GW
Add one ASG (autoscaling group) with EC2 templates. auto scale when CPU is high (90%)
Add a launch-config for the ec2, which has a user_data to show a simple HTML page for the Hostname: $HOSTNAME
Add Ec2 instances run in a role with minimum permissions (least privileges)
use ELB or ALB in front of the ASG
Make sure to use proper SG only allows connections from LB to the EC2 instances.
Create a proper output.tf
Put your design details in a README file.
Share the screenshot and URL for the app, which shows HTML and the GitHub link for code review.

**Project Overview**
This repo contains the terraform c oniguration to set up the aws with a S3 backedn for the state management  and a VPC which is in Central Canada region and the auto scaling EC2 instances behind the ALB with security groups. 

**Project Structure:**
terraform-aws-telus
├── main.tf
├── variables.tf
├── outputs.tf
├── s3_backend.tf
├── modules/
│   ├── vpc/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── security_groups/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── autoscaling/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── elb/
│       ├── main.tf
│       ├── variables.tf
│       ├── outputs.tf


**Project Flow:**
1. S3 Bucket and DynamoDB Table: Used for storing the Terraform state file and state locking 
  Bucket Name:  terraform-telus 
  Dynamo DB: telus-terraform-state-locking

2. A VPC in the Canada region (ca-central-1) with one public subnet and one private subnet. An Internet Gateway (IGW) and a NAT Gateway for internet access. Route tables for routing traffic within the VPC.

3. Auto Scaling Group: Launches EC2 instances based on a launch template. Automatically scales up or down based on CPU usage. User data script to display a simple HTML page with the instance's hostname.

4. Security Groups: Security Group for the ALB allowing HTTP access from the internet. Security Group for the EC2 instances allowing traffic only from the ALB.

5. App Load Balancer: Distributes incoming traffic across the EC2 instances in the ASG''


**Set Up Instructions:**
1. git clone https://github.com/vivek-canada/terraform-telus-work.git
2. cd terraform-aws-telus
3. terraform init
4. terraform validate
5. terraform plan
6. terraform apply 


**Modules:**
1. S3 Backend: Defines the backend configuration for Terraform to use an S3 bucket for state storage and a DynamoDB table for state locking.
2. VPC Module: Defines the VPC, subnets, route tables, and gateways.
3. Security Groups Module: Defines security groups for the ALB and EC2 instances.
4. Autoscaling Module: Defines the launch template and auto-scaling group, including scale-up and scale-down policies.
5. ELB Module: Defines the ALB, target group, and listener.
6. Outputs: outputs will be available: alb_dns_name: The DNS name of the Application Load Balancer
