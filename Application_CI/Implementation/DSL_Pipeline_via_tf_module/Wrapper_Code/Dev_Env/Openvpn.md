# DSL Jenkins pipeline for Openvpn setup in dev env 

<img width="360" length="100" alt="Terraform" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/556e50dc-0c8b-4262-be16-2c384d2cfa8a">

***

| **Author** | **Created On** | **Last Updated** | **Document version** |
| ---------- | -------------- | ---------------- | -------------------- |
| **Shreya Jaiswal** | **16 March 2024** | **16 March 2024** | **v1** |

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

With the increasing complexity of modern networks and the need for agility in infrastructure management, Terraform has emerged as a powerful tool for automating the provisioning and configuration of network resources.This module is designed to provide a foundational framework for managing network infrastructure as code using Terraform. The OpenVPN wrapper code simplifies the deployment and management of OpenVPN servers by automating configuration tasks and providing a user-friendly interface for users to connect securely to the VPN.

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

<img width="950" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/9b5ae612-95d9-4cf4-9612-d9874fcfd843">

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
        AWS_ACCESS_KEY_ID     = credentials('shreya-aws-cred')
        AWS_SECRET_ACCESS_KEY = credentials('shreya-aws-cred')
        TF_CLI_ARGS           = '-input=false'
    }
    
    parameters {
        choice(name: 'ACTION', choices: ['Apply'], description: 'Choose to apply the infrastructure')
    }
    
    stages {
        stage('Checkout') {
            steps {
                git branch: 'shreya/openvpn-wrapper-code', credentialsId: 'shreya PAT', url: 'https://github.com/CodeOps-Hub/Terraform-modules.git'
            }
        }
        
        stage('Copy Terraform Files') {
            steps {
                // Copy or move specific files from the repository to Jenkins workspace
                sh 'cp wrapperCode/Openvpn-wrapper-code/Dev-Env/* .'
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
            steps {
                // Prompt for approval before applying changes
                input "Do you want to apply Terraform changes?"
            }
        }
        
        stage('Apply') {
            steps {
                script {
                    sh 'terraform apply -auto-approve'
                }
            }
        }
    }
    
    post {
        success {
            echo 'Terraform operation successful!'
            archiveArtifacts artifacts: '*.pem', followSymlinks: false
        }
        failure {
            echo 'Terraform operation failed!'
            cleanWs()
        }
    }
}

```
</details>

**This Jenkins pipeline automates the deployment of a Openvpn Server using Terraform module and Wrapper code. It's configured to perform the following actions:**

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

<img width="700"  src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/5a6d206e-31de-468a-900c-c167e39f5904">

***

### Archive Artifact (SSH key pair)

<img width="700" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/23879352-5dfe-429b-9eee-187ffc19491a">

***

### Console Output

<details>
<summary><strong>Click here to see Console output</strong></summary>
<br>

```shell
Started by user shreya-snaatak
Obtained Openvpn/Dev-Env/Jenkinsfile from git https://github.com/CodeOps-Hub/Jenkinsfile.git
[Pipeline] Start of Pipeline
[Pipeline] node
Running on Jenkins in /var/lib/jenkins/workspace/Dev-Openvpn-Pipeline
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Declarative: Checkout SCM)
[Pipeline] checkout
Selected Git installation does not exist. Using Default
The recommended git tool is: NONE
using credential shreya PAT
Cloning the remote Git repository
Cloning repository https://github.com/CodeOps-Hub/Jenkinsfile.git
 > git init /var/lib/jenkins/workspace/Dev-Openvpn-Pipeline # timeout=10
Fetching upstream changes from https://github.com/CodeOps-Hub/Jenkinsfile.git
 > git --version # timeout=10
 > git --version # 'git version 2.34.1'
