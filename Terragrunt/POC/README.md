# Proof of Concept (POC) of Terragrunt

<img src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/ab3f6879-1856-4581-9791-5caaa0d52d87" width="700">


|   Authors        |  Created on   |  Version   | Last updated by | Last edited on |
| -----------------| --------------| -----------|---------------- | -------------- |
| Vidhi Yadav      | 13 March 2024   |     v1     | Vidhi Yadav     | 13 March 2024    |


## Table of Contents
+ [Introduction](#Introduction)
+ [Flow Diagram](#flow-diagram-of-poc)
+ [Pre-Requisites](#pre-requisites)
+ [Proof of Concept](#Proof-of-concept-(POC)-setup)
+ [Conclusion](#conclusion)
+ [Contact Information](#contact-information)
+ [References](#references)

***
## Introduction 

Terragrunt serves as a powerful complement to Terraform, enhancing its capabilities and simplifying infrastructure management. By leveraging Terragrunt alongside Terraform, users can achieve greater modularity, flexibility, and consistency in their infrastructure configurations.

For a comprehensive explanation and a thorough exploration of Terragrunt, kindly refer to the following [link](https://github.com/CodeOps-Hub/Documentation/blob/main/Terragrunt/Documentation/README.md#best-practices).

***
## Flow Diagram of POC

<img width="1535" alt="Screenshot 2024-03-13 at 9 12 34 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/0b29d791-3e94-42ab-aeba-8e01594788f9">

***
## Pre-requisites
|   Tool        |  Description   |
| -----------------| --------------|
| Terraform     | Terragrunt is a thin wrapper around Terraform, so you'll need to have Terraform installed on your system. |   

***
## Proof of Concept (PoC) setup

### 1. Setup Terragrunt

* Visit terragrunt [website](https://terragrunt.gruntwork.io/docs/getting-started/install/) and follow the instructions provided on the website for your operating system.

### 2. Terraform Configuration

* When working with Terragrunt, it's important to follow a consistent directory structure to ensure smooth execution and management of your infrastructure code.


 <img width="440" alt="Screenshot 2024-03-13 at 9 47 46 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/3ecd0b67-f134-4f6d-9d8b-e9c8c0525265">


* Your terraform configuration initially should look like this

<details>
<summary> <b> Click here for main.tf </b> </summary>
<br>
  
```shell
resource "aws_security_group" "terragrunt_sg" {
  name        = var.security_group_name
  description = var.description
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.inbound_rules
    content {
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = ingress.value.protocol
      cidr_blocks      = [ingress.value.source]
      
    }
  }

  dynamic "egress" {
    for_each = var.outbound_rules
    content {
      from_port       = egress.value.port
      to_port         = egress.value.port
      protocol        = egress.value.protocol
      cidr_blocks     = [egress.value.source]
    }
  }
  tags = var.sg_tags
}
```
</details>

* Configure variables based on your preference

<details>
<summary> <b> Click here for variable.tf </b> </summary>
<br>
  
```shell
variable "security_group_name" {
  description = "security group name"
  type            = string
  default         = "terragrunt-sg"
}

variable "description" {
  description = "security group for Attendance API"
  type            = string
  default         = "Security group for practice"
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type = string
  default = "vpc-0d744158f7f47f419"
}
variable "inbound_rules" {
  description = "List of inbound rules for the security group"
  type = list(map(any))
  default = [
    {
      port     = 22
      source   = "0.0.0.0/0"   //open for all
      protocol = "tcp"  
    },
    {
      port     = 8080
      source   = "0.0.0.0/0" 
      protocol = "tcp"  
    }
  ]
}

variable "outbound_rules" {
  description = "List of outbound rules for the security group"
  type = list(object({
    port     = number
    source   = string
    protocol = string
  }))
  default = [
    {
      port     = 0 // allow all ports 
      source   = "0.0.0.0/0"
      protocol = "-1"  // all protocols
    }
  ]
}

variable "sg_tags" {
  description = "Tag for Attedance sg"
  type        = map(string)
  default     = {
    Name = "terragrunt-sg"
    Environment = "Dev"
    Owner         = "Vidhi"
  }
}
```

</details>

<details>
<summary> <b> Click here for provider.tf </b> </summary>
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

<details>
<summary> <b> Click here for backend.tf </b> </summary>
<br>
  
```shell
terraform {
  backend "s3" {
    bucket  = "bucket-terragrunt-001"
    key     = "dev/terraform.tfstate"
    region  = "us-east-1" 
    encrypt = true
  }
}

```
</details>

### 3. Create terragrunt.hcl files

* To simplify and streamline your Terraform configurations, you can leverage Terragrunt by creating terragrunt.hcl files. These files serve as a central location for defining common configurations, reducing the overall complexity of your infrastructure codebase.

<img width="465" alt="Screenshot 2024-03-13 at 9 50 46 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/3d467cad-b013-484e-ad87-75e231b27232">

* To create a common configuration for `backend.tf` and `provider.tf` , you need to create a global terragrunt.hcl file that can be used in both the environnments (dev and prod). This would create our backend and provider automatically in both the environment saving us time and manual efforts. 

Global **terragrunt.hcl** 

```shell
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF
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
EOF
}

generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  backend "s3" {
    bucket  = "bucket-terragrunt-001"
    key     = "${path_relative_to_include()}/terraform.tfstate"   // path change based on the folder
    region  = "us-east-1" 
    encrypt = true
  }
}
EOF
}
```

* Now that we have created the global terragrunt.hcl file, the next step is to ensure that both the dev and prod environments utilize this shared configuration. To achieve this, we need to create separate terragrunt.hcl files within each of these environments. These files will serve the sole purpose of including the global Terragrunt configuration from their respective folders.

**terragrunt.hcl** in environment folders 

```shell
include "root"{
    path = find_in_parent_folders()
}
```

### 4. Execute changes using terragrunt

* Recheck your Terragrunt configuration and initialize your Terraform setup using the `terragrunt init` command. Afterwards, proceed with planning and applying the changes using `terragrunt plan` and `terragrunt apply` commands, respectively. These steps ensure that your infrastructure configuration is properly set up and any changes are carefully planned and applied using Terragrunt.


***
## Conclusion

In conclusion, This POC (Proof of Concept) demonstrates how Terragrunt streamlines Terraform configurations, reducing complexity and duplicacy by consolidating common settings into a single shared terragrunt.hcl file. It has provided valuable insights into the capabilities and benefits of integrating Terragrunt into our infrastructure management workflows. Throughout the POC, we have successfully demonstrated how Terragrunt simplifies the management of Terraform configurations, promotes code reuse, and enhances the consistency and reliability of our infrastructure deployments. 


***
## Contact Information

|Vidhi Yadav                     | vidhi.yadhav.snaatak@mygurukulam.co                                                                                      
|---------------------------------|------------------------------------------------------------|

***
## References

| Title                                      | URL                                           |
|--------------------------------------------|-----------------------------------------------|
| Official Terraform documentation          | [link](https://terragrunt.gruntwork.io/docs/#getting-started)    |
| Terragrunt documentation                  | [link](https://github.com/CodeOps-Hub/Documentation/blob/main/Terragrunt/Documentation/README.md#best-practices) |




