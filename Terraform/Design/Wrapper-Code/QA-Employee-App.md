# Wrapper Code for Employee App for QA Environment

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056364/591094eb-77ec-495b-9866-11e57fd0fd85)
***
| Author | Created On | Last Updated | Document Version | Last Updated By |
| ------ | ---------- | ------------ | ---------------- | --------------- |
| Shantanu | 14-03-2024 | 17-01-2024   |         v1     |     Shantanu    |
***

# Introduction
This document provides a step-by-step guide for setting up wrapper code for the Employee API, incorporating child modules.
Depending on the value specified in the root module or wrapper code, we can dynamically manage and construct the infrastructure setup.
This process includes handling various Terraform state files to manage different environments effectively.
***

# Need for Terraform Wrapper Code
| **Feature**                | **Description**                    |
|------------------------|---------------------------------------------------------------------------------------------------------------------|
| **Automation**      | Automates repetitive tasks like initialization, applying changes, and destroying resources, saving time and effort.|
| **Enhanced Functionality** | Extends Terraform's capabilities by integrating with other tools, implementing custom logic, or enforcing specific workflows.|
| **Standardization**        | Enforces standardized practices across Terraform projects, ensuring consistency and reducing the risk of errors.|
| **Integration**            | Facilitates integration with CI/CD pipelines, version control systems, and infrastructure management platforms for seamless deployment. |
***

# Pre-Requisites
| **Pre-Requisite** | **Description** |
| ----------------- | --------------- |
| **AWS Account**   | Access to the AWS Management Console with credentials configured. |
| **Hashicrop Terraform** | Terraform **(v1.7.4)** for configuration of AWS resources. |
***

# Flow Diagram

<img src="https://devopscube.com/wp-content/uploads/2023/08/alb-asg-workflow.gif" width="700">


***

