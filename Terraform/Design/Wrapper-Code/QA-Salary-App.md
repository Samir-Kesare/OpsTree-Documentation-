
# Salary-App Terraform Wrapper Code Doc For QA

<img width="360" length="100" alt="Terraform" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/7bebcb9c-e68b-4251-9974-9752be51b3b3">


***

| **Author** | **Created On** | **Last Updated** | **Document version** |
| ---------- | -------------- | ---------------- | -------------------- |
| **Shikha Tripathi** | **17 March 2024** | **17March 2024** | **v1** |

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

In this document, we will provide a comprehensive guide to setting up the "Salary Wrapper" for infrastructure provisioning using Terraform. This wrapper code is designed specifically for managing infrastructure setups related to salary management. It facilitates the organization and orchestration of various components within the infrastructure. The primary focus of this wrapper code is to enable efficient management and building of infrastructure setups, tailored to the requirements and specifications provided through the root module or wrapper code. Additionally, this setup entails the management of different Terraform state files to ensure proper isolation and handling of respective environments.
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
module "QA_Salary" {
source                              = "git@github.com:CodeOps-Hub/Terraform-modules.git//Modules/Auto_Sacling_Module?ref=main"
#---------------------------------Security Group ----------------------------------#
security_name                       = var.QA_Salary_security_name
Security_description                = var.QA_Salary_security_description
SG_vpc_id                           = var.QA_Salary_SG_vpc_id
inbound_ports                       = var.QA_Salary_inbound_ports
outbound_ports                      = var.QA_Salary_outbound_ports
Sg_tags                             = var.QA_Salary_Sg_tags
#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------Launch Template ----------------------------------
private_key_algorithm               = var.QA_Salary_private_key_algorithm
private_key_rsa_bits                = var.QA_Salary_private_key_rsa_bits
template_name                       = var.QA_Salary_template_name
template_description                = var.QA_Salary_template_description
AMI_ID                              = var.QA_Salary_AMI_ID
instance_type                       = var.QA_Salary_instance_type
instance_keypair                    = var.QA_Salary_instance_keypair
subnet_ID                           = var.QA_Salary_subnet_ID
user_data_script_path               = var.QA_Salary_user_data_script_path
#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------- Target Group -----------------------------------#
target_group_name                   = var.QA_Salary_target_group_name
target_group_port                   = var.QA_Salary_target_group_port
target_group_protocol               = var.QA_Salary_target_group_protocol
TG_vpc_id                           = var.QA_Salary_TG_vpc_id
health_check_path                   = var.QA_Salary_health_check_path
health_check_port                   = var.QA_Salary_health_check_port
health_check_interval               = var.QA_Salary_health_check_interval
health_check_timeout                = var.QA_Salary_health_check_timeout
health_check_healthy_threshold      = var.QA_Salary_health_check_healthy_threshold
health_check_unhealthy_threshold    = var.QA_Salary_health_check_unhealthy_threshold
#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#------------------------------- Listener rule of ALB -----------------------------#
listener_arn                         = var.QA_Salary_listener_arn
path_pattern                         = var.QA_Salary_path_pattern
action_type                          = var.QA_Salary_action_type
priority                             = var.QA_Salary_priority
#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------Configure Auto Scaling group ---------------------------#
autoscaling_group_name              = var.QA_Salary_autoscaling_group_name
ASG_version                         = var.QA_Salary_ASG_vserion
subnet_ids                          = var.QA_Salary_subnet_ids
tag_key                             = var.QA_Salary_tag_key
tag_value                           = var.QA_Salary_tag_value
propagate_at_launch                 = var.QA_Salary_propagate_at_launch
min_size                            = var.QA_Salary_min_size
max_size                            = var.QA_Salary_max_size
desired_capacity                    = var.QA_Salary_desired_capacity
#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#---------------------------- Auto Scaling Policies -------------------------------#
scaling_policy_name                 = var.QA_Salary_scaling_policy_name
policy_type                         = var.QA_Salary_policy_type
predefined_metric_type              = var.QA_Salary_predefined_metric_type
target_value                        = var.QA_Salary_target_value
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

variable "QA_Salary_security_name" {
  description     = "Name tag for the security group"
  type            = string
  default         = "QA-Salary-sg"
}
variable "QA_Salary_security_description" {
  description     = "Description for the security group"
  type            = string
  default         = "Security group for QA-Salary-Salary-API"
}
variable "QA_Salary_SG_vpc_id" {
  description     = "ID of the VPC for instances"
  type            = string
  default         = "vpc-00631f1bf6539cb88"   # QA_Salary-VPC ID
}
variable "QA_Salary_inbound_ports" {
  description     = "List of inbound ports and protocols and cidr block"
  type            = list(map(any))
  default         = [
    { port = 22, protocol = "tcp",cidr_blocks = "10.0.1.0/24" }, # Management VPC Cidr Block
    { port = 22, protocol = "tcp", security_group_ids = "sg-00a65bcd92abcee70" },    # OpenVPN-SG
    { port = 8080, protocol = "tcp", security_group_ids = "sg-0d2e3609a8b620d52" }, #  QA-Salary-lb-sg ID 
  ]
}
variable "QA_Salary_outbound_ports" {
  description     = "List of outbound ports and protocols and Cidr block "
  type            = list(map(any))
  default         = [
    { port = 0, protocol = "-1", cidr_blocks = "0.0.0.0/0", },
  ]
}
variable "QA_Salary_Sg_tags" {
  description     = "Tags for Security Group"
  type            = map(string)
  default         = {
    Name          = "QA-Salary-sg"
    Enviroment    = "QA-Salary"
    Owner         = "Shikha"
  }
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------Launch Template ----------------------------------#

# Key Generate

variable "QA_Salary_private_key_algorithm" {
  description     = "private_key_algorithm"
  type            = string
  default         = "RSA"
}
variable "QA_Salary_private_key_rsa_bits" {
  description     = "private_key_rsa_bits"
  type            = number
  default         = 4096
}

variable "QA_Salary_template_name" {
  description     = "Launch Template Name"
  type            = string
  default         = "QA-Salary-template"  
}
variable "QA_Salary_template_description" {
  description     = "Launch Template Description"
  type            = string
  default         = "Template for QA-Salary"  
}
variable "QA_Salary_AMI_ID" {
  description     = "Instance AMI ID"
  type            = string
  default         = "ami-0b8b44ec9a8f90422" # QA-Salary Setup AMI ID
}
variable "QA_Salary_instance_type" {
  description     = "Launch Template Instance Type"
  type            = string
  default         = "t2.micro"  
}
variable "QA_Salary_instance_keypair" {
  description     = "Launch Template Instance Type keypair name"
  type            = string
  default         = "QA_Salary_Key"  
}
variable "QA_Salary_subnet_ID" {
  description     = "Launch Template Subnet ID"
  type            = string
  default         = "subnet-03e34296260c1c84d"  
}
variable "QA_Salary_user_data_script_path" {
  description = "Path to the user data script file"
  type        = string
  default     = "./script.sh"  # Path QA-Salary User data Script
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------- Target Group -----------------------------------#

variable "QA_Salary_target_group_name" {
  description     = "Name of the target group"
  type            = string
  default         = "QA-Salary-TG"
}
variable "QA_Salary_target_group_port" {
  description     = "Port for the target group"
  type            = number 
  default         = 8080
}
variable "QA_Salary_target_group_protocol" {
  description     = "Protocol for the target group"
  type            = string
  default         = "HTTP"
}
variable "QA_Salary_TG_vpc_id" {
  description     = "ID of the VPC"
  type            = string
  default         = "vpc-00631f1bf6539cb88"    #  QA_Salary-VPC ID 
}
variable "QA_Salary_health_check_path" {
  description     = "The destination for the health check request"
  type            = string
  default         = "/health"
}
variable "QA_Salary_health_check_port" {
  description     = "The port to use to connect with the target for health checking"
  type            = string
  default         = "traffic-port"
}
variable "QA_Salary_health_check_interval" {
  description     = "The approximate amount of time, in seconds, between health checks of an individual target"
  type            = number
  default         = 30
}
variable "QA_Salary_health_check_timeout" {
  description     = "The amount of time, in seconds, during which no response means a failed health check"
  type            = number
  default         = 5
}
variable "QA_Salary_health_check_healthy_threshold" {
  description     = "The number of consecutive health checks successes required before considering an unhealthy target healthy"
  type            = number
  default         = 2
}
variable "QA_Salary_health_check_unhealthy_threshold" {
  description     = "The number of consecutive health check failures required before considering a target unhealthy"
  type            = number
  default         = 2
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#------------------------------- Listener rule of ALB -----------------------------#

variable "QA_Salary_listener_arn" {
  description       = "ARN of the existing listener where the rule will be added"
  type              = string
  default           = "arn:aws:elasticloadbalancing:us-east-2:975050171850:listener/app/alb/385bb840baa3fc3b/4eebd240281403eb"
}
variable "QA_Salary_path_pattern" {
  description       = "Path pattern for the listener rule"
  type              = string
  default           = "/api/v1/salary/*"   # Give your Path 
}
variable "QA_Salary_action_type" {
  description       = "Path pattern for the listener rule"
  type              = string
  default           = "forward"
}
variable "QA_Salary_priority" {
  description       = "priority"
  type              = number
  default           = 100 
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------Configure Auto Scaling group ---------------------------#

variable "QA_Salary_autoscaling_group_name" {
  description     = "The name of the Auto Scaling Group"
  type            = string
  default         = "QA_Salary_ASG"
}

variable "QA_Salary_ASG_vserion" {
  description     = "Give the Version"
  type            = string
  default         = "$Latest"
}
variable "QA_Salary_min_size" {
  description     = "The minimum number of instances in the ASG"
  type            = number
  default         = 1
}

variable "QA_Salary_max_size" {
  description     = "The maximum number of instances in the ASG"
  type            = number
  default         = 2
}

variable "QA_Salary_desired_capacity" {
  description     = "The desired number of instances in the ASG"
  type            = number
  default         = 1
}

variable "QA_Salary_subnet_ids" {
  description     = "The list of subnet IDs where the instances will be launched"
  type            = list(string)
  default         = [ "subnet-03e34296260c1c84d" ]    #Salary-Pvt-Subnet ID
}

variable "QA_Salary_tag_key" {
  description     = "The key for the tag to be applied to the ASG and instances"
  type            = string
  default         = "Name"
}

variable "QA_Salary_tag_value" {
  description     = "The value for the tag to be applied to the ASG and instances"
  type            = string
  default         = "QA_Salary_ASG"
}

variable "QA_Salary_propagate_at_launch" {
  description     = "Whether the tag should be propagated to instances launched by the ASG"
  type            = bool
  default         = true
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#---------------------------- Auto Scaling Policies -------------------------------#

variable "QA_Salary_scaling_policy_name" {
  description     = "The name of the scaling policy"
  type            = string
  default         = "target-tracking-policy"
}
variable "QA_Salary_policy_type" {
  description     = "The type of adjustment to make"
  type            = string
  default         = "TargetTrackingScaling"
}
variable "QA_Salary_predefined_metric_type" {
  description     = "The predefined metric type for tracking"
  type            = string
  default         = "ASGAverageCPUUtilization"
}
variable "QA_Salary_target_value" {
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

QA_Salary_security_name                       = "QA-Salary-sg"
QA_Salary_security_description                = "Security group for QA-Salary-API"
QA_Salary_SG_vpc_id                           = "vpc-00631f1bf6539cb88"    #QA_Salary-VPC-ID
QA_Salary_inbound_ports                       = [
  { port                                = 22, protocol = "tcp", cidr_blocks = "10.0.1.0/24" },                     # Management VPC Cidr Block
  { port                                = 22, protocol = "tcp", security_group_ids = "sg-00a65bcd92abcee70" },     #  QA-Salary-lb-sg ID
  { port                                = 8080, protocol = "tcp", security_group_ids = "sg-0d2e3609a8b620d52" },   # OpenVPN-SG
]
QA_Salary_outbound_ports                      = [
  { port                                = 0, protocol = "-1", cidr_blocks = "0.0.0.0/0" }
]
QA_Salary_Sg_tags                             = {
  Name                                  = "QA-Salary-sg"
  Enviroment                            = "QA-Salary"
  Owner                                 = "Salary"
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------Launch Template ----------------------------------#

QA_Salary_private_key_algorithm               = "RSA"
QA_Salary_private_key_rsa_bits                = 4096
QA_Salary_template_name                       = "QA-Salary-template"
QA_Salary_template_description                = "Template for QA-Salary"
QA_Salary_AMI_ID                              = "ami-0b8b44ec9a8f90422"
QA_Salary_instance_type                       = "t2.micro"
QA_Salary_instance_keypair                    = "QA_Salary_Key"
QA_Salary_subnet_ID                           = "subnet-03e34296260c1c84d"
QA_Salary_user_data_script_path               = "./script.sh"

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------- Target Group -----------------------------------#

QA_Salary_target_group_name                   = "QA-Salary-TG"
# QA_Salary_target_group_port                   = 8080
QA_Salary_target_group_protocol               = "HTTP"
QA_Salary_TG_vpc_id                           = "vpc-00631f1bf6539cb88"   #QA_Salary-VPC-ID
QA_Salary_health_check_path                   = "/health"
QA_Salary_health_check_port                   = "traffic-port"
QA_Salary_health_check_interval               = 30
QA_Salary_health_check_timeout                = 5
QA_Salary_health_check_healthy_threshold      = 2
QA_Salary_health_check_unhealthy_threshold    = 2

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#------------------------------- Listener rule of ALB -----------------------------#

QA_Salary_listener_arn                          = "arn:aws:elasticloadbalancing:us-east-2:975050171850:listener/app/alb/385bb840baa3fc3b/4eebd240281403eb"
QA_Salary_path_pattern                          = "/api/v1/salary/*"
QA_Salary_action_type                           = "forward"
QA_Salary_priority                              = 100

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------Configure Auto Scaling group ---------------------------#

QA_Salary_autoscaling_group_name              = "QA-Salary-ASG"
QA_Salary_ASG_vserion                         = "$Latest"
QA_Salary_min_size                            = 1
QA_Salary_max_size                            = 2
QA_Salary_desired_capacity                    = 1
QA_Salary_subnet_ids                          = ["subnet-03e34296260c1c84d"]   #QA-Salary Pvt ID
QA_Salary_tag_key                             = "Name"
QA_Salary_tag_value                           = "QA-Salary-ASG"
QA_Salary_propagate_at_launch                 = true

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#---------------------------- Auto Scaling Policies -------------------------------#

QA_Salary_scaling_policy_name                 = "target-tracking-policy"
QA_Salary_policy_type                         = "TargetTrackingScaling"
QA_Salary_predefined_metric_type              = "ASGAverageCPUUtilization"
QA_Salary_target_value                        = 50.0

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
  value = [module.QA_Salary.Security_Group_ID]
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------Launch Template ----------------------------------#

# Priavte Key
output "key_pair_name" {
  value       = [module.QA_Salary.key_pair_name]
}

# Template
output "launch_template_id" {
  value = [module.QA_Salary.launch_template_id]
}
#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------- Target Group -----------------------------------#

output "Target_group_id" {
  value = [module.QA_Salary.Target_group_id]
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------Configure Auto Scaling group ---------------------------#

output "Autoscaling_group_id" {
  value = [module.QA_Salary.Autoscaling_group_id]
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#---------------------------- Auto Scaling Policies -------------------------------#

output "Autoscaling_policy_name" {
  value       = [module.QA_Salary.Autoscaling_policy_name]
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


## Tags

* Tags are assigned to resources with name variable as prefix.
* Additial tags can be assigned by tags variables as defined above.
  
***

## Inputs

| Name                             | Description                                              | Type          | Default                        |
| -------------------------------- | -------------------------------------------------------- | ------------- | ------------------------------ |
| **QA_Salary_security_name**            | Name tag for the security group                          | `string`      | `QA-Salary-sg`             |
| **QA_Salary_security_description**     | Description for the security group                       | `string`      | `Security group for QA-Salary-API` |
| **QA_Salary_SG_vpc_id**                | ID of the VPC for instances                              | `string`      | `vpc-00631f1bf6539cb88`       |
| **QA_Salary_inbound_ports**            | List of inbound ports and protocols and cidr block       | `list(map(any))` | See default values |
| **QA_Salary_outbound_ports**           | List of outbound ports and protocols and Cidr block      | `list(map(any))` | See default values |
| **QA_Salary_Sg_tags**                  | Tags for Security Group                                  | `map(string)` | See default values |
| **QA_Salary_private_key_algorithm**    | private_key_algorithm                                    | `string`      | `RSA`                          |
| **QA_Salary_private_key_rsa_bits**     | private_key_rsa_bits                                     | `number`      | `4096`                         |
| **QA_Salary_template_name**            | Launch Template Name                                     | `string`      | `QA-Salary-template`        |
| **QA_Salary_template_description**     | Launch Template Description                              | `string`      | `Template for QA-Salary`    |
| **QA_Salary_AMI_ID**                   | Instance AMI ID                                          | `string`      | `ami-0b8b44ec9a8f90422`       |
| **QA_Salary_instance_type**            | Launch Template Instance Type                            | `string`      | `t2.micro`                     |
| **QA_Salary_instance_keypair**         | Launch Template Instance Type keypair name               | `string`      | `QA_Salary_Key`                      |
| **QA_Salary_subnet_ID**                | Launch Template Subnet ID                                | `string`      | `subnet-03e34296260c1c84d`    |
| **QA_Salary_user_data_script_path**    | Path to the user data script file                        | `string`      | `./script.sh`                  |
| **QA_Salary_target_group_name**        | Name of the target group                                 | `string`      | `QA-Salary-TG`              |
| **QA_Salary_target_group_port**        | Port for the target group                                | `number`      | `8080`                         |
| **QA_Salary_target_group_protocol**    | Protocol for the target group                            | `string`      | `HTTP`                         |
| **QA_Salary_TG_vpc_id**                | ID of the VPC                                             | `string`      | `vpc-00631f1bf6539cb88`       |
| **QA_Salary_health_check_path**        | The destination for the health check request             | `string`      | `/health`                      |
| **QA_Salary_health_check_port**        | The port to use to connect with the target for health checking | `string`  | `traffic-port`                 |
| **QA_Salary_health_check_interval**    | The approximate amount of time, in seconds, between health checks of an individual target | `number` | `30`          |
| **QA_Salary_health_check_timeout**     | The amount of time, in seconds, during which no response means a failed health check | `number` | `5`                          |
| **QA_Salary_health_check_healthy_threshold** | The number of consecutive health checks successes required before considering an unhealthy target healthy | `number` | `2`   |
| **QA_Salary_health_check_unhealthy_threshold** | The number of consecutive health check failures required before considering a target unhealthy | `number` | `2` |
| **QA_Salary_listener_arn**             | ARN of the existing listener where the rule will be added | `string`  | `arn:aws:elasticloadbalancing:us-east-2:975050171850:listener/app/alb/385bb840baa3fc3b/4eebd240281403eb` |
| **QA_Salary_path_pattern**             | Path pattern for the listener rule                       | `string`  | `*`                            |
| **QA_Salary_action_type**              | Path pattern for the listener rule                        | `string` | `forward`                     |
| **QA_Salary_priority**                 | priority                                                  | `number` | `100`                         |
| **QA_Salary_autoscaling_group_name**   | The name of the Auto Scaling Group                        | `string` | `QA_Salary_Salary_ASG`            |
| **QA_Salary_min_size**                 | The minimum number of instances in the ASG               | `number` | `1`                           |
| **QA_Salary_max_size**                 | The maximum number of instances in the ASG               | `number` | `2`                           |
| **QA_Salary_desired_capacity**         | The desired number of instances in the ASG               | `number` | `1`                           |
| **QA_Salary_subnet_ids**               | The list of subnet IDs where the instances will be launched | `list(string)` | See default values |
| **QA_Salary_tag_key**                  | The key for the tag to be applied to the ASG and instances | `string` | `Name`                        |
| **QA_Salary_tag_value**                | The value for the tag to be applied to the ASG and instances | `string` | `QA_Salary_Salary_ASG`            |
| **QA_Salary_propagate_at_launch**      | Whether the tag should be propagated to instances launched by the ASG | `bool` | `true`                     |
| **QA_Salary_scaling_policy_name**      | The name of the scaling policy                           | `string` | `target-tracking-policy`      |
| **QA_Salary_policy_type**              | The type of adjustment to make                           | `string` | `TargetTrackingScaling`       |
| **QA_Salary_predefined_metric_type**   | The predefined metric type for tracking                  | `string` | `ASGAverageCPUUtilization`    |
| **QA_Salary_target_value**             | The target value for the predefined metric               | `number` | `50.0`                        |

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

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056746/6585d6d2-f370-4fab-803f-9de2c40eb37f)


***

## Console Output

### Security Group

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056746/8dc468bd-ffc8-47a3-a4cd-84396673547a)


***
### Launch Template

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056746/fa8f3353-8504-4c89-87de-863a78eaf6e4)


***

### Target Group

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056746/4fdfbded-b1e6-41ff-8029-1b009c0541f6)


***
### Listener rule of ALB

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056746/c356930b-1eeb-4c8d-ae03-d5d126b69fb1)


***
### Auto Scaling Group

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056746/5c353380-438d-4682-b251-91175aeaeec2)


***
### Auto Scaling Group Policies

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056746/67574b24-0f59-4a9c-a76c-fad8c8ffc9c6)

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
 | **Shikha Tripathi** | shikha.tripathi.snaatak@mygurukulam.co |

 ***
 
## References

 | **Source** | **Description** |
 | ---------- | --------------- |
 | [**Link**](https://medium.com/@brandon.wagner/a-wrapper-for-terraform-61a125b27ffc) | Terraform Wrapper Code Concept. |
 | [**Link**](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GenericDoc/Terraform/terraform.md) | Terraform Generic Doc Link. |
 | [**Link**](https://QAeloper.hashicorp.com/terraform/language/modules) | Terraform Modules |
 | [**Link**](https://github.com/CodeOps-Hub/Documentation/blob/main/Terraform/Design/Module/Auto-scaling.md) | ASG-Module |
 | [**Link**](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Design/09-%20Cloud%20Infra%20Design/Cloud-Infra-Design-QA.md) | Cloud Infra Design QA |

 
