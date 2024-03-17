
# Terrafrom Wrapper Code for Attendance API (Dev)

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056746/54c1b29e-1fc9-42f1-886e-60bfb929fa15)


***

| **Author** | **Created On** | **Last Updated** | **Document version** |
| ---------- | -------------- | ---------------- | -------------------- |
|**Vidhi Yadav**  | **17 March 2024** | **17 March 2024** | **v1**            |

***

## Table of Contents

* [Introduction](#Introduction)
* [Terraform Wrapper Code](#Why-Terraform-Wrapper-Code)
* [Pre-requisites](#Pre-requisites)
* [Flow Diagram](#Flow-Diagram)
* [Directory Structure](#Directory-Structure)
* [Configuration Files](#Configuration-Files)
* [Tags](#Tags)
* [Inputs](#Inputs)
* [Outputs](#Outputs)
* [Terminal Output](#Terminal-Output)
* [Console Output](#Console-Output)
* [Best Practices](#Best-Practices)
* [Conclusion](#Conclusion) 
* [Contact Information](#Contact-Information) 
* [References](#References)

 ***

 ## Introduction

In this document it will guide through the steps to achieve the setup of wrapper code for Autoscaling module which involves the child modules.According to the value passed through the root module/wrapper code we can manage/build the infra structure setup accordingly. Which involves the managing of different terraform state files for managing respective environments.

***

# Terraform Wrapper Code

| Feature                | Description                    |
|------------------------|---------------------------------------------------------------------------------------------------------------------|
| **Automation**      | Automates repetitive tasks like initialization, applying changes, and destroying resources, saving time and effort.|
| **Enhanced Functionality** | Extends Terraform's capabilities by integrating with other tools, implementing custom logic, or enforcing specific workflows.|
| **Standardization**        | Enforces standardized practices across Terraform projects, ensuring consistency and reducing the risk of errors.|
| **Integration**            | Facilitates integration with CI/CD pipelines, version control systems, and infrastructure management platforms for seamless deployment. |

***
## Pre-requisites

| **Pre-requisite** | **Description** |
| ----------------- | --------------- |
| **AWS Account**   | Access to the AWS Management Console with credentials configured. |
| **Hashicrop Terraform** | Terraform **(v1.7.4)** for configuration of AWS resources. |

***

## Flow Diagram

<img src="https://devopscube.com/wp-content/uploads/2023/08/alb-asg-workflow.gif" width="700">

***

# Directory Structure

**Module**

<img width="388" alt="Screenshot 2024-03-17 at 4 10 14 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/865c5f99-c984-47d6-80d0-5c3aa2884be8">


**Wrapper Code**

<img width="429" alt="Screenshot 2024-03-17 at 4 06 26 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/1ded4f38-ae50-4e25-8143-15b1c5f23060">

***

## Configuration Files

### main.tf

<details>
<summary><strong>Click here to see main.tf file</strong></summary>
<br>

```shell
module "Dev_Salary" {
source                              = "git@github.com:CodeOps-Hub/Terraform-modules.git//Modules/Auto_Sacling_Module?ref=main"#---------------------------------Security Group ----------------------------------#
security_name                       = var.Dev_Salary_security_name
Security_description                = var.Dev_Salary_security_description
SG_vpc_id                           = var.Dev_Salary_SG_vpc_id
inbound_ports                       = var.Dev_Salary_inbound_ports
outbound_ports                      = var.Dev_Salary_outbound_ports
Sg_tags                             = var.Dev_Salary_Sg_tags
#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------Launch Template ----------------------------------
private_key_algorithm               = var.Dev_Salary_private_key_algorithm
private_key_rsa_bits                = var.Dev_Salary_private_key_rsa_bits
template_name                       = var.Dev_Salary_template_name
template_description                = var.Dev_Salary_template_description
AMI_ID                              = var.Dev_Salary_AMI_ID
instance_type                       = var.Dev_Salary_instance_type
instance_keypair                    = var.Dev_Salary_instance_keypair
subnet_ID                           = var.Dev_Salary_subnet_ID
user_data_script_path               = var.Dev_Salary_user_data_script_path
#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------- Target Group -----------------------------------#
target_group_name                   = var.Dev_Salary_target_group_name
target_group_port                   = var.Dev_Salary_target_group_port
target_group_protocol               = var.Dev_Salary_target_group_protocol
TG_vpc_id                           = var.Dev_Salary_TG_vpc_id
health_check_path                   = var.Dev_Salary_health_check_path
health_check_port                   = var.Dev_Salary_health_check_port
health_check_interval               = var.Dev_Salary_health_check_interval
health_check_timeout                = var.Dev_Salary_health_check_timeout
health_check_healthy_threshold      = var.Dev_Salary_health_check_healthy_threshold
health_check_unhealthy_threshold    = var.Dev_Salary_health_check_unhealthy_threshold
#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#------------------------------- Listener rule of ALB -----------------------------#
listener_arn                         = var.Dev_Salary_listener_arn
path_pattern                         = var.Dev_Salary_path_pattern
action_type                          = var.Dev_Salary_action_type
priority                             = var.Dev_Salary_priority
#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------Configure Auto Scaling group ---------------------------#
autoscaling_group_name              = var.Dev_Salary_autoscaling_group_name
ASG_version                         = var.Dev_Salary_ASG_vserion
subnet_ids                          = var.Dev_Salary_subnet_ids
tag_key                             = var.Dev_Salary_tag_key
tag_value                           = var.Dev_Salary_tag_value
propagate_at_launch                 = var.Dev_Salary_propagate_at_launch
min_size                            = var.Dev_Salary_min_size
max_size                            = var.Dev_Salary_max_size
desired_capacity                    = var.Dev_Salary_desired_capacity
#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#---------------------------- Auto Scaling Policies -------------------------------#
scaling_policy_name                 = var.Dev_Salary_scaling_policy_name
policy_type                         = var.Dev_Salary_policy_type
predefined_metric_type              = var.Dev_Salary_predefined_metric_type
target_value                        = var.Dev_Salary_target_value
#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
}

```
</details>

***

### variables.tf
<details>
<summary><strong>Click here to see variables.tf file</strong></summary>
<br>

```shell
#---------------------------------Security Group ----------------------------------#

variable "Dev_Salary_security_name" {
  description     = "Name tag for the security group"
  type            = string
  default         = "Dev-Salary-sg"
}
variable "Dev_Salary_security_description" {
  description     = "Description for the security group"
  type            = string
  default         = "Security group for Dev-Salary-API"
}
variable "Dev_Salary_SG_vpc_id" {
  description     = "ID of the VPC for instances"
  type            = string
  default         = "vpc-00631f1bf6539cb88"   # Dev_Salary-VPC ID
}
variable "Dev_Salary_inbound_ports" {
  description     = "List of inbound ports and protocols and cidr block"
  type            = list(map(any))
  default         = [
    { port = 22, protocol = "tcp",cidr_blocks = "20.0.0.0/28" }, # Management VPC Cidr Block
    { port = 22, protocol = "tcp", security_group_ids = "sg-00a65bcd92abcee70" },    # OpenVPN-SG
    { port =8080, protocol = "tcp", security_group_ids = "sg-0d2e3609a8b620d52" }, #  Dev-Salary-lb-sg ID 
  ]
}
variable "Dev_Salary_outbound_ports" {
  description     = "List of outbound ports and protocols and Cidr block "
  type            = list(map(any))
  default         = [
    { port = 0, protocol = "-1", cidr_blocks = "0.0.0.0/0", },
  ]
}
variable "Dev_Salary_Sg_tags" {
  description     = "Tags for Security Group"
  type            = map(string)
  default         = {
    Name          = "Dev-Salary-sg"
    Enviroment    = "Dev_Salary"
    Owner         = "Shikha"
  }
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------Launch Template ----------------------------------#

# Key Generate

variable "Dev_Salary_private_key_algorithm" {
  description     = "private_key_algorithm"
  type            = string
  default         = "RSA"
}
variable "Dev_Salary_private_key_rsa_bits" {
  description     = "private_key_rsa_bits"
  type            = number
  default         = 4096
}

variable "Dev_Salary_template_name" {
  description     = "Launch Template Name"
  type            = string
  default         = "Dev-Salary-template"  
}
variable "Dev_Salary_template_description" {
  description     = "Launch Template Description"
  type            = string
  default         = "Template for Dev-Salary"  
}
variable "Dev_Salary_AMI_ID" {
  description     = "Instance AMI ID"
  type            = string
  default         =  "ami-0b8b44ec9a8f90422"# Dev-Salary Setup AMI ID
}
variable "Dev_Salary_instance_type" {
  description     = "Launch Template Instance Type"
  type            = string
  default         = "t2.micro"  
}
variable "Dev_Salary_instance_keypair" {
  description     = "Launch Template Instance Type keypair name"
  type            = string
  default         = "Dev_Salary_Key"  
}
variable "Dev_Salary_subnet_ID" {
  description     = "Launch Template Subnet ID"
  type            = string
  default         = "subnet-03e34296260c1c84d"  
}
variable "Dev_Salary_user_data_script_path" {
  description = "Path to the user data script file"
  type        = string
  default     = "./script.sh"  # Path Dev-Salary User data Script
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------- Target Group -----------------------------------#

variable "Dev_Salary_target_group_name" {
  description     = "Name of the target group"
  type            = string
  default         = "Dev-Salary-TG"
}
variable "Dev_Salary_target_group_port" {
  description     = "Port for the target group"
  type            = number 
  default         = 8080
}
variable "Dev_Salary_target_group_protocol" {
  description     = "Protocol for the target group"
  type            = string
  default         = "HTTP"
}
variable "Dev_Salary_TG_vpc_id" {
  description     = "ID of the VPC"
  type            = string
  default         = "vpc-00631f1bf6539cb88"    #  Dev_Salary-VPC ID 
}
variable "Dev_Salary_health_check_path" {
  description     = "The destination for the health check request"
  type            = string
  default         = "/health"
}
variable "Dev_Salary_health_check_port" {
  description     = "The port to use to connect with the target for health checking"
  type            = string
  default         = "traffic-port"
}
variable "Dev_Salary_health_check_interval" {
  description     = "The approximate amount of time, in seconds, between health checks of an individual target"
  type            = number
  default         = 30
}
variable "Dev_Salary_health_check_timeout" {
  description     = "The amount of time, in seconds, during which no response means a failed health check"
  type            = number
  default         = 5
}
variable "Dev_Salary_health_check_healthy_threshold" {
  description     = "The number of consecutive health checks successes required before considering an unhealthy target healthy"
  type            = number
  default         = 2
}
variable "Dev_Salary_health_check_unhealthy_threshold" {
  description     = "The number of consecutive health check failures required before considering a target unhealthy"
  type            = number
  default         = 2
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#------------------------------- Listener rule of ALB -----------------------------#

variable "Dev_Salary_listener_arn" {
  description       = "ARN of the existing listener where the rule will be added"
  type              = string
  default           = "arn:aws:elasticloadbalancing:ap-northeast-1:133673781875:listener/app/Dev-ALB/75bc9b1a35dbe964/761653fb399a30be"
}
variable "Dev_Salary_path_pattern" {
  description       = "Path pattern for the listener rule"
  type              = string
  default           = "/api/v1/salary/*"   # Give your Path 
}
variable "Dev_Salary_action_type" {
  description       = "Path pattern for the listener rule"
  type              = string
  default           = "forward"
}
variable "Dev_Salary_priority" {
  description       = "priority"
  type              = number
  default           = 100 
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------Configure Auto Scaling group ---------------------------#

variable "Dev_Salary_autoscaling_group_name" {
  description     = "The name of the Auto Scaling Group"
  type            = string
  default         = "Dev-Salary_ASG"
}
variable "Dev_Salary_ASG_vserion" {
  description     = "Give the Version"
  type            = string
  default         = "$Latest"
}

variable "Dev_Salary_min_size" {
  description     = "The minimum number of instances in the ASG"
  type            = number
  default         = 1
}

variable "Dev_Salary_max_size" {
  description     = "The maximum number of instances in the ASG"
  type            = number
  default         = 2
}

variable "Dev_Salary_desired_capacity" {
  description     = "The desired number of instances in the ASG"
  type            = number
  default         = 1
}

variable "Dev_Salary_subnet_ids" {
  description     = "The list of subnet IDs where the instances will be launched"
  type            = list(string)
  default         = [ "subnet-03e34296260c1c84d" ]    #Salary-Pvt-Subnet ID
}

variable "Dev_Salary_tag_key" {
  description     = "The key for the tag to be applied to the ASG and instances"
  type            = string
  default         = "Name"
}

variable "Dev_Salary_tag_value" {
  description     = "The value for the tag to be applied to the ASG and instances"
  type            = string
  default         = "Dev-Salary_ASG"
}

variable "Dev_Salary_propagate_at_launch" {
  description     = "Whether the tag should be propagated to instances launched by the ASG"
  type            = bool
  default         = true
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#---------------------------- Auto Scaling Policies -------------------------------#

variable "Dev_Salary_scaling_policy_name" {
  description     = "The name of the scaling policy"
  type            = string
  default         = "target-tracking-policy"
}
variable "Dev_Salary_policy_type" {
  description     = "The type of adjustment to make"
  type            = string
  default         = "TargetTrackingScaling"
}
variable "Dev_Salary_predefined_metric_type" {
  description     = "The predefined metric type for tracking"
  type            = string
  default         = "ASGAverageCPUUtilization"
}
variable "Dev_Salary_target_value" {
  description     = "The target value for the predefined metric"
  type            = number
  default         = 50.0
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#

#--------------------------------Launch Template ----------------------------------#

# Key Generate

variable "Dev_Salary_private_key_algorithm" {
  description     = "private_key_algorithm"
  type            = string
  default         = "RSA"
}
variable "Dev_Salary_private_key_rsa_bits" {
  description     = "private_key_rsa_bits"
  type            = number
  default         = 4096
}

variable "Dev_Salary_template_name" {
  description     = "Launch Template Name"
  type            = string
  default         = "Dev-Salary-template"  
}
variable "Dev_Salary_template_description" {
  description     = "Launch Template Description"
  type            = string
  default         = "Template for Dev-Salary"  
}
variable "Dev_Salary_AMI_ID" {
  description     = "Instance AMI ID"
  type            = string
  default         = "ami-0b8b44ec9a8f90422" # Dev-Salary Setup AMI ID
}
variable "Dev_Salary_instance_type" {
  description     = "Launch Template Instance Type"
  type            = string
  default         = "t2.micro"  
}
variable "Dev_Salary_instance_keypair" {
  description     = "Launch Template Instance Type keypair name"
  type            = string
  default         = "Dev_Salary_Key"  
}
variable "Dev_Salary_subnet_ID" {
  description     = "Launch Template Subnet ID"
  type            = string
  default         = "subnet-03e34296260c1c84d"  
}
variable "Dev_Salary_user_data_script_path" {
  description = "Path to the user data script file"
  type        = string
  default     = "./script.sh"  # Path Dev-Salary User data Script
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------- Target Group -----------------------------------#

variable "Dev_Salary_target_group_name" {
  description     = "Name of the target group"
  type            = string
  default         = "Dev-Salary-TG"
}
variable "Dev_Salary_target_group_port" {
  description     = "Port for the target group"
  type            = number 
  default         = 8080
}
variable "Dev_Salary_target_group_protocol" {
  description     = "Protocol for the target group"
  type            = string
  default         = "HTTP"
}
variable "Dev_Salary_TG_vpc_id" {
  description     = "ID of the VPC"
  type            = string
  default         = "vpc-00631f1bf6539cb88"    #  Dev_Salary-VPC ID 
}
variable "Dev_Salary_health_check_path" {
  description     = "The destination for the health check request"
  type            = string
  default         = "/health"
}
variable "Dev_Salary_health_check_port" {
  description     = "The port to use to connect with the target for health checking"
  type            = string
  default         = "traffic-port"
}
variable "Dev_Salary_health_check_interval" {
  description     = "The approximate amount of time, in seconds, between health checks of an individual target"
  type            = number
  default         = 30
}
variable "Dev_Salary_health_check_timeout" {
  description     = "The amount of time, in seconds, during which no response means a failed health check"
  type            = number
  default         = 5
}
variable "Dev_Salary_health_check_healthy_threshold" {
  description     = "The number of consecutive health checks successes required before considering an unhealthy target healthy"
  type            = number
  default         = 2
}
variable "Dev_Salary_health_check_unhealthy_threshold" {
  description     = "The number of consecutive health check failures required before considering a target unhealthy"
  type            = number
  default         = 2
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#------------------------------- Listener rule of ALB -----------------------------#

variable "Dev_Salary_listener_arn" {
  description       = "ARN of the existing listener where the rule will be added"
  type              = string
  default           = "arn:aws:elasticloadbalancing:ap-northeast-1:133673781875:listener/app/Dev-ALB/75bc9b1a35dbe964/761653fb399a30be"
}
variable "Dev_Salary_path_pattern" {
  description       = "Path pattern for the listener rule"
  type              = string
  default           = "/api/v1/salary/*"   # Give your Path 
}
variable "Dev_Salary_action_type" {
  description       = "Path pattern for the listener rule"
  type              = string
  default           = "forward"
}
variable "Dev_Salary_priority" {
  description       = "priority"
  type              = number
  default           = 100 
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------Configure Auto Scaling group ---------------------------#

variable "Dev_Salary_autoscaling_group_name" {
  description     = "The name of the Auto Scaling Group"
  type            = string
  default         = "Dev-Salary_ASG"
}

variable "Dev_Salary_min_size" {
  description     = "The minimum number of instances in the ASG"
  type            = number
  default         = 1
}

variable "Dev_Salary_max_size" {
  description     = "The maximum number of instances in the ASG"
  type            = number
  default         = 2
}

variable "Dev_Salary_desired_capacity" {
  description     = "The desired number of instances in the ASG"
  type            = number
  default         = 1
}

variable "Dev_Salary_subnet_ids" {
  description     = "The list of subnet IDs where the instances will be launched"
  type            = list(string)
  default         = [ "subnet-03e34296260c1c84d" ]    #Salary-Pvt-Subnet ID
}

variable "Dev_Salary_tag_key" {
  description     = "The key for the tag to be applied to the ASG and instances"
  type            = string
  default         = "Name"
}

variable "Dev_Salary_tag_value" {
  description     = "The value for the tag to be applied to the ASG and instances"
  type            = string
  default         = "Dev-Salary_ASG"
}

variable "Dev_Salary_propagate_at_launch" {
  description     = "Whether the tag should be propagated to instances launched by the ASG"
  type            = bool
  default         = true
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#---------------------------- Auto Scaling Policies -------------------------------#

variable "Dev_Salary_scaling_policy_name" {
  description     = "The name of the scaling policy"
  type            = string
  default         = "target-tracking-policy"
}
variable "Dev_Salary_policy_type" {
  description     = "The type of adjustment to make"
  type            = string
  default         = "TargetTrackingScaling"
}
variable "Dev_Salary_predefined_metric_type" {
  description     = "The predefined metric type for tracking"
  type            = string
  default         = "ASGAverageCPUUtilization"
}
variable "Dev_Salary_target_value" {
  description     = "The target value for the predefined metric"
  type            = number
  default         = 50.0
}
```
</details>

***

### terraform.tfvars

<details>
<summary><strong>Click here to see terraform.tfvars file</strong></summary>
<br>

```shell
#---------------------------------Security Group ----------------------------------#

Dev_Salary_security_name                       = "Dev-Salary-sg"
Dev_Salary_security_description                = "Security group for Dev-Salary-API"
Dev_Salary_SG_vpc_id                           = "vpc-00631f1bf6539cb88"    #Dev_Salary-VPC-ID
Dev_Salary_inbound_ports                       = [
  { port                                = 22, protocol = "tcp", cidr_blocks = "20.0.0.0/28" },                     # Management VPC Cidr Block
  { port                                = 22, protocol = "tcp", security_group_ids = "sg-00a65bcd92abcee70" },     #  Dev-Salary-lb-sg ID
  { port                                = 8080, protocol = "tcp", security_group_ids = "sg-0d2e3609a8b620d52" },   # OpenVPN-SG
]
Dev_Salary_outbound_ports                      = [
  { port                                = 0, protocol = "-1", cidr_blocks = "0.0.0.0/0" }
]
Dev_Salary_Sg_tags                             = {
  Name                                  = "Dev-Salary-sg"
  Enviroment                            = "Dev_Salary"
  Owner                                 = "Salary"
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------Launch Template ----------------------------------#

Dev_Salary_private_key_algorithm               = "RSA"
Dev_Salary_private_key_rsa_bits                = 4096
Dev_Salary_template_name                       = "Dev-Salary-template"
Dev_Salary_template_description                = "Template for Dev-Salary"
Dev_Salary_AMI_ID                              = "ami-0b8b44ec9a8f90422"
Dev_Salary_instance_type                       = "t2.micro"
Dev_Salary_instance_keypair                    = "Dev_Salary_Key"
Dev_Salary_subnet_ID                           = "subnet-03e34296260c1c84d"
Dev_Salary_user_data_script_path               = "./script.sh"

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------- Target Group -----------------------------------#

Dev_Salary_target_group_name                   = "Dev-Salary-TG"
Dev_Salary_target_group_port                   = 8080
Dev_Salary_target_group_protocol               = "HTTP"
Dev_Salary_TG_vpc_id                           = "vpc-00631f1bf6539cb88"   #Dev_Salary-VPC-ID
Dev_Salary_health_check_path                   = "/health"
Dev_Salary_health_check_port                   = "traffic-port"
Dev_Salary_health_check_interval               = 30
Dev_Salary_health_check_timeout                = 5
Dev_Salary_health_check_healthy_threshold      = 2
Dev_Salary_health_check_unhealthy_threshold    = 2

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#------------------------------- Listener rule of ALB -----------------------------#

Dev_Salary_listener_arn                          = "arn:aws:elasticloadbalancing:us-east-2:975050171850:listener/app/alb/78ba193068ecdac7/e91f6155c19050d5"
Dev_Salary_path_pattern                          = "/api/v1/salary/*"
Dev_Salary_action_type                           = "forward"
Dev_Salary_priority                              = 100

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------Configure Auto Scaling group ---------------------------#

Dev_Salary_autoscaling_group_name              = "Dev-Salary_ASG"
Dev_Salary_ASG_vserion                         = "$Latest"
Dev_Salary_min_size                            = 1
Dev_Salary_max_size                            = 2
Dev_Salary_desired_capacity                    = 1
Dev_Salary_subnet_ids                          = ["subnet-03e34296260c1c84d"]   #Dev-Salary Pvt ID
Dev_Salary_tag_key                             = "Name"
Dev_Salary_tag_value                           = "Dev-Salary_ASG"
Dev_Salary_propagate_at_launch                 = true

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#---------------------------- Auto Scaling Policies -------------------------------#

Dev_Salary_scaling_policy_name                 = "target-tracking-policy"
Dev_Salary_policy_type                         = "TargetTrackingScaling"
Dev_Salary_predefined_metric_type              = "ASGAverageCPUUtilization"
Dev_Salary_target_value                        = 50.0

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
```
</details>

***
### output.tf

<details>
<summary><strong>Click here to see variables.tf file</strong></summary>
<br>

```shell
#---------------------------------Security Group ----------------------------------#

output "Security_Group_ID" {
  value = [module.Dev_Salary.Security_Group_ID]
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------Launch Template ----------------------------------#

# Priavte Key
output "key_pair_name" {
  value       = [module.Dev_Salary.key_pair_name]
}

# Template
output "launch_template_id" {
  value = [module.Dev_Salary.launch_template_id]
}
#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------- Target Group -----------------------------------#

output "Target_group_id" {
  value = [module.Dev_Salary.Target_group_id]
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------Configure Auto Scaling group ---------------------------#

output "Autoscaling_group_id" {
  value = [module.Dev_Salary.Autoscaling_group_id]
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#---------------------------- Auto Scaling Policies -------------------------------#

output "Autoscaling_policy_name" {
  value       = [module.Dev_Salary.Autoscaling_policy_name]
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
```
</details>

***
### provider.tf

<details>
<summary><strong>Click here to see provider.tf file</strong></summary>
<br>

```shell
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.38.0"  # Using a minimum version constraint
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-2"  
} 


```
</details>

***
### script.sh

<details>
<summary><strong>Click here to see script.sh file</strong></summary>
<br>

```shell

 #!/bin/bash  
 java -jar Salary-API/target/salary-0.1.0-RELEASE.jar
```
</details>

***


***

# Output

## Terminal Output


<img width="1095" alt="Screenshot 2024-03-17 at 4 14 40 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/5ca35267-dc43-4f05-8c7f-bb74dfa1b293">


***

## Console Output

### Private Key (scyllaDBKeyDev.pem)

<img width="800" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156056344/13bbaae8-4f79-4ab8-908b-7f6a8fb29e0e">

**Key Download**

![Screenshot 2024-03-17 020724](https://github.com/CodeOps-Hub/Documentation/assets/156056344/8f3916ef-e919-4349-8f3e-0689cc15a121)



***

### Security Group (scylladb-dev-sg)

<img width="800" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156056344/5036f839-69fa-43f3-a5f2-e9b2de8a694a">


***

### EC2 Instance (ScyllaDB-Server-QA)

<img width="800" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156056344/5c4dfb6c-f4bf-469a-8853-3f139a276c8b">


***

# Best Practices

| Practice           | Description                                                                                                                                   |
|--------------------|-----------------------------------------------------------------------------------------------------------------------------------------------|
| **Modularity**         | Design wrapper scripts in a modular way, with separate functions for each Terraform command or task.                                          |
| **Error Handling**     | Implement robust error handling mechanisms to gracefully handle failures and provide informative error messages.                             |
| **Logging**            | Include logging functionality to capture relevant information and debug issues during Terraform execution.                                    |
| **Version Control**    | Store wrapper scripts alongside Terraform configurations in version control repositories for versioning, collaboration, and auditability.  |
| **Documentation**      | Provide comprehensive documentation for wrapper scripts, including usage instructions, dependencies, and troubleshooting tips.               |
| **Security**           | Follow security best practices to protect sensitive information such as credentials and API keys used by wrapper scripts.                   |


***

# Conclusion

Terraform wrapper code enhances the capabilities of Terraform by automating tasks, providing additional functionality, and enforcing best practices. By following best practices such as modularity, error handling, and documentation, wrapper scripts can streamline Terraform workflows, improve productivity, and ensure the reliability and security of infrastructure deployments.The OpenVPN wrapper code makes it easier to set up and manage OpenVPN by simplifying complex tasks into easy steps. It helps improve security and makes it simpler to expand and maintain the VPN. With this wrapper, you can easily connect OpenVPN with your existing systems and automate tasks, making it faster to deploy and monitor your VPN across different setups.

***

# Contact Information

| **Name** | **Email Address** |
| -------- | ----------------- |
| **Vidhi Yadav** | vidhi.yadhav.snaatak@mygurukulam.co |

***

# References

| **Source** | **Description** |
| ---------- | --------------- |
| [Link](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GenericDoc/Terraform/terraform.md) | Terraform Generic Doc Link. |
| [Link](https://medium.com/@brandon.wagner/a-wrapper-for-terraform-61a125b27ffc) | Terraform Wrapper Code Concept. |
| [Link](https://medium.com/@selvamraju007/terraform-modules-explanation-726ba4a0b98e) | Reference Link For Terraform Modules. |
