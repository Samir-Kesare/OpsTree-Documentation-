# DSL Jenkins Pipeline For ScyllaDB Server Setup in Development Environment Documentation

<img width="360" length="100" alt="Terraform" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/556e50dc-0c8b-4262-be16-2c384d2cfa8a">

***

| **Author** | **Created On** | **Last Updated** | **Document version** |
| ---------- | -------------- | ---------------- | -------------------- |
| **Aakash Tripathi** | **15 March 2024** | **17 March 2024** | **v1.0** |

***

## Table of contents

* [Introduction](#Introduction)
* [What is DSL Pipeline](#What-is-DSL-Pipeline)
* [Why DSL Pipeline](#Why-DSP-Pipeline)
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
        AWS_ACCESS_KEY_ID     = credentials('aakash_aws_creds')
        AWS_SECRET_ACCESS_KEY = credentials('aakash_aws_creds')
        TF_CLI_ARGS           = '-input=false'
    }
    
    parameters {
        choice(name: 'ACTION', choices: ['Apply', 'Destroy'], description: 'Choose to apply or destroy the infrastructure')
    }
    
    stages {
        stage('Checkout') {
            steps {
                git branch: 'aakash/scylladb_dev', credentialsId: 'aakashgithub', url: 'https://github.com/CodeOps-Hub/Terraform-modules.git'
            }
        }
        
        stage('Copy Terraform Files') {
            steps {
                // Copy or move specific files from the repository to Jenkins workspace
                sh 'cp wrapperCode/ScyllaDB_Wrapper_Code/Dev/* .'
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
            cleanWs()
        }
    }
}
```
</details>

**This Jenkins pipeline automates the deployment of a ScyllaDB infrastructure using Terraform module and Wrapper code. It's configured to perform the following actions:**

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

<img width="700"  src="https://github.com/CodeOps-Hub/Documentation/assets/156056344/13ec73e5-b3a2-4632-a8cf-b165e032b35d">


***

### Archive Artifact (SSH key pair)

<img width="700"  src="https://github.com/CodeOps-Hub/Documentation/assets/156056344/0608fb41-8897-4258-a84f-6aabe3cb8eec">

***

### Console Output

<details>
<summary><strong>Click here to see Console output</strong></summary>
<br>

```shell
Started by user aakashtripathi-snaatak
[Pipeline] Start of Pipeline
[Pipeline] node
Running on Jenkins in /var/lib/jenkins/workspace/ScyllaDB_Development_Infra
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
using credential aakashgithub
 > git rev-parse --resolve-git-dir /var/lib/jenkins/workspace/ScyllaDB_Development_Infra/.git # timeout=10
Fetching changes from the remote Git repository
 > git config remote.origin.url https://github.com/CodeOps-Hub/Terraform-modules.git # timeout=10
Fetching upstream changes from https://github.com/CodeOps-Hub/Terraform-modules.git
 > git --version # timeout=10
 > git --version # 'git version 2.34.1'
using GIT_ASKPASS to set credentials aakashgithub 
 > git fetch --tags --force --progress -- https://github.com/CodeOps-Hub/Terraform-modules.git +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git rev-parse refs/remotes/origin/aakash/scylladb_dev^{commit} # timeout=10
Checking out Revision f62ae62ac48f58c1b70f6107a0c268e5a3ce69c9 (refs/remotes/origin/aakash/scylladb_dev)
 > git config core.sparsecheckout # timeout=10
 > git checkout -f f62ae62ac48f58c1b70f6107a0c268e5a3ce69c9 # timeout=10
 > git branch -a -v --no-abbrev # timeout=10
 > git branch -D aakash/scylladb_dev # timeout=10
 > git checkout -b aakash/scylladb_dev f62ae62ac48f58c1b70f6107a0c268e5a3ce69c9 # timeout=10
Commit message: "Update terraform.tfvars"
 > git rev-list --no-walk c79ad8c6c852bd3f66eaf6b9a023625fdc70e0a4 # timeout=10
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Copy Terraform Files)
[Pipeline] sh
+ cp wrapperCode/ScyllaDB_Wrapper_Code/Dev/main.tf wrapperCode/ScyllaDB_Wrapper_Code/Dev/output.tf wrapperCode/ScyllaDB_Wrapper_Code/Dev/provider.tf wrapperCode/ScyllaDB_Wrapper_Code/Dev/terraform.tfvars wrapperCode/ScyllaDB_Wrapper_Code/Dev/variable.tf .
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
[0m[1mmodule.scylladb.data.aws_ami.ubuntu: Reading...[0m[0m
[0m[1mmodule.scylladb.data.aws_ami.ubuntu: Read complete after 1s [id=ami-04491d9c87554d23d][0m

Terraform used the selected providers to generate the following execution
plan. Resource actions are indicated with the following symbols:
  [32m+[0m create[0m

Terraform will perform the following actions:

[1m  # module.scylladb.aws_instance.standalone_server[0m will be created
[0m  [32m+[0m[0m resource "aws_instance" "standalone_server" {
      [32m+[0m[0m ami                                  = "ami-04491d9c87554d23d"
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
      [32m+[0m[0m key_name                             = "scyllaDBKeyDev.pem"
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
      [32m+[0m[0m subnet_id                            = "subnet-0eb88feb4f7ec9f95"
      [32m+[0m[0m tags                                 = {
          [32m+[0m[0m "Name" = "ScyllaDB-Server-Dev"
          [32m+[0m[0m "Type" = "dev"
        }
      [32m+[0m[0m tags_all                             = {
          [32m+[0m[0m "Name" = "ScyllaDB-Server-Dev"
          [32m+[0m[0m "Type" = "dev"
        }
      [32m+[0m[0m tenancy                              = (known after apply)
      [32m+[0m[0m user_data                            = (known after apply)
      [32m+[0m[0m user_data_base64                     = (known after apply)
      [32m+[0m[0m user_data_replace_on_change          = false
      [32m+[0m[0m vpc_security_group_ids               = (known after apply)
    }

[1m  # module.scylladb.aws_key_pair.key_pair[0m will be created
[0m  [32m+[0m[0m resource "aws_key_pair" "key_pair" {
      [32m+[0m[0m arn             = (known after apply)
      [32m+[0m[0m fingerprint     = (known after apply)
      [32m+[0m[0m id              = (known after apply)
      [32m+[0m[0m key_name        = "scyllaDBKeyDev.pem"
      [32m+[0m[0m key_name_prefix = (known after apply)
      [32m+[0m[0m key_pair_id     = (known after apply)
      [32m+[0m[0m key_type        = (known after apply)
      [32m+[0m[0m public_key      = (known after apply)
      [32m+[0m[0m tags_all        = (known after apply)
    }

[1m  # module.scylladb.aws_security_group.sec_grp[0m will be created
[0m  [32m+[0m[0m resource "aws_security_group" "sec_grp" {
      [32m+[0m[0m arn                    = (known after apply)
      [32m+[0m[0m description            = "Security group for ScyllaDB in Dev Env"
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
                  [32m+[0m[0m "sg-0367b8b3d6b6b36c9",
                ]
              [32m+[0m[0m self             = false
              [32m+[0m[0m to_port          = 22
            },
          [32m+[0m[0m {
              [32m+[0m[0m cidr_blocks      = []
              [32m+[0m[0m description      = ""
              [32m+[0m[0m from_port        = 9042
              [32m+[0m[0m ipv6_cidr_blocks = []
              [32m+[0m[0m prefix_list_ids  = []
              [32m+[0m[0m protocol         = "tcp"
              [32m+[0m[0m security_groups  = [
                  [32m+[0m[0m "sg-0b1982ff2c211d41a",
                ]
              [32m+[0m[0m self             = false
              [32m+[0m[0m to_port          = 9042
            },
        ]
      [32m+[0m[0m name                   = "scylladb-dev-sg"
      [32m+[0m[0m name_prefix            = (known after apply)
      [32m+[0m[0m owner_id               = (known after apply)
      [32m+[0m[0m revoke_rules_on_delete = false
      [32m+[0m[0m tags                   = {
          [32m+[0m[0m "Enviroment" = "Dev"
          [32m+[0m[0m "Name"       = "scylladb-dev-sg"
          [32m+[0m[0m "Owner"      = "Aakash"
        }
      [32m+[0m[0m tags_all               = {
          [32m+[0m[0m "Enviroment" = "Dev"
          [32m+[0m[0m "Name"       = "scylladb-dev-sg"
          [32m+[0m[0m "Owner"      = "Aakash"
        }
      [32m+[0m[0m vpc_id                 = "vpc-0b4c152fb02b0af32"
    }

[1m  # module.scylladb.local_file.private_key[0m will be created
[0m  [32m+[0m[0m resource "local_file" "private_key" {
      [32m+[0m[0m content              = (sensitive value)
      [32m+[0m[0m content_base64sha256 = (known after apply)
      [32m+[0m[0m content_base64sha512 = (known after apply)
      [32m+[0m[0m content_md5          = (known after apply)
      [32m+[0m[0m content_sha1         = (known after apply)
      [32m+[0m[0m content_sha256       = (known after apply)
      [32m+[0m[0m content_sha512       = (known after apply)
      [32m+[0m[0m directory_permission = "0777"
      [32m+[0m[0m file_permission      = "0777"
      [32m+[0m[0m filename             = "scyllaDBKeyDev.pem"
      [32m+[0m[0m id                   = (known after apply)
    }

[1m  # module.scylladb.tls_private_key.rsa_4096[0m will be created
[0m  [32m+[0m[0m resource "tls_private_key" "rsa_4096" {
      [32m+[0m[0m algorithm                     = "RSA"
      [32m+[0m[0m ecdsa_curve                   = "P224"
      [32m+[0m[0m id                            = (known after apply)
      [32m+[0m[0m private_key_openssh           = (sensitive value)
      [32m+[0m[0m private_key_pem               = (sensitive value)
      [32m+[0m[0m private_key_pem_pkcs8         = (sensitive value)
      [32m+[0m[0m public_key_fingerprint_md5    = (known after apply)
      [32m+[0m[0m public_key_fingerprint_sha256 = (known after apply)
      [32m+[0m[0m public_key_openssh            = (known after apply)
      [32m+[0m[0m public_key_pem                = (known after apply)
      [32m+[0m[0m rsa_bits                      = 4096
    }

[1mPlan:[0m 5 to add, 0 to change, 0 to destroy.
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
Approved by aakashtripathi-snaatak
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
[0m[1mmodule.scylladb.data.aws_ami.ubuntu: Reading...[0m[0m
[0m[1mmodule.scylladb.data.aws_ami.ubuntu: Read complete after 1s [id=ami-04491d9c87554d23d][0m

Terraform used the selected providers to generate the following execution
plan. Resource actions are indicated with the following symbols:
  [32m+[0m create[0m

Terraform will perform the following actions:

[1m  # module.scylladb.aws_instance.standalone_server[0m will be created
[0m  [32m+[0m[0m resource "aws_instance" "standalone_server" {
      [32m+[0m[0m ami                                  = "ami-04491d9c87554d23d"
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
      [32m+[0m[0m key_name                             = "scyllaDBKeyDev.pem"
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
      [32m+[0m[0m subnet_id                            = "subnet-0eb88feb4f7ec9f95"
      [32m+[0m[0m tags                                 = {
          [32m+[0m[0m "Name" = "ScyllaDB-Server-Dev"
          [32m+[0m[0m "Type" = "dev"
        }
      [32m+[0m[0m tags_all                             = {
          [32m+[0m[0m "Name" = "ScyllaDB-Server-Dev"
          [32m+[0m[0m "Type" = "dev"
        }
      [32m+[0m[0m tenancy                              = (known after apply)
      [32m+[0m[0m user_data                            = (known after apply)
      [32m+[0m[0m user_data_base64                     = (known after apply)
      [32m+[0m[0m user_data_replace_on_change          = false
      [32m+[0m[0m vpc_security_group_ids               = (known after apply)
    }

[1m  # module.scylladb.aws_key_pair.key_pair[0m will be created
[0m  [32m+[0m[0m resource "aws_key_pair" "key_pair" {
      [32m+[0m[0m arn             = (known after apply)
      [32m+[0m[0m fingerprint     = (known after apply)
      [32m+[0m[0m id              = (known after apply)
      [32m+[0m[0m key_name        = "scyllaDBKeyDev.pem"
      [32m+[0m[0m key_name_prefix = (known after apply)
      [32m+[0m[0m key_pair_id     = (known after apply)
      [32m+[0m[0m key_type        = (known after apply)
      [32m+[0m[0m public_key      = (known after apply)
      [32m+[0m[0m tags_all        = (known after apply)
    }

[1m  # module.scylladb.aws_security_group.sec_grp[0m will be created
[0m  [32m+[0m[0m resource "aws_security_group" "sec_grp" {
      [32m+[0m[0m arn                    = (known after apply)
      [32m+[0m[0m description            = "Security group for ScyllaDB in Dev Env"
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
                  [32m+[0m[0m "sg-0367b8b3d6b6b36c9",
                ]
              [32m+[0m[0m self             = false
              [32m+[0m[0m to_port          = 22
            },
          [32m+[0m[0m {
              [32m+[0m[0m cidr_blocks      = []
              [32m+[0m[0m description      = ""
              [32m+[0m[0m from_port        = 9042
              [32m+[0m[0m ipv6_cidr_blocks = []
              [32m+[0m[0m prefix_list_ids  = []
              [32m+[0m[0m protocol         = "tcp"
              [32m+[0m[0m security_groups  = [
                  [32m+[0m[0m "sg-0b1982ff2c211d41a",
                ]
              [32m+[0m[0m self             = false
              [32m+[0m[0m to_port          = 9042
            },
        ]
      [32m+[0m[0m name                   = "scylladb-dev-sg"
      [32m+[0m[0m name_prefix            = (known after apply)
      [32m+[0m[0m owner_id               = (known after apply)
      [32m+[0m[0m revoke_rules_on_delete = false
      [32m+[0m[0m tags                   = {
          [32m+[0m[0m "Enviroment" = "Dev"
          [32m+[0m[0m "Name"       = "scylladb-dev-sg"
          [32m+[0m[0m "Owner"      = "Aakash"
        }
      [32m+[0m[0m tags_all               = {
          [32m+[0m[0m "Enviroment" = "Dev"
          [32m+[0m[0m "Name"       = "scylladb-dev-sg"
          [32m+[0m[0m "Owner"      = "Aakash"
        }
      [32m+[0m[0m vpc_id                 = "vpc-0b4c152fb02b0af32"
    }

[1m  # module.scylladb.local_file.private_key[0m will be created
[0m  [32m+[0m[0m resource "local_file" "private_key" {
      [32m+[0m[0m content              = (sensitive value)
      [32m+[0m[0m content_base64sha256 = (known after apply)
      [32m+[0m[0m content_base64sha512 = (known after apply)
      [32m+[0m[0m content_md5          = (known after apply)
      [32m+[0m[0m content_sha1         = (known after apply)
      [32m+[0m[0m content_sha256       = (known after apply)
      [32m+[0m[0m content_sha512       = (known after apply)
      [32m+[0m[0m directory_permission = "0777"
      [32m+[0m[0m file_permission      = "0777"
      [32m+[0m[0m filename             = "scyllaDBKeyDev.pem"
      [32m+[0m[0m id                   = (known after apply)
    }

[1m  # module.scylladb.tls_private_key.rsa_4096[0m will be created
[0m  [32m+[0m[0m resource "tls_private_key" "rsa_4096" {
      [32m+[0m[0m algorithm                     = "RSA"
      [32m+[0m[0m ecdsa_curve                   = "P224"
      [32m+[0m[0m id                            = (known after apply)
      [32m+[0m[0m private_key_openssh           = (sensitive value)
      [32m+[0m[0m private_key_pem               = (sensitive value)
      [32m+[0m[0m private_key_pem_pkcs8         = (sensitive value)
      [32m+[0m[0m public_key_fingerprint_md5    = (known after apply)
      [32m+[0m[0m public_key_fingerprint_sha256 = (known after apply)
      [32m+[0m[0m public_key_openssh            = (known after apply)
      [32m+[0m[0m public_key_pem                = (known after apply)
      [32m+[0m[0m rsa_bits                      = 4096
    }

[1mPlan:[0m 5 to add, 0 to change, 0 to destroy.
[0m
Changes to Outputs:
  [32m+[0m[0m Security_Group_ID = [
      [32m+[0m[0m (known after apply),
    ]
  [32m+[0m[0m server_id         = [
      [32m+[0m[0m (known after apply),
    ]
[0m[1mmodule.scylladb.tls_private_key.rsa_4096: Creating...[0m[0m
[0m[1mmodule.scylladb.aws_security_group.sec_grp: Creating...[0m[0m
[0m[1mmodule.scylladb.tls_private_key.rsa_4096: Creation complete after 1s [id=7b1776a51297b54c69f2d9caee5fd5a8e9743850][0m
[0m[1mmodule.scylladb.aws_key_pair.key_pair: Creating...[0m[0m
[0m[1mmodule.scylladb.local_file.private_key: Creating...[0m[0m
[0m[1mmodule.scylladb.local_file.private_key: Creation complete after 0s [id=933208e2e7e7d9c1e1c866fa8ce7ef9914b4c665][0m
[0m[1mmodule.scylladb.aws_key_pair.key_pair: Creation complete after 1s [id=scyllaDBKeyDev.pem][0m
[0m[1mmodule.scylladb.aws_security_group.sec_grp: Creation complete after 4s [id=sg-06b773edbac13ef72][0m
[0m[1mmodule.scylladb.aws_instance.standalone_server: Creating...[0m[0m
[0m[1mmodule.scylladb.aws_instance.standalone_server: Still creating... [10s elapsed][0m[0m
[0m[1mmodule.scylladb.aws_instance.standalone_server: Still creating... [20s elapsed][0m[0m
[0m[1mmodule.scylladb.aws_instance.standalone_server: Still creating... [30s elapsed][0m[0m
[0m[1mmodule.scylladb.aws_instance.standalone_server: Creation complete after 35s [id=i-0ec4c907d6f48312a][0m
[0m[1m[32m
Apply complete! Resources: 5 added, 0 changed, 0 destroyed.
[0m[0m[1m[32m
Outputs:

[0mSecurity_Group_ID = [
  "sg-06b773edbac13ef72",
]
server_id = [
  "i-0ec4c907d6f48312a",
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

```
</details>

***

## AWS Console Output 

### Security Group

<img width="700"  src="https://github.com/CodeOps-Hub/Documentation/assets/156056344/f44ee869-32df-46c5-8e14-666db5551de9"> 


***
### ScyllaDB Server

<img width="700"  src="https://github.com/CodeOps-Hub/Documentation/assets/156056344/3abc0cd7-60aa-4b08-bab2-3e33fecc07be"> 


***

### Key Pair

<img width="700"  src="https://github.com/CodeOps-Hub/Documentation/assets/156056344/406b51ef-e6dc-432c-a562-6912685e37bb">


***

# Conclusion

In conclusion, our DSL Pipeline offers a powerful solution for creating and managing domain-specific languages, enabling developers to express complex ideas in a concise and understandable manner. By embracing DSLs, organizations can accelerate development cycles, improve collaboration between domain experts and developers, and ultimately deliver higher-quality software solutions. 

***

# Contact Information

| **Name** | **Email Address** |
| -------- | ----------------- |
| **Aakash Tripathi** | aakash.tripathi.snaatak@mygurukulam.co |

***

# References

| **Source** | **Description** |
| ---------- | --------------- |
| [**Link**](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GenericDoc/Terraform/terraform.md) | Terraform Generic Doc Link. |
| [**Link**](https://developer.hashicorp.com/terraform/language/modules) | Terraform Module Concept. |
| [**Link**](https://medium.com/appgambit/terraform-with-jenkins-pipeline-439babe4095c)  | Jenkins DSL Pipeline Doc reference link. |
| [**Link**](https://github.com/CodeOps-Hub/Documentation/blob/main/Terraform/Design/Module/VM-Module.md) | VM Module Doc |
| [**Link**](https://github.com/CodeOps-Hub/Documentation/blob/main/Terraform/Design/Wrapper-Code/Dev-ScyllaDB.md) | Dev ScyllaDB Wrapper-Code |
