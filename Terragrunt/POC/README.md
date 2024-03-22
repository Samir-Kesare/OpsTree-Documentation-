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

<img width="1144" alt="Screenshot 2024-03-22 at 4 50 04 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/f9574720-0d47-451e-98c6-bb97e20faf1d">


### Explanation

1) The initial directory structure illustrates how your Terraform configuration would appear, featuring two environments: "dev" and "prod." Both environments utilize the same configuration for backend.tf and provider.tf files.

2) To avoid redundancy of these files across both environments, Terragrunt can be employed.

3) In the "After" scenario, you will create a global terragrunt.hcl file. This file will automatically generate backend.tf and provider.tf files across all your environments, significantly reducing manual effort.

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

<img width="454" alt="Screenshot 2024-03-22 at 2 52 41 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/a3cf8a0f-4953-4114-9921-6b848cb1bbd2">


* Your Terraform setup consists of .tf configuration files which utilize a `module` containing instance configurations.

#### main.tf 

```shell
resource "aws_instance" "web" {
  ami           = "ami-0a931e3a8c9589ff9"
  instance_type = var.instance_type

  tags = {
    Name = var.instance_name
  }
}
```

#### variable.tf

```shell
variable "instance_type" {
  description = "The type of EC2 instance"
}

variable "instance_name" {
  description = "Name tag for the EC2 instance"
}
```

### 2. Create terragrunt.hcl files

* To simplify and streamline your Terraform configurations, you can leverage Terragrunt by creating terragrunt.hcl files. These files serve as a central location for defining common configurations, reducing the overall complexity of your infrastructure codebase.

* To create a common configuration for `backend.tf` and `provider.tf` , you need to create a global terragrunt.hcl file that can be used in both the environnments (dev and prod). This would create our backend and provider automatically in both the environment saving us time and manual efforts. 

Global **common.hcl** 

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

* Now that we have created the global terragrunt.hcl file, the next step is to ensure that both the dev and prod environments utilize this shared configuration. Since we are also creating a resource through an ec2 instance `module` , we will also add this configuration directly in our terragrunt files. To achieve this, we need to create separate terragrunt.hcl files within each of these environments. These files will serve the sole purpose of including the global Terragrunt configuration from their respective folders.

**terragrunt.hcl** in environment folders 

#### Dev Environment 

```shell
include {
  path = find_in_parent_folders("common.hcl")
}

terraform {
  source = "../module"
}

inputs = {
  instance_type = "t2.micro"
  instance_name = "Dev"
}
```

#### Prod Environment 

```shell
include {
  path = find_in_parent_folders("common.hcl")
}

terraform {
  source = "../module"
}

inputs = {
  instance_type = "t2.medium"
  instance_name = "Prod"
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