# Directory Structure
![image](https://github.com/CodeOps-Hub/Documentation/assets/156056364/9308025a-2c08-44da-b08e-a7c465e1635f)

***

# Configuration File
This Terraform configuration file establishes infrastructure elements within an AWS environment.
These elements encompass Security Groups, Launch Templates, Target Groups, Configuration Rules for ALB Listeners, 
Auto Scaling Groups, Auto Scaling Policies, and various input variables for customization, each defined in separate 
files. Outputs are designated to display the IDs of the generated resources, aiding in their referencing within other 
configurations. Provider and Terraform configuration files guarantee the accurate version of the provider and AWS region 
settings. The terraform.tfvars file sets default values for variables while accommodating customization options as required.

### main.tf

<details>
<summary><strong>Click here</strong></summary>
<br>

```shell

module "QA_Employee" {
source                              ="git@github.com:CodeOps-Hub/Terraform-modules.git//Modules/Auto_Sacling_Module?ref=main"

#----------------------------------Security Group -----------------------------------#
security_name                       = var.QA_Employee_security_name
Security_description                = var.QA_Employee_security_description
SG_vpc_id                           = var.QA_Employee_SG_vpc_id
inbound_ports                       = var.QA_Employee_inbound_ports
outbound_ports                      = var.QA_Employee_outbound_ports
Sg_tags                             = var.QA_Employee_Sg_tags

#--------------------------------Launch Template ----------------------------------#
private_key_algorithm               = var.QA_Employee_private_key_algorithm
private_key_rsa_bits                = var.QA_Employee_private_key_rsa_bits
template_name                       = var.QA_Employee_template_name
template_description                = var.QA_Employee_template_description
AMI_ID                              = var.QA_Employee_AMI_ID
instance_type                       = var.QA_Employee_instance_type
instance_keypair                    = var.QA_Employee_instance_keypair
subnet_ID                           = var.QA_Employee_subnet_ID
user_data_script_path               = var.QA_Employee_user_data_script_path

#---------------------------------- Target Group -----------------------------------#
target_group_name                   = var.QA_Employee_target_group_name
target_group_port                   = var.QA_Employee_target_group_port
target_group_protocol               = var.QA_Employee_target_group_protocol
TG_vpc_id                           = var.QA_Employee_TG_vpc_id
health_check_path                   = var.QA_Employee_health_check_path
health_check_port                   = var.QA_Employee_health_check_port
health_check_interval               = var.QA_Employee_health_check_interval
health_check_timeout                = var.QA_Employee_health_check_timeout
health_check_healthy_threshold      = var.QA_Employee_health_check_healthy_threshold
health_check_unhealthy_threshold    = var.QA_Employee_health_check_unhealthy_threshold

#-------------------------------- Listener rule of ALB ------------------------------#
listener_arn                         = var.QA_Employee_listener_arn
path_pattern                         = var.QA_Employee_path_pattern
action_type                          = var.QA_Employee_action_type
priority                             = var.QA_Employee_priority

#---------------------------Configure Auto Scaling group ----------------------------#
autoscaling_group_name              = var.QA_Employee_autoscaling_group_name
ASG_version                         = var.QA_Employee_ASG_vserion
subnet_ids                          = var.QA_Employee_subnet_ids
tag_key                             = var.QA_Employee_tag_key
tag_value                           = var.QA_Employee_tag_value
propagate_at_launch                 = var.QA_Employee_propagate_at_launch
min_size                            = var.QA_Employee_min_size
max_size                            = var.QA_Employee_max_size
desired_capacity                    = var.QA_Employee_desired_capacity

#----------------------------- Auto Scaling Policies --------------------------------#
scaling_policy_name                 = var.QA_Employee_scaling_policy_name
policy_type                         = var.QA_Employee_policy_type
predefined_metric_type              = var.QA_Employee_predefined_metric_type
target_value                        = var.QA_Employee_target_value
}

```
</details>

***

### variables.tf

<details>
<summary><strong>Click here</strong></summary>
<br>

```shell
#----------------------------------Security Group -----------------------------------#

variable "QA_Employee_security_name" {
  description     = "Name tag for the security group"
  type            = string
  default         = "QA-Employee-sg"
}
variable "QA_Employee_security_description" {
  description     = "Description for the security group"
  type            = string
  default         = "Security group for QA-Employee-API"
}
variable "QA_Employee_SG_vpc_id" {
  description     = "ID of the VPC for instances"
  type            = string
  default         = "vpc-037273df63a16de65"   # QA_Employee-VPC ID
}
variable "QA_Employee_inbound_ports" {
  description     = "List of inbound ports and protocols and cidr block"
  type            = list(map(any))
  default         = [
    { port = 22, protocol = "tcp",cidr_blocks = "20.0.0.0/28" }, # Management VPC Cidr Block
    { port = 22, protocol = "tcp", security_group_ids = "sg-04b7eb5f6320a1aa6" },    # OpenVPN-SG
    { port = 8080, protocol = "tcp", security_group_ids = "sg-04b7eb5f6320a1aa6" }, #  QA-Employee-lb-sg ID 
  ]
}
variable "QA_Employee_outbound_ports" {
  description     = "List of outbound ports and protocols and Cidr block "
  type            = list(map(any))
  default         = [
    { port = 0, protocol = "-1", cidr_blocks = "0.0.0.0/0", },
  ]
}
variable "QA_Employee_Sg_tags" {
  description     = "Tags for Security Group"
  type            = map(string)
  default         = {
    Name          = "QA-Employee-sg"
    Enviroment    = "QA_Employee"
    Owner         = "Shantanu"
  }
}

#---------------------------------Launch Template -----------------------------------#

# Key Generate

variable "QA_Employee_private_key_algorithm" {
  description     = "private_key_algorithm"
  type            = string
  default         = "RSA"
}
variable "QA_Employee_private_key_rsa_bits" {
  description     = "private_key_rsa_bits"
  type            = number
  default         = 4096
}

variable "QA_Employee_template_name" {
  description     = "Launch Template Name"
  type            = string
  default         = "QA-Employee-template"  
}
variable "QA_Employee_template_description" {
  description     = "Launch Template Description"
  type            = string
  default         = "Template for QA-Employee"  
}
variable "QA_Employee_AMI_ID" {
  description     = "Instance AMI ID"
  type            = string
  default         = "ami-08e4b984abde34a4f" # QA-Employee Setup AMI ID
}
variable "QA_Employee_instance_type" {
  description     = "Launch Template Instance Type"
  type            = string
  default         = "t2.medium"  
}
variable "QA_Employee_instance_keypair" {
  description     = "Launch Template Instance Type keypair name"
  type            = string
  default         = "QA_Employee_Key"  
}
variable "QA_Employee_subnet_ID" {
  description     = "Launch Template Subnet ID"
  type            = string
  default         = "subnet-0abcfc7a31b6687b4"  
}
variable "QA_Employee_user_data_script_path" {
  description = "Path to the user data script file"
  type        = string
  default     = "./script.sh"  # Path QA-Employee User data Script
}

#---------------------------------- Target Group ------------------------------------#

variable "QA_Employee_target_group_name" {
  description     = "Name of the target group"
  type            = string
  default         = "QA-Employee-TG"
}
variable "QA_Employee_target_group_port" {
  description     = "Port for the target group"
  type            = number 
  default         = 8080
}
variable "QA_Employee_target_group_protocol" {
  description     = "Protocol for the target group"
  type            = string
  default         = "HTTP"
}
variable "QA_Employee_TG_vpc_id" {
  description     = "ID of the VPC"
  type            = string
  default         = "vpc-037273df63a16de65"    #  QA_Employee-VPC ID 
}
variable "QA_Employee_health_check_path" {
  description     = "The destination for the health check request"
  type            = string
  default         = "/health"
}
variable "QA_Employee_health_check_port" {
  description     = "The port to use to connect with the target for health checking"
  type            = string
  default         = "traffic-port"
}
variable "QA_Employee_health_check_interval" {
  description     = "The approximate amount of time, in seconds, between health checks of an individual target"
  type            = number
  default         = 30
}
variable "QA_Employee_health_check_timeout" {
  description     = "The amount of time, in seconds, during which no response means a failed health check"
  type            = number
  default         = 5
}
variable "QA_Employee_health_check_healthy_threshold" {
  description     = "The number of consecutive health checks successes required before considering an unhealthy target healthy"
  type            = number
  default         = 2
}
variable "QA_Employee_health_check_unhealthy_threshold" {
  description     = "The number of consecutive health check failures required before considering a target unhealthy"
  type            = number
  default         = 2
}

#-------------------------------- Listener rule of ALB ------------------------------#

variable "QA_Employee_listener_arn" {
  description       = "ARN of the existing listener where the rule will be added"
  type              = string
  default           = "arn:aws:elasticloadbalancing:ap-northeast-1:133673781875:listener/app/QA-ALB/75bc9b1a35dbe964/761653fb399a30be"
}
variable "QA_Employee_path_pattern" {
  description       = "Path pattern for the listener rule"
  type              = string
  default           = "*"   # Give your Path 
}
variable "QA_Employee_action_type" {
  description       = "Path pattern for the listener rule"
  type              = string
  default           = "forward"
}
variable "QA_Employee_priority" {
  description       = "priority"
  type              = number
  default           = 100 
}

#---------------------------Configure Auto Scaling group ----------------------------#

variable "QA_Employee_autoscaling_group_name" {
  description     = "The name of the Auto Scaling Group"
  type            = string
  default         = "QA-Employee_ASG"
}
variable "QA_Employee_ASG_vserion" {
  description     = "Give the Version"
  type            = string
  default         = "$Latest"
}

variable "QA_Employee_min_size" {
  description     = "The minimum number of instances in the ASG"
  type            = number
  default         = 1
}

variable "QA_Employee_max_size" {
  description     = "The maximum number of instances in the ASG"
  type            = number
  default         = 2
}

variable "QA_Employee_desired_capacity" {
  description     = "The desired number of instances in the ASG"
  type            = number
  default         = 1
}

variable "QA_Employee_subnet_ids" {
  description     = "The list of subnet IDs where the instances will be launched"
  type            = list(string)
  default         = [ "subnet-0abcfc7a31b6687b4" ]    #Employee-Pvt-Subnet ID
}

variable "QA_Employee_tag_key" {
  description     = "The key for the tag to be applied to the ASG and instances"
  type            = string
  default         = "Name"
}

variable "QA_Employee_tag_value" {
  description     = "The value for the tag to be applied to the ASG and instances"
  type            = string
  default         = "QA-Employee_ASG"
}

variable "QA_Employee_propagate_at_launch" {
  description     = "Whether the tag should be propagated to instances launched by the ASG"
  type            = bool
  default         = true
}

#----------------------------- Auto Scaling Policies --------------------------------#

variable "QA_Employee_scaling_policy_name" {
  description     = "The name of the scaling policy"
  type            = string
  default         = "target-tracking-policy"
}
variable "QA_Employee_policy_type" {
  description     = "The type of adjustment to make"
  type            = string
  default         = "TargetTrackingScaling"
}
variable "QA_Employee_predefined_metric_type" {
  description     = "The predefined metric type for tracking"
  type            = string
  default         = "ASGAverageCPUUtilization"
}
variable "QA_Employee_target_value" {
  description     = "The target value for the predefined metric"
  type            = number
  default         = 50.0
}
```
</details>

***

### terraform.tfvars

<details>
<summary><strong>Click here</strong></summary>
<br>

```shell
#----------------------------------Security Group -----------------------------------#

QA_Employee_security_name                       = "QA-Employee-sg"
QA_Employee_security_description                = "Security group for QA-Employee-API"
QA_Employee_SG_vpc_id                           = "vpc-037273df63a16de65"    #QA_Employee-VPC-ID
QA_Employee_inbound_ports                       = [
  { port                                = 22, protocol = "tcp", cidr_blocks = "20.0.0.0/28" },                     # Management VPC Cidr Block
  { port                                = 22, protocol = "tcp", security_group_ids = "sg-04b7eb5f6320a1aa6" },     #  QA-Employee-lb-sg ID
  { port                                = 8080, protocol = "tcp", security_group_ids = "sg-04b7eb5f6320a1aa6" },   # OpenVPN-SG
]
QA_Employee_outbound_ports                      = [
  { port                                = 0, protocol = "-1", cidr_blocks = "0.0.0.0/0" }
]
QA_Employee_Sg_tags                             = {
  Name                                  = "QA-Employee-sg"
  Enviroment                            = "QA_Employee"
  Owner                                 = "Employee"
}

#---------------------------------Launch Template -----------------------------------#

QA_Employee_private_key_algorithm               = "RSA"
QA_Employee_private_key_rsa_bits                = 4096
QA_Employee_template_name                       = "QA-Employee-template"
QA_Employee_template_description                = "Template for QA-Employee"
QA_Employee_AMI_ID                              = "ami-08e4b984abde34a4f"
QA_Employee_instance_type                       = "t2.medium"
QA_Employee_instance_keypair                    = "QA_Employee_Key"
QA_Employee_subnet_ID                           = "subnet-0abcfc7a31b6687b4"
QA_Employee_user_data_script_path               = "./script.sh"

#---------------------------------- Target Group ------------------------------------#

QA_Employee_target_group_name                   = "QA-Employee-TG"
QA_Employee_target_group_port                   = 8080
QA_Employee_target_group_protocol               = "HTTP"
QA_Employee_TG_vpc_id                           = "vpc-037273df63a16de65"   #QA_Employee-VPC-ID
QA_Employee_health_check_path                   = "/health"
QA_Employee_health_check_port                   = "traffic-port"
QA_Employee_health_check_interval               = 30
QA_Employee_health_check_timeout                = 5
QA_Employee_health_check_healthy_threshold      = 2
QA_Employee_health_check_unhealthy_threshold    = 2

#-------------------------------- Listener rule of ALB ------------------------------#

QA_Employee_listener_arn                          = "arn:aws:elasticloadbalancing:ap-southeast-1:441247711986:listener/app/QA-Employee/c13ae07d35f81b0c/1af6e0a2492db2a9"
QA_Employee_path_pattern                          = "/api/v1/employee/*"
QA_Employee_action_type                           = "forward"
QA_Employee_priority                              = 100

#---------------------------Configure Auto Scaling group ----------------------------#

QA_Employee_autoscaling_group_name              = "QA-Employee_ASG"
QA_Employee_ASG_vserion                         = "$Latest"
QA_Employee_min_size                            = 1
QA_Employee_max_size                            = 2
QA_Employee_desired_capacity                    = 1
QA_Employee_subnet_ids                          = ["subnet-0abcfc7a31b6687b4"]   #QA-Employee Pvt ID
QA_Employee_tag_key                             = "Name"
QA_Employee_tag_value                           = "QA-Employee_ASG"
QA_Employee_propagate_at_launch                 = true

#----------------------------- Auto Scaling Policies --------------------------------#

QA_Employee_scaling_policy_name                 = "target-tracking-policy"
QA_Employee_policy_type                         = "TargetTrackingScaling"
QA_Employee_predefined_metric_type              = "ASGAverageCPUUtilization"
QA_Employee_target_value                        = 50.0
```
</details>

***

### output.tf

<details>
<summary><strong>Click here</strong></summary>
<br>

```shell
#----------------------------------Security Group -----------------------------------#

output "Security_Group_ID" {
  value = [module.QA_Employee.Security_Group_ID]
}

#---------------------------------Launch Template -----------------------------------#

# Priavte Key
output "key_pair_name" {
  value       = [module.QA_Employee.key_pair_name]
}

# Template
output "launch_template_id" {
  value = [module.QA_Employee.launch_template_id]
}
#---------------------------------- Target Group ------------------------------------#

output "Target_group_id" {
  value = [module.QA_Employee.Target_group_id]
}

#---------------------------Configure Auto Scaling group ----------------------------#

output "Autoscaling_group_id" {
  value = [module.QA_Employee.Autoscaling_group_id]
}

#----------------------------- Auto Scaling Policies --------------------------------#

output "Autoscaling_policy_name" {
  value       = [module.QA_Employee.Autoscaling_policy_name]
}

```
</details>

***

### provider.tf

<details>
<summary><strong>Click here</strong></summary>
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
  region = "ap-southeast-1"  
} 
```
</details>

***

### script.sh

<details>
<summary><strong>Click here</strong></summary>
<br>

```shell
#!/bin/bash
cd employee-api/
make build
go test $(go list ./... | grep -v docs | grep -v model | grep -v main.go) -coverprofile cover.out
go tool cover -html=cover.out
make run-migrations
./employee-api
```
</details>

***

# Tags

* Tags are assigned to resources with name variable as prefix.
* Additial tags can be assigned by tags variables as defined above.

***

# Inputs

| Name                                   | Description                                              | Type            | Default                        |
| -------------------------------------- | -------------------------------------------------------- | --------------- | ------------------------------ |
| **QA_Employee_security_name**           | Name tag for the security group                          | `string`        | `QA-Employee-sg`               |
| **QA_Employee_security_description**    | Description for the security group                       | `string`        | `Security group for QA-Employee-API` |
| **QA_Employee_SG_vpc_id**               | ID of the VPC for instances                              | `string`        | `vpc-037273df63a16de65`       |
| **QA_Employee_inbound_ports**           | List of inbound ports and protocols and cidr block       | `list(map(any))` | See default values |
| **QA_Employee_outbound_ports**          | List of outbound ports and protocols and Cidr block      | `list(map(any))` | See default values |
| **QA_Employee_Sg_tags**                 | Tags for Security Group                                  | `map(string)`   | See default values |
| **QA_Employee_private_key_algorithm**   | private_key_algorithm                                    | `string`        | `RSA`                          |
| **QA_Employee_private_key_rsa_bits**    | private_key_rsa_bits                                     | `number`        | `4096`                         |
| **QA_Employee_template_name**           | Launch Template Name                                     | `string`        | `QA-Employee-template`        |
| **QA_Employee_template_description**    | Launch Template Description                              | `string`        | `Template for QA-Employee`    |
| **QA_Employee_AMI_ID**                  | Instance AMI ID                                          | `string`        | `ami-08e4b984abde34a4f`       |
| **QA_Employee_instance_type**           | Launch Template Instance Type                            | `string`        | `t2.medium`                     |
| **QA_Employee_instance_keypair**        | Launch Template Instance Type keypair name               | `string`        | `QA_Employee_Key`                      |
| **QA_Employee_subnet_ID**               | Launch Template Subnet ID                                | `string`        | `subnet-0abcfc7a31b6687b4`    |
| **QA_Employee_user_data_script_path**   | Path to the user data script file                        | `string`        | `./script.sh`                  |
| **QA_Employee_target_group_name**       | Name of the target group                                 | `string`        | `QA-Employee-TG`              |
| **QA_Employee_target_group_port**       | Port for the target group                                | `number`        | `8080`                         |
| **QA_Employee_target_group_protocol**   | Protocol for the target group                            | `string`        | `HTTP`                         |
| **QA_Employee_TG_vpc_id**               | ID of the VPC                                             | `string`        | `vpc-037273df63a16de65`       |
| **QA_Employee_health_check_path**       | The destination for the health check request             | `string`        | `/health`                      |
| **QA_Employee_health_check_port**       | The port to use to connect with the target for health checking | `string`    | `traffic-port`                 |
| **QA_Employee_health_check_interval**   | The approximate amount of time, in seconds, between health checks of an individual target | `number` | `30`          |
| **QA_Employee_health_check_timeout**    | The amount of time, in seconds, during which no response means a failed health check | `number` | `5`                          |
| **QA_Employee_health_check_healthy_threshold** | The number of consecutive health checks successes required before considering an unhealthy target healthy | `number` | `2`   |
| **QA_Employee_health_check_unhealthy_threshold** | The number of consecutive health check failures required before considering a target unhealthy | `number` | `2` |
| **QA_Employee_listener_arn**            | ARN of the existing listener where the rule will be added | `string`      | `arn:aws:elasticloadbalancing:ap-southeast-1:441247711986:listener/app/QA-Employee/c13ae07d35f81b0c/1af6e0a2492db2a9` |
| **QA_Employee_path_pattern**            | Path pattern for the listener rule                       | `string`      | `/api/v1/Employee/*`                            |
| **QA_Employee_action_type**             | Path pattern for the listener rule                        | `string`      | `forward`                     |
| **QA_Employee_priority**                | priority                                                  | `number`      | `100`                         |
| **QA_Employee_autoscaling_group_name** | The name of the Auto Scaling Group                     | `string`      | `QA_Employee_ASG`            |
| **QA_Employee_min_size**             | The minimum number of instances in the ASG               | `number`      | `1`                           |
| **QA_Employee_max_size**             | The maximum number of instances in the ASG               | `number`      | `2`                           |
| **QA_Employee_desired_capacity**     | The desired number of instances in the ASG               | `number`      | `1`                           |
| **QA_Employee_subnet_ids**           | The list of subnet IDs where the instances will be launched | `list(string)` | See default values |
| **QA_Employee_tag_key**              | The key for the tag to be applied to the ASG and instances | `string`      | `Name`                        |
| **QA_Employee_tag_value**            | The value for the tag to be applied to the ASG and instances | `string`      | `QA_Employee_ASG`            |
| **QA_Employee_propagate_at_launch**  | Whether the tag should be propagated to instances launched by the ASG | `bool`     | `true`                     |
| **QA_Employee_scaling_policy_name**  | The name of the scaling policy                           | `string`      | `target-tracking-policy`      |
| **QA_Employee_policy_type**          | The type of adjustment to make                           | `string`      | `TargetTrackingScaling`       |
| **QA_Employee_predefined_metric_type** | The predefined metric type for tracking                | `string`      | `ASGAverageCPUUtilization`    |
| **QA_Employee_target_value**         | The target value for the predefined metric               | `number`      | `50.0`                        |

***

# Output
| Name                 | Description                                       |
|----------------------|---------------------------------------------------|
| **Security_Group_ID**   | Output for the ID of the created security group   |
| **key_pair_name**       | Output for the key pair name                      |
| **launch_template_id**  | Output for the ID of the created launch template  |
| **Target_group_id**     | Output for the ID of the created target group     |
| **Autoscaling_group_id**| Output for the ID of the created auto-scaling group |
| **Autoscaling_policy_name** | Output for the name of the created auto-scaling policy |

***

# Terminal Output
![Screenshot 2024-03-17 at 11 51 18 PM](https://github.com/CodeOps-Hub/Documentation/assets/156056364/b86b2062-3e8c-47b4-8e09-67332349661b)

***

# Console Output

### Security Group
![Screenshot 2024-03-17 at 11 52 00 PM](https://github.com/CodeOps-Hub/Documentation/assets/156056364/00ae8692-7868-406d-92ee-40e1adff4473)

***

### Launch Template
![Screenshot 2024-03-17 at 11 52 42 PM](https://github.com/CodeOps-Hub/Documentation/assets/156056364/94b9c863-20b0-46b1-9f24-0134e0906109)

***

### Listener Rule of ALB
![Screenshot 2024-03-17 at 11 53 22 PM](https://github.com/CodeOps-Hub/Documentation/assets/156056364/186ba647-44bb-42ed-9ff5-46c25b441e00)

***

### ASG Policies
![Screenshot 2024-03-17 at 11 54 26 PM](https://github.com/CodeOps-Hub/Documentation/assets/156056364/0d9a544f-d77b-42bd-8023-e9f32b29a1e5)

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
Wrapper code for Terraform extends its capabilities by automating tasks, offering supplementary functionalities, and upholding best practices. 
Embracing principles like modularity, error handling, and comprehensive documentation, wrapper scripts streamline Terraform workflows, bolster productivity, 
and guarantee the dependability and security of infrastructure deployments.

***

# Contact Information

 | **Name** | **Email Address** |
 | -------- | ----------------- |
 | **Shantanu** | shantanu.chauhan.snaatak@mygurukulam.co |
 
***

 # References

 | **Source** | **Description** |
 | ---------- | --------------- |
 | [**Link**](https://medium.com/@brandon.wagner/a-wrapper-for-terraform-61a125b27ffc) | Terraform Wrapper Code Concept. |
 | [**Link**](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GenericDoc/Terraform/terraform.md) | Terraform Generic Doc Link. |
 | [**Link**](https://QAeloper.hashicorp.com/terraform/language/modules) | Terraform Modules |
 | [**Link**](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Design/09-%20Cloud%20Infra%20Design/Cloud-Infra-Design-QA.md) | Cloud Infra Design QA |
