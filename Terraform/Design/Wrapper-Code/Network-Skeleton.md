# Network Skeleton Terraform Wrapper Code Doc

<img width="360" length="100" alt="Terraform" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/f95dfc00-7217-45b6-b770-c0f2af907cec">

***

| **Author** | **Created on** | **Last Updated** | **Document Version** |
| ---------- | -------------- | ---------------- | -------------------- |
| **Shreya Jaiswal** | **13 March 2024** | **13 March 2024** | **v1** |

***

# Table of contents
* [Introduction](#Introduction)
* [Why Terraform Wrapper Code](#Why-Terraform-Wrapper-Code)
* [Flow Diagram](#Flow-Diagram)
* [Pre-requisites](#Pre-requisites)
* [Directory Structure](#Directory-Structure)
* [Configuration Files](#Configuration-Files)
* [Result](#Result)
* [Best Practices](#Best-Practices)
* [Conclusion](#Conclusion)
* [Contact Information](#Contact-Information)
* [References](#References)

***

# Introduction

In this document it will guide through the steps to achieve the setup of wrapper code for Network_Skeleton module which involves the child modules.According to the value passed through the root module/wrapper code we can manage/build the infra structure setup accordingly. Which involves the managing of different terraform state files for managing respective environments.

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

<img width="400" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/f3286afd-84d4-487c-b185-f6bc00787194">

***

# Configuration Files

**This Terraform configuration defines infrastructure components for an AWS environment, including VPC, subnets, internet gateway, NAT gateway, route tables, network ACLs, ALB, Route 53 zone, and records. It utilizes modularization with a main module for network setup and various input variables defined in separate files for customization. The output file specifies the IDs of created resources, facilitating reference in other configurations. Provider and Terraform configuration files ensure the correct provider version and AWS region settings. The terraform.tfvars file provides default values for variables, while allowing for customization as needed.**

### main.tf file

```shell
module "network" {
    source                         = "./networking"
    region                         = var.region
    vpc_cidr                       = var.vpc_cidr
    vpc_tags                       = var.vpc_tags
    vpc_enable_dns_support         = var.vpc_enable_dns_support
    vpc_enable_dns_hostnames       = var.vpc_enable_dns_hostnames
    public_subnets_cidr            = var.public_subnets_cidr
    public_subnets_az              = var.public_subnets_az
    enable_map_public_ip_on_launch = var.enable_map_public_ip_on_launch
    public_subnets_tags            = var.public_subnets_tags
    private_subnets_cidr           = var.private_subnets_cidr
    private_subnets_az             = var.private_subnets_az
    private_subnets_tags           = var.private_subnets_tags
    igw_tags                       = var.igw_tags
    nat_tags                       = var.nat_tags
    public_route_table_tags        = var.public_route_table_tags
    private_route_table_tags       = var.private_route_table_tags
    frontend_nacl_ingress          = var.frontend_nacl_ingress
    frontend_nacl_egress           = var.frontend_nacl_egress
    frontend_nacl_tags             = var.frontend_nacl_tags
    backend_nacl_ingress           = var.backend_nacl_ingress
    backend_nacl_egress            = var.backend_nacl_egress
    backend_nacl_tags              = var.backend_nacl_tags
    db_nacl_ingress                = var.db_nacl_ingress
    db_nacl_egress                 = var.db_nacl_egress
    db_nacl_tags                   = var.db_nacl_tags
    alb_sg_name                    = var.alb_sg_name
    alb_sg_description             = var.alb_sg_description
    alb_sg_inbound_rules           = var.alb_sg_inbound_rules
    alb_sg_outbound_rules          = var.alb_sg_outbound_rules
    alb_sg_tags                    = var.alb_tags
    alb_name                       = var.alb_name
    alb_internal                   = var.alb_internal
    alb_type                       = var.alb_type
    alb_deletion_protection        = var.alb_deletion_protection
    alb_tags                       = var.alb_tags
    route53_zone_tags              = var.route53_zone_tags
    route53_zone_name              = var.route53_zone_name
}    
```
***

### variables.tf file

```shell
variable "region" {
  type    = string
  default = "us-east-2"
}
/*---------------vpc variables---------------*/

variable "vpc_cidr" {
  type    = string
  default = "10.0.1.0/25"
}

variable "vpc_enable_dns_support" {
  type    = bool
  default = true
}

variable "vpc_enable_dns_hostnames" {
  type    = bool
  default = false
}

variable "vpc_tags" {
  type    = map(string)
  default = {
    Name = "dev-vpc"
    Enviroment = "dev"
    Owner = "shreya"
  }
}

/*--------------- Public Subnets ---------------*/

variable "public_subnets_cidr" {
  description = "public subnet cidr block"
  type        = list(string)
  default     = ["10.0.1.0/28", "10.0.1.64/28"]

}

variable "public_subnets_az" {
  description = "public subnet availability zones"
  type        = list(string)
  default     = ["us-east-2a", "us-east-2b"]
}
variable "enable_map_public_ip_on_launch" {
  type    = bool
  default = true
}

variable "public_subnets_tags" {
  description = "public subnet tags"
  type        = list(map(string))
  default = [{
    Name = "public-subnet-01"
    Enviroment = "dev"
    Owner = "shreya"
    }, {
    Name = "public-subnet-02"
    Enviroment = "dev"
    Owner = "shreya"
  }]
}

/*--------------- Private Subnets ---------------*/

variable "private_subnets_cidr" {
  description = "private subnet cidr block"
  type        = list(string)
  default     = ["10.0.1.16/28", "10.0.1.32/28", "10.0.1.48/28"]

}

variable "private_subnets_az" {
  description = "private subnet availability zones"
  type        = string
  default     = "us-east-2a"

}

variable "private_subnets_tags" {
  description = "private subnet tags"
  type        = list(map(string))
  default = [{
    Name = "frontend-subnet"
    Enviroment = "dev"
    Owner = "shreya"
    }, {
    Name = "backend-subnet"
    Enviroment = "dev"
    Owner = "shreya"
  }, {
    Name = "database-subnet"
    Enviroment = "dev"
    Owner = "shreya"
  }]
}

/*--------------- # Internet Gateway ---------------*/

variable "igw_tags" {
  type    = map(string)
  default = {
    Name = "dev-igw-01"
    Enviroment = "dev"
    Owner = "shreya"
  }
}

/*--------------- # NAT Gateway ---------------*/

variable "nat_tags" {
  type    = map(string)
  default = {
    Name = "dev-nat-01"
    Enviroment = "dev"
    Owner = "shreya"
  }
}

/*--------------- # Route Table ---------------*/

variable "public_route_table_tags" {
  type    = map(string)
  default = {
    Name = "dev-public-RTB-01"
    Enviroment = "dev"
    Owner = "shreya"
  }
}

variable "private_route_table_tags" {
  type    = map(string)
  default = {
    Name = "dev-private-RTB-01"
    Enviroment = "dev"
    Owner = "shreya"
  }
}

/*--------------- Frontend NACL ---------------*/

variable "frontend_nacl_ingress" {
  type    = list(object({
    rule_no = number
    protocol = string
    cidr_block = string
    from_port = number
    to_port = number
    action = string
  }))
}

variable "frontend_nacl_egress" {
  type    = list(object({
    rule_no = number
    protocol = string
    cidr_block = string
    from_port = number
    to_port = number
    action = string
  }))
}

variable "frontend_nacl_tags" {
  type    = map(string)
  default = {
    Name = "dev-frontend-nacl-01"
    Enviroment = "dev"
    Owner = "shreya"
  }
}

/*--------------- Backend NACL ---------------*/

variable "backend_nacl_ingress" {
  type    = list(object({
    rule_no = number
    protocol = string
    cidr_block = string
    from_port = number
    to_port = number
    action = string
  }))
}

variable "backend_nacl_egress" {
  type    = list(object({
    rule_no = number
    protocol = string
    cidr_block = string
    from_port = number
    to_port = number
    action = string
  }))
}

variable "backend_nacl_tags" {
  type    = map(string)
  default = {
    Name = "dev-backend-nacl-01"
    Enviroment = "dev"
    Owner = "shreya"
  }
}

/*--------------- Database NACL ---------------*/

variable "db_nacl_ingress" {
  type    = list(object({
    rule_no = number
    protocol = string
    cidr_block = string
    from_port = number
    to_port = number
    action = string
  }))
}

variable "db_nacl_egress" {
  type    = list(object({
    rule_no = number
    protocol = string
    cidr_block = string
    from_port = number
    to_port = number
    action = string
  }))
}

variable "db_nacl_tags" {
  type    = map(string)
  default = {
    Name = "dev-db-nacl-01"
    Enviroment = "dev"
    Owner = "shreya"
  }
}

/*--------------- ALB Security Group ---------------*/

variable "alb_sg_name" {
  description = "security group name"
  type            = string
  default         = "dev-alb-sg"
}

variable "alb_sg_description" {
  description = "security group for Attendance API"
  type            = string
  default         = "Security group for Dev-ALB"
}

variable "alb_sg_inbound_rules" {
  description = "List of inbound rules for the security group"
  type = list(object({
    port     = number
    source   = string
    protocol = string
  }))
  default = [{
      port     = 80
      source   = "0.0.0.0/0" 
      protocol = "tcp"  
    }, {
      port     = 443
      source   = "0.0.0.0/0" 
      protocol = "tcp"  
    }]
}

variable "alb_sg_outbound_rules" {
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

variable "alb_sg_tags" {
  description = "Tag for Attedance sg"
  type        = map(string)
  default     = {
    Environment = "dev"
    Owner       = "shreya"
  }
}

/*--------------- ALB ---------------*/
variable "alb_name" {
  type = string
  default = "dev-alb"
}
variable "alb_internal" {
  type = bool
  default = false 
}
variable "alb_type" {
  type = string
  default = "application"  
}
variable "alb_deletion_protection" {
  type = bool
  default = true
}
variable "alb_tags" {
  type    = map(string)
  default = {
    Enviroment = "dev"
    Owner = "shreya"
  }
}

/*--------------- Route 53 ---------------*/

variable "route53_zone_tags" {
  type    = map(string)
  default = {
    Enviroment = "dev"
    Owner = "shreya"
  }
}
variable "route53_zone_name" {
  type = string
  default = "example.com"
}
```
***

### output.tf file

```shell
output "vpc-id" {
  value = module.network.vpc-id
}

output "public-subnets-id" {
  value = module.network.public-subnets-id
}


output "private-subnets-id" {
  value = module.network.private-subnets-id
}

output "dev-igw-id" {
  value = module.network.dev-igw-id
}

output "dev-nat-id" {
  value = module.network.dev-nat-id
}

output "dev-public-RTB-id" {
  value = module.network.dev-public-RTB-id
}

output "dev-private-RTB-id" {
  value = module.network.dev-private-RTB-id
}

output "dev-frontend-nacl-id" {
  value = module.network.dev-frontend-nacl-id
}

output "dev-backend-nacl-id" {
  value = module.network.dev-backend-nacl-id
}

output "dev-db-nacl-id" {
  value = module.network.dev-db-nacl-id
}

output "alb-sg-id" {
  value = module.network.alb-sg-id  
}

output "dev-alb-dns" {
  value = module.network.dev-alb-dns
}

output "dev-route53-zone" {
  value = module.network.dev-route53-zone
}
output "dev-route53-record" {
  value = module.network.dev-route53-record
}
```
***

### provider.tf file

```shell
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.38.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region =  var.region
}
```
***

### terraform.tfvars

```shell
region = "us-east-2"
/*--------------- VPC ---------------*/
vpc_tags = {
    Name = "dev-vpc"
    Enviroment = "dev"
    Owner = "shreya"
}

/*--------------- Public Subnets ---------------*/
public_subnets_cidr = ["10.0.1.0/28", "10.0.1.64/28"]

public_subnets_az = ["us-east-2a", "us-east-2b"]

enable_map_public_ip_on_launch = true

public_subnets_tags  = [{
    Name = "public-subnet-01"
    Enviroment = "dev"
    Owner = "shreya"
    }, {
    Name = "public-subnet-02"
    Enviroment = "dev"
    Owner = "shreya"
  }]


/*--------------- Private Subnets ---------------*/

private_subnets_cidr = ["10.0.1.16/28", "10.0.1.32/28", "10.0.1.48/28"]

private_subnets_az = "us-east-2a"

private_subnets_tags = [{
    Name = "frontend-subnet"
    Enviroment = "dev"
    Owner = "shreya"
    }, {
    Name = "backend-subnet"
    Enviroment = "dev"
    Owner = "shreya"
  }, {
    Name = "database-subnet"
    Enviroment = "dev"
    Owner = "shreya"
  }]

/*--------------- IGW ---------------*/

igw_tags = {
    Name = "dev-igw-01"
    Enviroment = "dev"
    Owner = "shreya"
  }

/*--------------- NAT Gateway ---------------*/

nat_tags = {
    Name = "dev-nat-01"
    Enviroment = "dev"
    Owner = "shreya"
  }

/*--------------- # Route Table ---------------*/

public_route_table_tags = {
    Name = "dev-public-RTB-01"
    Enviroment = "dev"
    Owner = "shreya"
  }

private_route_table_tags  = {
    Name = "dev-private-RTB-01"
    Enviroment = "dev"
    Owner = "shreya"
  }

/*--------------- Frontend NACL ---------------*/

frontend_nacl_ingress = [{
    rule_no = 100
    protocol = "tcp"
    cidr_block = "20.0.0.0/28"	
    from_port = 22
    to_port = 22
    action = "allow"
    }, {
    rule_no = 110
    protocol = "tcp"
    cidr_block = "10.0.1.0/28"	
    from_port = 3000	
    to_port = 3000
    action = "allow"
    }, {
    rule_no = 120
    protocol = "tcp"
    cidr_block = "10.0.1.0/28"
    from_port = 22	
    to_port = 22
    action = "allow"
    }, {
    rule_no = 130
    protocol = "tcp"
    cidr_block = "10.0.1.64/28"	
    from_port = 3000
    to_port = 3000
    action = "allow"
    }]

frontend_nacl_egress = [{
    rule_no = 100
    protocol = "tcp"
    cidr_block = "20.0.0.0/28"	
    from_port = 1024 
    to_port = 65535
    action = "allow"
    }, {
    rule_no = 110
    protocol = "tcp"
    cidr_block = "10.0.1.0/28"	
    from_port = 1024
    to_port = 65535
    action = "allow"
    }, {
    rule_no = 120
    protocol = "tcp"
    cidr_block = "10.0.1.64/28"	
    from_port = 1024
    to_port =  65535
    action = "allow"
    }]

frontend_nacl_tags  = {
    Name = "dev-frontend-nacl-01"
    Enviroment = "dev"
    Owner = "shreya"
  }

/*--------------- Backend NACL ---------------*/

# ingress rules

backend_nacl_ingress = [{
    rule_no = 100
    protocol = "tcp"
    cidr_block = "20.0.0.0/28"	
    from_port = 22
    to_port = 22
    action = "allow"
    }, {
    rule_no = 110
    protocol = "tcp"
    cidr_block = "10.0.1.0/28"	
    from_port = 8080
    to_port = 8080
    action = "allow"
    }, {
    rule_no = 120
    protocol = "tcp"
    cidr_block = "10.0.1.48/28"
    from_port = 1024
    to_port = 65535
    action = "allow"
    }, {
    rule_no = 130
    protocol = "tcp"
    cidr_block = "10.0.1.64/28"	
    from_port = 1024
    to_port = 65535
    action = "allow"
    }, {
    rule_no = 140
    protocol = "tcp"
    cidr_block = "10.0.1.0/28"	
    from_port = 22
    to_port = 22
    action = "allow"
    }, {
    rule_no = 150
    protocol = "tcp"
    cidr_block = "10.0.1.0/28"	
    from_port = 1024
    to_port = 65535
    action = "allow"
    }, {
    rule_no = 160
    protocol = "tcp"
    cidr_block = "10.0.1.64/28"	
    from_port = 8080
    to_port = 8080
    action = "allow"
    }]

# egress rules

backend_nacl_egress = [{
    rule_no = 100
    protocol = "tcp"
    cidr_block = "20.0.0.0/28"	
    from_port = 22
    to_port = 22
    action = "allow"
    }, {
    rule_no = 110
    protocol = "tcp"
    cidr_block = "10.0.1.48/28"	
    from_port = 1024
    to_port = 65535
    action = "allow"
    }, {
    rule_no = 120
    protocol = "tcp"
    cidr_block = "20.0.0.0/28"	
    from_port = 1024
    to_port =  65535
    action = "allow"
    }, {
    rule_no = 130
    protocol = "tcp"
    cidr_block = "10.0.1.64/28"	
    from_port = 1024
    to_port =  65535
    action = "allow"
    }, {
    rule_no = 140
    protocol = "tcp"
    cidr_block = "10.0.1.0/28"	
    from_port = 1024
    to_port =  65535
    action = "allow"
    }]

backend_nacl_tags  = {
    Name = "dev-backend-nacl-01"
    Enviroment = "dev"
    Owner = "shreya"
  }

/*--------------- Database NACL ---------------*/

# ingress rules
# private_subnets_cidr = ["10.0.0.96/27", "10.0.0.128/26", "10.0.0.192/26"]

db_nacl_ingress = [{
    rule_no = 100
    protocol = "tcp"
    cidr_block = "20.0.0.0/28"	
    from_port = 22
    to_port = 22
    action = "allow"
    }, {
    rule_no = 110
    protocol = "tcp"
    cidr_block = "10.0.1.0/28"	
    from_port = 22
    to_port = 22
    action = "allow"
    }, {
    rule_no = 120
    protocol = "tcp"
    cidr_block = "10.0.1.32/28"
    from_port = 6379
    to_port = 6379
    action = "allow"
    }, {
    rule_no = 130
    protocol = "tcp"
    cidr_block = "10.0.1.32/28"	
    from_port = 9042
    to_port = 9042
    action = "allow"
    }, {
    rule_no = 140
    protocol = "tcp"
    cidr_block = "10.0.1.32/28"	
    from_port = 5432
    to_port = 5432
    action = "allow"
    }]

# egress rules

db_nacl_egress = [{
    rule_no = 100
    protocol = "tcp"
    cidr_block = "20.0.0.0/28"	
    from_port = 1024
    to_port = 65535
    action = "allow"
    }, {
    rule_no = 110
    protocol = "tcp"
    cidr_block = "10.0.1.32/28"	
    from_port = 1024
    to_port = 65535
    action = "allow"
    }, {
    rule_no = 120
    protocol = "tcp"
    cidr_block = "10.0.1.0/28"	
    from_port = 1024
    to_port =  65535
    action = "allow"
    }]

db_nacl_tags  = {
    Name = "dev-db-nacl-01"
    Enviroment = "dev"
    Owner = "shreya"
  }

/*--------------- ALB Security Group ---------------*/

alb_sg_name = "dev-alb-sg"

alb_sg_description = "Security group for Dev-ALB"

alb_sg_inbound_rules  = [{
      port     = 80
      source   = "0.0.0.0/0" 
      protocol = "tcp"  
    }, {
      port     = 443
      source   = "0.0.0.0/0" 
      protocol = "tcp"  
    }]

alb_sg_outbound_rules  = [
    {
      port     = 0  
      source   = "0.0.0.0/0"
      protocol = "-1"  
    }
  ]

alb_sg_tags = {
    Environment = "dev"
    Owner       = "shreya"
  }

/*--------------- ALB ---------------*/

 alb_deletion_protection = false
 alb_name = "dev-alb"

 alb_type = "application"
 alb_internal = false
 alb_tags = {
    Enviroment = "dev"
    Owner = "shreya"
  }
  /*--------------- Route 53 ---------------*/

route53_zone_tags = {
    Enviroment = "dev"
    Owner = "shreya"
  }
route53_zone_name = "example.com"

```
***

# Result

<img width="524" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/bd9a27e6-97e7-467b-b3ac-ad2cd7df65e6">

***

### VPC & it's resources

![Screenshot 2024-03-13 101153](https://github.com/CodeOps-Hub/Documentation/assets/156057205/742b3b6c-d16a-4189-a168-8d0b85d1f761)

***

### Elastic IP

![Screenshot 2024-03-13 101337](https://github.com/CodeOps-Hub/Documentation/assets/156057205/1befbce1-79cd-4c48-baa1-27e4b481b43c)

***

### NACLs

**Frontend NACL**

![Screenshot 2024-03-13 101312](https://github.com/CodeOps-Hub/Documentation/assets/156057205/e198c4cd-80d3-4624-8bb2-246ec8daba98)

***

**Backend NACL**

![Screenshot 2024-03-13 101257](https://github.com/CodeOps-Hub/Documentation/assets/156057205/29912ca1-bcc6-4301-9413-ca24ed050262)

***

**DB NACL**

![Screenshot 2024-03-13 101244](https://github.com/CodeOps-Hub/Documentation/assets/156057205/c79ed561-5823-4722-b3d1-4def3472b801)

***

### Security Group

![Screenshot 2024-03-13 101512](https://github.com/CodeOps-Hub/Documentation/assets/156057205/84aa070c-8dbf-4707-9b03-8bc6a6e95e6f)

***

### Load Balancer

![Screenshot 2024-03-13 101649](https://github.com/CodeOps-Hub/Documentation/assets/156057205/67cda353-793f-43c7-8b44-2eeace3316c8)

***

### Route53

![Screenshot 2024-03-13 101748](https://github.com/CodeOps-Hub/Documentation/assets/156057205/c21a501b-bc82-40a1-b09a-0ffddf4deea7)

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

Terraform wrapper code enhances the capabilities of Terraform by automating tasks, providing additional functionality, and enforcing best practices. By following best practices such as modularity, error handling, and documentation, wrapper scripts can streamline Terraform workflows, improve productivity, and ensure the reliability and security of infrastructure deployments.

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
| [Link](https://medium.com/@brandon.wagner/a-wrapper-for-terraform-61a125b27ffc) | Terraform Wrapper Code Concept. |
| [Link](https://medium.com/@selvamraju007/terraform-modules-explanation-726ba4a0b98e) | Reference Link For Terraform Modules. |
