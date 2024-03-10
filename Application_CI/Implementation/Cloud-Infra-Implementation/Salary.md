# Salary API Infra Documentation

|<img width="360" length="100" alt="Terraform" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/556e50dc-0c8b-4262-be16-2c384d2cfa8a">

***

|   Author        |  Created on   |  Version   | Last updated by  | Last edited on |
| --------------- | --------------| -----------|----------------- | -------------- |
| Shikha Tripathi and Khushi Malhotra | 10 March 2024 |  Version 1 | Shikha Tripathi and Khushi Malhotra | 10 March 2024  |

***
## Table of contents
* [Introduction](#Introduction)
* [What is DSL Pipeline](#What-is-DSL-Pipeline)
* [Why DSL Pipeline](#Why-DSP-Pipeline)
* [Flow Diagram](#Flow-Diagram)
* [Pre-requisites](#Pre-requisites)
* [Jenkinsfile](#Jenkinsfile)
* [Output](#Output)
* [Related Works](#Related-Works)
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

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/3d1ca721-d26c-4326-85f1-975eca0bd62c)


***

## Pre-requisites

| **Pre-requisites** | **Description** |
| ------------------ | ---------------- |
| **AWS Account**    | Access to the AWS Management Console with credentials configured. |
| **Jenkins**        | To integrate infra through DSL Pipeline. |
| **Terraform**      | Terraform HCL (v1.7.4) | ****

## [Jenkinsfile](https://github.com/CodeOps-Hub/Jenkinsfile/blob/Shikha/Salary-API/Pipeline/Salary-API/Jenkinsfile)

```shell
pipeline {
    agent any
    
    environment {
        AWS_ACCESS_KEY_ID     = credentials('Attendance_creds')
        AWS_SECRET_ACCESS_KEY = credentials('Attendance_creds')
        TF_CLI_ARGS           = '-input=false'
    }
    
    parameters {
        choice(name: 'ACTION', choices: ['Apply', 'Destroy'], description: 'Choose to apply or destroy the infrastructure')
    }
    
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', credentialsId: 'Harshit-Github-PAT', url: 'https://github.com/CodeOps-Hub/Terraform.git'
            }
        }
        
        stage('Copy Terraform Files') {
            steps {
                // Copy or move specific files from the repository to Jenkins workspace
                sh 'cp Dev_Infra/Static_Tf/Salary/* .'
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
            echo 'Terraform operation successful!'
            archiveArtifacts artifacts: '*.pem', followSymlinks: false
        }
        failure {
            echo 'Terraform operation failed!'
        }
    }
}
```
**This Jenkins pipeline automates the deployment of a Salary API infrastructure using Terraform. It's configured to perform the following actions:**

### Terraform Deployment Pipeline Overview

| Stage                   | Description                                                                                                                                                                      |
|-------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Checkout**            | Fetches the Terraform code from a GitHub repository branch (`main`). |                                                                                    
| **Copy Terraform Files**    | Copies Salary-related Terraform configuration files to the Jenkins workspace. |                                                                                                
| **Terraform Init**          | Initializes Terraform in the workspace directory. |                                                                                                                                
| **Terraform Plan**          | Generates a Terraform execution plan to preview the changes. |                                                                                                                     
| **Review and Approve Apply** | Asks for approval before applying Terraform changes if the selected action is "Apply". |                                                                                       
| **Review and Approve Destroy** | Asks for approval before destroying Terraform resources if the selected action is "Destroy". |                                                                            
| **Apply or Destroy**        | Executes Terraform apply or destroy based on the selected action. |                                                                                                               
| **Post**                    | Displays success or failure messages. |                                                                                                                                          
***

## Output

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/cc90c2a2-e5aa-4af6-a539-083969fdfdde)

**Blue Ocean Output**

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/5216cdff-b651-448c-b1b7-2b61e3ada78c)

***

**Console Output**

<details>
<summary> Click here to Console Output </summary>
<br>

```shell
Started by user Admin Broo
Lightweight checkout support not available, falling back to full checkout.
Checking out git https://github.com/CodeOps-Hub/Jenkinsfile.git into /var/lib/jenkins/workspace/SALARY_API_PIPELINE@script/5c437dca2a0dbfc0911c34629742fb588229e41b5397ea7e535d21bab42d1454 to read Salary-API/Jenkinsfile
Selected Git installation does not exist. Using Default
The recommended git tool is: NONE
using credential Harshit-Github-PAT
 > git rev-parse --resolve-git-dir /var/lib/jenkins/workspace/SALARY_API_PIPELINE@script/5c437dca2a0dbfc0911c34629742fb588229e41b5397ea7e535d21bab42d1454/.git # timeout=10
Fetching changes from the remote Git repository
 > git config remote.origin.url https://github.com/CodeOps-Hub/Jenkinsfile.git # timeout=10
Fetching upstream changes from https://github.com/CodeOps-Hub/Jenkinsfile.git
 > git --version # timeout=10
 > git --version # 'git version 2.34.1'
using GIT_ASKPASS to set credentials Harshit-Github-PAT
 > git fetch --tags --force --progress -- https://github.com/CodeOps-Hub/Jenkinsfile.git +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git rev-parse refs/remotes/origin/Shikha/Salary-API/Pipeline^{commit} # timeout=10
 > git rev-parse Shikha/Salary-API/Pipeline^{commit} # timeout=10
Checking out Revision e9b41c290b3e5abb43f7326b984a5d055d62f9d8 (refs/remotes/origin/Shikha/Salary-API/Pipeline)
 > git config core.sparsecheckout # timeout=10
 > git checkout -f e9b41c290b3e5abb43f7326b984a5d055d62f9d8 # timeout=10
Commit message: "Update Jenkinsfile"
 > git rev-list --no-walk e9b41c290b3e5abb43f7326b984a5d055d62f9d8 # timeout=10
[Pipeline] Start of Pipeline
[Pipeline] node
Running on Jenkins in /var/lib/jenkins/workspace/SALARY_API_PIPELINE
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Declarative: Checkout SCM)
[Pipeline] checkout
Selected Git installation does not exist. Using Default
The recommended git tool is: NONE
using credential Harshit-Github-PAT
 > git rev-parse --resolve-git-dir /var/lib/jenkins/workspace/SALARY_API_PIPELINE/.git # timeout=10
Fetching changes from the remote Git repository
 > git config remote.origin.url https://github.com/CodeOps-Hub/Jenkinsfile.git # timeout=10
Fetching upstream changes from https://github.com/CodeOps-Hub/Jenkinsfile.git
 > git --version # timeout=10
 > git --version # 'git version 2.34.1'
using GIT_ASKPASS to set credentials Harshit-Github-PAT
 > git fetch --tags --force --progress -- https://github.com/CodeOps-Hub/Jenkinsfile.git +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git rev-parse refs/remotes/origin/Shikha/Salary-API/Pipeline^{commit} # timeout=10
 > git rev-parse Shikha/Salary-API/Pipeline^{commit} # timeout=10
Checking out Revision e9b41c290b3e5abb43f7326b984a5d055d62f9d8 (refs/remotes/origin/Shikha/Salary-API/Pipeline)
 > git config core.sparsecheckout # timeout=10
 > git checkout -f e9b41c290b3e5abb43f7326b984a5d055d62f9d8 # timeout=10
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
using credential Harshit-Github-PAT
 > git rev-parse --resolve-git-dir /var/lib/jenkins/workspace/SALARY_API_PIPELINE/.git # timeout=10
Fetching changes from the remote Git repository
 > git config remote.origin.url https://github.com/CodeOps-Hub/Terraform.git # timeout=10
Fetching upstream changes from https://github.com/CodeOps-Hub/Terraform.git
 > git --version # timeout=10
 > git --version # 'git version 2.34.1'
using GIT_ASKPASS to set credentials Harshit-Github-PAT
 > git fetch --tags --force --progress -- https://github.com/CodeOps-Hub/Terraform.git +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git rev-parse refs/remotes/origin/main^{commit} # timeout=10
Checking out Revision 8a84adb6fb0a7baf2f2c5e43dc4dfcf213837c9a (refs/remotes/origin/main)
 > git config core.sparsecheckout # timeout=10
 > git checkout -f 8a84adb6fb0a7baf2f2c5e43dc4dfcf213837c9a # timeout=10
 > git branch -a -v --no-abbrev # timeout=10
 > git branch -D main # timeout=10
 > git checkout -b main 8a84adb6fb0a7baf2f2c5e43dc4dfcf213837c9a # timeout=10
Commit message: "Update terraform.tfvars"
 > git rev-list --no-walk 547baf5f2fa7f7d249a6eb816a4360e652e7490c # timeout=10
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Copy Terraform Files)
[Pipeline] sh
+ cp Dev_Infra/Static_Tf/Salary/main.tf Dev_Infra/Static_Tf/Salary/output.tf Dev_Infra/Static_Tf/Salary/provider.tf Dev_Infra/Static_Tf/Salary/script.sh Dev_Infra/Static_Tf/Salary/terraform.tfvars Dev_Infra/Static_Tf/Salary/variables.tf .
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Terraform Init)
[Pipeline] script
[Pipeline] {
[Pipeline] sh
+ terraform init

[0m[1mInitializing the backend...[0m

[0m[1mInitializing provider plugins...[0m
- Reusing previous version of hashicorp/aws from the dependency lock file
- Reusing previous version of hashicorp/tls from the dependency lock file
- Reusing previous version of hashicorp/local from the dependency lock file
- Using previously-installed hashicorp/aws v5.40.0
- Using previously-installed hashicorp/tls v4.0.5
- Using previously-installed hashicorp/local v2.4.1

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

[1m  # aws_ami_from_instance.AMI[0m will be created
[0m  [32m+[0m[0m resource "aws_ami_from_instance" "AMI" {
      [32m+[0m[0m architecture         = (known after apply)
      [32m+[0m[0m arn                  = (known after apply)
      [32m+[0m[0m boot_mode            = (known after apply)
      [32m+[0m[0m ena_support          = (known after apply)
      [32m+[0m[0m hypervisor           = (known after apply)
      [32m+[0m[0m id                   = (known after apply)
      [32m+[0m[0m image_location       = (known after apply)
      [32m+[0m[0m image_owner_alias    = (known after apply)
      [32m+[0m[0m image_type           = (known after apply)
      [32m+[0m[0m imds_support         = (known after apply)
      [32m+[0m[0m kernel_id            = (known after apply)
      [32m+[0m[0m manage_ebs_snapshots = (known after apply)
      [32m+[0m[0m name                 = "Dev-Salary-AMI"
      [32m+[0m[0m owner_id             = (known after apply)
      [32m+[0m[0m platform             = (known after apply)
      [32m+[0m[0m platform_details     = (known after apply)
      [32m+[0m[0m public               = (known after apply)
      [32m+[0m[0m ramdisk_id           = (known after apply)
      [32m+[0m[0m root_device_name     = (known after apply)
      [32m+[0m[0m root_snapshot_id     = (known after apply)
      [32m+[0m[0m source_instance_id   = "i-059e99af9483ecb56"
      [32m+[0m[0m sriov_net_support    = (known after apply)
      [32m+[0m[0m tags_all             = (known after apply)
      [32m+[0m[0m tpm_support          = (known after apply)
      [32m+[0m[0m usage_operation      = (known after apply)
      [32m+[0m[0m virtualization_type  = (known after apply)
    }

[1m  # aws_autoscaling_group.Salary_asg[0m will be created
[0m  [32m+[0m[0m resource "aws_autoscaling_group" "Salary_asg" {
      [32m+[0m[0m arn                              = (known after apply)
      [32m+[0m[0m availability_zones               = (known after apply)
      [32m+[0m[0m default_cooldown                 = (known after apply)
      [32m+[0m[0m desired_capacity                 = 1
      [32m+[0m[0m force_delete                     = false
      [32m+[0m[0m force_delete_warm_pool           = false
      [32m+[0m[0m health_check_grace_period        = 300
      [32m+[0m[0m health_check_type                = (known after apply)
      [32m+[0m[0m id                               = (known after apply)
      [32m+[0m[0m ignore_failed_scaling_activities = false
      [32m+[0m[0m load_balancers                   = (known after apply)
      [32m+[0m[0m max_size                         = 2
      [32m+[0m[0m metrics_granularity              = "1Minute"
      [32m+[0m[0m min_size                         = 1
      [32m+[0m[0m name                             = "Dev_Salary_ASG"
      [32m+[0m[0m name_prefix                      = (known after apply)
      [32m+[0m[0m predicted_capacity               = (known after apply)
      [32m+[0m[0m protect_from_scale_in            = false
      [32m+[0m[0m service_linked_role_arn          = (known after apply)
      [32m+[0m[0m target_group_arns                = (known after apply)
      [32m+[0m[0m vpc_zone_identifier              = [
          [32m+[0m[0m "subnet-0617c653773732b23",
        ]
      [32m+[0m[0m wait_for_capacity_timeout        = "10m"
      [32m+[0m[0m warm_pool_size                   = (known after apply)

      [32m+[0m[0m launch_template {
          [32m+[0m[0m id      = (known after apply)
          [32m+[0m[0m name    = (known after apply)
          [32m+[0m[0m version = (known after apply)
        }

      [32m+[0m[0m tag {
          [32m+[0m[0m key                 = "Name"
          [32m+[0m[0m propagate_at_launch = false
          [32m+[0m[0m value               = "Dev_Salary_ASG"
        }
    }

[1m  # aws_autoscaling_policy.Salary_ASG_Policy[0m will be created
[0m  [32m+[0m[0m resource "aws_autoscaling_policy" "Salary_ASG_Policy" {
      [32m+[0m[0m arn                     = (known after apply)
      [32m+[0m[0m autoscaling_group_name  = "Dev_Salary_ASG"
      [32m+[0m[0m enabled                 = true
      [32m+[0m[0m id                      = (known after apply)
      [32m+[0m[0m metric_aggregation_type = (known after apply)
      [32m+[0m[0m name                    = "target-tracking-policy"
      [32m+[0m[0m policy_type             = "TargetTrackingScaling"

      [32m+[0m[0m target_tracking_configuration {
          [32m+[0m[0m disable_scale_in = false
          [32m+[0m[0m target_value     = 50

          [32m+[0m[0m predefined_metric_specification {
              [32m+[0m[0m predefined_metric_type = "ASGAverageCPUUtilization"
            }
        }
    }

[1m  # aws_key_pair.key_pair[0m will be created
[0m  [32m+[0m[0m resource "aws_key_pair" "key_pair" {
      [32m+[0m[0m arn             = (known after apply)
      [32m+[0m[0m fingerprint     = (known after apply)
      [32m+[0m[0m id              = (known after apply)
      [32m+[0m[0m key_name        = "Dev_Key"
      [32m+[0m[0m key_name_prefix = (known after apply)
      [32m+[0m[0m key_pair_id     = (known after apply)
      [32m+[0m[0m key_type        = (known after apply)
      [32m+[0m[0m public_key      = (known after apply)
      [32m+[0m[0m tags_all        = (known after apply)
    }

[1m  # aws_launch_template.Salary_Launch_Template[0m will be created
[0m  [32m+[0m[0m resource "aws_launch_template" "Salary_Launch_Template" {
      [32m+[0m[0m arn             = (known after apply)
      [32m+[0m[0m default_version = (known after apply)
      [32m+[0m[0m description     = "Launch template for salary api"
      [32m+[0m[0m id              = (known after apply)
      [32m+[0m[0m image_id        = (known after apply)
      [32m+[0m[0m instance_type   = "t2.micro"
      [32m+[0m[0m key_name        = "Dev_Key"
      [32m+[0m[0m latest_version  = (known after apply)
      [32m+[0m[0m name            = "Salary-Launch-Template"
      [32m+[0m[0m name_prefix     = (known after apply)
      [32m+[0m[0m tags            = {
          [32m+[0m[0m "Name" = "Salary-Launch-Template"
        }
      [32m+[0m[0m tags_all        = {
          [32m+[0m[0m "Name" = "Salary-Launch-Template"
        }
      [32m+[0m[0m user_data       = "IyEvYmluL2Jhc2gKY2QgU2FsYXJ5LUFQSS8KbWFrZSBydW4tbWlncmF0aW9ucwptYWtlIGJ1aWxkCg=="

      [32m+[0m[0m network_interfaces {
          [32m+[0m[0m security_groups = (known after apply)
          [32m+[0m[0m subnet_id       = "subnet-03e34296260c1c84d"
        }
    }

[1m  # aws_lb.Dev_Alb[0m will be created
[0m  [32m+[0m[0m resource "aws_lb" "Dev_Alb" {
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
      [32m+[0m[0m name                                                         = "Dev-ALB"
      [32m+[0m[0m name_prefix                                                  = (known after apply)
      [32m+[0m[0m preserve_host_header                                         = false
      [32m+[0m[0m security_groups                                              = [
          [32m+[0m[0m "sg-058b1ce89cc72c92f",
        ]
      [32m+[0m[0m subnets                                                      = [
          [32m+[0m[0m "subnet-0617c653773732b23",
          [32m+[0m[0m "subnet-0d3ca0eaa48f20939",
        ]
      [32m+[0m[0m tags                                                         = {
          [32m+[0m[0m "Name" = "Dev-ALB"
        }
      [32m+[0m[0m tags_all                                                     = {
          [32m+[0m[0m "Name" = "Dev-ALB"
        }
      [32m+[0m[0m vpc_id                                                       = (known after apply)
      [32m+[0m[0m xff_header_processing_mode                                   = "append"
      [32m+[0m[0m zone_id                                                      = (known after apply)
    }

[1m  # aws_lb_listener_rule.path_rule[0m will be created
[0m  [32m+[0m[0m resource "aws_lb_listener_rule" "path_rule" {
      [32m+[0m[0m arn          = (known after apply)
      [32m+[0m[0m id           = (known after apply)
      [32m+[0m[0m listener_arn = "arn:aws:elasticloadbalancing:us-east-2:533267160240:listener/app/ALB/be4a2629e59585f7/63e7603c1a41fc34"
      [32m+[0m[0m priority     = 100
      [32m+[0m[0m tags_all     = (known after apply)

      [32m+[0m[0m action {
          [32m+[0m[0m order            = (known after apply)
          [32m+[0m[0m target_group_arn = (known after apply)
          [32m+[0m[0m type             = "forward"
        }

      [32m+[0m[0m condition {
          [32m+[0m[0m path_pattern {
              [32m+[0m[0m values = [
                  [32m+[0m[0m "/api/v1/salary/*",
                ]
            }
        }
    }

[1m  # aws_lb_target_group.Target_group[0m will be created
[0m  [32m+[0m[0m resource "aws_lb_target_group" "Target_group" {
      [32m+[0m[0m arn                                = (known after apply)
      [32m+[0m[0m arn_suffix                         = (known after apply)
      [32m+[0m[0m connection_termination             = (known after apply)
      [32m+[0m[0m deregistration_delay               = "300"
      [32m+[0m[0m id                                 = (known after apply)
      [32m+[0m[0m ip_address_type                    = (known after apply)
      [32m+[0m[0m lambda_multi_value_headers_enabled = false
      [32m+[0m[0m load_balancer_arns                 = (known after apply)
      [32m+[0m[0m load_balancing_algorithm_type      = (known after apply)
      [32m+[0m[0m load_balancing_anomaly_mitigation  = (known after apply)
      [32m+[0m[0m load_balancing_cross_zone_enabled  = (known after apply)
      [32m+[0m[0m name                               = "Dev-Salary-TG"
      [32m+[0m[0m name_prefix                        = (known after apply)
      [32m+[0m[0m port                               = 80
      [32m+[0m[0m preserve_client_ip                 = (known after apply)
      [32m+[0m[0m protocol                           = "HTTP"
      [32m+[0m[0m protocol_version                   = (known after apply)
      [32m+[0m[0m proxy_protocol_v2                  = false
      [32m+[0m[0m slow_start                         = 0
      [32m+[0m[0m tags                               = {
          [32m+[0m[0m "Name" = "Dev-Salary-TG"
        }
      [32m+[0m[0m tags_all                           = {
          [32m+[0m[0m "Name" = "Dev-Salary-TG"
        }
      [32m+[0m[0m target_type                        = "instance"
      [32m+[0m[0m vpc_id                             = "vpc-0c927c113819d1a70"

      [32m+[0m[0m health_check {
          [32m+[0m[0m enabled             = true
          [32m+[0m[0m healthy_threshold   = 5
          [32m+[0m[0m interval            = 30
          [32m+[0m[0m matcher             = (known after apply)
          [32m+[0m[0m path                = "/api/v1/salary/health"
          [32m+[0m[0m port                = "traffic-port"
          [32m+[0m[0m protocol            = "HTTP"
          [32m+[0m[0m timeout             = 5
          [32m+[0m[0m unhealthy_threshold = 2
        }
    }

[1m  # aws_security_group.salary-sg[0m will be created
[0m  [32m+[0m[0m resource "aws_security_group" "salary-sg" {
      [32m+[0m[0m arn                    = (known after apply)
      [32m+[0m[0m description            = "Security group for Salary API"
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
                  [32m+[0m[0m "sg-07aeb9cf56a804770",
                ]
              [32m+[0m[0m self             = false
              [32m+[0m[0m to_port          = 22
            },
          [32m+[0m[0m {
              [32m+[0m[0m cidr_blocks      = []
              [32m+[0m[0m description      = ""
              [32m+[0m[0m from_port        = 8080
              [32m+[0m[0m ipv6_cidr_blocks = []
              [32m+[0m[0m prefix_list_ids  = []
              [32m+[0m[0m protocol         = "tcp"
              [32m+[0m[0m security_groups  = [
                  [32m+[0m[0m "sg-058b1ce89cc72c92f",
                ]
              [32m+[0m[0m self             = false
              [32m+[0m[0m to_port          = 8080
            },
        ]
      [32m+[0m[0m name                   = "salary-sg"
      [32m+[0m[0m name_prefix            = (known after apply)
      [32m+[0m[0m owner_id               = (known after apply)
      [32m+[0m[0m revoke_rules_on_delete = false
      [32m+[0m[0m tags                   = {
          [32m+[0m[0m "Environment" = "Dev"
          [32m+[0m[0m "Name"        = "Salary-sg"
          [32m+[0m[0m "Owner"       = "Shikha"
        }
      [32m+[0m[0m tags_all               = {
          [32m+[0m[0m "Environment" = "Dev"
          [32m+[0m[0m "Name"        = "Salary-sg"
          [32m+[0m[0m "Owner"       = "Shikha"
        }
      [32m+[0m[0m vpc_id                 = "vpc-0c927c113819d1a70"
    }

[1m  # local_file.private_key[0m will be created
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
      [32m+[0m[0m filename             = "Dev_Key.pem"
      [32m+[0m[0m id                   = (known after apply)
    }

[1m  # tls_private_key.private_key[0m will be created
[0m  [32m+[0m[0m resource "tls_private_key" "private_key" {
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

[1mPlan:[0m 11 to add, 0 to change, 0 to destroy.
[0m
Changes to Outputs:
  [32m+[0m[0m ALB_arn                 = [
      [32m+[0m[0m (known after apply),
    ]
  [32m+[0m[0m AMI_ID                  = [
      [32m+[0m[0m (known after apply),
    ]
  [32m+[0m[0m Autoscaling_group_id    = [
      [32m+[0m[0m (known after apply),
    ]
  [32m+[0m[0m Autoscaling_policy_name = [
      [32m+[0m[0m "target-tracking-policy",
    ]
  [32m+[0m[0m Target_group_id         = [
      [32m+[0m[0m (known after apply),
    ]
  [32m+[0m[0m key_pair_name           = [
      [32m+[0m[0m "Dev_Key",
    ]
  [32m+[0m[0m launch_template_id      = (known after apply)
  [32m+[0m[0m load_balancer_dns_name  = [
      [32m+[0m[0m (known after apply),
    ]
  [32m+[0m[0m security_group_id       = (known after apply)
  [32m+[0m[0m target_group_arn        = [
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
Approved by Admin Broo
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

[1m  # aws_ami_from_instance.AMI[0m will be created
[0m  [32m+[0m[0m resource "aws_ami_from_instance" "AMI" {
      [32m+[0m[0m architecture         = (known after apply)
      [32m+[0m[0m arn                  = (known after apply)
      [32m+[0m[0m boot_mode            = (known after apply)
      [32m+[0m[0m ena_support          = (known after apply)
      [32m+[0m[0m hypervisor           = (known after apply)
      [32m+[0m[0m id                   = (known after apply)
      [32m+[0m[0m image_location       = (known after apply)
      [32m+[0m[0m image_owner_alias    = (known after apply)
      [32m+[0m[0m image_type           = (known after apply)
      [32m+[0m[0m imds_support         = (known after apply)
      [32m+[0m[0m kernel_id            = (known after apply)
      [32m+[0m[0m manage_ebs_snapshots = (known after apply)
      [32m+[0m[0m name                 = "Dev-Salary-AMI"
      [32m+[0m[0m owner_id             = (known after apply)
      [32m+[0m[0m platform             = (known after apply)
      [32m+[0m[0m platform_details     = (known after apply)
      [32m+[0m[0m public               = (known after apply)
      [32m+[0m[0m ramdisk_id           = (known after apply)
      [32m+[0m[0m root_device_name     = (known after apply)
      [32m+[0m[0m root_snapshot_id     = (known after apply)
      [32m+[0m[0m source_instance_id   = "i-059e99af9483ecb56"
      [32m+[0m[0m sriov_net_support    = (known after apply)
      [32m+[0m[0m tags_all             = (known after apply)
      [32m+[0m[0m tpm_support          = (known after apply)
      [32m+[0m[0m usage_operation      = (known after apply)
      [32m+[0m[0m virtualization_type  = (known after apply)
    }

[1m  # aws_autoscaling_group.Salary_asg[0m will be created
[0m  [32m+[0m[0m resource "aws_autoscaling_group" "Salary_asg" {
      [32m+[0m[0m arn                              = (known after apply)
      [32m+[0m[0m availability_zones               = (known after apply)
      [32m+[0m[0m default_cooldown                 = (known after apply)
      [32m+[0m[0m desired_capacity                 = 1
      [32m+[0m[0m force_delete                     = false
      [32m+[0m[0m force_delete_warm_pool           = false
      [32m+[0m[0m health_check_grace_period        = 300
      [32m+[0m[0m health_check_type                = (known after apply)
      [32m+[0m[0m id                               = (known after apply)
      [32m+[0m[0m ignore_failed_scaling_activities = false
      [32m+[0m[0m load_balancers                   = (known after apply)
      [32m+[0m[0m max_size                         = 2
      [32m+[0m[0m metrics_granularity              = "1Minute"
      [32m+[0m[0m min_size                         = 1
      [32m+[0m[0m name                             = "Dev_Salary_ASG"
      [32m+[0m[0m name_prefix                      = (known after apply)
      [32m+[0m[0m predicted_capacity               = (known after apply)
      [32m+[0m[0m protect_from_scale_in            = false
      [32m+[0m[0m service_linked_role_arn          = (known after apply)
      [32m+[0m[0m target_group_arns                = (known after apply)
      [32m+[0m[0m vpc_zone_identifier              = [
          [32m+[0m[0m "subnet-0617c653773732b23",
        ]
      [32m+[0m[0m wait_for_capacity_timeout        = "10m"
      [32m+[0m[0m warm_pool_size                   = (known after apply)

      [32m+[0m[0m launch_template {
          [32m+[0m[0m id      = (known after apply)
          [32m+[0m[0m name    = (known after apply)
          [32m+[0m[0m version = (known after apply)
        }

      [32m+[0m[0m tag {
          [32m+[0m[0m key                 = "Name"
          [32m+[0m[0m propagate_at_launch = false
          [32m+[0m[0m value               = "Dev_Salary_ASG"
        }
    }

[1m  # aws_autoscaling_policy.Salary_ASG_Policy[0m will be created
[0m  [32m+[0m[0m resource "aws_autoscaling_policy" "Salary_ASG_Policy" {
      [32m+[0m[0m arn                     = (known after apply)
      [32m+[0m[0m autoscaling_group_name  = "Dev_Salary_ASG"
      [32m+[0m[0m enabled                 = true
      [32m+[0m[0m id                      = (known after apply)
      [32m+[0m[0m metric_aggregation_type = (known after apply)
      [32m+[0m[0m name                    = "target-tracking-policy"
      [32m+[0m[0m policy_type             = "TargetTrackingScaling"

      [32m+[0m[0m target_tracking_configuration {
          [32m+[0m[0m disable_scale_in = false
          [32m+[0m[0m target_value     = 50

          [32m+[0m[0m predefined_metric_specification {
              [32m+[0m[0m predefined_metric_type = "ASGAverageCPUUtilization"
            }
        }
    }

[1m  # aws_key_pair.key_pair[0m will be created
[0m  [32m+[0m[0m resource "aws_key_pair" "key_pair" {
      [32m+[0m[0m arn             = (known after apply)
      [32m+[0m[0m fingerprint     = (known after apply)
      [32m+[0m[0m id              = (known after apply)
      [32m+[0m[0m key_name        = "Dev_Key"
      [32m+[0m[0m key_name_prefix = (known after apply)
      [32m+[0m[0m key_pair_id     = (known after apply)
      [32m+[0m[0m key_type        = (known after apply)
      [32m+[0m[0m public_key      = (known after apply)
      [32m+[0m[0m tags_all        = (known after apply)
    }

[1m  # aws_launch_template.Salary_Launch_Template[0m will be created
[0m  [32m+[0m[0m resource "aws_launch_template" "Salary_Launch_Template" {
      [32m+[0m[0m arn             = (known after apply)
      [32m+[0m[0m default_version = (known after apply)
      [32m+[0m[0m description     = "Launch template for salary api"
      [32m+[0m[0m id              = (known after apply)
      [32m+[0m[0m image_id        = (known after apply)
      [32m+[0m[0m instance_type   = "t2.micro"
      [32m+[0m[0m key_name        = "Dev_Key"
      [32m+[0m[0m latest_version  = (known after apply)
      [32m+[0m[0m name            = "Salary-Launch-Template"
      [32m+[0m[0m name_prefix     = (known after apply)
      [32m+[0m[0m tags            = {
          [32m+[0m[0m "Name" = "Salary-Launch-Template"
        }
      [32m+[0m[0m tags_all        = {
          [32m+[0m[0m "Name" = "Salary-Launch-Template"
        }
      [32m+[0m[0m user_data       = "IyEvYmluL2Jhc2gKY2QgU2FsYXJ5LUFQSS8KbWFrZSBydW4tbWlncmF0aW9ucwptYWtlIGJ1aWxkCg=="

      [32m+[0m[0m network_interfaces {
          [32m+[0m[0m security_groups = (known after apply)
          [32m+[0m[0m subnet_id       = "subnet-03e34296260c1c84d"
        }
    }

[1m  # aws_lb.Dev_Alb[0m will be created
[0m  [32m+[0m[0m resource "aws_lb" "Dev_Alb" {
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
      [32m+[0m[0m name                                                         = "Dev-ALB"
      [32m+[0m[0m name_prefix                                                  = (known after apply)
      [32m+[0m[0m preserve_host_header                                         = false
      [32m+[0m[0m security_groups                                              = [
          [32m+[0m[0m "sg-058b1ce89cc72c92f",
        ]
      [32m+[0m[0m subnets                                                      = [
          [32m+[0m[0m "subnet-0617c653773732b23",
          [32m+[0m[0m "subnet-0d3ca0eaa48f20939",
        ]
      [32m+[0m[0m tags                                                         = {
          [32m+[0m[0m "Name" = "Dev-ALB"
        }
      [32m+[0m[0m tags_all                                                     = {
          [32m+[0m[0m "Name" = "Dev-ALB"
        }
      [32m+[0m[0m vpc_id                                                       = (known after apply)
      [32m+[0m[0m xff_header_processing_mode                                   = "append"
      [32m+[0m[0m zone_id                                                      = (known after apply)
    }

[1m  # aws_lb_listener_rule.path_rule[0m will be created
[0m  [32m+[0m[0m resource "aws_lb_listener_rule" "path_rule" {
      [32m+[0m[0m arn          = (known after apply)
      [32m+[0m[0m id           = (known after apply)
      [32m+[0m[0m listener_arn = "arn:aws:elasticloadbalancing:us-east-2:533267160240:listener/app/ALB/be4a2629e59585f7/63e7603c1a41fc34"
      [32m+[0m[0m priority     = 100
      [32m+[0m[0m tags_all     = (known after apply)

      [32m+[0m[0m action {
          [32m+[0m[0m order            = (known after apply)
          [32m+[0m[0m target_group_arn = (known after apply)
          [32m+[0m[0m type             = "forward"
        }

      [32m+[0m[0m condition {
          [32m+[0m[0m path_pattern {
              [32m+[0m[0m values = [
                  [32m+[0m[0m "/api/v1/salary/*",
                ]
            }
        }
    }

[1m  # aws_lb_target_group.Target_group[0m will be created
[0m  [32m+[0m[0m resource "aws_lb_target_group" "Target_group" {
      [32m+[0m[0m arn                                = (known after apply)
      [32m+[0m[0m arn_suffix                         = (known after apply)
      [32m+[0m[0m connection_termination             = (known after apply)
      [32m+[0m[0m deregistration_delay               = "300"
      [32m+[0m[0m id                                 = (known after apply)
      [32m+[0m[0m ip_address_type                    = (known after apply)
      [32m+[0m[0m lambda_multi_value_headers_enabled = false
      [32m+[0m[0m load_balancer_arns                 = (known after apply)
      [32m+[0m[0m load_balancing_algorithm_type      = (known after apply)
      [32m+[0m[0m load_balancing_anomaly_mitigation  = (known after apply)
      [32m+[0m[0m load_balancing_cross_zone_enabled  = (known after apply)
      [32m+[0m[0m name                               = "Dev-Salary-TG"
      [32m+[0m[0m name_prefix                        = (known after apply)
      [32m+[0m[0m port                               = 80
      [32m+[0m[0m preserve_client_ip                 = (known after apply)
      [32m+[0m[0m protocol                           = "HTTP"
      [32m+[0m[0m protocol_version                   = (known after apply)
      [32m+[0m[0m proxy_protocol_v2                  = false
      [32m+[0m[0m slow_start                         = 0
      [32m+[0m[0m tags                               = {
          [32m+[0m[0m "Name" = "Dev-Salary-TG"
        }
      [32m+[0m[0m tags_all                           = {
          [32m+[0m[0m "Name" = "Dev-Salary-TG"
        }
      [32m+[0m[0m target_type                        = "instance"
      [32m+[0m[0m vpc_id                             = "vpc-0c927c113819d1a70"

      [32m+[0m[0m health_check {
          [32m+[0m[0m enabled             = true
          [32m+[0m[0m healthy_threshold   = 5
          [32m+[0m[0m interval            = 30
          [32m+[0m[0m matcher             = (known after apply)
          [32m+[0m[0m path                = "/api/v1/salary/health"
          [32m+[0m[0m port                = "traffic-port"
          [32m+[0m[0m protocol            = "HTTP"
          [32m+[0m[0m timeout             = 5
          [32m+[0m[0m unhealthy_threshold = 2
        }
    }

[1m  # aws_security_group.salary-sg[0m will be created
[0m  [32m+[0m[0m resource "aws_security_group" "salary-sg" {
      [32m+[0m[0m arn                    = (known after apply)
      [32m+[0m[0m description            = "Security group for Salary API"
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
                  [32m+[0m[0m "sg-07aeb9cf56a804770",
                ]
              [32m+[0m[0m self             = false
              [32m+[0m[0m to_port          = 22
            },
          [32m+[0m[0m {
              [32m+[0m[0m cidr_blocks      = []
              [32m+[0m[0m description      = ""
              [32m+[0m[0m from_port        = 8080
              [32m+[0m[0m ipv6_cidr_blocks = []
              [32m+[0m[0m prefix_list_ids  = []
              [32m+[0m[0m protocol         = "tcp"
              [32m+[0m[0m security_groups  = [
                  [32m+[0m[0m "sg-058b1ce89cc72c92f",
                ]
              [32m+[0m[0m self             = false
              [32m+[0m[0m to_port          = 8080
            },
        ]
      [32m+[0m[0m name                   = "salary-sg"
      [32m+[0m[0m name_prefix            = (known after apply)
      [32m+[0m[0m owner_id               = (known after apply)
      [32m+[0m[0m revoke_rules_on_delete = false
      [32m+[0m[0m tags                   = {
          [32m+[0m[0m "Environment" = "Dev"
          [32m+[0m[0m "Name"        = "Salary-sg"
          [32m+[0m[0m "Owner"       = "Shikha"
        }
      [32m+[0m[0m tags_all               = {
          [32m+[0m[0m "Environment" = "Dev"
          [32m+[0m[0m "Name"        = "Salary-sg"
          [32m+[0m[0m "Owner"       = "Shikha"
        }
      [32m+[0m[0m vpc_id                 = "vpc-0c927c113819d1a70"
    }

[1m  # local_file.private_key[0m will be created
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
      [32m+[0m[0m filename             = "Dev_Key.pem"
      [32m+[0m[0m id                   = (known after apply)
    }

[1m  # tls_private_key.private_key[0m will be created
[0m  [32m+[0m[0m resource "tls_private_key" "private_key" {
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

[1mPlan:[0m 11 to add, 0 to change, 0 to destroy.
[0m
Changes to Outputs:
  [32m+[0m[0m ALB_arn                 = [
      [32m+[0m[0m (known after apply),
    ]
  [32m+[0m[0m AMI_ID                  = [
      [32m+[0m[0m (known after apply),
    ]
  [32m+[0m[0m Autoscaling_group_id    = [
      [32m+[0m[0m (known after apply),
    ]
  [32m+[0m[0m Autoscaling_policy_name = [
      [32m+[0m[0m "target-tracking-policy",
    ]
  [32m+[0m[0m Target_group_id         = [
      [32m+[0m[0m (known after apply),
    ]
  [32m+[0m[0m key_pair_name           = [
      [32m+[0m[0m "Dev_Key",
    ]
  [32m+[0m[0m launch_template_id      = (known after apply)
  [32m+[0m[0m load_balancer_dns_name  = [
      [32m+[0m[0m (known after apply),
    ]
  [32m+[0m[0m security_group_id       = (known after apply)
  [32m+[0m[0m target_group_arn        = [
      [32m+[0m[0m (known after apply),
    ]
[0m[1mtls_private_key.private_key: Creating...[0m[0m
[0m[1maws_lb.Dev_Alb: Creating...[0m[0m
[0m[1maws_lb_target_group.Target_group: Creating...[0m[0m
[0m[1maws_security_group.salary-sg: Creating...[0m[0m
[0m[1maws_ami_from_instance.AMI: Creating...[0m[0m
[0m[1maws_lb_target_group.Target_group: Creation complete after 1s [id=arn:aws:elasticloadbalancing:us-east-2:533267160240:targetgroup/Dev-Salary-TG/873a33277b0a4674][0m
[0m[1maws_lb_listener_rule.path_rule: Creating...[0m[0m
[0m[1maws_lb_listener_rule.path_rule: Creation complete after 0s [id=arn:aws:elasticloadbalancing:us-east-2:533267160240:listener-rule/app/ALB/be4a2629e59585f7/63e7603c1a41fc34/2bd1868d7b7a5d10][0m
[0m[1maws_security_group.salary-sg: Creation complete after 2s [id=sg-060445cb3f121cab1][0m
[0m[1mtls_private_key.private_key: Creation complete after 6s [id=096a9ebfddeee94de2c12c15708bf8f303cb3310][0m
[0m[1maws_key_pair.key_pair: Creating...[0m[0m
[0m[1mlocal_file.private_key: Creating...[0m[0m
[0m[1mlocal_file.private_key: Creation complete after 0s [id=a86a8839bf6588d1f3b61150f1df96ecefb66af5][0m
[0m[1maws_key_pair.key_pair: Creation complete after 0s [id=Dev_Key][0m
[0m[1maws_lb.Dev_Alb: Still creating... [10s elapsed][0m[0m
[0m[1maws_ami_from_instance.AMI: Still creating... [10s elapsed][0m[0m
[0m[1maws_lb.Dev_Alb: Still creating... [20s elapsed][0m[0m
[0m[1maws_ami_from_instance.AMI: Still creating... [20s elapsed][0m[0m
[0m[1maws_lb.Dev_Alb: Still creating... [30s elapsed][0m[0m
[0m[1maws_ami_from_instance.AMI: Still creating... [30s elapsed][0m[0m
[0m[1maws_lb.Dev_Alb: Still creating... [40s elapsed][0m[0m
[0m[1maws_ami_from_instance.AMI: Still creating... [40s elapsed][0m[0m
[0m[1maws_lb.Dev_Alb: Still creating... [50s elapsed][0m[0m
[0m[1maws_ami_from_instance.AMI: Still creating... [50s elapsed][0m[0m
[0m[1maws_lb.Dev_Alb: Still creating... [1m0s elapsed][0m[0m
[0m[1maws_ami_from_instance.AMI: Still creating... [1m0s elapsed][0m[0m
[0m[1maws_lb.Dev_Alb: Still creating... [1m10s elapsed][0m[0m
[0m[1maws_ami_from_instance.AMI: Still creating... [1m10s elapsed][0m[0m
[0m[1maws_lb.Dev_Alb: Still creating... [1m20s elapsed][0m[0m
[0m[1maws_ami_from_instance.AMI: Still creating... [1m20s elapsed][0m[0m
[0m[1maws_lb.Dev_Alb: Still creating... [1m30s elapsed][0m[0m
[0m[1maws_ami_from_instance.AMI: Still creating... [1m30s elapsed][0m[0m
[0m[1maws_lb.Dev_Alb: Still creating... [1m40s elapsed][0m[0m
[0m[1maws_ami_from_instance.AMI: Still creating... [1m40s elapsed][0m[0m
[0m[1maws_lb.Dev_Alb: Still creating... [1m50s elapsed][0m[0m
[0m[1maws_ami_from_instance.AMI: Still creating... [1m50s elapsed][0m[0m
[0m[1maws_lb.Dev_Alb: Still creating... [2m0s elapsed][0m[0m
[0m[1maws_ami_from_instance.AMI: Still creating... [2m0s elapsed][0m[0m
[0m[1maws_lb.Dev_Alb: Still creating... [2m10s elapsed][0m[0m
[0m[1maws_ami_from_instance.AMI: Still creating... [2m10s elapsed][0m[0m
[0m[1maws_lb.Dev_Alb: Still creating... [2m20s elapsed][0m[0m
[0m[1maws_ami_from_instance.AMI: Still creating... [2m20s elapsed][0m[0m
[0m[1maws_lb.Dev_Alb: Still creating... [2m30s elapsed][0m[0m
[0m[1maws_ami_from_instance.AMI: Still creating... [2m30s elapsed][0m[0m
[0m[1maws_lb.Dev_Alb: Still creating... [2m40s elapsed][0m[0m
[0m[1maws_ami_from_instance.AMI: Still creating... [2m40s elapsed][0m[0m
[0m[1maws_lb.Dev_Alb: Still creating... [2m50s elapsed][0m[0m
[0m[1maws_ami_from_instance.AMI: Still creating... [2m50s elapsed][0m[0m
[0m[1maws_lb.Dev_Alb: Creation complete after 2m52s [id=arn:aws:elasticloadbalancing:us-east-2:533267160240:loadbalancer/app/Dev-ALB/ea022b2b4bc84583][0m
[0m[1maws_ami_from_instance.AMI: Still creating... [3m0s elapsed][0m[0m
[0m[1maws_ami_from_instance.AMI: Creation complete after 3m6s [id=ami-02dedf70cd7a56bab][0m
[0m[1maws_launch_template.Salary_Launch_Template: Creating...[0m[0m
[0m[1maws_launch_template.Salary_Launch_Template: Creation complete after 0s [id=lt-0562c48598ed4893c][0m
[0m[1maws_autoscaling_group.Salary_asg: Creating...[0m[0m
[0m[1maws_autoscaling_group.Salary_asg: Still creating... [10s elapsed][0m[0m
[0m[1maws_autoscaling_group.Salary_asg: Still creating... [20s elapsed][0m[0m
[0m[1maws_autoscaling_group.Salary_asg: Still creating... [30s elapsed][0m[0m
[0m[1maws_autoscaling_group.Salary_asg: Still creating... [40s elapsed][0m[0m
[0m[1maws_autoscaling_group.Salary_asg: Creation complete after 46s [id=Dev_Salary_ASG][0m
[0m[1maws_autoscaling_policy.Salary_ASG_Policy: Creating...[0m[0m
[0m[1maws_autoscaling_policy.Salary_ASG_Policy: Creation complete after 1s [id=target-tracking-policy][0m
[0m[1m[32m
Apply complete! Resources: 11 added, 0 changed, 0 destroyed.
[0m[0m[1m[32m
Outputs:

[0mALB_arn = [
  "arn:aws:elasticloadbalancing:us-east-2:533267160240:loadbalancer/app/Dev-ALB/ea022b2b4bc84583",
]
AMI_ID = [
  "ami-02dedf70cd7a56bab",
]
Autoscaling_group_id = [
  "Dev_Salary_ASG",
]
Autoscaling_policy_name = [
  "target-tracking-policy",
]
Target_group_id = [
  "arn:aws:elasticloadbalancing:us-east-2:533267160240:targetgroup/Dev-Salary-TG/873a33277b0a4674",
]
key_pair_name = [
  "Dev_Key",
]
launch_template_id = "lt-0562c48598ed4893c"
load_balancer_dns_name = [
  "Dev-ALB-1121411991.us-east-2.elb.amazonaws.com",
]
security_group_id = "sg-060445cb3f121cab1"
target_group_arn = [
  "arn:aws:elasticloadbalancing:us-east-2:533267160240:targetgroup/Dev-Salary-TG/873a33277b0a4674",
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

**AMI Output (Dev-Salary-AMI)**

It uses the aws_ami_from_instance resource to create an AMI from an existing EC2 instance (source_instance_id variable specifies the instance ID).

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/d8f32ffb-21ed-4a58-af9d-275fc1063b93)

***

**Security Group for Salary (Salary-sg)**
 
Defines a security group with inbound and outbound rules for controlling traffic to and from instances. It dynamically creates rules based on the provided inbound_ports and outbound_ports variables.

  ![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/34185125-fbb5-468b-ba52-be98a4a9c42b)

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/bd3c66ff-0f65-4633-b2a8-97eac02351b6)


***

**SSH Key Pair for Salary (Dev_Key)**

It generates an SSH key pair using the tls_private_key and aws_key_pair resources.

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/1fc4cc1b-b130-472f-9261-98c27d43b799)


***

**Launch Template for Salary (Salary-Launch-Template)**

Creates a launch template for EC2 instances with configurations such as AMI, instance type, key pair, security group, and user data script.

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/1f39aada-027a-459d-80a4-d5f139ba77de)

***

**Load Balancer for Salary (Dev-ALB)**

Configures an Application Load Balancer (ALB) with a listener and default action forwarding requests to the target group.

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/c0b7946a-a068-4b9f-a1bd-dde0a767e438)

***

**Auto Scaling Group for Salary (Dev_Salary_ASG)**

Sets up an auto-scaling group with configurations such as launch template, minimum size, maximum size, desired capacity, VPC zone identifier, and target group ARN.

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/7cf29b47-83d2-47c0-907b-b8ef894cfd28)

***

**Auto Scaling Policy**

Defines an auto-scaling policy for the auto-scaling group. It uses target tracking scaling with predefined metric specifications.

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/22a53360-b488-48f2-a5a4-160837a07bc4)

***

**Target Group for Salary(Dev-Salary-TG)**

Defines a target group for routing requests to registered instances. It includes health check configurations.

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/ac730138-4af7-4e63-83af-539753300067)

***

**Archive Artifact (SSH key pair - Dev_Key)**

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/ef361bd0-305f-45ec-9acb-1053589fa866)


***

# Related Works

| **References** |
| -------------- |
| [Salary API Terraform Code](https://github.com/CodeOps-Hub/Terraform/tree/main/Dev_Infra/Static_Tf/Salary) |

***

## Conclusion

In conclusion, our DSL Pipeline offers a powerful solution for creating and managing domain-specific languages, enabling developers to express complex ideas in a concise and understandable manner. By embracing DSLs, organizations can accelerate development cycles, improve collaboration between domain experts and developers, and ultimately deliver higher-quality software solutions. 

***

## Contact Information

| Name            | Email Address                        |
|-----------------|--------------------------------------|
| Khushi Malhotra | khushi.malhotra.snaatak@mygurukulam.co |
| Shikha Tripathi | shikha.tripathi.snaatak@mygurukulam.co |

***

## References

| **Source** | **Description** |
| ---------- | --------------- |
| [Link](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GenericDoc/Terraform/terraform.md) | Terraform Generic Doc Link. |
| [Link](https://developer.hashicorp.com/terraform/language/modules) | Terraform Module Concept. |
| [Link](https://www.linkedin.com/pulse/how-run-terraform-script-jenkins-step-by-step-guide-praveen-dandu) | Reference Link For DSL Pipeline. |
| [Link](https://medium.com/appgambit/terraform-with-jenkins-pipeline-439babe4095c)  | Jenkins DSL Pipeline Doc reference link. |
