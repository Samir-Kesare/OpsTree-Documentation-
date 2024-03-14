
# Autoscaling Terraform Wrapper Code Doc For QA

<img width="360" length="100" alt="Terraform" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/7bebcb9c-e68b-4251-9974-9752be51b3b3">


***

| **Author** | **Created On** | **Last Updated** | **Document version** |
| ---------- | -------------- | ---------------- | -------------------- |
| **Vishal Kumar Kesharwani** | **12 March 2024** | **13 March 2024** | **v1** |

***

## Table of Contents

* [Introduction](#Introduction)
* [Why Terraform Wrapper Code](#Why-Terraform-Wrapper-Code)
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

# Why Terraform Wrapper Code

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

<img src="https://Devopscube.com/wp-content/uploads/2023/08/alb-asg-workflow.gif" width="700">

***

## Directory Structure

<img width="242" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/13a20fce-0900-4467-ab59-a24772f89a56">

***

## Configuration Files

This Terraform configuration defines infrastructure components for an AWS environment, including  Security Group,Launch Template,Target Group,Configure Listener rule of ALB,Configure Auto Scaling group,Auto Scaling Policies and various input variables defined in separate files for customization. The output file specifies the IDs of created resources, facilitating reference in other configurations. Provider and Terraform configuration files ensure the correct provider version and AWS region settings. The terraform.tfvars file provides default values for variables, while allowing for customization as needed.

### main.tf

<details>
<summary><strong>Click here to see main.tf file</strong></summary>
<br>

```shell

module "QA_Frontend_ASG" {
source                              = "git::https://github.com/CodeOps-Hub/Terraform-modules/tree/main/Auto_Sacling_Module"
#---------------------------------Security Group ----------------------------------#
security_name                       = var.QA_Frontend_security_name
Security_description                = var.QA_Frontend_security_description
SG_vpc_id                           = var.QA_Frontend_SG_vpc_id
inbound_ports                       = var.QA_Frontend_inbound_ports
outbound_ports                      = var.QA_Frontend_outbound_ports
Sg_tags                             = var.QA_Frontend_Sg_tags
#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------Launch Template ----------------------------------
private_key_algorithm               = var.QA_Frontend_private_key_algorithm
private_key_rsa_bits                = var.QA_Frontend_private_key_rsa_bits
template_name                       = var.QA_Frontend_template_name
template_description                = var.QA_Frontend_template_description
AMI_ID                              = var.QA_Frontend_AMI_ID
instance_type                       = var.QA_Frontend_instance_type
instance_keypair                    = var.QA_Frontend_instance_keypair
subnet_ID                           = var.QA_Frontend_subnet_ID
user_data_script_path               = var.QA_Frontend_user_data_script_path
#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------- Target Group -----------------------------------#
target_group_name                   = var.QA_Frontend_target_group_name
target_group_port                   = var.QA_Frontend_target_group_port
target_group_protocol               = var.QA_Frontend_target_group_protocol
TG_vpc_id                           = var.QA_Frontend_TG_vpc_id
health_check_path                   = var.QA_Frontend_health_check_path
health_check_port                   = var.QA_Frontend_health_check_port
health_check_interval               = var.QA_Frontend_health_check_interval
health_check_timeout                = var.QA_Frontend_health_check_timeout
health_check_healthy_threshold      = var.QA_Frontend_health_check_healthy_threshold
health_check_unhealthy_threshold    = var.QA_Frontend_health_check_unhealthy_threshold
#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#------------------------------- Listener rule of ALB -----------------------------#
listener_arn                         = var.QA_Frontend_listener_arn
path_pattern                         = var.QA_Frontend_path_pattern
action_type                          = var.QA_Frontend_action_type
priority                             = var.QA_Frontend_priority
#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------Configure Auto Scaling group ---------------------------#
autoscaling_group_name              = var.QA_Frontend_autoscaling_group_name
min_size                            = var.QA_Frontend_min_size
max_size                            = var.QA_Frontend_max_size
desired_capacity                    = var.QA_Frontend_desired_capacity
}
#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
```
</details>

***
### variables.tf

<details>
<summary><strong>Click here to see variables.tf file</strong></summary>
<br>

```shell
#---------------------------------Security Group ----------------------------------#

variable "QA_Frontend_security_name" {
  description     = "Name tag for the security group"
  type            = string
  default         = "QA-Frontend-sg"
}
variable "QA_Frontend_security_description" {
  description     = "Description for the security group"
  type            = string
  default         = "Security group for QA-Frontend-Frontend-API"
}
variable "QA_Frontend_SG_vpc_id" {
  description     = "ID of the VPC for instances"
  type            = string
  default         = "vpc-0383f4dc3af051efa"   # QA_Frontend-VPC ID
}
variable "QA_Frontend_inbound_ports" {
  description     = "List of inbound ports and protocols and cidr block"
  type            = list(map(any))
  default         = [
    { port = 22, protocol = "tcp",cidr_blocks = "10.0.1.0/24" }, # Management VPC Cidr Block
    { port = 22, protocol = "tcp", security_group_ids = "sg-0f470a22a92136557" },    # OpenVPN-SG
    { port = 3000, protocol = "tcp", security_group_ids = "sg-0b426399b2b19b0ae" }, #  QA-Frontend-lb-sg ID 
  ]
}
variable "QA_Frontend_outbound_ports" {
  description     = "List of outbound ports and protocols and Cidr block "
  type            = list(map(any))
  default         = [
    { port = 0, protocol = "-1", cidr_blocks = "0.0.0.0/0", },
  ]
}
variable "QA_Frontend_Sg_tags" {
  description     = "Tags for Security Group"
  type            = map(string)
  default         = {
    Name          = "QA-Frontend-sg"
    Enviroment    = "QA_Frontend"
    Owner         = "Vishal"
  }
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------Launch Template ----------------------------------#

# Key Generate

variable "QA_Frontend_private_key_algorithm" {
  description     = "private_key_algorithm"
  type            = string
  default         = "RSA"
}
variable "QA_Frontend_private_key_rsa_bits" {
  description     = "private_key_rsa_bits"
  type            = number
  default         = 4096
}

variable "QA_Frontend_template_name" {
  description     = "Launch Template Name"
  type            = string
  default         = "QA-Frontend-template"  
}
variable "QA_Frontend_template_description" {
  description     = "Launch Template Description"
  type            = string
  default         = "Template for QA-Frontend"  
}
variable "QA_Frontend_AMI_ID" {
  description     = "Instance AMI ID"
  type            = string
  default         = "ami-0c335502f397b30c6" # QA-Frontend Setup AMI ID
}
variable "QA_Frontend_instance_type" {
  description     = "Launch Template Instance Type"
  type            = string
  default         = "t2.micro"  
}
variable "QA_Frontend_instance_keypair" {
  description     = "Launch Template Instance Type keypair name"
  type            = string
  default         = "QA_Frontend_Key"  
}
variable "QA_Frontend_subnet_ID" {
  description     = "Launch Template Subnet ID"
  type            = string
  default         = "subnet-04c0c823118f48202"  
}
variable "QA_Frontend_user_data_script_path" {
  description = "Path to the user data script file"
  type        = string
  default     = "./script.sh"  # Path QA-Frontend User data Script
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------- Target Group -----------------------------------#

variable "QA_Frontend_target_group_name" {
  description     = "Name of the target group"
  type            = string
  default         = "QA-Frontend-TG"
}
variable "QA_Frontend_target_group_port" {
  description     = "Port for the target group"
  type            = number 
  default         = 3000
}
variable "QA_Frontend_target_group_protocol" {
  description     = "Protocol for the target group"
  type            = string
  default         = "HTTP"
}
variable "QA_Frontend_TG_vpc_id" {
  description     = "ID of the VPC"
  type            = string
  default         = "vpc-0383f4dc3af051efa"    #  QA_Frontend-VPC ID 
}
variable "QA_Frontend_health_check_path" {
  description     = "The destination for the health check request"
  type            = string
  default         = "/health"
}
variable "QA_Frontend_health_check_port" {
  description     = "The port to use to connect with the target for health checking"
  type            = string
  default         = "traffic-port"
}
variable "QA_Frontend_health_check_interval" {
  description     = "The approximate amount of time, in seconds, between health checks of an individual target"
  type            = number
  default         = 30
}
variable "QA_Frontend_health_check_timeout" {
  description     = "The amount of time, in seconds, during which no response means a failed health check"
  type            = number
  default         = 5
}
variable "QA_Frontend_health_check_healthy_threshold" {
  description     = "The number of consecutive health checks successes required before considering an unhealthy target healthy"
  type            = number
  default         = 2
}
variable "QA_Frontend_health_check_unhealthy_threshold" {
  description     = "The number of consecutive health check failures required before considering a target unhealthy"
  type            = number
  default         = 2
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#------------------------------- Listener rule of ALB -----------------------------#

variable "QA_Frontend_listener_arn" {
  description       = "ARN of the existing listener where the rule will be added"
  type              = string
  default           = "arn:aws:elasticloadbalancing:ap-northeast-1:133673781875:listener/app/QA-ALB/28944ea6f074d63f/4f0525f30ddcc2a5"
}
variable "QA_Frontend_path_pattern" {
  description       = "Path pattern for the listener rule"
  type              = string
  default           = "*"   # Give your Path 
}
variable "QA_Frontend_action_type" {
  description       = "Path pattern for the listener rule"
  type              = string
  default           = "forward"
}
variable "QA_Frontend_priority" {
  description       = "priority"
  type              = number
  default           = 100 
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------Configure Auto Scaling group ---------------------------#

variable "QA_Frontend_autoscaling_group_name" {
  description     = "The name of the Auto Scaling Group"
  type            = string
  default         = "QA_Frontend_Frontend_ASG"
}

variable "QA_Frontend_min_size" {
  description     = "The minimum number of instances in the ASG"
  type            = number
  default         = 1
}

variable "QA_Frontend_max_size" {
  description     = "The maximum number of instances in the ASG"
  type            = number
  default         = 2
}

variable "QA_Frontend_desired_capacity" {
  description     = "The desired number of instances in the ASG"
  type            = number
  default         = 1
}

variable "QA_Frontend_subnet_ids" {
  description     = "The list of subnet IDs where the instances will be launched"
  type            = list(string)
  default         = [ "subnet-04c0c823118f48202" ]    #Frontend-Pvt-Subnet ID
}

variable "QA_Frontend_tag_key" {
  description     = "The key for the tag to be applied to the ASG and instances"
  type            = string
  default         = "Name"
}

variable "QA_Frontend_tag_value" {
  description     = "The value for the tag to be applied to the ASG and instances"
  type            = string
  default         = "QA_Frontend_Frontend_ASG"
}

variable "QA_Frontend_propagate_at_launch" {
  description     = "Whether the tag should be propagated to instances launched by the ASG"
  type            = bool
  default         = true
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#---------------------------- Auto Scaling Policies -------------------------------#

variable "QA_Frontend_scaling_policy_name" {
  description     = "The name of the scaling policy"
  type            = string
  default         = "target-tracking-policy"
}
variable "QA_Frontend_policy_type" {
  description     = "The type of adjustment to make"
  type            = string
  default         = "TargetTrackingScaling"
}
variable "QA_Frontend_predefined_metric_type" {
  description     = "The predefined metric type for tracking"
  type            = string
  default         = "ASGAverageCPUUtilization"
}
variable "QA_Frontend_target_value" {
  description     = "The target value for the predefined metric"
  type            = number
  default         = 50.0
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#

```
</details>

***

### terraform.tfvars

<details>
<summary><strong>Click here to see terraform.tfvars file</strong></summary>
<br>

```shell
#---------------------------------Security Group ----------------------------------#

QA_Frontend_security_name                       = "QA-Frontend-sg"
QA_Frontend_security_description                = "Security group for QA-Frontend-API"
QA_Frontend_SG_vpc_id                           = "vpc-0383f4dc3af051efa"    #QA_Frontend-VPC-ID
QA_Frontend_inbound_ports                       = [
  { port                                = 22, protocol = "tcp", cidr_blocks = "10.0.1.0/24" },                     # Management VPC Cidr Block
  { port                                = 22, protocol = "tcp", security_group_ids = "sg-0f470a22a92136557" },     #  QA-Frontend-lb-sg ID
  { port                                = 3000, protocol = "tcp", security_group_ids = "sg-0b426399b2b19b0ae" },   # OpenVPN-SG
]
QA_Frontend_outbound_ports                      = [
  { port                                = 0, protocol = "-1", cidr_blocks = "0.0.0.0/0" }
]
QA_Frontend_Sg_tags                             = {
  Name                                  = "QA-Frontend-sg"
  Enviroment                            = "QA-Frontend"
  Owner                                 = "Vishal"
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------Launch Template ----------------------------------#

QA_Frontend_private_key_algorithm               = "RSA"
QA_Frontend_private_key_rsa_bits                = 4096
QA_Frontend_template_name                       = "QA-Frontend-template"
QA_Frontend_template_description                = "Template for QA-Frontend"
QA_Frontend_AMI_ID                              = "ami-0c335502f397b30c6"
QA_Frontend_instance_type                       = "t2.micro"
QA_Frontend_instance_keypair                    = "QA_Frontend_Key"
QA_Frontend_subnet_ID                           = "subnet-04c0c823118f48202"
QA_Frontend_user_data_script_path               = "./script.sh"

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------- Target Group -----------------------------------#

QA_Frontend_target_group_name                   = "QA-Frontend-TG"
QA_Frontend_target_group_port                   = 3000
QA_Frontend_target_group_protocol               = "HTTP"
QA_Frontend_TG_vpc_id                           = "vpc-0383f4dc3af051efa"   #QA_Frontend-VPC-ID
QA_Frontend_health_check_path                   = "/health"
QA_Frontend_health_check_port                   = "traffic-port"
QA_Frontend_health_check_interval               = 30
QA_Frontend_health_check_timeout                = 5
QA_Frontend_health_check_healthy_threshold      = 2
QA_Frontend_health_check_unhealthy_threshold    = 2

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#------------------------------- Listener rule of ALB -----------------------------#

QA_Frontend_listener_arn                          = "arn:aws:elasticloadbalancing:ap-northeast-1:133673781875:listener/app/QA-ALB/28944ea6f074d63f/4f0525f30ddcc2a5"
QA_Frontend_path_pattern                          = "*"
QA_Frontend_action_type                           = "forward"
QA_Frontend_priority                              = 100

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------Configure Auto Scaling group ---------------------------#

QA_Frontend_autoscaling_group_name              = "QA-Frontend-ASG"
QA_Frontend_min_size                            = 1
QA_Frontend_max_size                            = 2
QA_Frontend_desired_capacity                    = 1
QA_Frontend_subnet_ids                          = ["subnet-04c0c823118f48202"]   #QA-Frontend Pvt ID
QA_Frontend_tag_key                             = "Name"
QA_Frontend_tag_value                           = "QA-Frontend-ASG"
QA_Frontend_propagate_at_launch                 = true

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#---------------------------- Auto Scaling Policies -------------------------------#

QA_Frontend_scaling_policy_name                 = "target-tracking-policy"
QA_Frontend_policy_type                         = "TargetTrackingScaling"
QA_Frontend_predefined_metric_type              = "ASGAverageCPUUtilization"
QA_Frontend_target_value                        = 50.0

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
  value = [module.ASG.Security_Group_ID]
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------Launch Template ----------------------------------#

# Priavte Key
output "key_pair_name" {
  value       = [module.ASG.key_pair_name]
}

# Template
output "launch_template_id" {
  value = [module.ASG.launch_template_id]
}
#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------- Target Group -----------------------------------#

output "Target_group_id" {
  value = [module.ASG.Target_group_id]
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------Configure Auto Scaling group ---------------------------#

output "Autoscaling_group_id" {
  value = [module.ASG.Autoscaling_group_id]
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#---------------------------- Auto Scaling Policies -------------------------------#

output "Autoscaling_policy_name" {
  value       = [module.ASG.Autoscaling_policy_name]
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
  region = "ap-northeast-1"  
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

ALB_DNS="QA-ALB-1428988738.ap-northeast-1.elb.amazonaws.com"
# Modify package.json with the ALB DNS placeholder
sed -i 's/"homepage": "https:\/\/opstree.github.io",/"homepage": "http:\/\/${ALB_DNS}",/' /home/ubuntu/Frontend/package.json
sed -i '/"proxy": "http:\/\/localhost:3000"/d' /home/ubuntu/Frontend/package.json

# Start your application
cd /home/ubuntu/Frontend 
npm start

```
</details>

***


## Tags

* Tags are assigned to resources with name variable as prefix.
* Additial tags can be assigned by tags variables as defined above.
  
***

## Inputs

| Name                             | Description                                              | Type          | Default                        |
| -------------------------------- | -------------------------------------------------------- | ------------- | ------------------------------ |
| **QA_Frontend_security_name**            | Name tag for the security group                          | `string`      | `QA-Frontend-sg`             |
| **QA_Frontend_security_description**     | Description for the security group                       | `string`      | `Security group for QA-Frontend-API` |
| **QA_Frontend_SG_vpc_id**                | ID of the VPC for instances                              | `string`      | `vpc-0383f4dc3af051efa`       |
| **QA_Frontend_inbound_ports**            | List of inbound ports and protocols and cidr block       | `list(map(any))` | See default values |
| **QA_Frontend_outbound_ports**           | List of outbound ports and protocols and Cidr block      | `list(map(any))` | See default values |
| **QA_Frontend_Sg_tags**                  | Tags for Security Group                                  | `map(string)` | See default values |
| **QA_Frontend_private_key_algorithm**    | private_key_algorithm                                    | `string`      | `RSA`                          |
| **QA_Frontend_private_key_rsa_bits**     | private_key_rsa_bits                                     | `number`      | `4096`                         |
| **QA_Frontend_template_name**            | Launch Template Name                                     | `string`      | `QA-Frontend-template`        |
| **QA_Frontend_template_description**     | Launch Template Description                              | `string`      | `Template for QA-Frontend`    |
| **QA_Frontend_AMI_ID**                   | Instance AMI ID                                          | `string`      | `ami-0c335502f397b30c6`       |
| **QA_Frontend_instance_type**            | Launch Template Instance Type                            | `string`      | `t2.micro`                     |
| **QA_Frontend_instance_keypair**         | Launch Template Instance Type keypair name               | `string`      | `QA_Frontend_Key`                      |
| **QA_Frontend_subnet_ID**                | Launch Template Subnet ID                                | `string`      | `subnet-04c0c823118f48202`    |
| **QA_Frontend_user_data_script_path**    | Path to the user data script file                        | `string`      | `./script.sh`                  |
| **QA_Frontend_target_group_name**        | Name of the target group                                 | `string`      | `QA-Frontend-TG`              |
| **QA_Frontend_target_group_port**        | Port for the target group                                | `number`      | `3000`                         |
| **QA_Frontend_target_group_protocol**    | Protocol for the target group                            | `string`      | `HTTP`                         |
| **QA_Frontend_TG_vpc_id**                | ID of the VPC                                             | `string`      | `vpc-0383f4dc3af051efa`       |
| **QA_Frontend_health_check_path**        | The destination for the health check request             | `string`      | `/health`                      |
| **QA_Frontend_health_check_port**        | The port to use to connect with the target for health checking | `string`  | `traffic-port`                 |
| **QA_Frontend_health_check_interval**    | The approximate amount of time, in seconds, between health checks of an individual target | `number` | `30`          |
| **QA_Frontend_health_check_timeout**     | The amount of time, in seconds, during which no response means a failed health check | `number` | `5`                          |
| **QA_Frontend_health_check_healthy_threshold** | The number of consecutive health checks successes required before considering an unhealthy target healthy | `number` | `2`   |
| **QA_Frontend_health_check_unhealthy_threshold** | The number of consecutive health check failures required before considering a target unhealthy | `number` | `2` |
| **QA_Frontend_listener_arn**             | ARN of the existing listener where the rule will be added | `string`  | `arn:aws:elasticloadbalancing:ap-northeast-1:133673781875:listener/app/QA_Frontend-ALB/28944ea6f074d63f/4f0525f30ddcc2a5` |
| **QA_Frontend_path_pattern**             | Path pattern for the listener rule                       | `string`  | `*`                            |
| **QA_Frontend_action_type**              | Path pattern for the listener rule                        | `string` | `forward`                     |
| **QA_Frontend_priority**                 | priority                                                  | `number` | `100`                         |
| **QA_Frontend_autoscaling_group_name**   | The name of the Auto Scaling Group                        | `string` | `QA_Frontend_Frontend_ASG`            |
| **QA_Frontend_min_size**                 | The minimum number of instances in the ASG               | `number` | `1`                           |
| **QA_Frontend_max_size**                 | The maximum number of instances in the ASG               | `number` | `2`                           |
| **QA_Frontend_desired_capacity**         | The desired number of instances in the ASG               | `number` | `1`                           |
| **QA_Frontend_subnet_ids**               | The list of subnet IDs where the instances will be launched | `list(string)` | See default values |
| **QA_Frontend_tag_key**                  | The key for the tag to be applied to the ASG and instances | `string` | `Name`                        |
| **QA_Frontend_tag_value**                | The value for the tag to be applied to the ASG and instances | `string` | `QA_Frontend_Frontend_ASG`            |
| **QA_Frontend_propagate_at_launch**      | Whether the tag should be propagated to instances launched by the ASG | `bool` | `true`                     |
| **QA_Frontend_scaling_policy_name**      | The name of the scaling policy                           | `string` | `target-tracking-policy`      |
| **QA_Frontend_policy_type**              | The type of adjustment to make                           | `string` | `TargetTrackingScaling`       |
| **QA_Frontend_predefined_metric_type**   | The predefined metric type for tracking                  | `string` | `ASGAverageCPUUtilization`    |
| **QA_Frontend_target_value**             | The target value for the predefined metric               | `number` | `50.0`                        |

***

## Outputs 

| Name                 | Description                                       |
|----------------------|---------------------------------------------------|
| **Security_Group_ID**   | Output for the ID of the created security group   |
| **key_pair_name**       | Output for the key pair name                      |
| **launch_template_id**  | Output for the ID of the created launch template  |
| **Target_group_id**     | Output for the ID of the created target group     |
| **Autoscaling_group_id**| Output for the ID of the created auto-scaling group |
| **Autoscaling_policy_name** | Output for the name of the created auto-scaling policy |

***

## Terminal Output

<img width="700" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/b7f45009-65bd-4c0f-a3c5-963dd4df36be">

***

## Console Output

### Security Group

<img width="700" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/61f3feea-ab60-4e1e-8997-9323a831f30a"> 

***
### Launch Template

<img width="700" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/d8e01224-9d3a-4109-8feb-669e4d30f244"> 

***

### Target Group

<img width="700" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/0be7e641-505d-4933-9be0-5e54b6576ca4">

***
### Listener rule of ALB

<img width="700" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/b9d7c429-9282-486b-b1f3-cc84871cc827">

***
### Auto Scaling Group

<img width="700" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/a8e30987-c1ee-4d1e-bb6f-5f582470f0e2">

***
### Auto Scaling Group Policies

<img width="700" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/0072a186-7f22-4069-b271-761dfb5de8a3">

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

## Conclusion

Terraform wrapper code enhances the capabilities of Terraform by automating tasks, providing additional functionality, and enforcing best practices. By following best practices such as modularity, error handling, and documentation, wrapper scripts can streamline Terraform workflows, improve productivity, and ensure the reliability and security of infrastructure deployments.

***
 ## Contact Information

 | **Name** | **Email Address** |
 | -------- | ----------------- |
 | **Vishal Kumar Kesharwani** | vishal.kumar.kesharwani.snaatak@mygurukulam.co |

 ***
 
## References

 | **Source** | **Description** |
 | ---------- | --------------- |
 | [**Link**](https://medium.com/@brandon.wagner/a-wrapper-for-terraform-61a125b27ffc) | Terraform Wrapper Code Concept. |
 | [**Link**](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GenericDoc/Terraform/terraform.md) | Terraform Generic Doc Link. |
 | [**Link**](https://QAeloper.hashicorp.com/terraform/language/modules) | Terraform Modules |
 | [**Link**](https://github.com/CodeOps-Hub/Documentation/blob/main/Terraform/Design/Module/Auto-scaling.md) | ASG-Module |
 | [**Link**](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Design/09-%20Cloud%20Infra%20Design/Cloud-Infra-Design-QA.md) | Cloud Infra Design QA |

 
