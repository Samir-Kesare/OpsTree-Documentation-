
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
* [Outputs](#Outputs)
* [Terminal Output](#Terminal-Output)
* [Console Output](#Console-Output)
* [Best Practices](#Best-Practices)
* [Conclusion](#Conclusion) 
* [Contact Information](#Contact-Information) 
* [References](#References)

 ***

 ## Introduction

This document provides a step-by-step guide for setting up wrapper code for an Attendance API, including the configuration files. Depending on the parameters passed through the wrapper code, we can dynamically adjust the infrastructure setup. This includes managing separate Terraform state files for each environment to effectively handle their respective configurations.

***

# Terraform Wrapper Code

| Feature                | Description                    |
|------------------------|---------------------------------------------------------------------------------------------------------------------|
| **Automation**      | Automates repetitive tasks like initialization, applying changes, and destroying resources, saving time and effort.|
| **Environment managementy** | It facilitates environment-specific configuration management by utilizing separate Terraform state files for different environments, such as development, staging, and production.|
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

<img width="1725" alt="Screenshot 2024-03-17 at 5 05 23 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/e07ae01e-6088-4124-9742-f51a11d2159a">

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

#---------------------------------Security Group ----------------------------------#
module "Dev_Attendance" {
source                              = "git@github.com:CodeOps-Hub/Terraform-modules.git//Modules/Auto_Sacling_Module?ref=main"
security_name                       = var.security_name
Security_description                = var.security_description
SG_vpc_id                           = var.vpc_id
inbound_ports                       = var.inbound_ports
outbound_ports                      = var.outbound_ports
Sg_tags                             = var.Sg_tags


#--------------------------------Launch Template ----------------------------------
private_key_algorithm               = var.private_key_algorithm
private_key_rsa_bits                = var.private_key_rsa_bits
template_name                       = var.template_name
template_description                = var.template_description
AMI_ID                              = var.AMI_ID
instance_type                       = var.instance_type
instance_keypair                    = var.instance_keypair
subnet_ID                           = var.subnet_ID
user_data_script_path               = var.user_data_script_path


#--------------------------------- Target Group -----------------------------------#
target_group_name                   = var.target_group_name
target_group_port                   = var.target_group_port
target_group_protocol               = var.target_group_protocol
TG_vpc_id                           = var.TG_vpc_id
health_check_path                   = var.health_check_path
health_check_port                   = var.health_check_port
health_check_interval               = var.health_check_interval
health_check_timeout                = var.health_check_timeout
health_check_healthy_threshold      = var.health_check_healthy_threshold
health_check_unhealthy_threshold    = var.health_check_unhealthy_threshold


#------------------------------- Listener rule of ALB -----------------------------#
listener_arn                         = var.listener_arn
path_pattern                         = var.path_pattern
action_type                          = var.action_type
priority                             = var.priority


#--------------------------Configure Auto Scaling group ---------------------------#
autoscaling_group_name              = var.autoscaling_group_name
ASG_version                         = var.ASG_version
subnet_ids                          = var.subnet_ids
tag_key                             = var.tag_key
tag_value                           = var.tag_value
propagate_at_launch                 = var.propagate_at_launch
min_size                            = var.min_size
max_size                            = var.max_size
desired_capacity                    = var.desired_capacity


#---------------------------- Auto Scaling Policies -------------------------------#
scaling_policy_name                 = var.scaling_policy_name
policy_type                         = var.policy_type
predefined_metric_type              = var.predefined_metric_type
target_value                        = var.target_value
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

variable "security_name" {
  description     = "Name tag for the security group"
  type            = string
  default         = "attendance-sg"
}
variable "security_description" {
  description     = "Description for the security group"
  type            = string
  default         = "Security group for Dev Attendance API"
}
variable "vpc_id" {
  description     = "ID of the VPC for instances"
  type            = string
  default         = "vpc-0d744158f7f47f419"   # Dev_Salary-VPC ID
}
variable "inbound_ports" {
  description     = "List of inbound ports and protocols and cidr block"
  type            = list(map(any))
  default         = [
    { port = 22, protocol = "tcp",cidr_blocks = "20.0.0.0/28" }, # Management VPC Cidr Block
    { port = 22, protocol = "tcp", security_group_ids = "sg-0add0279237c66ee0" },    # OpenVPN-SG
    { port = 8080, protocol = "tcp", security_group_ids = "sg-0add0279237c66ee0" }, #  Dev-Attendance-lb-sg ID 
  ]
}
variable "outbound_ports" {
  description     = "List of outbound ports and protocols and Cidr block "
  type            = list(map(any))
  default         = [
    { port = 0, protocol = "-1", cidr_blocks = "0.0.0.0/0", },
  ]
}
variable "Sg_tags" {
  description     = "Tags for Security Group"
  type            = map(string)
  default         = {
    Name          = "Dev-Attendance-sg"
    Enviroment    = "Dev_Attendance"
    Owner         = "Vidhi"
  }
}


#--------------------------------Launch Template ----------------------------------#

# Key Generate

variable "private_key_algorithm" {
  description     = "private_key_algorithm"
  type            = string
  default         = "RSA"
}
variable "private_key_rsa_bits" {
  description     = "private_key_rsa_bits"
  type            = number
  default         = 4096
}

variable "template_name" {
  description     = "Launch Template Name"
  type            = string
  default         = "Dev-Attendance-Launch-Template"  
}
variable "template_description" {
  description     = "Launch Template Description"
  type            = string
  default         = "Template for Dev-Attendance"  
}
variable "AMI_ID" {
  description     = "Instance AMI ID"
  type            = string
  default         =  "ami-0b622ae4dff08c413"# Dev-Attendance Setup AMI ID
}
variable "instance_type" {
  description     = "Launch Template Instance Type"
  type            = string
  default         = "t2.micro"  
}
variable "instance_keypair" {
  description     = "Launch Template Instance Type keypair name"
  type            = string
  default         = "Dev_Attendance_Key"  
}
variable "subnet_ID" {
  description     = "Launch Template Subnet ID"
  type            = string
  default         = "subnet-03e34296260c1c84d"  
}
variable "user_data_script_path" {
  description = "Path to the user data script file"
  type        = string
  default     = "./script.sh"  # Path Dev-Salary User data Script
}

#--------------------------------- Target Group -----------------------------------#

variable "target_group_name" {
  description     = "Name of the target group"
  type            = string
  default         = "Dev-Attendance-TG"
}
variable "target_group_port" {
  description     = "Port for the target group"
  type            = number 
  default         = 8080
}
variable "target_group_protocol" {
  description     = "Protocol for the target group"
  type            = string
  default         = "HTTP"
}
variable "TG_vpc_id" {
  description     = "ID of the VPC"
  type            = string
  default         = "vpc-00631f1bf6539cb88"    #  Dev_Salary-VPC ID 
}
variable "health_check_path" {
  description     = "The destination for the health check request"
  type            = string
  default         = "/health"
}
variable "health_check_port" {
  description     = "The port to use to connect with the target for health checking"
  type            = string
  default         = "traffic-port"
}
variable "health_check_interval" {
  description     = "The approximate amount of time, in seconds, between health checks of an individual target"
  type            = number
  default         = 30
}
variable "health_check_timeout" {
  description     = "The amount of time, in seconds, during which no response means a failed health check"
  type            = number
  default         = 5
}
variable "health_check_healthy_threshold" {
  description     = "The number of consecutive health checks successes required before considering an unhealthy target healthy"
  type            = number
  default         = 2
}
variable "health_check_unhealthy_threshold" {
  description     = "The number of consecutive health check failures required before considering a target unhealthy"
  type            = number
  default         = 2
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#------------------------------- Listener rule of ALB -----------------------------#

variable "listener_arn" {
  description       = "ARN of the existing listener where the rule will be added"
  type              = string
  default           = "arn:aws:elasticloadbalancing:ap-northeast-1:133673781875:listener/app/Dev-ALB/75bc9b1a35dbe964/761653fb399a30be"
}
variable "path_pattern" {
  description       = "Path pattern for the listener rule"
  type              = string
  default           = "/api/v1/attendance/*"   # Give your Path 
}
variable "action_type" {
  description       = "Path pattern for the listener rule"
  type              = string
  default           = "forward"
}
variable "priority" {
  description       = "priority"
  type              = number
  default           = 100 
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------Configure Auto Scaling group ---------------------------#

variable "autoscaling_group_name" {
  description     = "The name of the Auto Scaling Group"
  type            = string
  default         = "Dev-Attendance_ASG"
}
variable "ASG_version" {
  description     = "Give the Version"
  type            = string
  default         = "$Default"
}

variable "min_size" {
  description     = "The minimum number of instances in the ASG"
  type            = number
  default         = 1
}

variable "max_size" {
  description     = "The maximum number of instances in the ASG"
  type            = number
  default         = 2
}

variable "desired_capacity" {
  description     = "The desired number of instances in the ASG"
  type            = number
  default         = 1
}

variable "subnet_ids" {
  description     = "The list of subnet IDs where the instances will be launched"
  type            = list(string)
  default         = [ "subnet-03e34296260c1c84d" ]    #Salary-Pvt-Subnet ID
}

variable "tag_key" {
  description     = "The key for the tag to be applied to the ASG and instances"
  type            = string
  default         = "Name"
}

variable "tag_value" {
  description     = "The value for the tag to be applied to the ASG and instances"
  type            = string
  default         = "Dev-Attendance_ASG"
}

variable "propagate_at_launch" {
  description     = "Whether the tag should be propagated to instances launched by the ASG"
  type            = bool
  default         = true
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#---------------------------- Auto Scaling Policies -------------------------------#

variable "scaling_policy_name" {
  description     = "The name of the scaling policy"
  type            = string
  default         = "target-tracking-policy"
}
variable "policy_type" {
  description     = "The type of adjustment to make"
  type            = string
  default         = "TargetTrackingScaling"
}
variable "predefined_metric_type" {
  description     = "The predefined metric type for tracking"
  type            = string
  default         = "ASGAverageCPUUtilization"
}
variable "target_value" {
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

security_name                       = "Dev-Attendance-sg"
security_description                = "Security group for Dev Attendance API"
vpc_id                           = "vpc-0d744158f7f47f419"    #Dev_Salary-VPC-ID
inbound_ports                       = [
  { port                                = 22, protocol = "tcp", cidr_blocks = "20.0.0.0/28" },                     # Management VPC Cidr Block
  { port                                = 22, protocol = "tcp", security_group_ids = "sg-061f905ed2cbb0652" },     #  Dev-Salary-lb-sg ID
  { port                                = 8080, protocol = "tcp", security_group_ids = "sg-061f905ed2cbb0652" },   # OpenVPN-SG
]
outbound_ports                      = [
  { port                                = 0, protocol = "-1", cidr_blocks = "0.0.0.0/0" }
]
Sg_tags                             = {
  Name                                  = "Dev-Attendance-sg"
  Enviroment                            = "Dev_Attendance"
  Owner                                 = "Vidhi"
}

#--------------------------------Launch Template ----------------------------------#

private_key_algorithm               = "RSA"
private_key_rsa_bits                = 4096
template_name                       = "Dev-Attendance-Launch-Template"
template_description                = "Template for Attendance"
AMI_ID                              = "ami-0b622ae4dff08c413"
instance_type                       = "t2.micro"
instance_keypair                    = "Dev_Attendance_Key"
subnet_ID                           = "subnet-0a712151efeb16f4f"
user_data_script_path               = "./script.sh"

#--------------------------------- Target Group -----------------------------------#

target_group_name                   = "Dev-Attendance-TG"
target_group_port                   = 8080
target_group_protocol               = "HTTP"
TG_vpc_id                           = "vpc-0d744158f7f47f419"   #Dev_Attendance-VPC-ID
health_check_path                   = "/health"
health_check_port                   = "traffic-port"
health_check_interval               = 30
health_check_timeout                = 5
health_check_healthy_threshold      = 2
health_check_unhealthy_threshold    = 2


#------------------------------- Listener rule of ALB -----------------------------#

listener_arn                          = "arn:aws:elasticloadbalancing:us-east-1:905418193488:listener/app/alb-heh/127dfdd55a957475/99ac24ae778e4e38"
path_pattern                          = "/api/v1/attendance/*"
action_type                           = "forward"
priority                              = 90


#--------------------------Configure Auto Scaling group ---------------------------#

autoscaling_group_name              = "Dev-Attendance_ASG"
ASG_version                         = "$Latest"
min_size                            = 1
max_size                            = 2
desired_capacity                    = 1
subnet_ids                          = ["subnet-0a712151efeb16f4f"]   #Dev-Salary Pvt ID
tag_key                             = "Name"
tag_value                           = "Dev-Attendance_ASG"
propagate_at_launch                 = false

#---------------------------- Auto Scaling Policies -------------------------------#

scaling_policy_name                 = "target-tracking-policy"
policy_type                         = "TargetTrackingScaling"
predefined_metric_type              = "ASGAverageCPUUtilization"
target_value                        = 50.0




```
</details>

***
### output.tf

<details>
<summary><strong>Click here to see variables.tf file</strong></summary>
<br>

```shell
# Security group

output "Security_Group_ID" {
  value = [module.Dev_Attendance.Security_Group_ID]
}

# Private Key
output "key_pair_name" {
  value       = [module.Dev_Attendance.key_pair_name]
}

# Template

output "launch_template_id" {
  value = [module.Dev_Attendance.launch_template_id]
}

#Target group id

output "Target_group_id" {
  value = [module.Dev_Attendance.Target_group_id]
}

# ASG
output "Autoscaling_group_id" {
  value = [module.Dev_Attendance.Autoscaling_group_id]
}

# ASG Policies

output "Autoscaling_policy_name" {
  value       = [module.Dev_Attendance.Autoscaling_policy_name]
}


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
  region = "us-east-1"  
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
cd attendance
cd attendance-api/
poetry shell
gunicorn app:app --log-config log.conf -b 0.0.0.0:8080

```
</details>

***


# Output

## Terminal Output


<img width="1095" alt="Screenshot 2024-03-17 at 4 14 40 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/5ca35267-dc43-4f05-8c7f-bb74dfa1b293">


***

## Console Output

### Private Key (Dev_Attendance_Key.pem)

<img width="1098" alt="Screenshot 2024-03-17 at 4 15 55 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/92341244-222d-4c1e-8ef9-0ce6640a28ce">


**Key Download**
<img width="723" alt="Screenshot 2024-03-17 at 4 16 58 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/1bbf7b0a-3895-4850-ad83-8d683da470bf">




***

### Security Group (Dev-Attendance-sg)

<img width="1103" alt="Screenshot 2024-03-17 at 4 18 01 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/2ca88b51-ce86-4adf-b763-09865cbbe764">


***

### Launch Template (Dev-Attendance-Launch-Template)

<img width="1101" alt="Screenshot 2024-03-17 at 4 21 49 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/fcd43535-eff3-420f-a48b-177ec1d47325">

***

### Target Groups (Dev-Attendance-TG)

<img width="1076" alt="Screenshot 2024-03-17 at 4 22 27 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/a609687b-262e-46a6-8d58-6217bb01f9a4">

***
### Listener Rule 

<img width="1070" alt="Screenshot 2024-03-17 at 4 23 25 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/a44288c1-3ca8-41e0-ac51-213691a958ea">

***
### Auto Scaling Group (Dev-Attendance_ASG)

<img width="1044" alt="Screenshot 2024-03-17 at 4 24 35 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/5f315b47-b9d3-4eff-a54c-1e5ed11791ec">

***
### Auto Scaling Group Policy 

<img width="730" alt="Screenshot 2024-03-17 at 4 25 20 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/8c0db7dc-3e78-45f5-8850-ea6c724cd924">

***

# Best Practices

| Practice           | Description                                                                                                                                   |
|--------------------|-----------------------------------------------------------------------------------------------------------------------------------------------|
| **Modularity**         | Design wrapper scripts in a modular way, with separate functions for each Terraform command or task.                                          |
| **Error Handling**     | Implement robust error handling mechanisms to gracefully handle failures and provide informative error messages.                             |
| **Version Control**    | Store wrapper scripts alongside Terraform configurations in version control repositories for versioning, collaboration, and auditability.  |
| **Documentation**      | Provide comprehensive documentation for wrapper scripts, including usage instructions, dependencies, and troubleshooting tips.               |
| **Security**           | Follow security best practices to protect sensitive information such as credentials and API keys used by wrapper scripts.                   |


***

# Conclusion

In conclusion, the wrapper code serves as a crucial layer of organising and managing Terraform configurations. By encapsulating complex infrastructure setups and providing additional functionality such as environment management, parameterization, and error handling, wrapper code enhances the maintainability, and reliability of infrastructure deployments.

By leveraging wrapper code effectively, organizations can streamline their deployment processes, mitigate risks, and adapt to evolving requirements with ease.

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
| [Link](https://medium.com/@selvamraju007/terraform-modules-explanation-726ba4a0b98e) | Reference Link For Terraform Modules. |
