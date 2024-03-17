#  Terraform Wrapper Code For PostgreSQL Server in QA Environment 

![image](https://github.com/CodeOps-Hub/Documentation/assets/79625874/105272d3-edc7-437a-931d-887b7741ae24)

|   Author     |  Created on   |  Version   | Last updated by | Last edited on |
| ------------ | --------------| -----------|---------------- |--------------- |
| Vikram BISHT | 17 March 2024 |     v1     | Vikram Bisht    | 17 March 2024  |


# Table of contents
* [Introduction](#Introduction)
* [Why Terraform Wrapper Code](#Why-Terraform-Wrapper-Code)
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

In this document it will guide through the steps to achieve the setup of wrapper code for PostgreSQL server which involves the configuration files. According to the value passed through the root module/wrapper code we can manage/build the infra structure setup accordingly. Which involves the managing of different terraform state files for managing respective environments.

***
# Why Terraform Wrapper Code

| Feature                | Description                    |
|------------------------|---------------------------------------------------------------------------------------------------------------------|
| **Automation**      | Automates repetitive tasks like initialization, applying changes, and destroying resources, saving time and effort.|
| **Enhanced Functionality** | Extends Terraform's capabilities by integrating with other tools, implementing custom logic, or enforcing specific workflows.|
| **Standardization**        | Enforces standardized practices across Terraform projects, ensuring consistency and reducing the risk of errors.|
| **Integration**            | Facilitates integration with CI/CD pipelines, version control systems, and infrastructure management platforms for seamless deployment. |

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

**Module**

<img width="400" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156056344/dd404ad4-9fc5-4fa5-a9ab-38f2ada7dea5">

**Wrapper Code**

<img width="400" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156056344/34c6ec17-de67-433f-9a8f-d04c5826f354">

***

# Configuration Files

### main.tf file

<details>
<summary> <b> Click here for main.tf file </b> </summary>
<br>
    
```shell
module "Postgres" {
    source                         = "git@github.com:CodeOps-Hub/Terraform-modules.git//Modules/VM-Module?ref=main"  
    vpc_id                         = var.vpc-id 
    subnet_id                      = var.subnet-id         
    sec_grp_name                   = var.sec-grp-name
    Sec_grp_description            = var.sec-grp-description
    inbound_ports                  = var.inbound-ports
    outbound_ports                 = var.outbound-ports
    Sec_grp_tags                   = var.sec-grp-tags
    key_name                       = var.key-name
    server_type                    = var.server-type
    server_name                    = var.server-name
}
```

</details>

***

### variables.tf file

<details>
<summary> <b> Click here for variables.tf file </b> </summary>
<br>

```shell
variable "sec-grp-name" {
  description     = "Name of the security group"
  type            = string
  default         = "Postgres-sg"
}
variable "sec-grp-description" {
  description     = "Description for the security group"
  type            = string
  default         = "Security group for Postgres in QA Env"
}
variable "vpc-id" {
  description     = "ID of the VPC for instances"
  type            = string
}

variable "inbound-ports" {
  description     = "List of inbound ports, protocols and cidr block"
  type            = list(map(any))
}

variable "outbound-ports" {
  description     = "List of outbound ports, protocols and CIDR block "
  type            = list(map(any))
  default         = [
    { port = 0, protocol = "-1", cidr_blocks = "0.0.0.0/0", },
  ]
}
variable "sec-grp-tags" {
  type            = map(string)
  default         = {
    Name          = "Postgres-sg"
    Enviroment    = "QA"
    Owner         = "Vikram"
  }
}

variable "key-name" {
  description = "Name of the SSH key pair"
  type        = string
}

variable "server-type" {
  description = "Instance type for Postgres server"
  type        = string
}

variable "subnet-id" {
  description = "Id of the subnet for the Postgres server"
  type        = string
}

variable "server-name" {
  description = "Name tag for the Postgres server"
  type        = string
}
```
</details>

***

### output.tf file

<details>
<summary> <b> Click here for output.tf file </b> </summary>
<br>

```shell
output "Security_Group_ID" {
  value = module.Postgres.Security_Group_ID
}
output "server_id" {
  value = module.Postgres.server_id
}

```
</details>

***

### provider.tf file

<details>
<summary> <b> Click here for provider.tf file </b> </summary>
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

### terraform.tfvars

<details>
<summary> Click here to see terraform.tfvars file</summary>
<br>
    
```shell
vpc-id              = "vpc-0a744f2efc4febb2a"
key-name            = "postgres.pem"
server-type         = "t2.medium"
subnet-id           = "subnet-0dc05fffbacb821e8"
sec-grp-name = "Postgresqll-sg"
sec-grp-tags = {
    Name          = "Postgresqll-sg"
    Enviroment    = "QA"
    Owner         = "Vikram"
}
server-name         = "Postgres-QA"
inbound-ports = [ {
  port = 22 , protocol = "tcp" , security_group_ids = "sg-0ced15d988acdb94b" 
},
{
 port = 5432 , protocol = "tcp" , security_group_ids = "sg-0a4ecb0570e13e365"
},
{
 port = 22 , protocol = "tcp" , cidr_blocks = "20.0.0.0/28"
} ]
```
</details>

***

# Output

## Terminal Output

![image](https://github.com/CodeOps-Hub/Documentation/assets/79625874/06cf5a26-e871-49e5-8673-391e78be9d37)

***

## Console Output

### Private Key (postgres.pem)

![image](https://github.com/CodeOps-Hub/Documentation/assets/79625874/175584b9-f67a-42bd-97fe-4fad1bec5a81)


**Key Download**

![image](https://github.com/CodeOps-Hub/Documentation/assets/79625874/8636807d-f83e-4720-86f7-3d0f2b64e4ae)




***

### Security Group (Postgresqll-sg)

![image](https://github.com/CodeOps-Hub/Documentation/assets/79625874/f2b37fa7-6af1-42bc-becc-8ec7ab1a4731)



***

### EC2 Instance (Postgres-QA)

![image](https://github.com/CodeOps-Hub/Documentation/assets/79625874/d1f0af50-5e2b-4dd6-9348-4cc18d689185)




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

Terraform wrapper code enhances the capabilities of Terraform by automating tasks, providing additional functionality, and enforcing best practices. By following best practices such as modularity, error handling, and documentation, wrapper scripts can streamline Terraform workflows, improve productivity, and ensure the reliability and security of infrastructure deployments. It helps improve security and makes it simpler to expand and maintain the VPN. With this wrapper, you can easily connect Postgres with your existing systems and automate tasks, making it faster to deploy and monitor your VPN across different setups.

***

# Contact Information

|  Name                     |        	Email Address           |
| ------------              | --------------------------------|
| Vikram Bisht              |  Vikram.Bisht@opstree.com       |  

***

# References

| **Source** | **Description** |
| ---------- | --------------- |
| [Link](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GenericDoc/Terraform/terraform.md) | Terraform Generic Doc Link. |
| [Link](https://medium.com/@brandon.wagner/a-wrapper-for-terraform-61a125b27ffc) | Terraform Wrapper Code Concept. |

