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
* [Usage](#Usage)
* [Tags](#Tags)
* [Inputs](#Inputs)
* [Outputs](#Outputs)
* [Result](#Result)
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

# Configuration Files

The `main.tf` file contains the configuration for creating various AWS resources such as Security Group,Launch Template,Target Group,Configure Listener rule of ALB,Configure Auto Scaling group,Auto Scaling Policies.

<details>
<summary> <a href="main.tf" style="color: red;"> <strong>Click here to see main.tf file</strong> </a> </summary>
<br>

```shell

Helo
defklf
tgtg
tg

```
</details>



***

# Tags
* Tags are assigned to resources with name variable as prefix.
* Additial tags can be assigned by tags variables as defined above.
  
***

# Inputs

| Name | Description | Type | Default | 
| ---- | ----------- | ---- | ------- | 
| **AMI_name**                      | Name of the Amazon Machine Image (AMI)                    | `string`       | `Dev-Fronted-AMI`                 |
| **AMI_Instance_ID**               | ID of the EC2 instance to use for the Launch Template     | `string`       | `i-0572a5faad61b261e`             |
| **private_key_algorithm**        | Algorithm to use for generating the private key           | `string`       | `RSA`                              |
| **private_key_rsa_bits**         | Number of bits for the RSA private key                    | `number`       | `4096`                               |
| **template_name**                | Name of the Launch Template                               | `string`       | `Dev-Frontend-template`          |
| **template_description**         | Description of the Launch Template                        | `string`       | `Template for Dev-Frontend`       |
| **instance_type**                | Instance type for the Launch Template                     | `string`       | `t2.micro`                       |
| **instance_keypair**             | Name of the key pair associated with the Launch Template | `string`       | `Dev_Key`                         |
| **security_group**               | Security group for the Launch Template                    | `string`       | `sg-0c6b3e33e9b94f694`            |
| **subnet_ID**                    | Subnet ID for the Launch Template                         | `string`       | `subnet-04c0c823118f48202`        |
| **target_group_name**            | Name of the target group                                  | `string`       | `Dev-Frontend-TG`            |
| **target_group_port**            | Port for the target group                                 | `number`       | `3000`                               |
| **target_group_protocol**        | Protocol for the target group                             | `string`       | `HTTP`                             |
| **TG_vpc_id**                    | VPC ID for the target group                               | `string`       | `vpc-0383f4dc3af051efa`           |
| **health_check_path**            | Destination for the health check request                  | `string`       | `/health`                         |
| **health_check_port**            | Port to use to connect with the target for health checking| `string`       | `traffic-port`                    |
| **health_check_interval**        | Approximate amount of time between health checks          | `number`       | `30`                                 |
| **health_check_timeout**         | Amount of time during which no response means a failed health check | `number` | `5`                            |
| **health_check_healthy_threshold** | Number of consecutive health checks successes required before considering an unhealthy target healthy | `number` | `2`     |
| **health_check_unhealthy_threshold** | Number of consecutive health check failures required before considering a target unhealthy | `number` | `2` |
| **autoscaling_group_name**       | Name of the Auto Scaling Group                            | `string`       | `Dev_Frontend_ASG`               |
| **min_size**                     | Minimum number of instances in the Auto Scaling Group     | `number`       | `1`                                  |
| **max_size**                     | Maximum number of instances in the Auto Scaling Group     | `number`       | `2`                                  |
| **desired_capacity**             | Desired number of instances in the Auto Scaling Group     | `number`       | `1`                                  |
| **subnet_ids**                   | List of subnet IDs where the instances will be launched   | `list(string)` | `["subnet-04c0c823118f48202"]`      |
| **tag_key**                      | Key for the tag to be applied to the Auto Scaling Group and instances | `string` | `Name`                         |
| **tag_value**                    | Value for the tag to be applied to the Auto Scaling Group and instances | `string` | `Dev_Frontend_ASG`               |
| **propagate_at_launch**          | Whether the tag should be propagated to instances launched by the Auto Scaling Group | `bool` | `true` |
***

# Outputs 

| Name | Description |
|------|-------------|
| **AMI_ID** | The ID of the Amazon Machine Image (AMI) used by the Auto Scaling Group |
| **key_pair_name** | The name of the key pair associated with the Auto Scaling Group instances |
| **launch_template_id** | The ID of the Launch Template used by the Auto Scaling Group |
| **Target_group_id** | The ID of the Target Group associated with the Auto Scaling Group |
| **Autoscaling_group_id** | The ID of the Auto Scaling Group |

***

# Result

<img width="500" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/bf7c2df5-04cb-43ef-8151-ab504a4d9214">

***
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

 
