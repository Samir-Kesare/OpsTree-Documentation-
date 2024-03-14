# Generic Doc for VM Module (Standalone Server)

<img width="360" length="100" alt="Terraform" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/f95dfc00-7217-45b6-b770-c0f2af907cec">

***

| **Author** | **Created on** | **Last Updated** | **Document Version** |
| ---------- | -------------- | ---------------- | -------------------- |
| **Shreya Jaiswal** | **14 March 2024** | **14 March 2024** | **v1** |

***

# Table of contents
* [Introduction](#Introduction)
* [Why Terraform Module](#Why-Terraform-Module)
* [Flow Diagram](#Flow-Diagram)
* [Pre-requisites](#Pre-requisites)
* [Directory Structure](#Directory-Structure)
* [Configuration Files](#Configuration-Files)
* [Output](#Output)
* [Best Practices](#Best-Practices)
* [Conclusion](#Conclusion)
* [Contact Information](#Contact-Information)
* [References](#References)

***

# Introduction

<img width="400" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/643d0c30-6c1e-4088-bba3-5b1c91be9253">

A Terraform module is a container for organizing and reusing Terraform code to manage related resources. It encapsulates a set of resources and configurations into a single unit that can be easily shared, reused, and versioned. Modules promote code reusability, maintainability, and scalability in Terraform projects.

***

# Why Terraform Module

| Benefit           | Description                                                                                                      |
| ----------------  | ---------------------------------------------------------------------------------------------------------------- |
| **Reusability**   | Define reusable components for different Terraform configurations or projects.                                   |
| **Abstraction**   | Abstract the complexity of infrastructure components, making them easier to manage and understand.               |
| **Consistency**   | Enforce consistency by providing a standardized way to create and manage resources, reducing configuration drift.|
| **Collaboration** | Enable collaboration by allowing teams to share infrastructure components as reusable building blocks.           |
| **Versioning**    | Version modules to track changes and ensure consistent deployments across environments.                          |

***

# Flow Diagram

<img width="950" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/9b5ae612-95d9-4cf4-9612-d9874fcfd843">

***

# Pre-requisites

| **Pre-requisite** | **Description** |
| ----------------- | --------------- |
| **AWS Account**   | Access to the AWS Management Console with credentials configured. |
| **Hashicrop Terraform** | Terraform **(v1.7.4)** for configuration of AWS resources. |

***

# Directory Structure

<img width="500" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/25103345-c972-4fc0-ade1-7d470c9db529">

***

# Configuration Files

### main.tf file

**The `main.tf` file contains the configuration for creating various AWS resources such as security groups, key pair and EC2 Instance.**

<details>
<summary> Click here to see main.tf file</summary>
<br>
  
```shell

# Security Group #
locals {
  inbound_ports         = var.inbound_ports
  outbound_ports        = var.outbound_ports
}
resource "aws_security_group" "sec_grp" {
  name                  = var.sec_grp_name
  description           = var.Sec_grp_description
  vpc_id                = var.vpc_id

  dynamic "ingress" {
  for_each              = local.inbound_ports
  content {
   from_port            = ingress.value.port
   to_port              = ingress.value.port
   protocol             = ingress.value.protocol
   cidr_blocks          = [ingress.value.cidr_blocks]
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
  tags                  = var.Sec_grp_tags
}

/*------------Genrate-Key--------------*/
resource "tls_private_key" "rsa_4096" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

/*----------pem Key----------------------*/
resource "aws_key_pair" "key_pair" {
  key_name   = var.key_name
  public_key = tls_private_key.rsa_4096.public_key_openssh
}

/*----------Download Pem Key-------------------*/
resource "local_file" "private_key" {
  content  = tls_private_key.rsa_4096.private_key_pem
  filename = var.key_name
}

/*-----------Server-------------------*/

resource "aws_instance" "standalone_server" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.server_type
  key_name                    = aws_key_pair.key_pair.key_name
  subnet_id                   = var.subnet_id
  associate_public_ip_address = false
  vpc_security_group_ids      = [aws_security_group.sec_grp.id]
  tags = {
    Name = var.server_name
    Type = "dev"
  }

}
```
</details>

***

### variables.tf file

**The `variables.tf` file defines input variables used in the `main.tf` file to parameterize the configuration. These variables include vpc, subnet, security group, private key and instance related configurations .**

<details>
<summary> Click here to see variables.tf file</summary>
<br>
  
```shell
variable "sec_grp_name" {
  description     = "Name for the security group"
  type            = string
  default         = "dev_sg"
}
variable "Sec_grp_description" {
  description     = "Description for the security group"
  type            = string
  default         = "Security group for Dev Env"
}
variable "vpc_id" {
  description     = "ID of the VPC for instances"
  type            = string
}

variable "inbound_ports" {
  description     = "List of inbound ports, protocols and cidr block"
  type            = list(map(any))
  default         = [
    { port = 22, protocol = "tcp",cidr_blocks = "20.0.0.0/28" }, 
  ]
}

variable "outbound_ports" {
  description     = "List of outbound ports, protocols and Cidr block "
  type            = list(map(any))
  default         = [
    { port = 0, protocol = "-1", cidr_blocks = "0.0.0.0/0", },
  ]
}
variable "Sec_grp_tags" {
  type            = map(string)
  default         = {
    Name          = "dev-sg"
    Enviroment    = "dev"
    Owner         = "shreya"
  }
}

variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
}

variable "server_type" {
  description = "Instance type for Standalone server"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet for the Standalone server"
  type        = string
}

variable "server_name" {
  description = "Name tag for the standalone server"
  type        = string
}

```
</details>

***

### output.tf file

**The `output.tf` file specifies the outputs of the Terraform configuration. It includes the IDs of Securioty Group and EC2 Instance.**

<details>
<summary> Click here to see output.tf file</summary>
<br>

```shell
output "Security_Group_ID" {
  value = [aws_security_group.sec_grp.id]
}
output "server_id" {
  value = [aws_instance.standalone_server.id]
}

```
</details>

***

### data.tf file

<details>
<summary> Click here to see data.tf file</summary>
<br>

```shell
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

```
</details>


# Output

## Terminal Output

<img width="900" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/1c3b58fa-2136-4ad6-92de-24790585fbc2">

***

## Console Output

### Security Group

<img width="900" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/60879fc6-f6c5-4794-8147-0476470d4a03">

***

### Private Key

<img width="900" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/cd56aa74-2a0f-4fd1-a2e4-848805eb627b">

***

### EC2 Instance

<img width="900" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/0e1d3c60-eada-4a04-92a6-bb4fff18b064">

***

# Best Practices

| Practice              | Description                                                                                                        |
|-----------------------|------------------------------------------------------------------------------------------------------------------- |
| **Atomicity**         | Keep modules small and focused on a single concern or resource type to promote reusability and maintainability.    |
| **Input Validation**  | Validate input variables to ensure they meet expected requirements and constraints.                                |
| **Documentation**     | Provide clear documentation, including usage examples, input variables, and outputs.                               |
| **Testing**           | Implement automated tests to validate functionality and prevent regressions.                                       |
| **Versioning**        | Follow semantic versioning to manage changes and dependencies effectively.                                         |
| **Error Handling**    | Implement error handling and logging mechanisms for troubleshooting.                                               |
| **Idempotency**       | Ensure modules are idempotent, allowing multiple applications without unintended changes.                          |
| **State Management**  | Avoid storing sensitive information in Terraform state files and leverage remote state management for better security.|
| **Separation of Concerns**| Separate infrastructure concerns into reusable modules based on functionality or lifecycle.                       |

***

# Conclusion

Terraform modules are a fundamental building block for creating reusable and maintainable infrastructure as code. By following best practices and principles such as modularity, abstraction, and versioning, teams can leverage modules to efficiently manage complex infrastructure deployments at scale.The VM module, housed within the network directory, defines resources for provisioning virtual machines. It includes configurations for specifying the Amazon Machine Image (AMI), instance type, key pair, subnet, and security groups. This modular approach enhances code organization and facilitates easier management of virtual machine deployments within the larger infrastructure setup.

***

# Contact Information

| **Name** | **Email Address** |
| -------- | ----------------- |
| **Shreya Jaiswal** | shreya.jaiswal.snaatak@mygurukulam.co |

***

# References

| **Source** | **Description** |
| ---------- | --------------- |
| [Link](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GenericDoc/Terraform/terraform.md) | Terraform Generic Doc Link. |
| [Link](https://developer.hashicorp.com/terraform/language/modules) | Terraform Module Concept. |
| [Link](https://medium.com/@selvamraju007/terraform-modules-explanation-726ba4a0b98e) | Reference Link For Terraform Modules. |
