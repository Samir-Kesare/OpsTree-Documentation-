# Terraform Infra Divergence Management POC

<p align="center">
  <img src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/072662dd-f2ef-4010-b2e8-385fe9b393b7" height="200" width="380">
</p>

***

| **Author** | **Created On** | **Last Updated** | **Document version** |
| ---------- | -------------- | ---------------- | -------------------- |
| **Vishal Kumar Kesharwani** | **02 April 2024** | **03 April 2024** | **v1** |

***

## Table of Contents

* [Introduction](#Introduction)
* [What is Drift?](#What-is-Drift)
* [Flow Diagram](#Flow-Diagram)
* [Run Time Dependency](#Run-Time-Dependency)
* [Proof of Concept](#Proof-of-Concept)
* [Conclusion](#Conclusion) 
* [Contact Information](#Contact-Information) 
* [References](#References)

 ***

 ## Introduction

A Proof of Concept (POC) for drift detection is like a test drive for a drift detection tool. It's a small experiment where we create a simplified version of our cloud setup and intentionally make some changes to see if the tool can catch them. We use tools like Terraform plan to compare what we want our setup to be with what it actually is. This helps us decide if the drift detection tool works well enough to use it everywhere in our cloud system.

***

## What is Drift?

Drift occurs when the actual state of the infrastructure diverges from what’s defined in the Terraform configurations. This divergence can occur due to manual changes, external processes, or resource modifications. Since the possible implications of drift are potentially catastrophic, drift detection in IaC collaboration tools such as Digger is sometimes a hard compliance requirement for companies.

For More Information [**Click here**](https://github.com/CodeOps-Hub/Documentation/blob/main/Terraform/Infra_Divergence_Management/Introduction.md)
***
## Flow Diagram

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056413/feff3544-67e4-4c94-a5d2-8c4aa125d1b7)

***

## Run Time Dependency

* Configured Infra via Terraform.
* **v1.txt File** -  Once applied `terraform apply` command, then when we run the `terraform plan` again, it's output will be there in this `v1.txt` File.
   
***
## Proof of Concept

* **Step-1**

  Pushed all the configuration files in a repository in github.

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
```
</details>

<details>
<summary><strong>Click here to see Variable.tf file</strong></summary>
<br>

```shell
#---------------------------------Security Group ----------------------------------#

variable "security_name" {
  description     = "Name tag for the security group"
  type            = string
  default         = "Dev-Frontend-sg"
}
variable "Security_description" {
  description     = "Description for the security group"
  type            = string
  default         = "Security group for Dev-Frontend-API"
}
variable "SG_vpc_id" {
  description     = "ID of the VPC for instances"
  type            = string
  default         = "vpc-0383f4dc3af051efa"   # Dev-VPC ID
}
variable "inbound_ports" {
  description     = "List of inbound ports and protocols and cidr block"
  type            = list(map(any))
  default         = [
    { port = 22, protocol = "tcp",cidr_blocks = "20.0.0.0/28" }, # Management VPC Cidr Block
    { port = 22, protocol = "tcp", security_group_ids = "sg-0f470a22a92136557" },    # OpenVPN-SG
    { port = 3000, protocol = "tcp", security_group_ids = "sg-0b426399b2b19b0ae" }, #  Dev-Frontend-lb-sg ID  
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
    Name          = "Dev-Frontend-sg"
    Enviroment    = "dev"
    Owner         = "Vishal"
  }
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
```
</details>

<details>
<summary><strong>Click here to see Output.tf file</strong></summary>
<br>

```shell

#---------------------------------Security Group ----------------------------------#

output "Security_Group_ID" {
  value = [aws_security_group.security_group.id]
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#

```
</details>

<details>
<summary><strong>Click here to see terraform.tfvars file</strong></summary>
<br>

```shell

#---------------------------------Security Group ----------------------------------#

security_name                 = "Test-sg"
Security_description          = "Security group for Dev-Frontend-API"
SG_vpc_id                     = "vpc-0a5873d6063e0cc06"

inbound_ports                 = [
    { port = 22, protocol = "tcp",cidr_blocks = "0.0.0.0/0" }, 
    { port = 22, protocol = "tcp", security_group_ids = "sg-0004a4ea2f847d247" },    
  ]

outbound_ports                = [
    { port = 0, protocol = "-1", cidr_blocks = "0.0.0.0/0", },
  ]

Sg_tags                       = {
    Name          = "Test-sg"
    Owner         = "Vishal"
  }   

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
```
</details>
<details>
<summary><strong>Click here to see Provider.tf file</strong></summary>
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
<details>
<summary><strong>Click here to see backend.tf file</strong></summary>
<br>

```shell
terraform {

  backend "s3" {

    bucket         = "terraform-bucket-8303"

    key            = "Dirft/terraform.tfstate"

    region         = "us-east-2"

    dynamodb_table = "terraform-dynamodb"

    encrypt        = true

  }

}
```
</details>

<details>
<summary><strong>Click here to see v1.txt file</strong></summary>
<br>

```shell
Acquiring state lock. This may take a few moments...
[0m[1maws_security_group.security_group: Refreshing state... [id=sg-002365dfd136bce90][0m

[0m[1m[32mNo changes.[0m[1m Your infrastructure matches the configuration.[0m

[0mTerraform has compared your real infrastructure against your configuration
and found no differences, so no changes are needed.
Releasing state lock. This may take a few moments...
```
</details>

<details>
<summary><strong>Click here to see drift.sh file</strong></summary>
<br>

```shell
#!/bin/bash

# Define the paths to the two text files
file1="./v1.txt"
file2="./v2.txt"

# Create v2 file for compare v1 file
cd ./ && terraform init
terraform plan > v2.txt


# Check if both files exist
if [ ! -f "$file1" ]; then
  echo "Error: $file1 not found."
  exit 1
fi

if [ ! -f "$file2" ]; then
  echo "Error: $file2 not found."
  exit 1
fi

# Perform the comparison using the 'diff' command
if diff "$file1" "$file2" >/dev/null; then
  echo "No Manual Changes."
else
  echo "Something has been changed manually so I am running  reapply in the console according to the state file."
  cd ./ && terraform apply -auto-approve
fi

```
</details>
 
***

* **Step-2**

  - Setup the jenkins Environment

  * Create a Pipeline and configure `Build periodically` method, I have configured this as, the pipeline will run every hours, you can change it as per your requirement.

    <img src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/0474d322-1ac2-412e-9580-aa45db93a9d4" height="500" width="380">
      

*** 
## Conclusion


***

 ## Contact Information

 | **Name** | **Email Address** |
 | -------- | ----------------- |
 | **Vishal Kumar Kesharwani** | vishal.kumar.kesharwani.snaatak@mygurukulam.co |

 ***
 
## References

| **Source** | **Description** |
| ---------- | --------------- |
| [**Link**](https://github.com/CodeOps-Hub/Documentation/blob/main/Terraform/Infra_Divergence_Management/Introduction.md) | Introduction of Drift |
