# DSL Jenkins pipeline for Network Skeleton setup in QA env 

<img width="360" length="100" alt="Terraform" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/556e50dc-0c8b-4262-be16-2c384d2cfa8a">

***
|   Author        |  Created on   |  Version   | Last updated by  | Last edited on |
| --------------- | --------------| -----------|----------------- | -------------- |
| Khushi Malhotra |  18 March 2024  |  Version 1 | Khushi Malhotra  | 18 March 2024    |

## Table of contents

* [Introduction](#Introduction)
* [What is DSL Pipeline](#What-is-DSL-Pipeline)
* [Why DSL Pipeline](#Why-DSP-Pipeline)
* [Flow Diagram](#Flow-Diagram)
* [Pre-requisites](#Pre-requisites)
* [Implementation of DSL Pipeline](#Implementation-of-DSL-Pipeline)
* [Terraform Module](#Terraform-Module)
* [Jenkinsfile](#Jenkinsfile)
* [Output](#Output)
* [Conclusion](#Conclusion)
* [Contact Information](#Contact-Information)
* [References](#References)

***
## Introduction

With the increasing complexity of modern networks and the need for agility in infrastructure management, Terraform has emerged as a powerful tool for automating the provisioning and configuration of network resources.This module is designed to provide a foundational framework for managing network infrastructure as code using Terraform. The  wrapper code simplifies the deployment and management of Network Skeleton setup by automating configuration tasks and providing a user-friendly interface for users to connect securely to the Network.

***

## What is DSL Pipeline?

A Domain-Specific Language (DSL) is a programming language or specification language dedicated to a particular problem domain, a particular problem representation technique, and/or a particular solution technique.DSL Pipeline is a robust framework designed to facilitate the creation, deployment, and management of domain-specific languages within your software development projects. By employing DSLs, developers can express solutions in a concise, domain-specific syntax tailored to the problem at hand, thereby enhancing productivity and reducing the gap between domain experts and software implementation.

***

## Why DSL Pipeline

| Key Features  | Description                                                                                                              |
|---------------|--------------------------------------------------------------------------------------------------------------------------|
| **Modularity**    | The DSL Pipeline offers a modular architecture, allowing developers to define and integrate custom DSL components seamlessly. |
| **Extensibility** | Extend the capabilities of the DSL Pipeline by incorporating new DSL constructs, transformations, and integrations with existing tools and libraries. |
| **Automation**    | Automate repetitive tasks in the development lifecycle through pipeline automation, including parsing, validation, transformation, and code generation. |
| **Flexibility**   | Accommodate diverse DSL requirements with flexible configuration options, support for various syntax styles, and compatibility with multiple target platforms. |

***

## Flow Diagram

<img width="950" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/9b5ae612-95d9-4cf4-9612-d9874fcfd843">

***

## Pre-requisites

| **Pre-requisites** | **Description** |
| ------------------ | ---------------- |
| **AWS Account**    | Access to the AWS Management Console with credentials configured. |
| **Jenkins**        | To integrate infra through DSL Pipeline. |
| **Terraform**      | Terraform HCL (v1.7.4) |

***

## Implementation of DSL Pipeline 

**Step-1** Create a New Pipeline Job

**Step-2** Configure Pipeline Script

**Step-3** Save the Configuration

**Step-4** Build the Pipeline

**Step-5** View Build Console Output

**This Jenkins pipeline automates the deployment of a NetworkSkeleton_QA Server using Terraform module and Wrapper code. It's configured to perform the following actions:**

### Terraform Deployment Pipeline Overview

| Stage                   | Description                                                                                                                                                                      |
|-------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Checkout**            | Fetches the Terraform code from a GitHub repository branch (`main`). |                                                                                    
| **Copy Terraform Files**    | Copies Frontend-related Terraform configuration files to the Jenkins workspace. |                                                                                                
| **Terraform Init**          | Initializes Terraform in the workspace directory. |                                                                                                                                
| **Terraform Plan**          | Generates a Terraform execution plan to preview the changes. |                                                                                                                     
| **Review and Approve Apply** | Asks for approval before applying Terraform changes if the selected action is "Apply". |                                                                                       
| **Review and Approve Destroy** | Asks for approval before destroying Terraform resources if the selected action is "Destroy". |                                                                            
| **Apply or Destroy**        | Executes Terraform apply or destroy based on the selected action. |                                                                                                               
| **Post**                    | Displays success or failure messages. |                                                                                                                                          
***

<details>
<summary> <b> Click here for Console Output </b> </summary>
<br>

```shell
Started by user Shikha Tripathi
Lightweight checkout support not available, falling back to full checkout.
Checking out git https://github.com/CodeOps-Hub/Jenkinsfile.git into /var/lib/jenkins/jobs/QA_NS_DSL_Pipeline/workspace@script/2c624e68d9ac93966b0a6ecea74a8a9f93dbab47b6fffa7f2ebbef857f80f0b1 to read Wrapper-Code/QA_Env/networkskeleton_QA/Jenkinsfile
Selected Git installation does not exist. Using Default
The recommended git tool is: NONE
using credential Khushi_PAT
 > git rev-parse --resolve-git-dir /var/lib/jenkins/jobs/QA_NS_DSL_Pipeline/workspace@script/2c624e68d9ac93966b0a6ecea74a8a9f93dbab47b6fffa7f2ebbef857f80f0b1/.git # timeout=10
Fetching changes from the remote Git repository
 > git config remote.origin.url https://github.com/CodeOps-Hub/Jenkinsfile.git # timeout=10
Fetching upstream changes from https://github.com/CodeOps-Hub/Jenkinsfile.git
 > git --version # timeout=10
 > git --version # 'git version 2.34.1'
using GIT_ASKPASS to set credentials Khushi_PAT
 > git fetch --tags --force --progress -- https://github.com/CodeOps-Hub/Jenkinsfile.git +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git rev-parse refs/remotes/origin/khushi/networkSkeleton_QA^{commit} # timeout=10
 > git rev-parse khushi/networkSkeleton_QA^{commit} # timeout=10
Checking out Revision 33bec14482cf60973148febd3fe55ca9080add67 (refs/remotes/origin/khushi/networkSkeleton_QA)
 > git config core.sparsecheckout # timeout=10
 > git checkout -f 33bec14482cf60973148febd3fe55ca9080add67 # timeout=10
Commit message: "Update Jenkinsfile"
 > git rev-list --no-walk c33cddee067a7ca70915d796f1c411d92ba9f140 # timeout=10
[Pipeline] Start of Pipeline
[Pipeline] node
Running on Jenkins in /var/lib/jenkins/jobs/QA_NS_DSL_Pipeline/workspace
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Declarative: Checkout SCM)
[Pipeline] checkout
Selected Git installation does not exist. Using Default
The recommended git tool is: NONE
using credential Khushi_PAT
Cloning the remote Git repository
Cloning repository https://github.com/CodeOps-Hub/Jenkinsfile.git
 > git init /var/lib/jenkins/jobs/QA_NS_DSL_Pipeline/workspace # timeout=10
Fetching upstream changes from https://github.com/CodeOps-Hub/Jenkinsfile.git
 > git --version # timeout=10
 > git --version # 'git version 2.34.1'
using GIT_ASKPASS to set credentials Khushi_PAT
 > git fetch --tags --force --progress -- https://github.com/CodeOps-Hub/Jenkinsfile.git +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git config remote.origin.url https://github.com/CodeOps-Hub/Jenkinsfile.git # timeout=10
 > git config --add remote.origin.fetch +refs/heads/*:refs/remotes/origin/* # timeout=10
Avoid second fetch
 > git rev-parse refs/remotes/origin/khushi/networkSkeleton_QA^{commit} # timeout=10
 > git rev-parse khushi/networkSkeleton_QA^{commit} # timeout=10
Checking out Revision 33bec14482cf60973148febd3fe55ca9080add67 (refs/remotes/origin/khushi/networkSkeleton_QA)
 > git config core.sparsecheckout # timeout=10
 > git checkout -f 33bec14482cf60973148febd3fe55ca9080add67 # timeout=10
Commit message: "Update Jenkinsfile"
[Pipeline] }
[Pipeline] // stage
[Pipeline] withEnv
[Pipeline] {
[Pipeline] withCredentials
WARNING: Unknown parameter(s) found for class type 'com.cloudbees.jenkins.plugins.awscredentials.AmazonWebServicesCredentialsBinding': keyIdVariable,secretVariable
WARNING: Unknown parameter(s) found for class type 'com.cloudbees.jenkins.plugins.awscredentials.AmazonWebServicesCredentialsBinding': keyIdVariable,secretVariable
Masking supported pattern matches of $AWS_ACCESS_KEY_ID or $AWS_SECRET_ACCESS_KEY
[Pipeline] {
[Pipeline] withEnv
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Checkout)
[Pipeline] git
The recommended git tool is: NONE
using credential Khushi_PAT
 > git rev-parse --resolve-git-dir /var/lib/jenkins/jobs/QA_NS_DSL_Pipeline/workspace/.git # timeout=10
Fetching changes from the remote Git repository
 > git config remote.origin.url https://github.com/CodeOps-Hub/Terraform-modules.git # timeout=10
Fetching upstream changes from https://github.com/CodeOps-Hub/Terraform-modules.git
 > git --version # timeout=10
 > git --version # 'git version 2.34.1'
using GIT_ASKPASS to set credentials Khushi_PAT
 > git fetch --tags --force --progress -- https://github.com/CodeOps-Hub/Terraform-modules.git +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git rev-parse refs/remotes/origin/main^{commit} # timeout=10
Checking out Revision 0cb5bbf1af0778791c4c1c54bd62f0564a6d0041 (refs/remotes/origin/main)
 > git config core.sparsecheckout # timeout=10
 > git checkout -f 0cb5bbf1af0778791c4c1c54bd62f0564a6d0041 # timeout=10
 > git branch -a -v --no-abbrev # timeout=10
 > git checkout -b main 0cb5bbf1af0778791c4c1c54bd62f0564a6d0041 # timeout=10
Commit message: "Update output.tf"
 > git rev-list --no-walk 642510eaa0d500bfea93885e3f2c0d6cfdb1e006 # timeout=10
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Copy Terraform Files)
[Pipeline] sh
+ cp wrapperCode/Network-Skeleton-Wrapper-Code/QA-Network-Skeleton-Wrapper-Code/main.tf wrapperCode/Network-Skeleton-Wrapper-Code/QA-Network-Skeleton-Wrapper-Code/output.tf wrapperCode/Network-Skeleton-Wrapper-Code/QA-Network-Skeleton-Wrapper-Code/providers.tf wrapperCode/Network-Skeleton-Wrapper-Code/QA-Network-Skeleton-Wrapper-Code/terraform.tfvars wrapperCode/Network-Skeleton-Wrapper-Code/QA-Network-Skeleton-Wrapper-Code/variables.tf .
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Terraform Init)
[Pipeline] script
[Pipeline] {
[Pipeline] sh
+ terraform init

[0m[1mInitializing the backend...[0m
[0m[1mInitializing modules...[0m
Downloading git::ssh://git@github.com/CodeOps-Hub/Terraform-modules.git?ref=main for network...
- network in .terraform/modules/network/Modules/Network_Skeleton_Module

[0m[1mInitializing provider plugins...[0m
- Finding hashicorp/aws versions matching ">= 5.38.0"...
- Installing hashicorp/aws v5.41.0...
- Installed hashicorp/aws v5.41.0 (signed by HashiCorp)

Terraform has created a lock file [1m.terraform.lock.hcl[0m to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.[0m

[0m[1m[32mTerraform has been successfully initialized![0m[32m[0m
[0m[32m
You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.[0m
[Pipeline] }
[Pipeline] // script
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Terraform Plan)
[Pipeline] script
[Pipeline] {
[Pipeline] sh
+ terraform plan

Terraform used the selected providers to generate the following execution
plan. Resource actions are indicated with the following symbols:
  [32m+[0m create[0m

Terraform will perform the following actions:

[1m  # module.network.aws_eip.dev_elastic_ip[0m will be created
[0m  [32m+[0m[0m resource "aws_eip" "dev_elastic_ip" {
      [32m+[0m[0m allocation_id        = (known after apply)
      [32m+[0m[0m association_id       = (known after apply)
      [32m+[0m[0m carrier_ip           = (known after apply)
      [32m+[0m[0m customer_owned_ip    = (known after apply)
      [32m+[0m[0m domain               = "vpc"
      [32m+[0m[0m id                   = (known after apply)
      [32m+[0m[0m instance             = (known after apply)
      [32m+[0m[0m network_border_group = (known after apply)
      [32m+[0m[0m network_interface    = (known after apply)
      [32m+[0m[0m private_dns          = (known after apply)
      [32m+[0m[0m private_ip           = (known after apply)
      [32m+[0m[0m public_dns           = (known after apply)
      [32m+[0m[0m public_ip            = (known after apply)
      [32m+[0m[0m public_ipv4_pool     = (known after apply)
      [32m+[0m[0m tags_all             = (known after apply)
      [32m+[0m[0m vpc                  = (known after apply)
    }

[1m  # module.network.aws_internet_gateway.dev_igw[0m will be created
[0m  [32m+[0m[0m resource "aws_internet_gateway" "dev_igw" {
      [32m+[0m[0m arn      = (known after apply)
      [32m+[0m[0m id       = (known after apply)
      [32m+[0m[0m owner_id = (known after apply)
      [32m+[0m[0m tags     = {
          [32m+[0m[0m "Enviroment" = "QA"
          [32m+[0m[0m "Name"       = "QA-igw-01"
          [32m+[0m[0m "Owner"      = "shreya"
        }
      [32m+[0m[0m tags_all = {
          [32m+[0m[0m "Enviroment" = "QA"
          [32m+[0m[0m "Name"       = "QA-igw-01"
          [32m+[0m[0m "Owner"      = "shreya"
        }
      [32m+[0m[0m vpc_id   = (known after apply)
    }

[1m  # module.network.aws_lb.dev_alb[0m will be created
[0m  [32m+[0m[0m resource "aws_lb" "dev_alb" {
      [32m+[0m[0m arn                                                          = (known after apply)
      [32m+[0m[0m arn_suffix                                                   = (known after apply)
      [32m+[0m[0m desync_mitigation_mode                                       = "defensive"
      [32m+[0m[0m dns_name                                                     = (known after apply)
      [32m+[0m[0m drop_invalid_header_fields                                   = false
      [32m+[0m[0m enable_deletion_protection                                   = false
      [32m+[0m[0m enable_http2                                                 = true
      [32m+[0m[0m enable_tls_version_and_cipher_suite_headers                  = false
      [32m+[0m[0m enable_waf_fail_open                                         = false
      [32m+[0m[0m enable_xff_client_port                                       = false
      [32m+[0m[0m enforce_security_group_inbound_rules_on_private_link_traffic = (known after apply)
      [32m+[0m[0m id                                                           = (known after apply)
      [32m+[0m[0m idle_timeout                                                 = 60
      [32m+[0m[0m internal                                                     = false
      [32m+[0m[0m ip_address_type                                              = (known after apply)
      [32m+[0m[0m load_balancer_type                                           = "application"
      [32m+[0m[0m name                                                         = "QA-alb"
      [32m+[0m[0m name_prefix                                                  = (known after apply)
      [32m+[0m[0m preserve_host_header                                         = false
      [32m+[0m[0m security_groups                                              = (known after apply)
      [32m+[0m[0m subnets                                                      = (known after apply)
      [32m+[0m[0m tags                                                         = {
          [32m+[0m[0m "Enviroment" = "QA"
          [32m+[0m[0m "Owner"      = "shreya"
        }
      [32m+[0m[0m tags_all                                                     = {
          [32m+[0m[0m "Enviroment" = "QA"
          [32m+[0m[0m "Owner"      = "shreya"
        }
      [32m+[0m[0m vpc_id                                                       = (known after apply)
      [32m+[0m[0m xff_header_processing_mode                                   = "append"
      [32m+[0m[0m zone_id                                                      = (known after apply)
    }

[1m  # module.network.aws_nat_gateway.dev_nat[0m will be created
[0m  [32m+[0m[0m resource "aws_nat_gateway" "dev_nat" {
      [32m+[0m[0m allocation_id                      = (known after apply)
      [32m+[0m[0m association_id                     = (known after apply)
      [32m+[0m[0m connectivity_type                  = "public"
      [32m+[0m[0m id                                 = (known after apply)
      [32m+[0m[0m network_interface_id               = (known after apply)
      [32m+[0m[0m private_ip                         = (known after apply)
      [32m+[0m[0m public_ip                          = (known after apply)
      [32m+[0m[0m secondary_private_ip_address_count = (known after apply)
      [32m+[0m[0m secondary_private_ip_addresses     = (known after apply)
      [32m+[0m[0m subnet_id                          = (known after apply)
      [32m+[0m[0m tags                               = {
          [32m+[0m[0m "Enviroment" = "QA"
          [32m+[0m[0m "Name"       = "QA-nat-01"
          [32m+[0m[0m "Owner"      = "shreya"
        }
      [32m+[0m[0m tags_all                           = {
          [32m+[0m[0m "Enviroment" = "QA"
          [32m+[0m[0m "Name"       = "QA-nat-01"
          [32m+[0m[0m "Owner"      = "shreya"
        }
    }

[1m  # module.network.aws_network_acl.dev_backend_nacl[0m will be created
[0m  [32m+[0m[0m resource "aws_network_acl" "dev_backend_nacl" {
      [32m+[0m[0m arn        = (known after apply)
      [32m+[0m[0m egress     = [
          [32m+[0m[0m {
              [32m+[0m[0m action          = "allow"
              [32m+[0m[0m cidr_block      = "10.0.1.128/28"
              [32m+[0m[0m from_port       = 1024
              [32m+[0m[0m ipv6_cidr_block = ""
              [32m+[0m[0m protocol        = "tcp"
              [32m+[0m[0m rule_no         = 140
              [32m+[0m[0m to_port         = 65535
            },
          [32m+[0m[0m {
              [32m+[0m[0m action          = "allow"
              [32m+[0m[0m cidr_block      = "10.0.1.144/28"
              [32m+[0m[0m from_port       = 1024
              [32m+[0m[0m ipv6_cidr_block = ""
              [32m+[0m[0m protocol        = "tcp"
              [32m+[0m[0m rule_no         = 130
              [32m+[0m[0m to_port         = 65535
            },
          [32m+[0m[0m {
              [32m+[0m[0m action          = "allow"
              [32m+[0m[0m cidr_block      = "10.0.1.192/28"
              [32m+[0m[0m from_port       = 1024
              [32m+[0m[0m ipv6_cidr_block = ""
              [32m+[0m[0m protocol        = "tcp"
              [32m+[0m[0m rule_no         = 110
              [32m+[0m[0m to_port         = 65535
            },
          [32m+[0m[0m {
              [32m+[0m[0m action          = "allow"
              [32m+[0m[0m cidr_block      = "20.0.0.0/28"
              [32m+[0m[0m from_port       = 1024
              [32m+[0m[0m ipv6_cidr_block = ""
              [32m+[0m[0m protocol        = "tcp"
              [32m+[0m[0m rule_no         = 120
              [32m+[0m[0m to_port         = 65535
            },
          [32m+[0m[0m {
              [32m+[0m[0m action          = "allow"
              [32m+[0m[0m cidr_block      = "20.0.0.0/28"
              [32m+[0m[0m from_port       = 22
              [32m+[0m[0m ipv6_cidr_block = ""
              [32m+[0m[0m protocol        = "tcp"
              [32m+[0m[0m rule_no         = 100
              [32m+[0m[0m to_port         = 22
            },
        ]
      [32m+[0m[0m id         = (known after apply)
      [32m+[0m[0m ingress    = [
          [32m+[0m[0m {
              [32m+[0m[0m action          = "allow"
              [32m+[0m[0m cidr_block      = "10.0.1.128/28"
              [32m+[0m[0m from_port       = 1024
              [32m+[0m[0m ipv6_cidr_block = ""
              [32m+[0m[0m protocol        = "tcp"
              [32m+[0m[0m rule_no         = 150
              [32m+[0m[0m to_port         = 65535
            },
          [32m+[0m[0m {
              [32m+[0m[0m action          = "allow"
              [32m+[0m[0m cidr_block      = "10.0.1.128/28"
              [32m+[0m[0m from_port       = 22
              [32m+[0m[0m ipv6_cidr_block = ""
              [32m+[0m[0m protocol        = "tcp"
              [32m+[0m[0m rule_no         = 140
              [32m+[0m[0m to_port         = 22
            },
          [32m+[0m[0m {
              [32m+[0m[0m action          = "allow"
              [32m+[0m[0m cidr_block      = "10.0.1.128/28"
              [32m+[0m[0m from_port       = 8080
              [32m+[0m[0m ipv6_cidr_block = ""
              [32m+[0m[0m protocol        = "tcp"
              [32m+[0m[0m rule_no         = 110
              [32m+[0m[0m to_port         = 8080
            },
          [32m+[0m[0m {
              [32m+[0m[0m action          = "allow"
              [32m+[0m[0m cidr_block      = "10.0.1.144/28"
              [32m+[0m[0m from_port       = 1024
              [32m+[0m[0m ipv6_cidr_block = ""
              [32m+[0m[0m protocol        = "tcp"
              [32m+[0m[0m rule_no         = 130
              [32m+[0m[0m to_port         = 65535
            },
          [32m+[0m[0m {
              [32m+[0m[0m action          = "allow"
              [32m+[0m[0m cidr_block      = "10.0.1.144/28"
              [32m+[0m[0m from_port       = 8080
              [32m+[0m[0m ipv6_cidr_block = ""
              [32m+[0m[0m protocol        = "tcp"
              [32m+[0m[0m rule_no         = 160
              [32m+[0m[0m to_port         = 8080
            },
          [32m+[0m[0m {
              [32m+[0m[0m action          = "allow"
              [32m+[0m[0m cidr_block      = "10.0.1.192/28"
              [32m+[0m[0m from_port       = 1024
              [32m+[0m[0m ipv6_cidr_block = ""
              [32m+[0m[0m protocol        = "tcp"
              [32m+[0m[0m rule_no         = 120
              [32m+[0m[0m to_port         = 65535
            },
          [32m+[0m[0m {
              [32m+[0m[0m action          = "allow"
              [32m+[0m[0m cidr_block      = "20.0.0.0/28"
              [32m+[0m[0m from_port       = 22
              [32m+[0m[0m ipv6_cidr_block = ""
              [32m+[0m[0m protocol        = "tcp"
              [32m+[0m[0m rule_no         = 100
              [32m+[0m[0m to_port         = 22
            },
        ]
      [32m+[0m[0m owner_id   = (known after apply)
      [32m+[0m[0m subnet_ids = (known after apply)
      [32m+[0m[0m tags       = {
          [32m+[0m[0m "Enviroment" = "QA"
          [32m+[0m[0m "Name"       = "QA-backend-nacl-01"
          [32m+[0m[0m "Owner"      = "shreya"
        }
      [32m+[0m[0m tags_all   = {
          [32m+[0m[0m "Enviroment" = "QA"
          [32m+[0m[0m "Name"       = "QA-backend-nacl-01"
          [32m+[0m[0m "Owner"      = "shreya"
        }
      [32m+[0m[0m vpc_id     = (known after apply)
    }

[1m  # module.network.aws_network_acl.dev_db_nacl[0m will be created
[0m  [32m+[0m[0m resource "aws_network_acl" "dev_db_nacl" {
      [32m+[0m[0m arn        = (known after apply)
      [32m+[0m[0m egress     = [
          [32m+[0m[0m {
              [32m+[0m[0m action          = "allow"
              [32m+[0m[0m cidr_block      = "10.0.1.128/28"
              [32m+[0m[0m from_port       = 1024
              [32m+[0m[0m ipv6_cidr_block = ""
              [32m+[0m[0m protocol        = "tcp"
              [32m+[0m[0m rule_no         = 120
              [32m+[0m[0m to_port         = 65535
            },
          [32m+[0m[0m {
              [32m+[0m[0m action          = "allow"
              [32m+[0m[0m cidr_block      = "10.0.1.176/28"
              [32m+[0m[0m from_port       = 1024
              [32m+[0m[0m ipv6_cidr_block = ""
              [32m+[0m[0m protocol        = "tcp"
              [32m+[0m[0m rule_no         = 110
              [32m+[0m[0m to_port         = 65535
            },
          [32m+[0m[0m {
              [32m+[0m[0m action          = "allow"
              [32m+[0m[0m cidr_block      = "20.0.0.0/28"
              [32m+[0m[0m from_port       = 1024
              [32m+[0m[0m ipv6_cidr_block = ""
              [32m+[0m[0m protocol        = "tcp"
              [32m+[0m[0m rule_no         = 100
              [32m+[0m[0m to_port         = 65535
            },
        ]
      [32m+[0m[0m id         = (known after apply)
      [32m+[0m[0m ingress    = [
          [32m+[0m[0m {
              [32m+[0m[0m action          = "allow"
              [32m+[0m[0m cidr_block      = "10.0.1.128/28"
              [32m+[0m[0m from_port       = 22
              [32m+[0m[0m ipv6_cidr_block = ""
              [32m+[0m[0m protocol        = "tcp"
              [32m+[0m[0m rule_no         = 110
              [32m+[0m[0m to_port         = 22
            },
          [32m+[0m[0m {
              [32m+[0m[0m action          = "allow"
              [32m+[0m[0m cidr_block      = "10.0.1.176/28"
              [32m+[0m[0m from_port       = 5432
              [32m+[0m[0m ipv6_cidr_block = ""
              [32m+[0m[0m protocol        = "tcp"
              [32m+[0m[0m rule_no         = 140
              [32m+[0m[0m to_port         = 5432
            },
          [32m+[0m[0m {
              [32m+[0m[0m action          = "allow"
              [32m+[0m[0m cidr_block      = "10.0.1.176/28"
              [32m+[0m[0m from_port       = 6379
              [32m+[0m[0m ipv6_cidr_block = ""
              [32m+[0m[0m protocol        = "tcp"
              [32m+[0m[0m rule_no         = 120
              [32m+[0m[0m to_port         = 6379
            },
          [32m+[0m[0m {
              [32m+[0m[0m action          = "allow"
              [32m+[0m[0m cidr_block      = "10.0.1.176/28"
              [32m+[0m[0m from_port       = 9042
              [32m+[0m[0m ipv6_cidr_block = ""
              [32m+[0m[0m protocol        = "tcp"
              [32m+[0m[0m rule_no         = 130
              [32m+[0m[0m to_port         = 9042
            },
          [32m+[0m[0m {
              [32m+[0m[0m action          = "allow"
              [32m+[0m[0m cidr_block      = "20.0.0.0/28"
              [32m+[0m[0m from_port       = 22
              [32m+[0m[0m ipv6_cidr_block = ""
              [32m+[0m[0m protocol        = "tcp"
              [32m+[0m[0m rule_no         = 100
              [32m+[0m[0m to_port         = 22
            },
        ]
      [32m+[0m[0m owner_id   = (known after apply)
      [32m+[0m[0m subnet_ids = (known after apply)
      [32m+[0m[0m tags       = {
          [32m+[0m[0m "Enviroment" = "QA"
          [32m+[0m[0m "Name"       = "QA-db-nacl-01"
          [32m+[0m[0m "Owner"      = "shreya"
        }
      [32m+[0m[0m tags_all   = {
          [32m+[0m[0m "Enviroment" = "QA"
          [32m+[0m[0m "Name"       = "QA-db-nacl-01"
          [32m+[0m[0m "Owner"      = "shreya"
        }
      [32m+[0m[0m vpc_id     = (known after apply)
    }

[1m  # module.network.aws_network_acl.dev_frontend_nacl[0m will be created
[0m  [32m+[0m[0m resource "aws_network_acl" "dev_frontend_nacl" {
      [32m+[0m[0m arn        = (known after apply)
      [32m+[0m[0m egress     = [
          [32m+[0m[0m {
              [32m+[0m[0m action          = "allow"
              [32m+[0m[0m cidr_block      = "10.0.1.128/28"
              [32m+[0m[0m from_port       = 1024
              [32m+[0m[0m ipv6_cidr_block = ""
              [32m+[0m[0m protocol        = "tcp"
              [32m+[0m[0m rule_no         = 110
              [32m+[0m[0m to_port         = 65535
            },
          [32m+[0m[0m {
              [32m+[0m[0m action          = "allow"
              [32m+[0m[0m cidr_block      = "10.0.1.144/28"
              [32m+[0m[0m from_port       = 1024
              [32m+[0m[0m ipv6_cidr_block = ""
              [32m+[0m[0m protocol        = "tcp"
              [32m+[0m[0m rule_no         = 120
              [32m+[0m[0m to_port         = 65535
            },
          [32m+[0m[0m {
              [32m+[0m[0m action          = "allow"
              [32m+[0m[0m cidr_block      = "20.0.0.0/28"
              [32m+[0m[0m from_port       = 1024
              [32m+[0m[0m ipv6_cidr_block = ""
              [32m+[0m[0m protocol        = "tcp"
              [32m+[0m[0m rule_no         = 100
              [32m+[0m[0m to_port         = 65535
            },
        ]
      [32m+[0m[0m id         = (known after apply)
      [32m+[0m[0m ingress    = [
          [32m+[0m[0m {
              [32m+[0m[0m action          = "allow"
              [32m+[0m[0m cidr_block      = "10.0.1.128/28"
              [32m+[0m[0m from_port       = 22
              [32m+[0m[0m ipv6_cidr_block = ""
              [32m+[0m[0m protocol        = "tcp"
              [32m+[0m[0m rule_no         = 120
              [32m+[0m[0m to_port         = 22
            },
          [32m+[0m[0m {
              [32m+[0m[0m action          = "allow"
              [32m+[0m[0m cidr_block      = "10.0.1.128/28"
              [32m+[0m[0m from_port       = 3000
              [32m+[0m[0m ipv6_cidr_block = ""
              [32m+[0m[0m protocol        = "tcp"
              [32m+[0m[0m rule_no         = 110
              [32m+[0m[0m to_port         = 3000
            },
          [32m+[0m[0m {
              [32m+[0m[0m action          = "allow"
              [32m+[0m[0m cidr_block      = "10.0.1.144/28"
              [32m+[0m[0m from_port       = 3000
              [32m+[0m[0m ipv6_cidr_block = ""
              [32m+[0m[0m protocol        = "tcp"
              [32m+[0m[0m rule_no         = 130
              [32m+[0m[0m to_port         = 3000
            },
          [32m+[0m[0m {
              [32m+[0m[0m action          = "allow"
              [32m+[0m[0m cidr_block      = "20.0.0.0/28"
              [32m+[0m[0m from_port       = 22
              [32m+[0m[0m ipv6_cidr_block = ""
              [32m+[0m[0m protocol        = "tcp"
              [32m+[0m[0m rule_no         = 100
              [32m+[0m[0m to_port         = 22
            },
        ]
      [32m+[0m[0m owner_id   = (known after apply)
      [32m+[0m[0m subnet_ids = (known after apply)
      [32m+[0m[0m tags       = {
          [32m+[0m[0m "Enviroment" = "QA"
          [32m+[0m[0m "Name"       = "QA-frontend-nacl-01"
          [32m+[0m[0m "Owner"      = "shreya"
        }
      [32m+[0m[0m tags_all   = {
          [32m+[0m[0m "Enviroment" = "QA"
          [32m+[0m[0m "Name"       = "QA-frontend-nacl-01"
          [32m+[0m[0m "Owner"      = "shreya"
        }
      [32m+[0m[0m vpc_id     = (known after apply)
    }

[1m  # module.network.aws_network_acl_association.dev_backend_nacl_assc[0m will be created
[0m  [32m+[0m[0m resource "aws_network_acl_association" "dev_backend_nacl_assc" {
      [32m+[0m[0m id             = (known after apply)
      [32m+[0m[0m network_acl_id = (known after apply)
      [32m+[0m[0m subnet_id      = (known after apply)
    }

[1m  # module.network.aws_network_acl_association.dev_db_nacl_assc[0m will be created
[0m  [32m+[0m[0m resource "aws_network_acl_association" "dev_db_nacl_assc" {
      [32m+[0m[0m id             = (known after apply)
      [32m+[0m[0m network_acl_id = (known after apply)
      [32m+[0m[0m subnet_id      = (known after apply)
    }

[1m  # module.network.aws_network_acl_association.dev_frontend_nacl[0m will be created
[0m  [32m+[0m[0m resource "aws_network_acl_association" "dev_frontend_nacl" {
      [32m+[0m[0m id             = (known after apply)
      [32m+[0m[0m network_acl_id = (known after apply)
      [32m+[0m[0m subnet_id      = (known after apply)
    }

[1m  # module.network.aws_route53_record.dev_route53_record[0m will be created
[0m  [32m+[0m[0m resource "aws_route53_record" "dev_route53_record" {
      [32m+[0m[0m allow_overwrite = (known after apply)
      [32m+[0m[0m fqdn            = (known after apply)
      [32m+[0m[0m id              = (known after apply)
      [32m+[0m[0m name            = "example.com"
      [32m+[0m[0m type            = "A"
      [32m+[0m[0m zone_id         = (known after apply)

      [32m+[0m[0m alias {
          [32m+[0m[0m evaluate_target_health = true
          [32m+[0m[0m name                   = (known after apply)
          [32m+[0m[0m zone_id                = (known after apply)
        }
    }

[1m  # module.network.aws_route53_zone.dev_route53_zone[0m will be created
[0m  [32m+[0m[0m resource "aws_route53_zone" "dev_route53_zone" {
      [32m+[0m[0m arn                 = (known after apply)
      [32m+[0m[0m comment             = "Managed by Terraform"
      [32m+[0m[0m force_destroy       = false
      [32m+[0m[0m id                  = (known after apply)
      [32m+[0m[0m name                = "example.com"
      [32m+[0m[0m name_servers        = (known after apply)
      [32m+[0m[0m primary_name_server = (known after apply)
      [32m+[0m[0m tags                = {
          [32m+[0m[0m "Enviroment" = "QA"
          [32m+[0m[0m "Owner"      = "shreya"
        }
      [32m+[0m[0m tags_all            = {
          [32m+[0m[0m "Enviroment" = "QA"
          [32m+[0m[0m "Owner"      = "shreya"
        }
      [32m+[0m[0m zone_id             = (known after apply)

      [32m+[0m[0m vpc {
          [32m+[0m[0m vpc_id     = (known after apply)
          [32m+[0m[0m vpc_region = "us-east-2"
        }
    }

[1m  # module.network.aws_route_table.dev_private_rtb[0m will be created
[0m  [32m+[0m[0m resource "aws_route_table" "dev_private_rtb" {
      [32m+[0m[0m arn              = (known after apply)
      [32m+[0m[0m id               = (known after apply)
      [32m+[0m[0m owner_id         = (known after apply)
      [32m+[0m[0m propagating_vgws = (known after apply)
      [32m+[0m[0m route            = [
          [32m+[0m[0m {
              [32m+[0m[0m carrier_gateway_id         = ""
              [32m+[0m[0m cidr_block                 = "0.0.0.0/0"
              [32m+[0m[0m core_network_arn           = ""
              [32m+[0m[0m destination_prefix_list_id = ""
              [32m+[0m[0m egress_only_gateway_id     = ""
              [32m+[0m[0m gateway_id                 = ""
              [32m+[0m[0m ipv6_cidr_block            = ""
              [32m+[0m[0m local_gateway_id           = ""
              [32m+[0m[0m nat_gateway_id             = (known after apply)
              [32m+[0m[0m network_interface_id       = ""
              [32m+[0m[0m transit_gateway_id         = ""
              [32m+[0m[0m vpc_endpoint_id            = ""
              [32m+[0m[0m vpc_peering_connection_id  = ""
            },
          [32m+[0m[0m {
              [32m+[0m[0m carrier_gateway_id         = ""
              [32m+[0m[0m cidr_block                 = "10.0.1.128/25"
              [32m+[0m[0m core_network_arn           = ""
              [32m+[0m[0m destination_prefix_list_id = ""
              [32m+[0m[0m egress_only_gateway_id     = ""
              [32m+[0m[0m gateway_id                 = "local"
              [32m+[0m[0m ipv6_cidr_block            = ""
              [32m+[0m[0m local_gateway_id           = ""
              [32m+[0m[0m nat_gateway_id             = ""
              [32m+[0m[0m network_interface_id       = ""
              [32m+[0m[0m transit_gateway_id         = ""
              [32m+[0m[0m vpc_endpoint_id            = ""
              [32m+[0m[0m vpc_peering_connection_id  = ""
            },
        ]
      [32m+[0m[0m tags             = {
          [32m+[0m[0m "Enviroment" = "QA"
          [32m+[0m[0m "Name"       = "QA-private-RTB-01"
          [32m+[0m[0m "Owner"      = "shreya"
        }
      [32m+[0m[0m tags_all         = {
          [32m+[0m[0m "Enviroment" = "QA"
          [32m+[0m[0m "Name"       = "QA-private-RTB-01"
          [32m+[0m[0m "Owner"      = "shreya"
        }
      [32m+[0m[0m vpc_id           = (known after apply)
    }

[1m  # module.network.aws_route_table.dev_public_rtb[0m will be created
[0m  [32m+[0m[0m resource "aws_route_table" "dev_public_rtb" {
      [32m+[0m[0m arn              = (known after apply)
      [32m+[0m[0m id               = (known after apply)
      [32m+[0m[0m owner_id         = (known after apply)
      [32m+[0m[0m propagating_vgws = (known after apply)
      [32m+[0m[0m route            = [
          [32m+[0m[0m {
              [32m+[0m[0m carrier_gateway_id         = ""
              [32m+[0m[0m cidr_block                 = "0.0.0.0/0"
              [32m+[0m[0m core_network_arn           = ""
              [32m+[0m[0m destination_prefix_list_id = ""
              [32m+[0m[0m egress_only_gateway_id     = ""
              [32m+[0m[0m gateway_id                 = (known after apply)
              [32m+[0m[0m ipv6_cidr_block            = ""
              [32m+[0m[0m local_gateway_id           = ""
              [32m+[0m[0m nat_gateway_id             = ""
              [32m+[0m[0m network_interface_id       = ""
              [32m+[0m[0m transit_gateway_id         = ""
              [32m+[0m[0m vpc_endpoint_id            = ""
              [32m+[0m[0m vpc_peering_connection_id  = ""
            },
          [32m+[0m[0m {
              [32m+[0m[0m carrier_gateway_id         = ""
              [32m+[0m[0m cidr_block                 = "10.0.1.128/25"
              [32m+[0m[0m core_network_arn           = ""
              [32m+[0m[0m destination_prefix_list_id = ""
              [32m+[0m[0m egress_only_gateway_id     = ""
              [32m+[0m[0m gateway_id                 = "local"
              [32m+[0m[0m ipv6_cidr_block            = ""
              [32m+[0m[0m local_gateway_id           = ""
              [32m+[0m[0m nat_gateway_id             = ""
              [32m+[0m[0m network_interface_id       = ""
              [32m+[0m[0m transit_gateway_id         = ""
              [32m+[0m[0m vpc_endpoint_id            = ""
              [32m+[0m[0m vpc_peering_connection_id  = ""
            },
        ]
      [32m+[0m[0m tags             = {
          [32m+[0m[0m "Enviroment" = "QA"
          [32m+[0m[0m "Name"       = "QA-public-RTB-01"
          [32m+[0m[0m "Owner"      = "shreya"
        }
      [32m+[0m[0m tags_all         = {
          [32m+[0m[0m "Enviroment" = "QA"
          [32m+[0m[0m "Name"       = "QA-public-RTB-01"
          [32m+[0m[0m "Owner"      = "shreya"
        }
      [32m+[0m[0m vpc_id           = (known after apply)
    }

[1m  # module.network.aws_route_table_association.dev_private_route_association01[0][0m will be created
[0m  [32m+[0m[0m resource "aws_route_table_association" "dev_private_route_association01" {
      [32m+[0m[0m id             = (known after apply)
      [32m+[0m[0m route_table_id = (known after apply)
      [32m+[0m[0m subnet_id      = (known after apply)
    }

[1m  # module.network.aws_route_table_association.dev_private_route_association01[1][0m will be created
[0m  [32m+[0m[0m resource "aws_route_table_association" "dev_private_route_association01" {
      [32m+[0m[0m id             = (known after apply)
      [32m+[0m[0m route_table_id = (known after apply)
      [32m+[0m[0m subnet_id      = (known after apply)
    }

[1m  # module.network.aws_route_table_association.dev_private_route_association01[2][0m will be created
[0m  [32m+[0m[0m resource "aws_route_table_association" "dev_private_route_association01" {
      [32m+[0m[0m id             = (known after apply)
      [32m+[0m[0m route_table_id = (known after apply)
      [32m+[0m[0m subnet_id      = (known after apply)
    }

[1m  # module.network.aws_route_table_association.dev_public_route_association01[0][0m will be created
[0m  [32m+[0m[0m resource "aws_route_table_association" "dev_public_route_association01" {
      [32m+[0m[0m id             = (known after apply)
      [32m+[0m[0m route_table_id = (known after apply)
      [32m+[0m[0m subnet_id      = (known after apply)
    }

[1m  # module.network.aws_route_table_association.dev_public_route_association01[1][0m will be created
[0m  [32m+[0m[0m resource "aws_route_table_association" "dev_public_route_association01" {
      [32m+[0m[0m id             = (known after apply)
      [32m+[0m[0m route_table_id = (known after apply)
      [32m+[0m[0m subnet_id      = (known after apply)
    }

[1m  # module.network.aws_security_group.dev_alb_sg[0m will be created
[0m  [32m+[0m[0m resource "aws_security_group" "dev_alb_sg" {
      [32m+[0m[0m arn                    = (known after apply)
      [32m+[0m[0m description            = "Security group for QA-ALB"
      [32m+[0m[0m egress                 = [
          [32m+[0m[0m {
              [32m+[0m[0m cidr_blocks      = [
                  [32m+[0m[0m "0.0.0.0/0",
                ]
              [32m+[0m[0m description      = ""
              [32m+[0m[0m from_port        = 0
              [32m+[0m[0m ipv6_cidr_blocks = []
              [32m+[0m[0m prefix_list_ids  = []
              [32m+[0m[0m protocol         = "-1"
              [32m+[0m[0m security_groups  = []
              [32m+[0m[0m self             = false
              [32m+[0m[0m to_port          = 0
            },
        ]
      [32m+[0m[0m id                     = (known after apply)
      [32m+[0m[0m ingress                = [
          [32m+[0m[0m {
              [32m+[0m[0m cidr_blocks      = [
                  [32m+[0m[0m "0.0.0.0/0",
                ]
              [32m+[0m[0m description      = ""
              [32m+[0m[0m from_port        = 443
              [32m+[0m[0m ipv6_cidr_blocks = []
              [32m+[0m[0m prefix_list_ids  = []
              [32m+[0m[0m protocol         = "tcp"
              [32m+[0m[0m security_groups  = []
              [32m+[0m[0m self             = false
              [32m+[0m[0m to_port          = 443
            },
          [32m+[0m[0m {
              [32m+[0m[0m cidr_blocks      = [
                  [32m+[0m[0m "0.0.0.0/0",
                ]
              [32m+[0m[0m description      = ""
              [32m+[0m[0m from_port        = 80
              [32m+[0m[0m ipv6_cidr_blocks = []
              [32m+[0m[0m prefix_list_ids  = []
              [32m+[0m[0m protocol         = "tcp"
              [32m+[0m[0m security_groups  = []
              [32m+[0m[0m self             = false
              [32m+[0m[0m to_port          = 80
            },
        ]
      [32m+[0m[0m name                   = "QA-alb-sg"
      [32m+[0m[0m name_prefix            = (known after apply)
      [32m+[0m[0m owner_id               = (known after apply)
      [32m+[0m[0m revoke_rules_on_delete = false
      [32m+[0m[0m tags                   = {
          [32m+[0m[0m "Enviroment" = "QA"
          [32m+[0m[0m "Owner"      = "shreya"
        }
      [32m+[0m[0m tags_all               = {
          [32m+[0m[0m "Enviroment" = "QA"
          [32m+[0m[0m "Owner"      = "shreya"
        }
      [32m+[0m[0m vpc_id                 = (known after apply)
    }

[1m  # module.network.aws_subnet.dev_private_subnets[0][0m will be created
[0m  [32m+[0m[0m resource "aws_subnet" "dev_private_subnets" {
      [32m+[0m[0m arn                                            = (known after apply)
      [32m+[0m[0m assign_ipv6_address_on_creation                = false
      [32m+[0m[0m availability_zone                              = "us-east-2a"
      [32m+[0m[0m availability_zone_id                           = (known after apply)
      [32m+[0m[0m cidr_block                                     = "10.0.1.160/28"
      [32m+[0m[0m enable_dns64                                   = false
      [32m+[0m[0m enable_resource_name_dns_a_record_on_launch    = false
      [32m+[0m[0m enable_resource_name_dns_aaaa_record_on_launch = false
      [32m+[0m[0m id                                             = (known after apply)
      [32m+[0m[0m ipv6_cidr_block_association_id                 = (known after apply)
      [32m+[0m[0m ipv6_native                                    = false
      [32m+[0m[0m map_public_ip_on_launch                        = false
      [32m+[0m[0m owner_id                                       = (known after apply)
      [32m+[0m[0m private_dns_hostname_type_on_launch            = (known after apply)
      [32m+[0m[0m tags                                           = {
          [32m+[0m[0m "Enviroment" = "QA"
          [32m+[0m[0m "Name"       = "frontend-subnet"
          [32m+[0m[0m "Owner"      = "shreya"
        }
      [32m+[0m[0m tags_all                                       = {
          [32m+[0m[0m "Enviroment" = "QA"
          [32m+[0m[0m "Name"       = "frontend-subnet"
          [32m+[0m[0m "Owner"      = "shreya"
        }
      [32m+[0m[0m vpc_id                                         = (known after apply)
    }

[1m  # module.network.aws_subnet.dev_private_subnets[1][0m will be created
[0m  [32m+[0m[0m resource "aws_subnet" "dev_private_subnets" {
      [32m+[0m[0m arn                                            = (known after apply)
      [32m+[0m[0m assign_ipv6_address_on_creation                = false
      [32m+[0m[0m availability_zone                              = "us-east-2a"
      [32m+[0m[0m availability_zone_id                           = (known after apply)
      [32m+[0m[0m cidr_block                                     = "10.0.1.176/28"
      [32m+[0m[0m enable_dns64                                   = false
      [32m+[0m[0m enable_resource_name_dns_a_record_on_launch    = false
      [32m+[0m[0m enable_resource_name_dns_aaaa_record_on_launch = false
      [32m+[0m[0m id                                             = (known after apply)
      [32m+[0m[0m ipv6_cidr_block_association_id                 = (known after apply)
      [32m+[0m[0m ipv6_native                                    = false
      [32m+[0m[0m map_public_ip_on_launch                        = false
      [32m+[0m[0m owner_id                                       = (known after apply)
      [32m+[0m[0m private_dns_hostname_type_on_launch            = (known after apply)
      [32m+[0m[0m tags                                           = {
          [32m+[0m[0m "Enviroment" = "QA"
          [32m+[0m[0m "Name"       = "backend-subnet"
          [32m+[0m[0m "Owner"      = "shreya"
        }
      [32m+[0m[0m tags_all                                       = {
          [32m+[0m[0m "Enviroment" = "QA"
          [32m+[0m[0m "Name"       = "backend-subnet"
          [32m+[0m[0m "Owner"      = "shreya"
        }
      [32m+[0m[0m vpc_id                                         = (known after apply)
    }

[1m  # module.network.aws_subnet.dev_private_subnets[2][0m will be created
[0m  [32m+[0m[0m resource "aws_subnet" "dev_private_subnets" {
      [32m+[0m[0m arn                                            = (known after apply)
      [32m+[0m[0m assign_ipv6_address_on_creation                = false
      [32m+[0m[0m availability_zone                              = "us-east-2a"
      [32m+[0m[0m availability_zone_id                           = (known after apply)
      [32m+[0m[0m cidr_block                                     = "10.0.1.192/28"
      [32m+[0m[0m enable_dns64                                   = false
      [32m+[0m[0m enable_resource_name_dns_a_record_on_launch    = false
      [32m+[0m[0m enable_resource_name_dns_aaaa_record_on_launch = false
      [32m+[0m[0m id                                             = (known after apply)
      [32m+[0m[0m ipv6_cidr_block_association_id                 = (known after apply)
      [32m+[0m[0m ipv6_native                                    = false
      [32m+[0m[0m map_public_ip_on_launch                        = false
      [32m+[0m[0m owner_id                                       = (known after apply)
      [32m+[0m[0m private_dns_hostname_type_on_launch            = (known after apply)
      [32m+[0m[0m tags                                           = {
          [32m+[0m[0m "Enviroment" = "QA"
          [32m+[0m[0m "Name"       = "database-subnet"
          [32m+[0m[0m "Owner"      = "shreya"
        }
      [32m+[0m[0m tags_all                                       = {
          [32m+[0m[0m "Enviroment" = "QA"
          [32m+[0m[0m "Name"       = "database-subnet"
          [32m+[0m[0m "Owner"      = "shreya"
        }
      [32m+[0m[0m vpc_id                                         = (known after apply)
    }

[1m  # module.network.aws_subnet.dev_public_subnets[0][0m will be created
[0m  [32m+[0m[0m resource "aws_subnet" "dev_public_subnets" {
      [32m+[0m[0m arn                                            = (known after apply)
      [32m+[0m[0m assign_ipv6_address_on_creation                = false
      [32m+[0m[0m availability_zone                              = "us-east-2a"
      [32m+[0m[0m availability_zone_id                           = (known after apply)
      [32m+[0m[0m cidr_block                                     = "10.0.1.128/28"
      [32m+[0m[0m enable_dns64                                   = false
      [32m+[0m[0m enable_resource_name_dns_a_record_on_launch    = false
      [32m+[0m[0m enable_resource_name_dns_aaaa_record_on_launch = false
      [32m+[0m[0m id                                             = (known after apply)
      [32m+[0m[0m ipv6_cidr_block_association_id                 = (known after apply)
      [32m+[0m[0m ipv6_native                                    = false
      [32m+[0m[0m map_public_ip_on_launch                        = true
      [32m+[0m[0m owner_id                                       = (known after apply)
      [32m+[0m[0m private_dns_hostname_type_on_launch            = (known after apply)
      [32m+[0m[0m tags                                           = {
          [32m+[0m[0m "Enviroment" = "QA"
          [32m+[0m[0m "Name"       = "public-subnet-01"
          [32m+[0m[0m "Owner"      = "shreya"
        }
      [32m+[0m[0m tags_all                                       = {
          [32m+[0m[0m "Enviroment" = "QA"
          [32m+[0m[0m "Name"       = "public-subnet-01"
          [32m+[0m[0m "Owner"      = "shreya"
        }
      [32m+[0m[0m vpc_id                                         = (known after apply)
    }

[1m  # module.network.aws_subnet.dev_public_subnets[1][0m will be created
[0m  [32m+[0m[0m resource "aws_subnet" "dev_public_subnets" {
      [32m+[0m[0m arn                                            = (known after apply)
      [32m+[0m[0m assign_ipv6_address_on_creation                = false
      [32m+[0m[0m availability_zone                              = "us-east-2b"
      [32m+[0m[0m availability_zone_id                           = (known after apply)
      [32m+[0m[0m cidr_block                                     = "10.0.1.144/28"
      [32m+[0m[0m enable_dns64                                   = false
      [32m+[0m[0m enable_resource_name_dns_a_record_on_launch    = false
      [32m+[0m[0m enable_resource_name_dns_aaaa_record_on_launch = false
      [32m+[0m[0m id                                             = (known after apply)
      [32m+[0m[0m ipv6_cidr_block_association_id                 = (known after apply)
      [32m+[0m[0m ipv6_native                                    = false
      [32m+[0m[0m map_public_ip_on_launch                        = true
      [32m+[0m[0m owner_id                                       = (known after apply)
      [32m+[0m[0m private_dns_hostname_type_on_launch            = (known after apply)
      [32m+[0m[0m tags                                           = {
          [32m+[0m[0m "Enviroment" = "QA"
          [32m+[0m[0m "Name"       = "public-subnet-02"
          [32m+[0m[0m "Owner"      = "shreya"
        }
      [32m+[0m[0m tags_all                                       = {
          [32m+[0m[0m "Enviroment" = "QA"
          [32m+[0m[0m "Name"       = "public-subnet-02"
          [32m+[0m[0m "Owner"      = "shreya"
        }
      [32m+[0m[0m vpc_id                                         = (known after apply)
    }

[1m  # module.network.aws_vpc.dev_vpc[0m will be created
[0m  [32m+[0m[0m resource "aws_vpc" "dev_vpc" {
      [32m+[0m[0m arn                                  = (known after apply)
      [32m+[0m[0m cidr_block                           = "10.0.1.128/25"
      [32m+[0m[0m default_network_acl_id               = (known after apply)
      [32m+[0m[0m default_route_table_id               = (known after apply)
      [32m+[0m[0m default_security_group_id            = (known after apply)
      [32m+[0m[0m dhcp_options_id                      = (known after apply)
      [32m+[0m[0m enable_dns_hostnames                 = false
      [32m+[0m[0m enable_dns_support                   = true
      [32m+[0m[0m enable_network_address_usage_metrics = (known after apply)
      [32m+[0m[0m id                                   = (known after apply)
      [32m+[0m[0m instance_tenancy                     = "default"
      [32m+[0m[0m ipv6_association_id                  = (known after apply)
      [32m+[0m[0m ipv6_cidr_block                      = (known after apply)
      [32m+[0m[0m ipv6_cidr_block_network_border_group = (known after apply)
      [32m+[0m[0m main_route_table_id                  = (known after apply)
      [32m+[0m[0m owner_id                             = (known after apply)
      [32m+[0m[0m tags                                 = {
          [32m+[0m[0m "Enviroment" = "QA"
          [32m+[0m[0m "Name"       = "QA-vpc"
          [32m+[0m[0m "Owner"      = "shreya"
        }
      [32m+[0m[0m tags_all                             = {
          [32m+[0m[0m "Enviroment" = "QA"
          [32m+[0m[0m "Name"       = "QA-vpc"
          [32m+[0m[0m "Owner"      = "shreya"
        }
    }

[1mPlan:[0m 26 to add, 0 to change, 0 to destroy.
[0m
Changes to Outputs:
  [32m+[0m[0m alb-sg-id            = (known after apply)
  [32m+[0m[0m dev-alb-dns          = (known after apply)
  [32m+[0m[0m dev-backend-nacl-id  = (known after apply)
  [32m+[0m[0m dev-db-nacl-id       = (known after apply)
  [32m+[0m[0m dev-frontend-nacl-id = (known after apply)
  [32m+[0m[0m dev-igw-id           = (known after apply)
  [32m+[0m[0m dev-nat-id           = (known after apply)
  [32m+[0m[0m dev-private-RTB-id   = (known after apply)
  [32m+[0m[0m dev-public-RTB-id    = (known after apply)
  [32m+[0m[0m dev-route53-record   = "example.com"
  [32m+[0m[0m dev-route53-zone     = (known after apply)
  [32m+[0m[0m private-subnets-id   = [
      [32m+[0m[0m (known after apply),
      [32m+[0m[0m (known after apply),
      [32m+[0m[0m (known after apply),
    ]
  [32m+[0m[0m public-subnets-id    = [
      [32m+[0m[0m (known after apply),
      [32m+[0m[0m (known after apply),
    ]
  [32m+[0m[0m vpc-id               = (known after apply)
[90m
─────────────────────────────────────────────────────────────────────────────[0m

Note: You didn't use the -out option to save this plan, so Terraform can't
guarantee to take exactly these actions if you run "terraform apply" now.
[Pipeline] }
[Pipeline] // script
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Review and Approve Apply)
[Pipeline] input
Do you want to apply Terraform changes?
Proceed or Abort
Approved by Shikha Tripathi
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Review and Approve Destroy)
Stage "Review and Approve Destroy" skipped due to when conditional
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Apply or Destroy)
[Pipeline] script
[Pipeline] {
[Pipeline] sh
+ terraform apply -auto-approve

Terraform used the selected providers to generate the following execution
plan. Resource actions are indicated with the following symbols:
  [32m+[0m create[0m

Terraform will perform the following actions:

[1m  # module.network.aws_eip.dev_elastic_ip[0m will be created
[0m  [32m+[0m[0m resource "aws_eip" "dev_elastic_ip" {
      [32m+[0m[0m allocation_id        = (known after apply)
      [32m+[0m[0m association_id       = (known after apply)
      [32m+[0m[0m carrier_ip           = (known after apply)
      [32m+[0m[0m customer_owned_ip    = (known after apply)
      [32m+[0m[0m domain               = "vpc"
      [32m+[0m[0m id                   = (known after apply)
      [32m+[0m[0m instance             = (known after apply)
      [32m+[0m[0m network_border_group = (known after apply)
      [32m+[0m[0m network_interface    = (known after apply)
      [32m+[0m[0m private_dns          = (known after apply)
      [32m+[0m[0m private_ip           = (known after apply)
      [32m+[0m[0m public_dns           = (known after apply)
      [32m+[0m[0m public_ip            = (known after apply)
      [32m+[0m[0m public_ipv4_pool     = (known after apply)
      [32m+[0m[0m tags_all             = (known after apply)
      [32m+[0m[0m vpc                  = (known after apply)
    }

[1m  # module.network.aws_internet_gateway.dev_igw[0m will be created
[0m  [32m+[0m[0m resource "aws_internet_gateway" "dev_igw" {
      [32m+[0m[0m arn      = (known after apply)
      [32m+[0m[0m id       = (known after apply)
      [32m+[0m[0m owner_id = (known after apply)
      [32m+[0m[0m tags     = {
          [32m+[0m[0m "Enviroment" = "QA"
          [32m+[0m[0m "Name"       = "QA-igw-01"
          [32m+[0m[0m "Owner"      = "shreya"
        }
      [32m+[0m[0m tags_all = {
          [32m+[0m[0m "Enviroment" = "QA"
          [32m+[0m[0m "Name"       = "QA-igw-01"
          [32m+[0m[0m "Owner"      = "shreya"
        }
      [32m+[0m[0m vpc_id   = (known after apply)
    }

[1m  # module.network.aws_lb.dev_alb[0m will be created
[0m  [32m+[0m[0m resource "aws_lb" "dev_alb" {
      [32m+[0m[0m arn                                                          = (known after apply)
      [32m+[0m[0m arn_suffix                                                   = (known after apply)
      [32m+[0m[0m desync_mitigation_mode                                       = "defensive"
      [32m+[0m[0m dns_name                                                     = (known after apply)
      [32m+[0m[0m drop_invalid_header_fields                                   = false
      [32m+[0m[0m enable_deletion_protection                                   = false
      [32m+[0m[0m enable_http2                                                 = true
      [32m+[0m[0m enable_tls_version_and_cipher_suite_headers                  = false
      [32m+[0m[0m enable_waf_fail_open                                         = false
      [32m+[0m[0m enable_xff_client_port                                       = false
      [32m+[0m[0m enforce_security_group_inbound_rules_on_private_link_traffic = (known after apply)
      [32m+[0m[0m id                                                           = (known after apply)
      [32m+[0m[0m idle_timeout                                                 = 60
      [32m+[0m[0m internal                                                     = false
      [32m+[0m[0m ip_address_type                                              = (known after apply)
      [32m+[0m[0m load_balancer_type                                           = "application"
      [32m+[0m[0m name                                                         = "QA-alb"
      [32m+[0m[0m name_prefix                                                  = (known after apply)
      [32m+[0m[0m preserve_host_header                                         = false
      [32m+[0m[0m security_groups                                              = (known after apply)
      [32m+[0m[0m subnets                                                      = (known after apply)
      [32m+[0m[0m tags                                                         = {
          [32m+[0m[0m "Enviroment" = "QA"
          [32m+[0m[0m "Owner"      = "shreya"
        }
      [32m+[0m[0m tags_all                                                     = {
          [32m+[0m[0m "Enviroment" = "QA"
          [32m+[0m[0m "Owner"      = "shreya"
        }
      [32m+[0m[0m vpc_id                                                       = (known after apply)
      [32m+[0m[0m xff_header_processing_mode                                   = "append"
      [32m+[0m[0m zone_id                                                      = (known after apply)
    }

[1m  # module.network.aws_nat_gateway.dev_nat[0m will be created
[0m  [32m+[0m[0m resource "aws_nat_gateway" "dev_nat" {
      [32m+[0m[0m allocation_id                      = (known after apply)
      [32m+[0m[0m association_id                     = (known after apply)
      [32m+[0m[0m connectivity_type                  = "public"
      [32m+[0m[0m id                                 = (known after apply)
      [32m+[0m[0m network_interface_id               = (known after apply)
      [32m+[0m[0m private_ip                         = (known after apply)
      [32m+[0m[0m public_ip                          = (known after apply)
      [32m+[0m[0m secondary_private_ip_address_count = (known after apply)
      [32m+[0m[0m secondary_private_ip_addresses     = (known after apply)
      [32m+[0m[0m subnet_id                          = (known after apply)
      [32m+[0m[0m tags                               = {
          [32m+[0m[0m "Enviroment" = "QA"
          [32m+[0m[0m "Name"       = "QA-nat-01"
          [32m+[0m[0m "Owner"      = "shreya"
        }
      [32m+[0m[0m tags_all                           = {
          [32m+[0m[0m "Enviroment" = "QA"
          [32m+[0m[0m "Name"       = "QA-nat-01"
          [32m+[0m[0m "Owner"      = "shreya"
        }
    }

[1m  # module.network.aws_network_acl.dev_backend_nacl[0m will be created
[0m  [32m+[0m[0m resource "aws_network_acl" "dev_backend_nacl" {
      [32m+[0m[0m arn        = (known after apply)
      [32m+[0m[0m egress     = [
          [32m+[0m[0m {
              [32m+[0m[0m action          = "allow"
              [32m+[0m[0m cidr_block      = "10.0.1.128/28"
              [32m+[0m[0m from_port       = 1024
              [32m+[0m[0m ipv6_cidr_block = ""
              [32m+[0m[0m protocol        = "tcp"
              [32m+[0m[0m rule_no         = 140
              [32m+[0m[0m to_port         = 65535
            },
          [32m+[0m[0m {
              [32m+[0m[0m action          = "allow"
              [32m+[0m[0m cidr_block      = "10.0.1.144/28"
              [32m+[0m[0m from_port       = 1024
              [32m+[0m[0m ipv6_cidr_block = ""
              [32m+[0m[0m protocol        = "tcp"
              [32m+[0m[0m rule_no         = 130
              [32m+[0m[0m to_port         = 65535
            },
          [32m+[0m[0m {
              [32m+[0m[0m action          = "allow"
              [32m+[0m[0m cidr_block      = "10.0.1.192/28"
              [32m+[0m[0m from_port       = 1024
              [32m+[0m[0m ipv6_cidr_block = ""
              [32m+[0m[0m protocol        = "tcp"
              [32m+[0m[0m rule_no         = 110
              [32m+[0m[0m to_port         = 65535
            },
          [32m+[0m[0m {
              [32m+[0m[0m action          = "allow"
              [32m+[0m[0m cidr_block      = "20.0.0.0/28"
              [32m+[0m[0m from_port       = 1024
              [32m+[0m[0m ipv6_cidr_block = ""
              [32m+[0m[0m protocol        = "tcp"
              [32m+[0m[0m rule_no         = 120
              [32m+[0m[0m to_port         = 65535
            },
          [32m+[0m[0m {
              [32m+[0m[0m action          = "allow"
              [32m+[0m[0m cidr_block      = "20.0.0.0/28"
              [32m+[0m[0m from_port       = 22
              [32m+[0m[0m ipv6_cidr_block = ""
              [32m+[0m[0m protocol        = "tcp"
              [32m+[0m[0m rule_no         = 100
              [32m+[0m[0m to_port         = 22
            },
        ]
      [32m+[0m[0m id         = (known after apply)
      [32m+[0m[0m ingress    = [
          [32m+[0m[0m {
              [32m+[0m[0m action          = "allow"
              [32m+[0m[0m cidr_block      = "10.0.1.128/28"
              [32m+[0m[0m from_port       = 1024
              [32m+[0m[0m ipv6_cidr_block = ""
              [32m+[0m[0m protocol        = "tcp"
              [32m+[0m[0m rule_no         = 150
              [32m+[0m[0m to_port         = 65535
            },
          [32m+[0m[0m {
              [32m+[0m[0m action          = "allow"
              [32m+[0m[0m cidr_block      = "10.0.1.128/28"
              [32m+[0m[0m from_port       = 22
              [32m+[0m[0m ipv6_cidr_block = ""
              [32m+[0m[0m protocol        = "tcp"
              [32m+[0m[0m rule_no         = 140
              [32m+[0m[0m to_port         = 22
            },
          [32m+[0m[0m {
              [32m+[0m[0m action          = "allow"
              [32m+[0m[0m cidr_block      = "10.0.1.128/28"
              [32m+[0m[0m from_port       = 8080
              [32m+[0m[0m ipv6_cidr_block = ""
              [32m+[0m[0m protocol        = "tcp"
              [32m+[0m[0m rule_no         = 110
              [32m+[0m[0m to_port         = 8080
            },
          [32m+[0m[0m {
              [32m+[0m[0m action          = "allow"
              [32m+[0m[0m cidr_block      = "10.0.1.144/28"
              [32m+[0m[0m from_port       = 1024
              [32m+[0m[0m ipv6_cidr_block = ""
              [32m+[0m[0m protocol        = "tcp"
              [32m+[0m[0m rule_no         = 130
              [32m+[0m[0m to_port         = 65535
            },
          [32m+[0m[0m {
              [32m+[0m[0m action          = "allow"
              [32m+[0m[0m cidr_block      = "10.0.1.144/28"
              [32m+[0m[0m from_port       = 8080
              [32m+[0m[0m ipv6_cidr_block = ""
              [32m+[0m[0m protocol        = "tcp"
              [32m+[0m[0m rule_no         = 160
              [32m+[0m[0m to_port         = 8080
            },
          [32m+[0m[0m {
              [32m+[0m[0m action          = "allow"
              [32m+[0m[0m cidr_block      = "10.0.1.192/28"
              [32m+[0m[0m from_port       = 1024
              [32m+[0m[0m ipv6_cidr_block = ""
              [32m+[0m[0m protocol        = "tcp"
              [32m+[0m[0m rule_no         = 120
              [32m+[0m[0m to_port         = 65535
            },
          [32m+[0m[0m {
              [32m+[0m[0m action          = "allow"
              [32m+[0m[0m cidr_block      = "20.0.0.0/28"
              [32m+[0m[0m from_port       = 22
              [32m+[0m[0m ipv6_cidr_block = ""
              [32m+[0m[0m protocol        = "tcp"
              [32m+[0m[0m rule_no         = 100
              [32m+[0m[0m to_port         = 22
            },
        ]
      [32m+[0m[0m owner_id   = (known after apply)
      [32m+[0m[0m subnet_ids = (known after apply)
      [32m+[0m[0m tags       = {
          [32m+[0m[0m "Enviroment" = "QA"
          [32m+[0m[0m "Name"       = "QA-backend-nacl-01"
          [32m+[0m[0m "Owner"      = "shreya"
        }
      [32m+[0m[0m tags_all   = {
          [32m+[0m[0m "Enviroment" = "QA"
          [32m+[0m[0m "Name"       = "QA-backend-nacl-01"
          [32m+[0m[0m "Owner"      = "shreya"
        }
      [32m+[0m[0m vpc_id     = (known after apply)
    }

[1m  # module.network.aws_network_acl.dev_db_nacl[0m will be created
[0m  [32m+[0m[0m resource "aws_network_acl" "dev_db_nacl" {
      [32m+[0m[0m arn        = (known after apply)
      [32m+[0m[0m egress     = [
          [32m+[0m[0m {
              [32m+[0m[0m action          = "allow"
              [32m+[0m[0m cidr_block      = "10.0.1.128/28"
              [32m+[0m[0m from_port       = 1024
              [32m+[0m[0m ipv6_cidr_block = ""
              [32m+[0m[0m protocol        = "tcp"
              [32m+[0m[0m rule_no         = 120
              [32m+[0m[0m to_port         = 65535
            },
          [32m+[0m[0m {
              [32m+[0m[0m action          = "allow"
              [32m+[0m[0m cidr_block      = "10.0.1.176/28"
              [32m+[0m[0m from_port       = 1024
              [32m+[0m[0m ipv6_cidr_block = ""
              [32m+[0m[0m protocol        = "tcp"
              [32m+[0m[0m rule_no         = 110
              [32m+[0m[0m to_port         = 65535
            },
          [32m+[0m[0m {
              [32m+[0m[0m action          = "allow"
              [32m+[0m[0m cidr_block      = "20.0.0.0/28"
              [32m+[0m[0m from_port       = 1024
              [32m+[0m[0m ipv6_cidr_block = ""
              [32m+[0m[0m protocol        = "tcp"
              [32m+[0m[0m rule_no         = 100
              [32m+[0m[0m to_port         = 65535
            },
        ]
      [32m+[0m[0m id         = (known after apply)
      [32m+[0m[0m ingress    = [
          [32m+[0m[0m {
              [32m+[0m[0m action          = "allow"
              [32m+[0m[0m cidr_block      = "10.0.1.128/28"
              [32m+[0m[0m from_port       = 22
              [32m+[0m[0m ipv6_cidr_block = ""
              [32m+[0m[0m protocol        = "tcp"
              [32m+[0m[0m rule_no         = 110
              [32m+[0m[0m to_port         = 22
            },
          [32m+[0m[0m {
              [32m+[0m[0m action          = "allow"
              [32m+[0m[0m cidr_block      = "10.0.1.176/28"
              [32m+[0m[0m from_port       = 5432
              [32m+[0m[0m ipv6_cidr_block = ""
              [32m+[0m[0m protocol        = "tcp"
              [32m+[0m[0m rule_no         = 140
              [32m+[0m[0m to_port         = 5432
            },
          [32m+[0m[0m {
              [32m+[0m[0m action          = "allow"
              [32m+[0m[0m cidr_block      = "10.0.1.176/28"
              [32m+[0m[0m from_port       = 6379
              [32m+[0m[0m ipv6_cidr_block = ""
              [32m+[0m[0m protocol        = "tcp"
              [32m+[0m[0m rule_no         = 120
              [32m+[0m[0m to_port         = 6379
            },
          [32m+[0m[0m {
              [32m+[0m[0m action          = "allow"
              [32m+[0m[0m cidr_block      = "10.0.1.176/28"
              [32m+[0m[0m from_port       = 9042
              [32m+[0m[0m ipv6_cidr_block = ""
              [32m+[0m[0m protocol        = "tcp"
              [32m+[0m[0m rule_no         = 130
              [32m+[0m[0m to_port         = 9042
            },
          [32m+[0m[0m {
              [32m+[0m[0m action          = "allow"
              [32m+[0m[0m cidr_block      = "20.0.0.0/28"
              [32m+[0m[0m from_port       = 22
              [32m+[0m[0m ipv6_cidr_block = ""
              [32m+[0m[0m protocol        = "tcp"
              [32m+[0m[0m rule_no         = 100
              [32m+[0m[0m to_port         = 22
            },
        ]
      [32m+[0m[0m owner_id   = (known after apply)
      [32m+[0m[0m subnet_ids = (known after apply)
      [32m+[0m[0m tags       = {
          [32m+[0m[0m "Enviroment" = "QA"
          [32m+[0m[0m "Name"       = "QA-db-nacl-01"
          [32m+[0m[0m "Owner"      = "shreya"
        }
      [32m+[0m[0m tags_all   = {
          [32m+[0m[0m "Enviroment" = "QA"
          [32m+[0m[0m "Name"       = "QA-db-nacl-01"
          [32m+[0m[0m "Owner"      = "shreya"
        }
      [32m+[0m[0m vpc_id     = (known after apply)
    }

[1m  # module.network.aws_network_acl.dev_frontend_nacl[0m will be created
[0m  [32m+[0m[0m resource "aws_network_acl" "dev_frontend_nacl" {
      [32m+[0m[0m arn        = (known after apply)
      [32m+[0m[0m egress     = [
          [32m+[0m[0m {
              [32m+[0m[0m action          = "allow"
              [32m+[0m[0m cidr_block      = "10.0.1.128/28"
              [32m+[0m[0m from_port       = 1024
              [32m+[0m[0m ipv6_cidr_block = ""
              [32m+[0m[0m protocol        = "tcp"
              [32m+[0m[0m rule_no         = 110
              [32m+[0m[0m to_port         = 65535
            },
          [32m+[0m[0m {
              [32m+[0m[0m action          = "allow"
              [32m+[0m[0m cidr_block      = "10.0.1.144/28"
              [32m+[0m[0m from_port       = 1024
              [32m+[0m[0m ipv6_cidr_block = ""
              [32m+[0m[0m protocol        = "tcp"
              [32m+[0m[0m rule_no         = 120
              [32m+[0m[0m to_port         = 65535
            },
          [32m+[0m[0m {
              [32m+[0m[0m action          = "allow"
              [32m+[0m[0m cidr_block      = "20.0.0.0/28"
              [32m+[0m[0m from_port       = 1024
              [32m+[0m[0m ipv6_cidr_block = ""
              [32m+[0m[0m protocol        = "tcp"
              [32m+[0m[0m rule_no         = 100
              [32m+[0m[0m to_port         = 65535
            },
        ]
      [32m+[0m[0m id         = (known after apply)
      [32m+[0m[0m ingress    = [
          [32m+[0m[0m {
              [32m+[0m[0m action          = "allow"
              [32m+[0m[0m cidr_block      = "10.0.1.128/28"
              [32m+[0m[0m from_port       = 22
              [32m+[0m[0m ipv6_cidr_block = ""
              [32m+[0m[0m protocol        = "tcp"
              [32m+[0m[0m rule_no         = 120
              [32m+[0m[0m to_port         = 22
            },
          [32m+[0m[0m {
              [32m+[0m[0m action          = "allow"
              [32m+[0m[0m cidr_block      = "10.0.1.128/28"
              [32m+[0m[0m from_port       = 3000
              [32m+[0m[0m ipv6_cidr_block = ""
              [32m+[0m[0m protocol        = "tcp"
              [32m+[0m[0m rule_no         = 110
              [32m+[0m[0m to_port         = 3000
            },
          [32m+[0m[0m {
              [32m+[0m[0m action          = "allow"
              [32m+[0m[0m cidr_block      = "10.0.1.144/28"
              [32m+[0m[0m from_port       = 3000
              [32m+[0m[0m ipv6_cidr_block = ""
              [32m+[0m[0m protocol        = "tcp"
              [32m+[0m[0m rule_no         = 130
              [32m+[0m[0m to_port         = 3000
            },
          [32m+[0m[0m {
              [32m+[0m[0m action          = "allow"
              [32m+[0m[0m cidr_block      = "20.0.0.0/28"
              [32m+[0m[0m from_port       = 22
              [32m+[0m[0m ipv6_cidr_block = ""
              [32m+[0m[0m protocol        = "tcp"
              [32m+[0m[0m rule_no         = 100
              [32m+[0m[0m to_port         = 22
            },
        ]
      [32m+[0m[0m owner_id   = (known after apply)
      [32m+[0m[0m subnet_ids = (known after apply)
      [32m+[0m[0m tags       = {
          [32m+[0m[0m "Enviroment" = "QA"
          [32m+[0m[0m "Name"       = "QA-frontend-nacl-01"
          [32m+[0m[0m "Owner"      = "shreya"
        }
      [32m+[0m[0m tags_all   = {
          [32m+[0m[0m "Enviroment" = "QA"
          [32m+[0m[0m "Name"       = "QA-frontend-nacl-01"
          [32m+[0m[0m "Owner"      = "shreya"
        }
      [32m+[0m[0m vpc_id     = (known after apply)
    }

[1m  # module.network.aws_network_acl_association.dev_backend_nacl_assc[0m will be created
[0m  [32m+[0m[0m resource "aws_network_acl_association" "dev_backend_nacl_assc" {
      [32m+[0m[0m id             = (known after apply)
      [32m+[0m[0m network_acl_id = (known after apply)
      [32m+[0m[0m subnet_id      = (known after apply)
    }

[1m  # module.network.aws_network_acl_association.dev_db_nacl_assc[0m will be created
[0m  [32m+[0m[0m resource "aws_network_acl_association" "dev_db_nacl_assc" {
      [32m+[0m[0m id             = (known after apply)
      [32m+[0m[0m network_acl_id = (known after apply)
      [32m+[0m[0m subnet_id      = (known after apply)
    }

[1m  # module.network.aws_network_acl_association.dev_frontend_nacl[0m will be created
[0m  [32m+[0m[0m resource "aws_network_acl_association" "dev_frontend_nacl" {
      [32m+[0m[0m id             = (known after apply)
      [32m+[0m[0m network_acl_id = (known after apply)
      [32m+[0m[0m subnet_id      = (known after apply)
    }

[1m  # module.network.aws_route53_record.dev_route53_record[0m will be created
[0m  [32m+[0m[0m resource "aws_route53_record" "dev_route53_record" {
      [32m+[0m[0m allow_overwrite = (known after apply)
      [32m+[0m[0m fqdn            = (known after apply)
      [32m+[0m[0m id              = (known after apply)
      [32m+[0m[0m name            = "example.com"
      [32m+[0m[0m type            = "A"
      [32m+[0m[0m zone_id         = (known after apply)

      [32m+[0m[0m alias {
          [32m+[0m[0m evaluate_target_health = true
          [32m+[0m[0m name                   = (known after apply)
          [32m+[0m[0m zone_id                = (known after apply)
        }
    }

[1m  # module.network.aws_route53_zone.dev_route53_zone[0m will be created
[0m  [32m+[0m[0m resource "aws_route53_zone" "dev_route53_zone" {
      [32m+[0m[0m arn                 = (known after apply)
      [32m+[0m[0m comment             = "Managed by Terraform"
      [32m+[0m[0m force_destroy       = false
      [32m+[0m[0m id                  = (known after apply)
      [32m+[0m[0m name                = "example.com"
      [32m+[0m[0m name_servers        = (known after apply)
      [32m+[0m[0m primary_name_server = (known after apply)
      [32m+[0m[0m tags                = {
          [32m+[0m[0m "Enviroment" = "QA"
          [32m+[0m[0m "Owner"      = "shreya"
        }
      [32m+[0m[0m tags_all            = {
          [32m+[0m[0m "Enviroment" = "QA"
          [32m+[0m[0m "Owner"      = "shreya"
        }
      [32m+[0m[0m zone_id             = (known after apply)

      [32m+[0m[0m vpc {
          [32m+[0m[0m vpc_id     = (known after apply)
          [32m+[0m[0m vpc_region = "us-east-2"
        }
    }

[1m  # module.network.aws_route_table.dev_private_rtb[0m will be created
[0m  [32m+[0m[0m resource "aws_route_table" "dev_private_rtb" {
      [32m+[0m[0m arn              = (known after apply)
      [32m+[0m[0m id               = (known after apply)
      [32m+[0m[0m owner_id         = (known after apply)
      [32m+[0m[0m propagating_vgws = (known after apply)
      [32m+[0m[0m route            = [
          [32m+[0m[0m {
              [32m+[0m[0m carrier_gateway_id         = ""
              [32m+[0m[0m cidr_block                 = "0.0.0.0/0"
              [32m+[0m[0m core_network_arn           = ""
              [32m+[0m[0m destination_prefix_list_id = ""
              [32m+[0m[0m egress_only_gateway_id     = ""
              [32m+[0m[0m gateway_id                 = ""
              [32m+[0m[0m ipv6_cidr_block            = ""
              [32m+[0m[0m local_gateway_id           = ""
              [32m+[0m[0m nat_gateway_id             = (known after apply)
              [32m+[0m[0m network_interface_id       = ""
              [32m+[0m[0m transit_gateway_id         = ""
              [32m+[0m[0m vpc_endpoint_id            = ""
              [32m+[0m[0m vpc_peering_connection_id  = ""
            },
          [32m+[0m[0m {
              [32m+[0m[0m carrier_gateway_id         = ""
              [32m+[0m[0m cidr_block                 = "10.0.1.128/25"
              [32m+[0m[0m core_network_arn           = ""
              [32m+[0m[0m destination_prefix_list_id = ""
              [32m+[0m[0m egress_only_gateway_id     = ""
              [32m+[0m[0m gateway_id                 = "local"
              [32m+[0m[0m ipv6_cidr_block            = ""
              [32m+[0m[0m local_gateway_id           = ""
              [32m+[0m[0m nat_gateway_id             = ""
              [32m+[0m[0m network_interface_id       = ""
              [32m+[0m[0m transit_gateway_id         = ""
              [32m+[0m[0m vpc_endpoint_id            = ""
              [32m+[0m[0m vpc_peering_connection_id  = ""
            },
        ]
      [32m+[0m[0m tags             = {
          [32m+[0m[0m "Enviroment" = "QA"
          [32m+[0m[0m "Name"       = "QA-private-RTB-01"
          [32m+[0m[0m "Owner"      = "shreya"
        }
      [32m+[0m[0m tags_all         = {
          [32m+[0m[0m "Enviroment" = "QA"
          [32m+[0m[0m "Name"       = "QA-private-RTB-01"
          [32m+[0m[0m "Owner"      = "shreya"
        }
      [32m+[0m[0m vpc_id           = (known after apply)
    }

[1m  # module.network.aws_route_table.dev_public_rtb[0m will be created
[0m  [32m+[0m[0m resource "aws_route_table" "dev_public_rtb" {
      [32m+[0m[0m arn              = (known after apply)
      [32m+[0m[0m id               = (known after apply)
      [32m+[0m[0m owner_id         = (known after apply)
      [32m+[0m[0m propagating_vgws = (known after apply)
      [32m+[0m[0m route            = [
          [32m+[0m[0m {
              [32m+[0m[0m carrier_gateway_id         = ""
              [32m+[0m[0m cidr_block                 = "0.0.0.0/0"
              [32m+[0m[0m core_network_arn           = ""
              [32m+[0m[0m destination_prefix_list_id = ""
              [32m+[0m[0m egress_only_gateway_id     = ""
              [32m+[0m[0m gateway_id                 = (known after apply)
              [32m+[0m[0m ipv6_cidr_block            = ""
              [32m+[0m[0m local_gateway_id           = ""
              [32m+[0m[0m nat_gateway_id             = ""
              [32m+[0m[0m network_interface_id       = ""
              [32m+[0m[0m transit_gateway_id         = ""
              [32m+[0m[0m vpc_endpoint_id            = ""
              [32m+[0m[0m vpc_peering_connection_id  = ""
            },
          [32m+[0m[0m {
              [32m+[0m[0m carrier_gateway_id         = ""
              [32m+[0m[0m cidr_block                 = "10.0.1.128/25"
              [32m+[0m[0m core_network_arn           = ""
              [32m+[0m[0m destination_prefix_list_id = ""
              [32m+[0m[0m egress_only_gateway_id     = ""
              [32m+[0m[0m gateway_id                 = "local"
              [32m+[0m[0m ipv6_cidr_block            = ""
              [32m+[0m[0m local_gateway_id           = ""
              [32m+[0m[0m nat_gateway_id             = ""
              [32m+[0m[0m network_interface_id       = ""
              [32m+[0m[0m transit_gateway_id         = ""
              [32m+[0m[0m vpc_endpoint_id            = ""
              [32m+[0m[0m vpc_peering_connection_id  = ""
            },
        ]
      [32m+[0m[0m tags             = {
          [32m+[0m[0m "Enviroment" = "QA"
          [32m+[0m[0m "Name"       = "QA-public-RTB-01"
          [32m+[0m[0m "Owner"      = "shreya"
        }
      [32m+[0m[0m tags_all         = {
          [32m+[0m[0m "Enviroment" = "QA"
          [32m+[0m[0m "Name"       = "QA-public-RTB-01"
          [32m+[0m[0m "Owner"      = "shreya"
        }
      [32m+[0m[0m vpc_id           = (known after apply)
    }

[1m  # module.network.aws_route_table_association.dev_private_route_association01[0][0m will be created
[0m  [32m+[0m[0m resource "aws_route_table_association" "dev_private_route_association01" {
      [32m+[0m[0m id             = (known after apply)
      [32m+[0m[0m route_table_id = (known after apply)
      [32m+[0m[0m subnet_id      = (known after apply)
    }

[1m  # module.network.aws_route_table_association.dev_private_route_association01[1][0m will be created
[0m  [32m+[0m[0m resource "aws_route_table_association" "dev_private_route_association01" {
      [32m+[0m[0m id             = (known after apply)
      [32m+[0m[0m route_table_id = (known after apply)
      [32m+[0m[0m subnet_id      = (known after apply)
    }

[1m  # module.network.aws_route_table_association.dev_private_route_association01[2][0m will be created
[0m  [32m+[0m[0m resource "aws_route_table_association" "dev_private_route_association01" {
      [32m+[0m[0m id             = (known after apply)
      [32m+[0m[0m route_table_id = (known after apply)
      [32m+[0m[0m subnet_id      = (known after apply)
    }

[1m  # module.network.aws_route_table_association.dev_public_route_association01[0][0m will be created
[0m  [32m+[0m[0m resource "aws_route_table_association" "dev_public_route_association01" {
      [32m+[0m[0m id             = (known after apply)
      [32m+[0m[0m route_table_id = (known after apply)
      [32m+[0m[0m subnet_id      = (known after apply)
    }

[1m  # module.network.aws_route_table_association.dev_public_route_association01[1][0m will be created
[0m  [32m+[0m[0m resource "aws_route_table_association" "dev_public_route_association01" {
      [32m+[0m[0m id             = (known after apply)
      [32m+[0m[0m route_table_id = (known after apply)
      [32m+[0m[0m subnet_id      = (known after apply)
    }

[1m  # module.network.aws_security_group.dev_alb_sg[0m will be created
[0m  [32m+[0m[0m resource "aws_security_group" "dev_alb_sg" {
      [32m+[0m[0m arn                    = (known after apply)
      [32m+[0m[0m description            = "Security group for QA-ALB"
      [32m+[0m[0m egress                 = [
          [32m+[0m[0m {
              [32m+[0m[0m cidr_blocks      = [
                  [32m+[0m[0m "0.0.0.0/0",
                ]
              [32m+[0m[0m description      = ""
              [32m+[0m[0m from_port        = 0
              [32m+[0m[0m ipv6_cidr_blocks = []
              [32m+[0m[0m prefix_list_ids  = []
              [32m+[0m[0m protocol         = "-1"
              [32m+[0m[0m security_groups  = []
              [32m+[0m[0m self             = false
              [32m+[0m[0m to_port          = 0
            },
        ]
      [32m+[0m[0m id                     = (known after apply)
      [32m+[0m[0m ingress                = [
          [32m+[0m[0m {
              [32m+[0m[0m cidr_blocks      = [
                  [32m+[0m[0m "0.0.0.0/0",
                ]
              [32m+[0m[0m description      = ""
              [32m+[0m[0m from_port        = 443
              [32m+[0m[0m ipv6_cidr_blocks = []
              [32m+[0m[0m prefix_list_ids  = []
              [32m+[0m[0m protocol         = "tcp"
              [32m+[0m[0m security_groups  = []
              [32m+[0m[0m self             = false
              [32m+[0m[0m to_port          = 443
            },
          [32m+[0m[0m {
              [32m+[0m[0m cidr_blocks      = [
                  [32m+[0m[0m "0.0.0.0/0",
                ]
              [32m+[0m[0m description      = ""
              [32m+[0m[0m from_port        = 80
              [32m+[0m[0m ipv6_cidr_blocks = []
              [32m+[0m[0m prefix_list_ids  = []
              [32m+[0m[0m protocol         = "tcp"
              [32m+[0m[0m security_groups  = []
              [32m+[0m[0m self             = false
              [32m+[0m[0m to_port          = 80
            },
        ]
      [32m+[0m[0m name                   = "QA-alb-sg"
      [32m+[0m[0m name_prefix            = (known after apply)
      [32m+[0m[0m owner_id               = (known after apply)
      [32m+[0m[0m revoke_rules_on_delete = false
      [32m+[0m[0m tags                   = {
          [32m+[0m[0m "Enviroment" = "QA"
          [32m+[0m[0m "Owner"      = "shreya"
        }
      [32m+[0m[0m tags_all               = {
          [32m+[0m[0m "Enviroment" = "QA"
          [32m+[0m[0m "Owner"      = "shreya"
        }
      [32m+[0m[0m vpc_id                 = (known after apply)
    }

[1m  # module.network.aws_subnet.dev_private_subnets[0][0m will be created
[0m  [32m+[0m[0m resource "aws_subnet" "dev_private_subnets" {
      [32m+[0m[0m arn                                            = (known after apply)
      [32m+[0m[0m assign_ipv6_address_on_creation                = false
      [32m+[0m[0m availability_zone                              = "us-east-2a"
      [32m+[0m[0m availability_zone_id                           = (known after apply)
      [32m+[0m[0m cidr_block                                     = "10.0.1.160/28"
      [32m+[0m[0m enable_dns64                                   = false
      [32m+[0m[0m enable_resource_name_dns_a_record_on_launch    = false
      [32m+[0m[0m enable_resource_name_dns_aaaa_record_on_launch = false
      [32m+[0m[0m id                                             = (known after apply)
      [32m+[0m[0m ipv6_cidr_block_association_id                 = (known after apply)
      [32m+[0m[0m ipv6_native                                    = false
      [32m+[0m[0m map_public_ip_on_launch                        = false
      [32m+[0m[0m owner_id                                       = (known after apply)
      [32m+[0m[0m private_dns_hostname_type_on_launch            = (known after apply)
      [32m+[0m[0m tags                                           = {
          [32m+[0m[0m "Enviroment" = "QA"
          [32m+[0m[0m "Name"       = "frontend-subnet"
          [32m+[0m[0m "Owner"      = "shreya"
        }
      [32m+[0m[0m tags_all                                       = {
          [32m+[0m[0m "Enviroment" = "QA"
          [32m+[0m[0m "Name"       = "frontend-subnet"
          [32m+[0m[0m "Owner"      = "shreya"
        }
      [32m+[0m[0m vpc_id                                         = (known after apply)
    }

[1m  # module.network.aws_subnet.dev_private_subnets[1][0m will be created
[0m  [32m+[0m[0m resource "aws_subnet" "dev_private_subnets" {
      [32m+[0m[0m arn                                            = (known after apply)
      [32m+[0m[0m assign_ipv6_address_on_creation                = false
      [32m+[0m[0m availability_zone                              = "us-east-2a"
      [32m+[0m[0m availability_zone_id                           = (known after apply)
      [32m+[0m[0m cidr_block                                     = "10.0.1.176/28"
      [32m+[0m[0m enable_dns64                                   = false
      [32m+[0m[0m enable_resource_name_dns_a_record_on_launch    = false
      [32m+[0m[0m enable_resource_name_dns_aaaa_record_on_launch = false
      [32m+[0m[0m id                                             = (known after apply)
      [32m+[0m[0m ipv6_cidr_block_association_id                 = (known after apply)
      [32m+[0m[0m ipv6_native                                    = false
      [32m+[0m[0m map_public_ip_on_launch                        = false
      [32m+[0m[0m owner_id                                       = (known after apply)
      [32m+[0m[0m private_dns_hostname_type_on_launch            = (known after apply)
      [32m+[0m[0m tags                                           = {
          [32m+[0m[0m "Enviroment" = "QA"
          [32m+[0m[0m "Name"       = "backend-subnet"
          [32m+[0m[0m "Owner"      = "shreya"
        }
      [32m+[0m[0m tags_all                                       = {
          [32m+[0m[0m "Enviroment" = "QA"
          [32m+[0m[0m "Name"       = "backend-subnet"
          [32m+[0m[0m "Owner"      = "shreya"
        }
      [32m+[0m[0m vpc_id                                         = (known after apply)
    }

[1m  # module.network.aws_subnet.dev_private_subnets[2][0m will be created
[0m  [32m+[0m[0m resource "aws_subnet" "dev_private_subnets" {
      [32m+[0m[0m arn                                            = (known after apply)
      [32m+[0m[0m assign_ipv6_address_on_creation                = false
      [32m+[0m[0m availability_zone                              = "us-east-2a"
      [32m+[0m[0m availability_zone_id                           = (known after apply)
      [32m+[0m[0m cidr_block                                     = "10.0.1.192/28"
      [32m+[0m[0m enable_dns64                                   = false
      [32m+[0m[0m enable_resource_name_dns_a_record_on_launch    = false
      [32m+[0m[0m enable_resource_name_dns_aaaa_record_on_launch = false
      [32m+[0m[0m id                                             = (known after apply)
      [32m+[0m[0m ipv6_cidr_block_association_id                 = (known after apply)
      [32m+[0m[0m ipv6_native                                    = false
      [32m+[0m[0m map_public_ip_on_launch                        = false
      [32m+[0m[0m owner_id                                       = (known after apply)
      [32m+[0m[0m private_dns_hostname_type_on_launch            = (known after apply)
      [32m+[0m[0m tags                                           = {
          [32m+[0m[0m "Enviroment" = "QA"
          [32m+[0m[0m "Name"       = "database-subnet"
          [32m+[0m[0m "Owner"      = "shreya"
        }
      [32m+[0m[0m tags_all                                       = {
          [32m+[0m[0m "Enviroment" = "QA"
          [32m+[0m[0m "Name"       = "database-subnet"
          [32m+[0m[0m "Owner"      = "shreya"
        }
      [32m+[0m[0m vpc_id                                         = (known after apply)
    }

[1m  # module.network.aws_subnet.dev_public_subnets[0][0m will be created
[0m  [32m+[0m[0m resource "aws_subnet" "dev_public_subnets" {
      [32m+[0m[0m arn                                            = (known after apply)
      [32m+[0m[0m assign_ipv6_address_on_creation                = false
      [32m+[0m[0m availability_zone                              = "us-east-2a"
      [32m+[0m[0m availability_zone_id                           = (known after apply)
      [32m+[0m[0m cidr_block                                     = "10.0.1.128/28"
      [32m+[0m[0m enable_dns64                                   = false
      [32m+[0m[0m enable_resource_name_dns_a_record_on_launch    = false
      [32m+[0m[0m enable_resource_name_dns_aaaa_record_on_launch = false
      [32m+[0m[0m id                                             = (known after apply)
      [32m+[0m[0m ipv6_cidr_block_association_id                 = (known after apply)
      [32m+[0m[0m ipv6_native                                    = false
      [32m+[0m[0m map_public_ip_on_launch                        = true
      [32m+[0m[0m owner_id                                       = (known after apply)
      [32m+[0m[0m private_dns_hostname_type_on_launch            = (known after apply)
      [32m+[0m[0m tags                                           = {
          [32m+[0m[0m "Enviroment" = "QA"
          [32m+[0m[0m "Name"       = "public-subnet-01"
          [32m+[0m[0m "Owner"      = "shreya"
        }
      [32m+[0m[0m tags_all                                       = {
          [32m+[0m[0m "Enviroment" = "QA"
          [32m+[0m[0m "Name"       = "public-subnet-01"
          [32m+[0m[0m "Owner"      = "shreya"
        }
      [32m+[0m[0m vpc_id                                         = (known after apply)
    }

[1m  # module.network.aws_subnet.dev_public_subnets[1][0m will be created
[0m  [32m+[0m[0m resource "aws_subnet" "dev_public_subnets" {
      [32m+[0m[0m arn                                            = (known after apply)
      [32m+[0m[0m assign_ipv6_address_on_creation                = false
      [32m+[0m[0m availability_zone                              = "us-east-2b"
      [32m+[0m[0m availability_zone_id                           = (known after apply)
      [32m+[0m[0m cidr_block                                     = "10.0.1.144/28"
      [32m+[0m[0m enable_dns64                                   = false
      [32m+[0m[0m enable_resource_name_dns_a_record_on_launch    = false
      [32m+[0m[0m enable_resource_name_dns_aaaa_record_on_launch = false
      [32m+[0m[0m id                                             = (known after apply)
      [32m+[0m[0m ipv6_cidr_block_association_id                 = (known after apply)
      [32m+[0m[0m ipv6_native                                    = false
      [32m+[0m[0m map_public_ip_on_launch                        = true
      [32m+[0m[0m owner_id                                       = (known after apply)
      [32m+[0m[0m private_dns_hostname_type_on_launch            = (known after apply)
      [32m+[0m[0m tags                                           = {
          [32m+[0m[0m "Enviroment" = "QA"
          [32m+[0m[0m "Name"       = "public-subnet-02"
          [32m+[0m[0m "Owner"      = "shreya"
        }
      [32m+[0m[0m tags_all                                       = {
          [32m+[0m[0m "Enviroment" = "QA"
          [32m+[0m[0m "Name"       = "public-subnet-02"
          [32m+[0m[0m "Owner"      = "shreya"
        }
      [32m+[0m[0m vpc_id                                         = (known after apply)
    }

[1m  # module.network.aws_vpc.dev_vpc[0m will be created
[0m  [32m+[0m[0m resource "aws_vpc" "dev_vpc" {
      [32m+[0m[0m arn                                  = (known after apply)
      [32m+[0m[0m cidr_block                           = "10.0.1.128/25"
      [32m+[0m[0m default_network_acl_id               = (known after apply)
      [32m+[0m[0m default_route_table_id               = (known after apply)
      [32m+[0m[0m default_security_group_id            = (known after apply)
      [32m+[0m[0m dhcp_options_id                      = (known after apply)
      [32m+[0m[0m enable_dns_hostnames                 = false
      [32m+[0m[0m enable_dns_support                   = true
      [32m+[0m[0m enable_network_address_usage_metrics = (known after apply)
      [32m+[0m[0m id                                   = (known after apply)
      [32m+[0m[0m instance_tenancy                     = "default"
      [32m+[0m[0m ipv6_association_id                  = (known after apply)
      [32m+[0m[0m ipv6_cidr_block                      = (known after apply)
      [32m+[0m[0m ipv6_cidr_block_network_border_group = (known after apply)
      [32m+[0m[0m main_route_table_id                  = (known after apply)
      [32m+[0m[0m owner_id                             = (known after apply)
      [32m+[0m[0m tags                                 = {
          [32m+[0m[0m "Enviroment" = "QA"
          [32m+[0m[0m "Name"       = "QA-vpc"
          [32m+[0m[0m "Owner"      = "shreya"
        }
      [32m+[0m[0m tags_all                             = {
          [32m+[0m[0m "Enviroment" = "QA"
          [32m+[0m[0m "Name"       = "QA-vpc"
          [32m+[0m[0m "Owner"      = "shreya"
        }
    }

[1mPlan:[0m 26 to add, 0 to change, 0 to destroy.
[0m
Changes to Outputs:
  [32m+[0m[0m alb-sg-id            = (known after apply)
  [32m+[0m[0m dev-alb-dns          = (known after apply)
  [32m+[0m[0m dev-backend-nacl-id  = (known after apply)
  [32m+[0m[0m dev-db-nacl-id       = (known after apply)
  [32m+[0m[0m dev-frontend-nacl-id = (known after apply)
  [32m+[0m[0m dev-igw-id           = (known after apply)
  [32m+[0m[0m dev-nat-id           = (known after apply)
  [32m+[0m[0m dev-private-RTB-id   = (known after apply)
  [32m+[0m[0m dev-public-RTB-id    = (known after apply)
  [32m+[0m[0m dev-route53-record   = "example.com"
  [32m+[0m[0m dev-route53-zone     = (known after apply)
  [32m+[0m[0m private-subnets-id   = [
      [32m+[0m[0m (known after apply),
      [32m+[0m[0m (known after apply),
      [32m+[0m[0m (known after apply),
    ]
  [32m+[0m[0m public-subnets-id    = [
      [32m+[0m[0m (known after apply),
      [32m+[0m[0m (known after apply),
    ]
  [32m+[0m[0m vpc-id               = (known after apply)
[0m[1mmodule.network.aws_vpc.dev_vpc: Creating...[0m[0m
[0m[1mmodule.network.aws_eip.dev_elastic_ip: Creating...[0m[0m
[0m[1mmodule.network.aws_eip.dev_elastic_ip: Creation complete after 0s [id=eipalloc-06ed2d588543a8977][0m
[0m[1mmodule.network.aws_vpc.dev_vpc: Creation complete after 1s [id=vpc-0a917fb8214d4ce27][0m
[0m[1mmodule.network.aws_subnet.dev_private_subnets[2]: Creating...[0m[0m
[0m[1mmodule.network.aws_internet_gateway.dev_igw: Creating...[0m[0m
[0m[1mmodule.network.aws_security_group.dev_alb_sg: Creating...[0m[0m
[0m[1mmodule.network.aws_subnet.dev_private_subnets[0]: Creating...[0m[0m
[0m[1mmodule.network.aws_subnet.dev_private_subnets[1]: Creating...[0m[0m
[0m[1mmodule.network.aws_route53_zone.dev_route53_zone: Creating...[0m[0m
[0m[1mmodule.network.aws_network_acl.dev_db_nacl: Creating...[0m[0m
[0m[1mmodule.network.aws_network_acl.dev_frontend_nacl: Creating...[0m[0m
[0m[1mmodule.network.aws_subnet.dev_public_subnets[0]: Creating...[0m[0m
[0m[1mmodule.network.aws_subnet.dev_public_subnets[1]: Creating...[0m[0m
[0m[1mmodule.network.aws_internet_gateway.dev_igw: Creation complete after 0s [id=igw-029d331ad13cf3181][0m
[0m[1mmodule.network.aws_network_acl.dev_backend_nacl: Creating...[0m[0m
[0m[1mmodule.network.aws_subnet.dev_private_subnets[1]: Creation complete after 1s [id=subnet-0729f2e42a973a23d][0m
[0m[1mmodule.network.aws_subnet.dev_private_subnets[0]: Creation complete after 1s [id=subnet-0d2692e3f50413cb0][0m
[0m[1mmodule.network.aws_route_table.dev_public_rtb: Creating...[0m[0m
[0m[1mmodule.network.aws_subnet.dev_private_subnets[2]: Creation complete after 1s [id=subnet-0833f5adf745ed36e][0m
[0m[1mmodule.network.aws_network_acl.dev_frontend_nacl: Creation complete after 1s [id=acl-0e1fdcd7a4e2d28f4][0m
[0m[1mmodule.network.aws_network_acl_association.dev_frontend_nacl: Creating...[0m[0m
[0m[1mmodule.network.aws_network_acl.dev_db_nacl: Creation complete after 1s [id=acl-0dc3bb1249fefdc2a][0m
[0m[1mmodule.network.aws_network_acl_association.dev_db_nacl_assc: Creating...[0m[0m
[0m[1mmodule.network.aws_network_acl_association.dev_frontend_nacl: Creation complete after 0s [id=aclassoc-025a02d3403117f89][0m
[0m[1mmodule.network.aws_network_acl_association.dev_db_nacl_assc: Creation complete after 0s [id=aclassoc-02c4ceb5646dc3f58][0m
[0m[1mmodule.network.aws_route_table.dev_public_rtb: Creation complete after 1s [id=rtb-0ebe9542ba1b8b63c][0m
[0m[1mmodule.network.aws_network_acl.dev_backend_nacl: Creation complete after 2s [id=acl-05193e105cbafa972][0m
[0m[1mmodule.network.aws_network_acl_association.dev_backend_nacl_assc: Creating...[0m[0m
[0m[1mmodule.network.aws_network_acl_association.dev_backend_nacl_assc: Creation complete after 0s [id=aclassoc-0dfdc2502459a5ce5][0m
[0m[1mmodule.network.aws_security_group.dev_alb_sg: Creation complete after 2s [id=sg-0cb0d9b0b204a76b0][0m
[0m[1mmodule.network.aws_route53_zone.dev_route53_zone: Still creating... [10s elapsed][0m[0m
[0m[1mmodule.network.aws_subnet.dev_public_subnets[1]: Still creating... [10s elapsed][0m[0m
[0m[1mmodule.network.aws_subnet.dev_public_subnets[0]: Still creating... [10s elapsed][0m[0m
[0m[1mmodule.network.aws_subnet.dev_public_subnets[1]: Creation complete after 11s [id=subnet-019b3e37356b9a8fc][0m
[0m[1mmodule.network.aws_subnet.dev_public_subnets[0]: Creation complete after 11s [id=subnet-029ec349c99f32b78][0m
[0m[1mmodule.network.aws_route_table_association.dev_public_route_association01[1]: Creating...[0m[0m
[0m[1mmodule.network.aws_lb.dev_alb: Creating...[0m[0m
[0m[1mmodule.network.aws_nat_gateway.dev_nat: Creating...[0m[0m
[0m[1mmodule.network.aws_route_table_association.dev_public_route_association01[0]: Creating...[0m[0m
[0m[1mmodule.network.aws_route_table_association.dev_public_route_association01[1]: Creation complete after 0s [id=rtbassoc-07e0a3f81eb238476][0m
[0m[1mmodule.network.aws_route_table_association.dev_public_route_association01[0]: Creation complete after 0s [id=rtbassoc-023c9ddeb3106b4a3][0m
[0m[1mmodule.network.aws_route53_zone.dev_route53_zone: Still creating... [20s elapsed][0m[0m
[0m[1mmodule.network.aws_lb.dev_alb: Still creating... [10s elapsed][0m[0m
[0m[1mmodule.network.aws_nat_gateway.dev_nat: Still creating... [10s elapsed][0m[0m
[0m[1mmodule.network.aws_route53_zone.dev_route53_zone: Still creating... [30s elapsed][0m[0m
[0m[1mmodule.network.aws_lb.dev_alb: Still creating... [20s elapsed][0m[0m
[0m[1mmodule.network.aws_nat_gateway.dev_nat: Still creating... [20s elapsed][0m[0m
[0m[1mmodule.network.aws_route53_zone.dev_route53_zone: Still creating... [40s elapsed][0m[0m
[0m[1mmodule.network.aws_lb.dev_alb: Still creating... [30s elapsed][0m[0m
[0m[1mmodule.network.aws_nat_gateway.dev_nat: Still creating... [30s elapsed][0m[0m
[0m[1mmodule.network.aws_route53_zone.dev_route53_zone: Still creating... [50s elapsed][0m[0m
[0m[1mmodule.network.aws_lb.dev_alb: Still creating... [40s elapsed][0m[0m
[0m[1mmodule.network.aws_nat_gateway.dev_nat: Still creating... [40s elapsed][0m[0m
[0m[1mmodule.network.aws_route53_zone.dev_route53_zone: Creation complete after 56s [id=Z02676911RHIWQ84M65B8][0m
[0m[1mmodule.network.aws_lb.dev_alb: Still creating... [50s elapsed][0m[0m
[0m[1mmodule.network.aws_nat_gateway.dev_nat: Still creating... [50s elapsed][0m[0m
[0m[1mmodule.network.aws_lb.dev_alb: Still creating... [1m0s elapsed][0m[0m
[0m[1mmodule.network.aws_nat_gateway.dev_nat: Still creating... [1m0s elapsed][0m[0m
[0m[1mmodule.network.aws_lb.dev_alb: Still creating... [1m10s elapsed][0m[0m
[0m[1mmodule.network.aws_nat_gateway.dev_nat: Still creating... [1m10s elapsed][0m[0m
[0m[1mmodule.network.aws_lb.dev_alb: Still creating... [1m20s elapsed][0m[0m
[0m[1mmodule.network.aws_nat_gateway.dev_nat: Still creating... [1m20s elapsed][0m[0m
[0m[1mmodule.network.aws_nat_gateway.dev_nat: Creation complete after 1m24s [id=nat-07d8818303623fb59][0m
[0m[1mmodule.network.aws_route_table.dev_private_rtb: Creating...[0m[0m
[0m[1mmodule.network.aws_route_table.dev_private_rtb: Creation complete after 1s [id=rtb-051d119075e393d2a][0m
[0m[1mmodule.network.aws_route_table_association.dev_private_route_association01[0]: Creating...[0m[0m
[0m[1mmodule.network.aws_route_table_association.dev_private_route_association01[2]: Creating...[0m[0m
[0m[1mmodule.network.aws_route_table_association.dev_private_route_association01[1]: Creating...[0m[0m
[0m[1mmodule.network.aws_route_table_association.dev_private_route_association01[0]: Creation complete after 0s [id=rtbassoc-0aed0aad698470afb][0m
[0m[1mmodule.network.aws_route_table_association.dev_private_route_association01[2]: Creation complete after 0s [id=rtbassoc-06a303cad50a27114][0m
[0m[1mmodule.network.aws_route_table_association.dev_private_route_association01[1]: Creation complete after 0s [id=rtbassoc-0dc813f2dde9d7efb][0m
[0m[1mmodule.network.aws_lb.dev_alb: Still creating... [1m30s elapsed][0m[0m
[0m[1mmodule.network.aws_lb.dev_alb: Still creating... [1m40s elapsed][0m[0m
[0m[1mmodule.network.aws_lb.dev_alb: Still creating... [1m50s elapsed][0m[0m
[0m[1mmodule.network.aws_lb.dev_alb: Still creating... [2m0s elapsed][0m[0m
[0m[1mmodule.network.aws_lb.dev_alb: Still creating... [2m10s elapsed][0m[0m
[0m[1mmodule.network.aws_lb.dev_alb: Still creating... [2m20s elapsed][0m[0m
[0m[1mmodule.network.aws_lb.dev_alb: Still creating... [2m30s elapsed][0m[0m
[0m[1mmodule.network.aws_lb.dev_alb: Still creating... [2m40s elapsed][0m[0m
[0m[1mmodule.network.aws_lb.dev_alb: Still creating... [2m50s elapsed][0m[0m
[0m[1mmodule.network.aws_lb.dev_alb: Creation complete after 2m52s [id=arn:aws:elasticloadbalancing:us-east-2:133673781875:loadbalancer/app/QA-alb/ad64e23f0761861a][0m
[0m[1mmodule.network.aws_route53_record.dev_route53_record: Creating...[0m[0m
[0m[1mmodule.network.aws_route53_record.dev_route53_record: Still creating... [10s elapsed][0m[0m
[0m[1mmodule.network.aws_route53_record.dev_route53_record: Creation complete after 18s [id=Z02676911RHIWQ84M65B8_example.com_A][0m
[0m[1m[32m
Apply complete! Resources: 26 added, 0 changed, 0 destroyed.
[0m[0m[1m[32m
Outputs:

[0malb-sg-id = "sg-0cb0d9b0b204a76b0"
dev-alb-dns = "QA-alb-1420650551.us-east-2.elb.amazonaws.com"
dev-backend-nacl-id = "acl-05193e105cbafa972"
dev-db-nacl-id = "acl-0dc3bb1249fefdc2a"
dev-frontend-nacl-id = "acl-0e1fdcd7a4e2d28f4"
dev-igw-id = "igw-029d331ad13cf3181"
dev-nat-id = "nat-07d8818303623fb59"
dev-private-RTB-id = "rtb-051d119075e393d2a"
dev-public-RTB-id = "rtb-0ebe9542ba1b8b63c"
dev-route53-record = "example.com"
dev-route53-zone = tolist([
  "ns-0.awsdns-00.com.",
  "ns-1024.awsdns-00.org.",
  "ns-1536.awsdns-00.co.uk.",
  "ns-512.awsdns-00.net.",
])
private-subnets-id = [
  "subnet-0d2692e3f50413cb0",
  "subnet-0729f2e42a973a23d",
  "subnet-0833f5adf745ed36e",
]
public-subnets-id = [
  "subnet-029ec349c99f32b78",
  "subnet-019b3e37356b9a8fc",
]
vpc-id = "vpc-0a917fb8214d4ce27"
[Pipeline] }
[Pipeline] // script
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Declarative: Post Actions)
[Pipeline] script
[Pipeline] {
[Pipeline] echo
Terraform operation successful!
[Pipeline] archiveArtifacts
Archiving artifacts
‘*.pem’ doesn’t match anything
No artifacts found that match the file pattern "*.pem". Configuration error?
[Pipeline] }
[Pipeline] // script
[Pipeline] }
[Pipeline] // stage
[Pipeline] }
[Pipeline] // withEnv
[Pipeline] }
[Pipeline] // withCredentials
[Pipeline] }
[Pipeline] // withEnv
[Pipeline] }
[Pipeline] // node
[Pipeline] End of Pipeline
Finished: SUCCESS

```
</details>

## [Terraform Module](https://github.com/CodeOps-Hub/Terraform-modules/tree/main/wrapperCode/Network-Skeleton-Wrapper-Code/QA-Network-Skeleton-Wrapper-Code)

## [Jenkinsfile](https://github.com/CodeOps-Hub/Jenkinsfile/blob/khushi/networkSkeleton_QA/Wrapper-Code/QA_Env/networkskeleton_QA/Jenkinsfile)

<details>
  <summary> <b> Click here to see Jenkins file </b> </summary>

  ```shell
pipeline {
    agent any
    
    environment {
        AWS_ACCESS_KEY_ID     = credentials('vishal_cred')
        AWS_SECRET_ACCESS_KEY = credentials('vishal_cred')
        TF_CLI_ARGS           = '-input=false'
    }
    
    parameters {
        choice(name: 'ACTION', choices: ['Apply', 'Destroy'], description: 'Choose to apply or destroy the infrastructure')
        string (defaultValue: 'wrapperCode/Network-Skeleton-Wrapper-Code/QA-Network-Skeleton-Wrapper-Code', description: 'define path of wrapper code directory', name: 'WrapperPath')
    }
    
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', credentialsId: 'Khushi_PAT', url: 'https://github.com/CodeOps-Hub/Terraform-modules.git'
            }
        }
        
        stage('Copy Terraform Files') {
            steps {
                // Copy or move specific files from the repository to Jenkins workspace
                sh "cp ${params.WrapperPath}/* ."
            }
        }
        
        stage('Terraform Init') {
            steps {
                script {
                    sh 'terraform init'
                }
            }
        }
        
        stage('Terraform Plan') {
            steps {
                script {
                    sh 'terraform plan'
                }
            }
        }
        
        stage('Review and Approve Apply') {
            when {
                expression { params.ACTION == 'Apply' }
            }
            steps {
                // Prompt for approval before applying changes
                input "Do you want to apply Terraform changes?"
            }
        }
        
        stage('Review and Approve Destroy') {
            when {
                expression { params.ACTION == 'Destroy' }
            }
            steps {
                // Prompt for approval before destroying resources
                input "Do you want to destroy Terraform resources?"
            }
        }
        
        stage('Apply or Destroy') {
            steps {
                script {
                    if (params.ACTION == 'Apply') {
                        sh 'terraform apply -auto-approve'
                    } else if (params.ACTION == 'Destroy') {
                        sh 'terraform destroy -auto-approve'
                    }
                }
            }
        }
    }
    
     post {
        success {
            script {
                    echo 'Terraform operation successful!'
                    archiveArtifacts artifacts: '*.pem', allowEmptyArchive: true
            }
        }
        failure {
            echo 'Terraform operation failed!'
          
        }
    }
}
```
</details>

## Output

**Jenkins Output**

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/2fb508a3-dfae-42c3-a453-54cd62377fbd)

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/02922b8b-c2c5-40c1-9209-e9258ce4e6ec)


**VPC & it's resources**

<img width="800" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/bd03370b-9419-42a2-9c91-831176b8a8d3">

***

**Elastic IP**

<img width="800" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/2b642830-7a6e-4c58-a20d-52ce3488b3c0">

***

**Frontend NACL**

<img width="800" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/1bfe075f-c85e-49c2-ab89-668624ec2122">

***

**Backend NACL**

<img width="800" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/74b31c37-f664-4be3-bad3-e2eb6869cda3">

***

**DB NACL**

<img width="800" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/7f538afe-31df-4f56-b25e-e73603188528">

***

**Security Group**

<img width="800" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/b18405d2-68e8-4d8c-9944-b9fe037ac518">

***

**Load Balancer**

<img width="800" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/ee63527c-bd8a-4815-bc0e-744af1ba910e">

***

**Route53**

<img width="800" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/2d563ec3-61ef-4032-b86c-2787f68f4bdc">

***

## Conclusion

In conclusion, our DSL Pipeline offers a powerful solution for creating and managing domain-specific languages, enabling developers to express complex ideas in a concise and understandable manner. By embracing DSLs, organizations can accelerate development cycles, improve collaboration between domain experts and developers, and ultimately deliver higher-quality software solutions.The NetworkSkeleton_QA wrapper code streamlines the setup process, enhances security through standardized configurations, and improves usability by abstracting complex tasks, making it an efficient solution for deploying and managing network infrastructures. 

***


## Contact Information
| Name            | Email Address                        |
|-----------------|--------------------------------------|
| Khushi Malhotra | khushi.malhotra.snaatak@mygurukulam.co |

## References

| **Source** | **Description** |
| ---------- | --------------- |
| [**Link**](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GenericDoc/Terraform/terraform.md) | Terraform Generic Doc Link. |
| [**Link**](https://developer.hashicorp.com/terraform/language/modules) | Terraform Module Concept. |
| [**Link**](https://medium.com/appgambit/terraform-with-jenkins-pipeline-439babe4095c)  | Jenkins DSL Pipeline Doc reference link. |