using GIT_ASKPASS to set credentials Github personal access token for shreya
 > git fetch --tags --force --progress -- https://github.com/CodeOps-Hub/Jenkinsfile.git +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git config remote.origin.url https://github.com/CodeOps-Hub/Jenkinsfile.git # timeout=10
 > git config --add remote.origin.fetch +refs/heads/*:refs/remotes/origin/* # timeout=10
Avoid second fetch
 > git rev-parse refs/remotes/origin/shreya/openvpn-pipeline^{commit} # timeout=10
Checking out Revision 5341c08c59f63d24caee2002a532c965b207d9ff (refs/remotes/origin/shreya/openvpn-pipeline)
 > git config core.sparsecheckout # timeout=10
 > git checkout -f 5341c08c59f63d24caee2002a532c965b207d9ff # timeout=10
Commit message: "Update Jenkinsfile"
 > git rev-list --no-walk 47d03ab453d967d9758655cf3d41056cc39630fa # timeout=10
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
using credential shreya PAT
 > git rev-parse --resolve-git-dir /var/lib/jenkins/workspace/Dev-Openvpn-Pipeline/.git # timeout=10
Fetching changes from the remote Git repository
 > git config remote.origin.url https://github.com/CodeOps-Hub/Terraform-modules.git # timeout=10
Fetching upstream changes from https://github.com/CodeOps-Hub/Terraform-modules.git
 > git --version # timeout=10
 > git --version # 'git version 2.34.1'
using GIT_ASKPASS to set credentials Github personal access token for shreya
 > git fetch --tags --force --progress -- https://github.com/CodeOps-Hub/Terraform-modules.git +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git rev-parse refs/remotes/origin/shreya/openvpn-wrapper-code^{commit} # timeout=10
Checking out Revision d0beafab7f49be51629d1ba6783d1680e4e95705 (refs/remotes/origin/shreya/openvpn-wrapper-code)
 > git config core.sparsecheckout # timeout=10
 > git checkout -f d0beafab7f49be51629d1ba6783d1680e4e95705 # timeout=10
 > git branch -a -v --no-abbrev # timeout=10
 > git checkout -b shreya/openvpn-wrapper-code d0beafab7f49be51629d1ba6783d1680e4e95705 # timeout=10
Commit message: "Delete wrapperCode/QA-Openvpn-Wrapper-Code/main.tf"
First time build. Skipping changelog.
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Copy Terraform Files)
[Pipeline] sh
+ cp wrapperCode/Openvpn-wrapper-code/Dev-Env/main.tf wrapperCode/Openvpn-wrapper-code/Dev-Env/output.tf wrapperCode/Openvpn-wrapper-code/Dev-Env/provider.tf wrapperCode/Openvpn-wrapper-code/Dev-Env/terraform.tfvars wrapperCode/Openvpn-wrapper-code/Dev-Env/variables.tf .
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
- network in .terraform/modules/network/Modules/VM-Module

[0m[1mInitializing provider plugins...[0m
- Finding hashicorp/aws versions matching ">= 5.38.0"...
- Finding latest version of hashicorp/tls...
- Finding latest version of hashicorp/local...
- Installing hashicorp/aws v5.41.0...
- Installed hashicorp/aws v5.41.0 (signed by HashiCorp)
- Installing hashicorp/tls v4.0.5...
- Installed hashicorp/tls v4.0.5 (signed by HashiCorp)
- Installing hashicorp/local v2.5.1...
- Installed hashicorp/local v2.5.1 (signed by HashiCorp)

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
[0m[1mmodule.network.data.aws_ami.ubuntu: Reading...[0m[0m
[0m[1mmodule.network.data.aws_ami.ubuntu: Read complete after 1s [id=ami-0f8b8f874036055b1][0m

Terraform used the selected providers to generate the following execution
plan. Resource actions are indicated with the following symbols:
  [32m+[0m create[0m

Terraform will perform the following actions:

[1m  # module.network.aws_instance.standalone_server[0m will be created
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
      [32m+[0m[0m instance_type                        = "t2.micro"
      [32m+[0m[0m ipv6_address_count                   = (known after apply)
      [32m+[0m[0m ipv6_addresses                       = (known after apply)
      [32m+[0m[0m key_name                             = "snaatak.pem"
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
      [32m+[0m[0m subnet_id                            = "subnet-009e342da70d1d460"
      [32m+[0m[0m tags                                 = {
          [32m+[0m[0m "Name" = "openvpn-Server"
          [32m+[0m[0m "Type" = "dev"
        }
      [32m+[0m[0m tags_all                             = {
          [32m+[0m[0m "Name" = "openvpn-Server"
          [32m+[0m[0m "Type" = "dev"
        }
      [32m+[0m[0m tenancy                              = (known after apply)
      [32m+[0m[0m user_data                            = (known after apply)
      [32m+[0m[0m user_data_base64                     = (known after apply)
      [32m+[0m[0m user_data_replace_on_change          = false
      [32m+[0m[0m vpc_security_group_ids               = (known after apply)
    }

[1m  # module.network.aws_key_pair.key_pair[0m will be created
[0m  [32m+[0m[0m resource "aws_key_pair" "key_pair" {
      [32m+[0m[0m arn             = (known after apply)
      [32m+[0m[0m fingerprint     = (known after apply)
      [32m+[0m[0m id              = (known after apply)
      [32m+[0m[0m key_name        = "snaatak.pem"
      [32m+[0m[0m key_name_prefix = (known after apply)
      [32m+[0m[0m key_pair_id     = (known after apply)
      [32m+[0m[0m key_type        = (known after apply)
      [32m+[0m[0m public_key      = (known after apply)
      [32m+[0m[0m tags_all        = (known after apply)
    }

[1m  # module.network.aws_security_group.sec_grp[0m will be created
[0m  [32m+[0m[0m resource "aws_security_group" "sec_grp" {
      [32m+[0m[0m arn                    = (known after apply)
      [32m+[0m[0m description            = "Security group for Open Vpn in Dev Env"
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
              [32m+[0m[0m from_port        = 1194
              [32m+[0m[0m ipv6_cidr_blocks = []
              [32m+[0m[0m prefix_list_ids  = []
              [32m+[0m[0m protocol         = "udp"
              [32m+[0m[0m security_groups  = []
              [32m+[0m[0m self             = false
              [32m+[0m[0m to_port          = 1194
            },
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
        ]
      [32m+[0m[0m name                   = "dev-openvpn-sg"
      [32m+[0m[0m name_prefix            = (known after apply)
      [32m+[0m[0m owner_id               = (known after apply)
      [32m+[0m[0m revoke_rules_on_delete = false
      [32m+[0m[0m tags                   = {
          [32m+[0m[0m "Enviroment" = "dev"
          [32m+[0m[0m "Name"       = "openvpn-sg"
          [32m+[0m[0m "Owner"      = "shreya"
        }
      [32m+[0m[0m tags_all               = {
          [32m+[0m[0m "Enviroment" = "dev"
          [32m+[0m[0m "Name"       = "openvpn-sg"
          [32m+[0m[0m "Owner"      = "shreya"
        }
      [32m+[0m[0m vpc_id                 = "vpc-0a744f2efc4febb2a"
    }

[1m  # module.network.local_file.private_key[0m will be created
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
      [32m+[0m[0m filename             = "snaatak.pem"
      [32m+[0m[0m id                   = (known after apply)
    }

[1m  # module.network.tls_private_key.rsa_4096[0m will be created
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
Approved by shreya-snaatak
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Apply)
[Pipeline] script
[Pipeline] {
[Pipeline] sh
+ terraform apply -auto-approve
[0m[1mmodule.network.data.aws_ami.ubuntu: Reading...[0m[0m
[0m[1mmodule.network.data.aws_ami.ubuntu: Read complete after 0s [id=ami-0f8b8f874036055b1][0m

Terraform used the selected providers to generate the following execution
plan. Resource actions are indicated with the following symbols:
  [32m+[0m create[0m

Terraform will perform the following actions:

[1m  # module.network.aws_instance.standalone_server[0m will be created
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
      [32m+[0m[0m instance_type                        = "t2.micro"
      [32m+[0m[0m ipv6_address_count                   = (known after apply)
      [32m+[0m[0m ipv6_addresses                       = (known after apply)
      [32m+[0m[0m key_name                             = "snaatak.pem"
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
      [32m+[0m[0m subnet_id                            = "subnet-009e342da70d1d460"
      [32m+[0m[0m tags                                 = {
          [32m+[0m[0m "Name" = "openvpn-Server"
          [32m+[0m[0m "Type" = "dev"
        }
      [32m+[0m[0m tags_all                             = {
          [32m+[0m[0m "Name" = "openvpn-Server"
          [32m+[0m[0m "Type" = "dev"
        }
      [32m+[0m[0m tenancy                              = (known after apply)
      [32m+[0m[0m user_data                            = (known after apply)
      [32m+[0m[0m user_data_base64                     = (known after apply)
      [32m+[0m[0m user_data_replace_on_change          = false
      [32m+[0m[0m vpc_security_group_ids               = (known after apply)
    }

[1m  # module.network.aws_key_pair.key_pair[0m will be created
[0m  [32m+[0m[0m resource "aws_key_pair" "key_pair" {
      [32m+[0m[0m arn             = (known after apply)
      [32m+[0m[0m fingerprint     = (known after apply)
      [32m+[0m[0m id              = (known after apply)
      [32m+[0m[0m key_name        = "snaatak.pem"
      [32m+[0m[0m key_name_prefix = (known after apply)
      [32m+[0m[0m key_pair_id     = (known after apply)
      [32m+[0m[0m key_type        = (known after apply)
      [32m+[0m[0m public_key      = (known after apply)
      [32m+[0m[0m tags_all        = (known after apply)
    }

[1m  # module.network.aws_security_group.sec_grp[0m will be created
[0m  [32m+[0m[0m resource "aws_security_group" "sec_grp" {
      [32m+[0m[0m arn                    = (known after apply)
      [32m+[0m[0m description            = "Security group for Open Vpn in Dev Env"
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
              [32m+[0m[0m from_port        = 1194
              [32m+[0m[0m ipv6_cidr_blocks = []
              [32m+[0m[0m prefix_list_ids  = []
              [32m+[0m[0m protocol         = "udp"
              [32m+[0m[0m security_groups  = []
              [32m+[0m[0m self             = false
              [32m+[0m[0m to_port          = 1194
            },
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
        ]
      [32m+[0m[0m name                   = "dev-openvpn-sg"
      [32m+[0m[0m name_prefix            = (known after apply)
      [32m+[0m[0m owner_id               = (known after apply)
      [32m+[0m[0m revoke_rules_on_delete = false
      [32m+[0m[0m tags                   = {
          [32m+[0m[0m "Enviroment" = "dev"
          [32m+[0m[0m "Name"       = "openvpn-sg"
          [32m+[0m[0m "Owner"      = "shreya"
        }
      [32m+[0m[0m tags_all               = {
          [32m+[0m[0m "Enviroment" = "dev"
          [32m+[0m[0m "Name"       = "openvpn-sg"
          [32m+[0m[0m "Owner"      = "shreya"
        }
      [32m+[0m[0m vpc_id                 = "vpc-0a744f2efc4febb2a"
    }

[1m  # module.network.local_file.private_key[0m will be created
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
      [32m+[0m[0m filename             = "snaatak.pem"
      [32m+[0m[0m id                   = (known after apply)
    }

[1m  # module.network.tls_private_key.rsa_4096[0m will be created
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
[0m[1mmodule.network.tls_private_key.rsa_4096: Creating...[0m[0m
[0m[1mmodule.network.aws_security_group.sec_grp: Creating...[0m[0m
[0m[1mmodule.network.aws_security_group.sec_grp: Creation complete after 2s [id=sg-0452a3a41a8f275dd][0m
[0m[1mmodule.network.tls_private_key.rsa_4096: Creation complete after 4s [id=053583506418e20961e643333a69acc4f927e4d8][0m
[0m[1mmodule.network.aws_key_pair.key_pair: Creating...[0m[0m
[0m[1mmodule.network.local_file.private_key: Creating...[0m[0m
[0m[1mmodule.network.local_file.private_key: Creation complete after 0s [id=8c93100ef31dddb84227f30590e483cc5fe6acbb][0m
[0m[1mmodule.network.aws_key_pair.key_pair: Creation complete after 1s [id=snaatak.pem][0m
[0m[1mmodule.network.aws_instance.standalone_server: Creating...[0m[0m
[0m[1mmodule.network.aws_instance.standalone_server: Still creating... [10s elapsed][0m[0m
[0m[1mmodule.network.aws_instance.standalone_server: Still creating... [20s elapsed][0m[0m
[0m[1mmodule.network.aws_instance.standalone_server: Still creating... [30s elapsed][0m[0m
[0m[1mmodule.network.aws_instance.standalone_server: Creation complete after 31s [id=i-08e6e1931075abf4e][0m
[0m[1m[32m
Apply complete! Resources: 5 added, 0 changed, 0 destroyed.
[0m[0m[1m[32m
Outputs:

[0mSecurity_Group_ID = [
  "sg-0452a3a41a8f275dd",
]
server_id = [
  "i-08e6e1931075abf4e",
]
[Pipeline] }
[Pipeline] // script
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Declarative: Post Actions)
[Pipeline] echo
Terraform operation successful!
[Pipeline] archiveArtifacts
Archiving artifacts
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

***

## AWS Console Output 

### Security Group

<img width="800"  src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/862a2245-3dfc-4532-94a9-eab3b3095939"> 

***
### SSH Key

<img width="800"  src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/cec695bb-205e-453e-9d05-55316b70a50c"> 

***

### EC2 Instance

<img width="800"  src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/4e92b753-883a-4414-bfe1-247b8ead7b1d">

***

# Conclusion

In conclusion, our DSL Pipeline offers a powerful solution for creating and managing domain-specific languages, enabling developers to express complex ideas in a concise and understandable manner. By embracing DSLs, organizations can accelerate development cycles, improve collaboration between domain experts and developers, and ultimately deliver higher-quality software solutions.The OpenVPN wrapper code streamlines the setup process, enhances security through standardized configurations, and improves usability by abstracting complex tasks, making it an efficient solution for deploying and managing VPN infrastructures. 

***

# Contact Information

| **Name** | **Email Address** |
| -------- | ----------------- |
| **Shreya Jaiswal** | shreya.jaiswal.snaatak@mygurukulam.co |

***

# References

| **Source** | **Description** |
| ---------- | --------------- |
| [**Link**](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GenericDoc/Terraform/terraform.md) | Terraform Generic Doc Link. |
| [**Link**](https://developer.hashicorp.com/terraform/language/modules) | Terraform Module Concept. |
| [**Link**](https://medium.com/appgambit/terraform-with-jenkins-pipeline-439babe4095c)  | Jenkins DSL Pipeline Doc reference link. |


