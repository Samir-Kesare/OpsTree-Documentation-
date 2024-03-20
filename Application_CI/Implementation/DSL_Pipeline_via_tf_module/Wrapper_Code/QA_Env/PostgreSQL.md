# DSL Jenkins Pipeline For PostgreSQL Server Setup in QA Environment

<img width="360" length="100" alt="Terraform" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/556e50dc-0c8b-4262-be16-2c384d2cfa8a">

|   Author     |  Created on   |  Version   | Last updated by | Last edited on |
| ------------ | --------------| -----------|---------------- |--------------- |
| Vikram BISHT | 19 March 2024 |     v1     | Vikram Bisht    | 20 March 2024  |


***
## Table of contents

* [Introduction](#Introduction)
* [What is DSL Pipeline](#What-is-DSL-Pipeline)
* [Why DSL Pipeline](#Why-DSL-Pipeline)
* [Flow Diagram](#Flow-Diagram)
* [Pre-requisites](#Pre-requisites)
* [Jenkinsfile](#Jenkinsfile)
* [Jenkins Output](#Jenkins-Output)
* [AWS Console Output](#AWS-Console-Output)
* [Conclusion](#Conclusion)
* [Contact Information](#Contact-Information)
* [References](#References)
  
***

## Introduction

With the increasing complexity of modern networks and the need for agility in infrastructure management, Terraform has emerged as a powerful tool for automating the provisioning and configuration of network resources.This module is designed to provide a foundational framework for managing network infrastructure as code using Terraform. By leveraging this module, users can quickly establish a standardized and scalable network architecture within their cloud environment.As networks get more complicated and managing infrastructure becomes more important, specialized languages called Domain-Specific Languages (DSLs) have become really useful. They help simplify and automate different tasks.

***

## What is DSL Pipeline?

A Domain-Specific Language (DSL) is a programming language or specification language dedicated to a particular problem domain, a particular problem representation technique, and/or a particular solution technique.DSL Pipeline is a robust framework designed to facilitate the creation, deployment, and management of domain-specific languages within your software development projects. By employing DSLs, developers can express solutions in a concise, domain-specific syntax tailored to the problem at hand, thereby enhancing productivity and reducing the gap between domain experts and software implementation.

There are two main types of DSLs: external DSLs and internal DSLs. External DSLs have their own syntax and are typically parsed by a separate compiler or interpreter. Internal DSLs, on the other hand, are embedded within a host programming language, leveraging its syntax and features to create a domain-specific syntax.

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

<img width="715" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156056344/c1ad95b9-b8df-48f5-b407-6af47df9fd81">


***

## Pre-requisites

| **Pre-requisites** | **Description** |
| ------------------ | ---------------- |
| **AWS Account**    | Access to the AWS Management Console with credentials configured. |
| **Jenkins**        | To integrate infra through DSL Pipeline. |
| **Terraform**      | Terraform HCL (v1.7.4) |

***

## Jenkinsfile

<details>
<summary><strong>Click here to see Jenkinsfile</strong></summary>
<br>

```shell
pipeline {
    agent any
    
    environment {
        AWS_ACCESS_KEY_ID     = credentials('vikram-aws')
        AWS_SECRET_ACCESS_KEY = credentials('vikram-aws')
        TF_CLI_ARGS           = '-input=false'
    }
    
    parameters {
        choice(name: 'ACTION', choices: ['Apply', 'Destroy'], description: 'Choose to apply or destroy the infrastructure')
    }
    
    stages {
        stage('Checkout') {
            steps {
                git branch: 'PostgreSQL_Vikram_QA', credentialsId: 'vikram445', url: 'https://github.com/CodeOps-Hub/Terraform-modules.git'
            }
        }
        
        stage('Copy Terraform Files') {
            steps {
                // Copy or move specific files from the repository to Jenkins workspace
                sh 'cp wrapperCode/wrapperCode/PostgreSQL/QA/* .'
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

**This Jenkins pipeline automates the deployment of a Redis infrastructure using Terraform module and Wrapper code. It's configured to perform the following actions:**

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

## Jenkins Output

### Pipeline view

![image](https://github.com/CodeOps-Hub/Documentation/assets/79625874/7560fc24-838d-4f42-8cd0-d2f96c53a626)

***

### Archive Artifact (SSH key pair)

![image](https://github.com/CodeOps-Hub/Documentation/assets/79625874/b2ecc74c-6166-4178-aa2e-5ed7417209f7)

***
### Console Output

<details>
<summary><strong>Click here to see Console output</strong></summary>
<br>

```shell
Started by user vikram445
[Pipeline] Start of Pipeline
[Pipeline] node
Running on Jenkins in /var/lib/jenkins/workspace/PostgreSQL_QA_Env
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
using credential vikram445
 > git rev-parse --resolve-git-dir /var/lib/jenkins/workspace/PostgreSQL_QA_Env/.git # timeout=10
Fetching changes from the remote Git repository
 > git config remote.origin.url https://github.com/CodeOps-Hub/Terraform-modules.git # timeout=10
Fetching upstream changes from https://github.com/CodeOps-Hub/Terraform-modules.git
 > git --version # timeout=10
 > git --version # 'git version 2.34.1'
using GIT_ASKPASS to set credentials 
 > git fetch --tags --force --progress -- https://github.com/CodeOps-Hub/Terraform-modules.git +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git rev-parse refs/remotes/origin/PostgreSQL_Vikram_QA^{commit} # timeout=10
Checking out Revision b8af1b766bf89646ef11f80e8494c9c898c9992c (refs/remotes/origin/PostgreSQL_Vikram_QA)
 > git config core.sparsecheckout # timeout=10
 > git checkout -f b8af1b766bf89646ef11f80e8494c9c898c9992c # timeout=10
 > git branch -a -v --no-abbrev # timeout=10
 > git branch -D PostgreSQL_Vikram_QA # timeout=10
 > git checkout -b PostgreSQL_Vikram_QA b8af1b766bf89646ef11f80e8494c9c898c9992c # timeout=10
Commit message: "Update terraform.tfvars"
 > git rev-list --no-walk 0b75cc6b3724b621cf7c190a985637c23c573b72 # timeout=10
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Copy Terraform Files)
[Pipeline] sh
+ cp wrapperCode/wrapperCode/PostgreSQL/QA/main.tf wrapperCode/wrapperCode/PostgreSQL/QA/output.tf wrapperCode/wrapperCode/PostgreSQL/QA/provider.tf wrapperCode/wrapperCode/PostgreSQL/QA/terraform.tfvars wrapperCode/wrapperCode/PostgreSQL/QA/variable.tf .
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

[0m[1mInitializing provider plugins...[0m
- Reusing previous version of hashicorp/aws from the dependency lock file
- Reusing previous version of hashicorp/tls from the dependency lock file
- Reusing previous version of hashicorp/local from the dependency lock file
- Using previously-installed hashicorp/aws v5.41.0
- Using previously-installed hashicorp/tls v4.0.5
- Using previously-installed hashicorp/local v2.5.1

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
[0m[1mmodule.Postgres.tls_private_key.rsa_4096: Refreshing state... [id=1c1394f2f99dfbb55baadf78560ca33bf12009e3][0m
[0m[1mmodule.Postgres.local_file.private_key: Refreshing state... [id=bbef2acf6cc88e2ec3c0a965dd46d0a21976b8d7][0m
[0m[1mmodule.Postgres.data.aws_ami.ubuntu: Reading...[0m[0m
[0m[1mmodule.Postgres.aws_key_pair.key_pair: Refreshing state... [id=postgres_QA.pem][0m
[0m[1mmodule.Postgres.data.aws_ami.ubuntu: Read complete after 0s [id=ami-0f8b8f874036055b1][0m

[1m[36mNote:[0m[1m Objects have changed outside of Terraform
[0m
Terraform detected the following changes made outside of Terraform since the
last "terraform apply" which may have affected this plan:

[1m  # module.Postgres.aws_key_pair.key_pair[0m has been deleted
[0m  [31m-[0m[0m resource "aws_key_pair" "key_pair" {
        id          = "postgres_QA.pem"
      [31m-[0m[0m key_name    = "postgres_QA.pem" [90m-> null[0m[0m
        [90m# (6 unchanged attributes hidden)[0m[0m
    }


Unless you have made equivalent changes to your configuration, or ignored the
relevant attributes using ignore_changes, the following plan may include
actions to undo or respond to these changes.
[90m
─────────────────────────────────────────────────────────────────────────────[0m

Terraform used the selected providers to generate the following execution
plan. Resource actions are indicated with the following symbols:
  [32m+[0m create[0m
[31m-[0m/[32m+[0m destroy and then create replacement[0m

Terraform will perform the following actions:

[1m  # module.Postgres.aws_instance.standalone_server[0m will be created
[0m  [32m+[0m[0m resource "aws_instance" "standalone_server" {
      [32m+[0m[0m ami                                  = "ami-0f8b8f874036055b1"
      [32m+[0m[0m arn                                  = (known after apply)
      [32m+[0m[0m associate_public_ip_address          = false
      [32m+[0m[0m availability_zone                    = (known after apply)
      [32m+[0m[0m cpu_core_count                       = (known after apply)
      [32m+[0m[0m cpu_threads_per_core                 = (known after apply)
      [32m+[0m[0m disable_api_stop                     = (known after apply)
      [32m+[0m[0m disable_api_termination              = (known after apply)
      [32m+[0m[0m ebs_optimized                        = (known after apply)
      [32m+[0m[0m get_password_data                    = false
      [32m+[0m[0m host_id                              = (known after apply)
      [32m+[0m[0m host_resource_group_arn              = (known after apply)
      [32m+[0m[0m iam_instance_profile                 = (known after apply)
      [32m+[0m[0m id                                   = (known after apply)
      [32m+[0m[0m instance_initiated_shutdown_behavior = (known after apply)
      [32m+[0m[0m instance_lifecycle                   = (known after apply)
      [32m+[0m[0m instance_state                       = (known after apply)
      [32m+[0m[0m instance_type                        = "t2.medium"
      [32m+[0m[0m ipv6_address_count                   = (known after apply)
      [32m+[0m[0m ipv6_addresses                       = (known after apply)
      [32m+[0m[0m key_name                             = "postgres.pem"
      [32m+[0m[0m monitoring                           = (known after apply)
      [32m+[0m[0m outpost_arn                          = (known after apply)
      [32m+[0m[0m password_data                        = (known after apply)
      [32m+[0m[0m placement_group                      = (known after apply)
      [32m+[0m[0m placement_partition_number           = (known after apply)
      [32m+[0m[0m primary_network_interface_id         = (known after apply)
      [32m+[0m[0m private_dns                          = (known after apply)
      [32m+[0m[0m private_ip                           = (known after apply)
      [32m+[0m[0m public_dns                           = (known after apply)
      [32m+[0m[0m public_ip                            = (known after apply)
      [32m+[0m[0m secondary_private_ips                = (known after apply)
      [32m+[0m[0m security_groups                      = (known after apply)
      [32m+[0m[0m source_dest_check                    = true
      [32m+[0m[0m spot_instance_request_id             = (known after apply)
      [32m+[0m[0m subnet_id                            = "subnet-0dc05fffbacb821e8"
      [32m+[0m[0m tags                                 = {
          [32m+[0m[0m "Name" = "Postgres-QA"
          [32m+[0m[0m "Type" = "dev"
        }
      [32m+[0m[0m tags_all                             = {
          [32m+[0m[0m "Name" = "Postgres-QA"
          [32m+[0m[0m "Type" = "dev"
        }
      [32m+[0m[0m tenancy                              = (known after apply)
      [32m+[0m[0m user_data                            = (known after apply)
      [32m+[0m[0m user_data_base64                     = (known after apply)
      [32m+[0m[0m user_data_replace_on_change          = false
      [32m+[0m[0m vpc_security_group_ids               = (known after apply)
    }

[1m  # module.Postgres.aws_key_pair.key_pair[0m will be created
[0m  [32m+[0m[0m resource "aws_key_pair" "key_pair" {
      [32m+[0m[0m arn             = (known after apply)
      [32m+[0m[0m fingerprint     = (known after apply)
      [32m+[0m[0m id              = (known after apply)
      [32m+[0m[0m key_name        = "postgres.pem"
      [32m+[0m[0m key_name_prefix = (known after apply)
      [32m+[0m[0m key_pair_id     = (known after apply)
      [32m+[0m[0m key_type        = (known after apply)
      [32m+[0m[0m public_key      = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDGoZWUoa+xVagzqALg2IsW1FtksgLw94fshnrrtBAeKpLA7HKZ0wwjTMb34KAhZCTR6Df0c0jpWd3+o8dAyZc6iWsURJ4wVeQrLUT84zvyG6qGbD/pkwhA7pc2wFiUky/Nhv1VxfU8BdBVjlt8CJtpoD6ZReOfzCevmTuA59K5NydxTG5IptefBrWuVFRyCtOVMF/7o3zzxuhhh18lulI8AZFlpjIz63JPPGmKt+EYu572FDadlpAqthZzParp6OrqOsfxpp3OnnXZbbrorPkWkV9zWDYb0vyVBFoHUIdN4jPXdX2lYrnOa5cYW75RFoD0F210m/3Lm/1gIya4gDhJ6cnwODTSTr5mAqeafieoy+Kipa7xltcUWpzkPi7GDKAOntDgYpG+D5MByjCKTIcrH2TFhvCLS2HqyM/WasCe7AXHF6hmJXnYL3hLfCjId+xSQ136AnjarQUjBpRuTJ2qJyxqCs6rX+2NTI9UzMEZjjCCYRTd7LlMXYEJnyDm/O+7QJ2hDMIFfCDtaM8wjDlZtMpP1JOVNLsV7Tddkk7swi2wscheW2MFkvKClEWlZsQIdr9WFxblFuMiy76CGZBnT5aX6Y0jAGQW5ctAFO/dcp+r2dXdWz8Ku31TBllUY13vy7NKy1QniBbADAIG8Ma8vk1q6Kug4s2ZXr1q26ooFw=="
      [32m+[0m[0m tags_all        = (known after apply)
    }

[1m  # module.Postgres.aws_security_group.sec_grp[0m will be created
[0m  [32m+[0m[0m resource "aws_security_group" "sec_grp" {
      [32m+[0m[0m arn                    = (known after apply)
      [32m+[0m[0m description            = "Security group for Postgres in QA Env"
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
                  [32m+[0m[0m "20.0.0.0/28",
                ]
              [32m+[0m[0m description      = ""
              [32m+[0m[0m from_port        = 22
              [32m+[0m[0m ipv6_cidr_blocks = []
              [32m+[0m[0m prefix_list_ids  = []
              [32m+[0m[0m protocol         = "tcp"
              [32m+[0m[0m security_groups  = []
              [32m+[0m[0m self             = false
              [32m+[0m[0m to_port          = 22
            },
          [32m+[0m[0m {
              [32m+[0m[0m cidr_blocks      = []
              [32m+[0m[0m description      = ""
              [32m+[0m[0m from_port        = 22
              [32m+[0m[0m ipv6_cidr_blocks = []
              [32m+[0m[0m prefix_list_ids  = []
              [32m+[0m[0m protocol         = "tcp"
              [32m+[0m[0m security_groups  = [
                  [32m+[0m[0m "sg-0ced15d988acdb94b",
                ]
              [32m+[0m[0m self             = false
              [32m+[0m[0m to_port          = 22
            },
          [32m+[0m[0m {
              [32m+[0m[0m cidr_blocks      = []
              [32m+[0m[0m description      = ""
              [32m+[0m[0m from_port        = 5432
              [32m+[0m[0m ipv6_cidr_blocks = []
              [32m+[0m[0m prefix_list_ids  = []
              [32m+[0m[0m protocol         = "tcp"
              [32m+[0m[0m security_groups  = [
                  [32m+[0m[0m "sg-0a4ecb0570e13e365",
                ]
              [32m+[0m[0m self             = false
              [32m+[0m[0m to_port          = 5432
            },
        ]
      [32m+[0m[0m name                   = "Postgresqll-sg"
      [32m+[0m[0m name_prefix            = (known after apply)
      [32m+[0m[0m owner_id               = (known after apply)
      [32m+[0m[0m revoke_rules_on_delete = false
      [32m+[0m[0m tags                   = {
          [32m+[0m[0m "Enviroment" = "QA"
          [32m+[0m[0m "Name"       = "Postgresqll-sg"
          [32m+[0m[0m "Owner"      = "Vikram"
        }
      [32m+[0m[0m tags_all               = {
          [32m+[0m[0m "Enviroment" = "QA"
          [32m+[0m[0m "Name"       = "Postgresqll-sg"
          [32m+[0m[0m "Owner"      = "Vikram"
        }
      [32m+[0m[0m vpc_id                 = "vpc-0a744f2efc4febb2a"
    }

[1m  # module.Postgres.local_file.private_key[0m must be [1m[31mreplaced[0m
[0m[31m-[0m/[32m+[0m[0m resource "local_file" "private_key" {
      [33m~[0m[0m content_base64sha256 = "ZoxDJLJmWQxKCZsXmwWCotBI3byKBedvRBXDTEbghbw=" -> (known after apply)
      [33m~[0m[0m content_base64sha512 = "gdD5mox8U2Gy2P/PhKG+yGIUFZ7HOgIjWiEW99yA3Ssz54XPj3l4+VrDTEzkckNJcA3Hx4E9qI0kcR7RKqtlDw==" -> (known after apply)
      [33m~[0m[0m content_md5          = "718e8cd169bc6fe452e6224d7ad79330" -> (known after apply)
      [33m~[0m[0m content_sha1         = "bbef2acf6cc88e2ec3c0a965dd46d0a21976b8d7" -> (known after apply)
      [33m~[0m[0m content_sha256       = "668c4324b266590c4a099b179b0582a2d048ddbc8a05e76f4415c34c46e085bc" -> (known after apply)
      [33m~[0m[0m content_sha512       = "81d0f99a8c7c5361b2d8ffcf84a1bec86214159ec73a02235a2116f7dc80dd2b33e785cf8f7978f95ac34c4ce4724349700dc7c7813da88d24711ed12aab650f" -> (known after apply)
      [33m~[0m[0m filename             = "postgres_QA.pem" [33m->[0m[0m "postgres.pem" [31m# forces replacement[0m[0m
      [33m~[0m[0m id                   = "bbef2acf6cc88e2ec3c0a965dd46d0a21976b8d7" -> (known after apply)
        [90m# (3 unchanged attributes hidden)[0m[0m
    }

[1mPlan:[0m 4 to add, 0 to change, 1 to destroy.
[0m
Changes to Outputs:
  [32m+[0m[0m Security_Group_ID = [
      [32m+[0m[0m (known after apply),
    ]
  [32m+[0m[0m server_id         = [
      [32m+[0m[0m (known after apply),
    ]
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
Approved by vikram445
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
[0m[1mmodule.Postgres.tls_private_key.rsa_4096: Refreshing state... [id=1c1394f2f99dfbb55baadf78560ca33bf12009e3][0m
[0m[1mmodule.Postgres.local_file.private_key: Refreshing state... [id=bbef2acf6cc88e2ec3c0a965dd46d0a21976b8d7][0m
[0m[1mmodule.Postgres.data.aws_ami.ubuntu: Reading...[0m[0m
[0m[1mmodule.Postgres.aws_key_pair.key_pair: Refreshing state... [id=postgres_QA.pem][0m
[0m[1mmodule.Postgres.data.aws_ami.ubuntu: Read complete after 1s [id=ami-0f8b8f874036055b1][0m

[1m[36mNote:[0m[1m Objects have changed outside of Terraform
[0m
Terraform detected the following changes made outside of Terraform since the
last "terraform apply" which may have affected this plan:

[1m  # module.Postgres.aws_key_pair.key_pair[0m has been deleted
[0m  [31m-[0m[0m resource "aws_key_pair" "key_pair" {
        id          = "postgres_QA.pem"
      [31m-[0m[0m key_name    = "postgres_QA.pem" [90m-> null[0m[0m
        [90m# (6 unchanged attributes hidden)[0m[0m
    }


Unless you have made equivalent changes to your configuration, or ignored the
relevant attributes using ignore_changes, the following plan may include
actions to undo or respond to these changes.
[90m
─────────────────────────────────────────────────────────────────────────────[0m

Terraform used the selected providers to generate the following execution
plan. Resource actions are indicated with the following symbols:
  [32m+[0m create[0m
[31m-[0m/[32m+[0m destroy and then create replacement[0m

Terraform will perform the following actions:

[1m  # module.Postgres.aws_instance.standalone_server[0m will be created
[0m  [32m+[0m[0m resource "aws_instance" "standalone_server" {
      [32m+[0m[0m ami                                  = "ami-0f8b8f874036055b1"
      [32m+[0m[0m arn                                  = (known after apply)
      [32m+[0m[0m associate_public_ip_address          = false
      [32m+[0m[0m availability_zone                    = (known after apply)
      [32m+[0m[0m cpu_core_count                       = (known after apply)
      [32m+[0m[0m cpu_threads_per_core                 = (known after apply)
      [32m+[0m[0m disable_api_stop                     = (known after apply)
      [32m+[0m[0m disable_api_termination              = (known after apply)
      [32m+[0m[0m ebs_optimized                        = (known after apply)
      [32m+[0m[0m get_password_data                    = false
      [32m+[0m[0m host_id                              = (known after apply)
      [32m+[0m[0m host_resource_group_arn              = (known after apply)
      [32m+[0m[0m iam_instance_profile                 = (known after apply)
      [32m+[0m[0m id                                   = (known after apply)
      [32m+[0m[0m instance_initiated_shutdown_behavior = (known after apply)
      [32m+[0m[0m instance_lifecycle                   = (known after apply)
      [32m+[0m[0m instance_state                       = (known after apply)
      [32m+[0m[0m instance_type                        = "t2.medium"
      [32m+[0m[0m ipv6_address_count                   = (known after apply)
      [32m+[0m[0m ipv6_addresses                       = (known after apply)
      [32m+[0m[0m key_name                             = "postgres.pem"
      [32m+[0m[0m monitoring                           = (known after apply)
      [32m+[0m[0m outpost_arn                          = (known after apply)
      [32m+[0m[0m password_data                        = (known after apply)
      [32m+[0m[0m placement_group                      = (known after apply)
      [32m+[0m[0m placement_partition_number           = (known after apply)
      [32m+[0m[0m primary_network_interface_id         = (known after apply)
      [32m+[0m[0m private_dns                          = (known after apply)
      [32m+[0m[0m private_ip                           = (known after apply)
      [32m+[0m[0m public_dns                           = (known after apply)
      [32m+[0m[0m public_ip                            = (known after apply)
      [32m+[0m[0m secondary_private_ips                = (known after apply)
      [32m+[0m[0m security_groups                      = (known after apply)
      [32m+[0m[0m source_dest_check                    = true
      [32m+[0m[0m spot_instance_request_id             = (known after apply)
      [32m+[0m[0m subnet_id                            = "subnet-0dc05fffbacb821e8"
      [32m+[0m[0m tags                                 = {
          [32m+[0m[0m "Name" = "Postgres-QA"
          [32m+[0m[0m "Type" = "dev"
        }
      [32m+[0m[0m tags_all                             = {
          [32m+[0m[0m "Name" = "Postgres-QA"
          [32m+[0m[0m "Type" = "dev"
        }
      [32m+[0m[0m tenancy                              = (known after apply)
      [32m+[0m[0m user_data                            = (known after apply)
      [32m+[0m[0m user_data_base64                     = (known after apply)
      [32m+[0m[0m user_data_replace_on_change          = false
      [32m+[0m[0m vpc_security_group_ids               = (known after apply)
    }

[1m  # module.Postgres.aws_key_pair.key_pair[0m will be created
[0m  [32m+[0m[0m resource "aws_key_pair" "key_pair" {
      [32m+[0m[0m arn             = (known after apply)
      [32m+[0m[0m fingerprint     = (known after apply)
      [32m+[0m[0m id              = (known after apply)
      [32m+[0m[0m key_name        = "postgres.pem"
      [32m+[0m[0m key_name_prefix = (known after apply)
      [32m+[0m[0m key_pair_id     = (known after apply)
      [32m+[0m[0m key_type        = (known after apply)
      [32m+[0m[0m public_key      = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDGoZWUoa+xVagzqALg2IsW1FtksgLw94fshnrrtBAeKpLA7HKZ0wwjTMb34KAhZCTR6Df0c0jpWd3+o8dAyZc6iWsURJ4wVeQrLUT84zvyG6qGbD/pkwhA7pc2wFiUky/Nhv1VxfU8BdBVjlt8CJtpoD6ZReOfzCevmTuA59K5NydxTG5IptefBrWuVFRyCtOVMF/7o3zzxuhhh18lulI8AZFlpjIz63JPPGmKt+EYu572FDadlpAqthZzParp6OrqOsfxpp3OnnXZbbrorPkWkV9zWDYb0vyVBFoHUIdN4jPXdX2lYrnOa5cYW75RFoD0F210m/3Lm/1gIya4gDhJ6cnwODTSTr5mAqeafieoy+Kipa7xltcUWpzkPi7GDKAOntDgYpG+D5MByjCKTIcrH2TFhvCLS2HqyM/WasCe7AXHF6hmJXnYL3hLfCjId+xSQ136AnjarQUjBpRuTJ2qJyxqCs6rX+2NTI9UzMEZjjCCYRTd7LlMXYEJnyDm/O+7QJ2hDMIFfCDtaM8wjDlZtMpP1JOVNLsV7Tddkk7swi2wscheW2MFkvKClEWlZsQIdr9WFxblFuMiy76CGZBnT5aX6Y0jAGQW5ctAFO/dcp+r2dXdWz8Ku31TBllUY13vy7NKy1QniBbADAIG8Ma8vk1q6Kug4s2ZXr1q26ooFw=="
      [32m+[0m[0m tags_all        = (known after apply)
    }

[1m  # module.Postgres.aws_security_group.sec_grp[0m will be created
[0m  [32m+[0m[0m resource "aws_security_group" "sec_grp" {
      [32m+[0m[0m arn                    = (known after apply)
      [32m+[0m[0m description            = "Security group for Postgres in QA Env"
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
                  [32m+[0m[0m "20.0.0.0/28",
                ]
              [32m+[0m[0m description      = ""
              [32m+[0m[0m from_port        = 22
              [32m+[0m[0m ipv6_cidr_blocks = []
              [32m+[0m[0m prefix_list_ids  = []
              [32m+[0m[0m protocol         = "tcp"
              [32m+[0m[0m security_groups  = []
              [32m+[0m[0m self             = false
              [32m+[0m[0m to_port          = 22
            },
          [32m+[0m[0m {
              [32m+[0m[0m cidr_blocks      = []
              [32m+[0m[0m description      = ""
              [32m+[0m[0m from_port        = 22
              [32m+[0m[0m ipv6_cidr_blocks = []
              [32m+[0m[0m prefix_list_ids  = []
              [32m+[0m[0m protocol         = "tcp"
              [32m+[0m[0m security_groups  = [
                  [32m+[0m[0m "sg-0ced15d988acdb94b",
                ]
              [32m+[0m[0m self             = false
              [32m+[0m[0m to_port          = 22
            },
          [32m+[0m[0m {
              [32m+[0m[0m cidr_blocks      = []
              [32m+[0m[0m description      = ""
              [32m+[0m[0m from_port        = 5432
              [32m+[0m[0m ipv6_cidr_blocks = []
              [32m+[0m[0m prefix_list_ids  = []
              [32m+[0m[0m protocol         = "tcp"
              [32m+[0m[0m security_groups  = [
                  [32m+[0m[0m "sg-0a4ecb0570e13e365",
                ]
              [32m+[0m[0m self             = false
              [32m+[0m[0m to_port          = 5432
            },
        ]
      [32m+[0m[0m name                   = "Postgresqll-sg"
      [32m+[0m[0m name_prefix            = (known after apply)
      [32m+[0m[0m owner_id               = (known after apply)
      [32m+[0m[0m revoke_rules_on_delete = false
      [32m+[0m[0m tags                   = {
          [32m+[0m[0m "Enviroment" = "QA"
          [32m+[0m[0m "Name"       = "Postgresqll-sg"
          [32m+[0m[0m "Owner"      = "Vikram"
        }
      [32m+[0m[0m tags_all               = {
          [32m+[0m[0m "Enviroment" = "QA"
          [32m+[0m[0m "Name"       = "Postgresqll-sg"
          [32m+[0m[0m "Owner"      = "Vikram"
        }
      [32m+[0m[0m vpc_id                 = "vpc-0a744f2efc4febb2a"
    }

[1m  # module.Postgres.local_file.private_key[0m must be [1m[31mreplaced[0m
[0m[31m-[0m/[32m+[0m[0m resource "local_file" "private_key" {
      [33m~[0m[0m content_base64sha256 = "ZoxDJLJmWQxKCZsXmwWCotBI3byKBedvRBXDTEbghbw=" -> (known after apply)
      [33m~[0m[0m content_base64sha512 = "gdD5mox8U2Gy2P/PhKG+yGIUFZ7HOgIjWiEW99yA3Ssz54XPj3l4+VrDTEzkckNJcA3Hx4E9qI0kcR7RKqtlDw==" -> (known after apply)
      [33m~[0m[0m content_md5          = "718e8cd169bc6fe452e6224d7ad79330" -> (known after apply)
      [33m~[0m[0m content_sha1         = "bbef2acf6cc88e2ec3c0a965dd46d0a21976b8d7" -> (known after apply)
      [33m~[0m[0m content_sha256       = "668c4324b266590c4a099b179b0582a2d048ddbc8a05e76f4415c34c46e085bc" -> (known after apply)
      [33m~[0m[0m content_sha512       = "81d0f99a8c7c5361b2d8ffcf84a1bec86214159ec73a02235a2116f7dc80dd2b33e785cf8f7978f95ac34c4ce4724349700dc7c7813da88d24711ed12aab650f" -> (known after apply)
      [33m~[0m[0m filename             = "postgres_QA.pem" [33m->[0m[0m "postgres.pem" [31m# forces replacement[0m[0m
      [33m~[0m[0m id                   = "bbef2acf6cc88e2ec3c0a965dd46d0a21976b8d7" -> (known after apply)
        [90m# (3 unchanged attributes hidden)[0m[0m
    }

[1mPlan:[0m 4 to add, 0 to change, 1 to destroy.
[0m
Changes to Outputs:
  [32m+[0m[0m Security_Group_ID = [
      [32m+[0m[0m (known after apply),
    ]
  [32m+[0m[0m server_id         = [
      [32m+[0m[0m (known after apply),
    ]
[0m[1mmodule.Postgres.local_file.private_key: Destroying... [id=bbef2acf6cc88e2ec3c0a965dd46d0a21976b8d7][0m[0m
[0m[1mmodule.Postgres.local_file.private_key: Destruction complete after 0s[0m
[0m[1mmodule.Postgres.local_file.private_key: Creating...[0m[0m
[0m[1mmodule.Postgres.local_file.private_key: Creation complete after 0s [id=bbef2acf6cc88e2ec3c0a965dd46d0a21976b8d7][0m
[0m[1mmodule.Postgres.aws_key_pair.key_pair: Creating...[0m[0m
[0m[1mmodule.Postgres.aws_security_group.sec_grp: Creating...[0m[0m
[0m[1mmodule.Postgres.aws_key_pair.key_pair: Creation complete after 0s [id=postgres.pem][0m
[0m[1mmodule.Postgres.aws_security_group.sec_grp: Creation complete after 3s [id=sg-07a85cc2a39a0b6fd][0m
[0m[1mmodule.Postgres.aws_instance.standalone_server: Creating...[0m[0m
[0m[1mmodule.Postgres.aws_instance.standalone_server: Still creating... [10s elapsed][0m[0m
[0m[1mmodule.Postgres.aws_instance.standalone_server: Still creating... [20s elapsed][0m[0m
[0m[1mmodule.Postgres.aws_instance.standalone_server: Still creating... [30s elapsed][0m[0m
[0m[1mmodule.Postgres.aws_instance.standalone_server: Still creating... [40s elapsed][0m[0m
[0m[1mmodule.Postgres.aws_instance.standalone_server: Creation complete after 42s [id=i-02da7b0597ab76c09][0m
[0m[1m[32m
Apply complete! Resources: 4 added, 0 changed, 1 destroyed.
[0m[0m[1m[32m
Outputs:

[0mSecurity_Group_ID = [
  "sg-07a85cc2a39a0b6fd",
]
server_id = [
  "i-02da7b0597ab76c09",
]
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
[Pipeline] }
[Pipeline] // script
[Pipeline] }
[Pipeline] // stage
[Pipeline] }
[Pipeline] // withEnv
[Pipeline] }
[Pipeline] // withCredentials
[Pipeline] }
[Pipeline] // node
[Pipeline] End of Pipeline
Finished: SUCCESS

</details>

```



## AWS Console Output 

### Security Group

![image](https://github.com/CodeOps-Hub/Documentation/assets/79625874/65e770ba-ea4f-4886-b33c-60a481f363f9)


***
### Postgres_QA Server

![image](https://github.com/CodeOps-Hub/Documentation/assets/79625874/fa8cfda4-cfa2-4b26-a503-4f4c94757084)

***

### Key Pair

![image](https://github.com/CodeOps-Hub/Documentation/assets/79625874/d071f1fc-1747-495c-af79-e3869142469b)


***

# Conclusion

In conclusion, our DSL Pipeline offers a powerful solution for creating and managing domain-specific languages, enabling developers to express complex ideas in a concise and understandable manner. By embracing DSLs, organizations can accelerate development cycles, improve collaboration between domain experts and developers, and ultimately deliver higher-quality software solutions. 

***
# Contact Information

|  Name                     |        	Email Address           |
| ------------              | --------------------------------|
| Vikram Bisht              |  Vikram.Bisht@opstree.com       |  

# References

| **Source** | **Description** |
| ---------- | --------------- |
| [**Link**](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GenericDoc/Terraform/terraform.md) | Terraform Generic Doc Link. |
| [**Link**](https://developer.hashicorp.com/terraform/language/modules) | Terraform Module Concept. |
| [**Link**](https://medium.com/appgambit/terraform-with-jenkins-pipeline-439babe4095c)  | Jenkins DSL Pipeline Doc reference link. |
| [**Link**](https://github.com/CodeOps-Hub/Documentation/blob/main/Terraform/Design/Module/VM-Module.md) | VM Module Doc |
