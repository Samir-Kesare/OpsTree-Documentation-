# Autoscaling Terraform Module Doc

<img width="360" length="100" alt="Terraform" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/7bebcb9c-e68b-4251-9974-9752be51b3b3">


***

| **Author** | **Created On** | **Last Updated** | **Document version** |
| ---------- | -------------- | ---------------- | -------------------- |
| **Vishal Kumar Kesharwani** | **12 March 2024** | **12 March 2024** | **v1** |

***

## Table of Contents

* [Introduction](#Introduction)
* [Terraform Modules](#Terraform-Modules)
* [What is State file](#What-is-State-file)
* [Pre-requisites](#Pre-requisites)
* [Flow Diagram](#Flow-Diagram)
* [Directory Structure](#Directory-Structure)
* [Configuration Files](#Configuration-Files)
* [Tags](#Tags)
* [Inputs](#Inputs)
* [Outputs](#Outputs)
* [Terminal Output](#Terminal-Output)
* [Console Output](#Console-Output)
* [Conclusion](#Conclusion) 
* [Contact Information](#Contact-Information) 
* [References](#References)

 ***

 ## Introduction

With the increasing complexity of modern networks and the need for agility in infrastructure management, Terraform has emerged as a powerful tool for automating the provisioning and configuration of network resources.This module is designed to provide a foundational framework for managing network infrastructure as code using Terraform. By leveraging this module, users can quickly establish a standardized and scalable network architecture within their cloud environment.

***

## Terraform Modules

<img width="360" length="100" alt="Terraform" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/4bd29a49-2c4f-47f2-aeb0-45707bf552bc">

Terraform modules serve as fundamental building blocks within the Terraform infrastructure as code (IaC) framework, enabling users to encapsulate and reuse configuration logic across different projects and environments. Essentially, a Terraform module is a collection of resources and associated configuration files that define a specific piece of infrastructure, such as a virtual machine, network, or application. By organizing infrastructure components into modular units, users can achieve greater abstraction, maintainability, and scalability in their infrastructure provisioning workflows.Additionally, Terraform modules support parameterization, allowing users to customize module behavior through input variables and outputs, further enhancing flexibility and adaptability.

***

## What is State file?

<img width="360" length="100" alt="Terraform" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/40ac0ac5-1a6a-4221-b2a8-f97467608f01">

The state file is an artifact that you’re left with once an Infrastructure as Code framework finishes a deployment. It is the “single source of truth” about what was deployed, where it was deployed, and all the configuration needed to deploy it. 

***

## Pre-requisites

| **Pre-requisite** | **Description** |
| ----------------- | --------------- |
| **AWS Account**   | Access to the AWS Management Console with credentials configured. |
| **Hashicrop Terraform** | Terraform **(v1.7.4)** for configuration of AWS resources. |

***

## Flow Diagram

![image](https://github.com/CodeOps-Hub/Documentation/assets/156057205/9b5ae612-95d9-4cf4-9612-d9874fcfd843)

***

## Directory Structure

<img width="242" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/13a20fce-0900-4467-ab59-a24772f89a56">

***

## Configuration Files

### main.tf

The `main.tf` file contains the configuration for creating various AWS resources such as Security Group,Launch Template,Target Group,Configure Listener rule of ALB,Configure Auto Scaling group,Auto Scaling Policies.

<details>
<summary><strong>Click here to see main.tf file</strong></summary>
<br>

```shell
#---------------------------------Security Group ----------------------------------#

locals {
  inbound_ports         = var.inbound_ports
  outbound_ports        = var.outbound_ports
}
resource "aws_security_group" "security_group" {
  name                  = var.security_name
  description           = var.Security_description
  vpc_id                = var.SG_vpc_id

  dynamic "ingress" {
  for_each              = local.inbound_ports
  content {
   from_port            = ingress.value.port
   to_port              = ingress.value.port
   protocol             = ingress.value.protocol
   # Conditionally apply CIDR block or security group rule based on type
   cidr_blocks      = contains(keys(ingress.value), "cidr_blocks") ? [ingress.value.cidr_blocks] : null
   security_groups  = contains(keys(ingress.value), "security_group_ids") ? [ingress.value.security_group_ids] : null
  }
 }
 dynamic "egress" {
  for_each              = local.outbound_ports
  content {
   from_port            = egress.value.port
   to_port              = egress.value.port
   protocol             = egress.value.protocol
   cidr_blocks          = [egress.value.cidr_blocks]
  }
 }
  tags                  = var.Sg_tags
}
#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------Launch Template ----------------------------------#

# Generate Private Key
resource "tls_private_key" "private_key" {
  algorithm = var.private_key_algorithm
  rsa_bits  = var.private_key_rsa_bits
}

# Generate SSH Key Pair
resource "aws_key_pair" "key_pair" {
  key_name   = var.instance_keypair
  public_key = tls_private_key.private_key.public_key_openssh
}

# Download Private Key in PEM Format
resource "local_file" "private_key" {
  content  = tls_private_key.private_key.private_key_pem
  filename = "${var.instance_keypair}.pem"
}

resource "aws_launch_template" "Template" {
  name                      = var.template_name
  description               = var.template_description
  image_id                  = var.AMI_ID        
  instance_type             = var.instance_type
  key_name                  = aws_key_pair.key_pair.key_name
  network_interfaces {
    security_groups         = [aws_security_group.security_group.id]
    subnet_id               = var.subnet_ID 
  }
  # user_data = base64encode(templatefile(var.user_data_script_path, { varibale_name = Value (Fatch in Resources) })) if you need any variable pass in User data
  user_data                 = filebase64(var.user_data_script_path)
  tags                      = {  
    Name                  = var.template_name
  }
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------- Target Group -----------------------------------#

resource "aws_lb_target_group" "Target_group" {
  name        = var.target_group_name
  port        = var.target_group_port
  protocol    = var.target_group_protocol
  vpc_id      = var.TG_vpc_id

  health_check {
    path                = var.health_check_path
    protocol            = var.target_group_protocol
    port                = var.health_check_port
    interval            = var.health_check_interval
    timeout             = var.health_check_timeout
    healthy_threshold   = var.health_check_healthy_threshold
    unhealthy_threshold = var.health_check_unhealthy_threshold
  }

  tags = {
    Name = var.target_group_name
  }
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#------------------------------- Listener rule of ALB -----------------------------#

resource "aws_lb_listener_rule" "path_rule" {
  listener_arn = var.listener_arn
  priority     = var.priority
  
  action {
    type             = var.action_type
    target_group_arn = aws_lb_target_group.Target_group.arn
  }
  
  condition {
    path_pattern {
      values = [var.path_pattern]
    }
  }
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------Configure Auto Scaling group ---------------------------#

resource "aws_autoscaling_group" "ASG" {
  name                  = var.autoscaling_group_name
  launch_template {
    id                  = aws_launch_template.Template.id
    version             = var.ASG_version    
  }
  min_size              = var.min_size
  max_size              = var.max_size
  desired_capacity      = var.desired_capacity
  vpc_zone_identifier   = var.subnet_ids
  target_group_arns     = [
    aws_lb_target_group.Target_group.arn
  ]
  tag {
    key                 = var.tag_key
    value               = var.tag_value
    propagate_at_launch = var.propagate_at_launch
  }
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#---------------------------- Auto Scaling Policies -------------------------------#

resource "aws_autoscaling_policy" "ASG_Policy" {
  name                        = var.scaling_policy_name
  autoscaling_group_name      = aws_autoscaling_group.ASG.name
  policy_type                 = var.policy_type

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = var.predefined_metric_type
    }

    target_value = var.target_value

  }
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#

```
</details>

***
### variables.tf

The `variables.tf` file defines input variables used in the `main.tf` file to parameterize the configuration. These variables include Security Group,Launch Template,Target Group,Configure Listener rule of ALB,Configure Auto Scaling group,Auto Scaling Policies.

<details>
<summary><strong>Click here to see variables.tf file</strong></summary>
<br>

```shell
#---------------------------------Security Group ----------------------------------#

variable "security_name" {
  description     = "Name tag for the security group"
  type            = string
  default         = "Security-Group"
}
variable "Security_description" {
  description     = "Description for the security group"
  type            = string
  default         = "Security group for Dev-Frontend-API"
}
variable "SG_vpc_id" {
  description     = "ID of the VPC for instances"
  type            = string
  default         = "vpc-0383f4dc3af051efa"   
}
variable "inbound_ports" {
  description     = "List of inbound ports and protocols and cidr block & Security_group_ids"
  type            = list(map(any))
  default         = [
    { port = 22, protocol = "tcp",cidr_blocks = "20.0.0.0/28" }, 
    { port = 22, protocol = "tcp", security_group_ids = "sg-0f470a22a92136557" },   
    { port = 3000, protocol = "tcp", security_group_ids = "sg-0b426399b2b19b0ae" },  
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
    Name          = "Security-Group"
    Enviroment    = "Env"
    Owner         = "Owner"
  }
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------Launch Template ----------------------------------#

# Key Generate

variable "private_key_algorithm" {
  description = "value"
  type = string
  default = "RSA"
}
variable "private_key_rsa_bits" {
  description = "value"
  type = number
  default = 4096
}

# Launch Template 

variable "template_name" {
  description     = "Launch Template Name"
  type            = string
  default         = "Template"  
}
variable "template_description" {
  description     = "Launch Template Description"
  type            = string
  default         = "Template for XXXX"  
}
variable "AMI_ID" {
  description     = "Instance AMI ID"
  type            = string
  default         = "ami-0c335502f397b30c6"
}
variable "instance_type" {
  description     = "Launch Template Instance Type"
  type            = string
  default         = "t2.micro"  
}
variable "instance_keypair" {
  description     = "Launch Template Instance Type keypair name"
  type            = string
  default         = "MasterKey"  
}
variable "subnet_ID" {
  description     = "Launch Template Subnet ID"
  type            = string
  default         = "subnet-04c0c823118f48202"  
}
variable "user_data_script_path" {
  description = "Path to the user data script file"
  type        = string
  default     = "./script.sh"
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------- Target Group -----------------------------------#

variable "target_group_name" {
  description     = "Name of the target group"
  type            = string
  default         = "Target-Group"
}
variable "target_group_port" {
  description     = "Port for the target group"
  type            = number 
  default         = 80
}
variable "target_group_protocol" {
  description     = "Protocol for the target group"
  type            = string
  default         = "HTTP"
}
variable "TG_vpc_id" {
  description     = "ID of the VPC"
  type            = string
  default         = "vpc-0383f4dc3af051efa"    
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
  default           = "/"   # Give your Path 
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
  default         = "ASG"
}
variable "ASG_version" {
  description     = "select Version"
  type            = string
  default         = "$Latest"
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
  default         = [ "subnet-04c0c823118f48202" ]
}

variable "tag_key" {
  description     = "The key for the tag to be applied to the ASG and instances"
  type            = string
  default         = "Name"
}

variable "tag_value" {
  description     = "The value for the tag to be applied to the ASG and instances"
  type            = string
  default         = "ASG"
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

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#

```
</details>

***

### output.tf

The `output.tf` file specifies the outputs of the Terraform configuration. It includes the IDs of various resources created such as Security_Group_ID,key_pair_name,launch_template_id,Target_group_id,Autoscaling_group_id,Autoscaling_policy_name.

<details>
<summary><strong>Click here to see variables.tf file</strong></summary>
<br>

```shell
#---------------------------------Security Group ----------------------------------#

output "Security_Group_ID" {
  value = [aws_security_group.security_group.id]
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------Launch Template ----------------------------------#

# Priavte Key
output "key_pair_name" {
  description = "key name"
  value       = [aws_key_pair.key_pair.key_name]
}

# Template
output "launch_template_id" {
  value = [aws_launch_template.Template.id]
}
#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------- Target Group -----------------------------------#

output "Target_group_id" {
  value = [aws_lb_target_group.Target_group.id]
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------Configure Auto Scaling group ---------------------------#

output "Autoscaling_group_id" {
  value = [aws_autoscaling_group.ASG.id]
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#---------------------------- Auto Scaling Policies -------------------------------#

output "Autoscaling_policy_name" {
  value       = [aws_autoscaling_policy.ASG_Policy.name]
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#

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
| **security_name**                | Name tag for the security group                          | `string`      | `Security-Group`               |
| **Security_description**         | Description for the security group                       | `string`      | `Security group for Dev-Frontend-API` |
| **SG_vpc_id**                    | ID of the VPC for instances                              | `string`      | `vpc-0383f4dc3af051efa`        |
| **inbound_ports**                | List of inbound ports and protocols and cidr block & Security_group_ids | `list(map(any))` | See below |
| **outbound_ports**               | List of outbound ports and protocols and Cidr block      | `list(map(any))` | See below |
| **Sg_tags**                      | Tags for Security Group                                  | `map(string)` | See below |
| **private_key_algorithm**        | Algorithm to use for generating the private key          | `string`      | `RSA`                          |
| **private_key_rsa_bits**         | Number of bits for the RSA private key                   | `number`      | `4096`                         |
| **template_name**                | Launch Template Name                                     | `string`      | `Template`                     |
| **template_description**         | Launch Template Description                              | `string`      | `Template for XXXX`            |
| **AMI_ID**                       | Instance AMI ID                                          | `string`      | `ami-0c335502f397b30c6`       |
| **instance_type**                | Launch Template Instance Type                            | `string`      | `t2.micro`                     |
| **instance_keypair**             | Launch Template Instance Type keypair name               | `string`      | `MasterKey`                    |
| **subnet_ID**                    | Launch Template Subnet ID                                | `string`      | `subnet-04c0c823118f48202`     |
| **user_data_script_path**        | Path to the user data script file                        | `string`      | `./script.sh`                  |
| **target_group_name**            | Name of the target group                                 | `string`      | `Target-Group`                 |
| **target_group_port**            | Port for the target group                                | `number`      | `80`                           |
| **target_group_protocol**        | Protocol for the target group                            | `string`      | `HTTP`                         |
| **TG_vpc_id**                    | ID of the VPC                                            | `string`      | `vpc-0383f4dc3af051efa`        |
| **health_check_path**            | The destination for the health check request             | `string`      | `/health`                      |
| **health_check_port**            | The port to use to connect with the target for health checking | `string` | `traffic-port`                 |
| **health_check_interval**        | The approximate amount of time between health checks of an individual target | `number` | `30`                          |
| **health_check_timeout**         | The amount of time during which no response means a failed health check | `number` | `5`                           |
| **health_check_healthy_threshold** | The number of consecutive health check successes required before considering an unhealthy target healthy | `number` | `2`                    |
| **health_check_unhealthy_threshold** | The number of consecutive health check failures required before considering a target unhealthy | `number` | `2`                     |
| **listener_arn**                 | ARN of the existing listener where the rule will be added | `string`  | `arn:aws:elasticloadbalancing:ap-northeast-1:133673781875:listener/app/Dev-ALB/75bc9b1a35dbe964/761653fb399a30be` |
| **path_pattern**                 | Path pattern for the listener rule                        | `string`      | `/`                            |
| **action_type**                  | Path pattern for the listener rule                        | `string`      | `forward`                      |
| **priority**                     | Priority                                                 | `number`      | `100`                          |
| **autoscaling_group_name**       | The name of the Auto Scaling Group                       | `string`      | `ASG`                          |
| **ASG_version**                  | Select Version                                           | `string`      | `$Latest`                      |
| **min_size**                     | The minimum number of instances in the ASG               | `number`      | `1`                            |
| **max_size**                     | The maximum number of instances in the ASG               | `number`      | `2`                            |
| **desired_capacity**             | The desired number of instances in the ASG               | `number`      | `1`                            |
| **subnet_ids**                   | The list of subnet IDs where the instances will be launched | `list(string)` | `["subnet-04c0c823118f48202"]` |
| **tag_key**                      | The key for the tag to be applied to the ASG and instances | `string`   | `Name`                         |
| **tag_value**                    | The value for the tag to be applied to the ASG and instances | `string` | `ASG`                          |
| **propagate_at_launch**          | Whether the tag should be propagated to instances launched by the ASG | `bool` | `true`                      |
| **scaling_policy_name**          | The name of the scaling policy                           | `string`      | `target-tracking-policy`       |
| **policy_type**                  | The type of adjustment to make                           | `string`      | `TargetTrackingScaling`        |
| **predefined_metric_type**       | The predefined metric type for tracking                  | `string`      | `ASGAverageCPUUtilization`     |
| **target_value**                 | The target value for the predefined metric               | `number`      | `50.0`                         |

***

# Outputs 

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

<img width="500" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/7b5aa214-14c0-4834-9e41-753225a2bebe">

***

## Console Output

### Launch Template

<img width="700" alt="image" src=""> 

***

### Target Group

<img width="700" alt="image" src="">

***
### Auto Scaling Group

<img width="700" alt="image" src="">

***

## Conclusion

In conclusion, the design module documentation serves as a valuable resource for understanding the architecture, configuration, and deployment considerations of an auto-scalable system, empowering stakeholders to design, implement, and maintain resilient, scalable, and cost-effective cloud infrastructures.

***
 ## Contact Information

 | **Name** | **Email Address** |
 | -------- | ----------------- |
 | **Vishal Kumar Kesharwani** | vishal.kumar.kesharwani.snaatak@mygurukulam.co |

 ***
 
## References

 | **Source** | **Description** |
 | ---------- | --------------- |
 | [**Link**](https://developer.hashicorp.com/terraform/intro) | Official Doc Link For Terraform |
 | [**Link**](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GenericDoc/Terraform/terraform.md) | Terraform Generic Doc Link. |
 | [**Link**](https://developer.hashicorp.com/terraform/language/modules) | Terraform Modules |

 
