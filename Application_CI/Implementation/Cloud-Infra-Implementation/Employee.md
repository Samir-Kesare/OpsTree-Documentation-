# Employee API Infra Documentation

|<img width="360" length="100" alt="Terraform" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/556e50dc-0c8b-4262-be16-2c384d2cfa8a">

***

|   Author        |  Created on   |  Version   | Last updated by  | Last edited on |
| --------------- | --------------| -----------|----------------- | -------------- |
| Khushi Malhotra | 06 March 2024 |  Version 1 | Khushi Malhotra  | 07 March 2024  |

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

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/addfcec0-cd38-4d5e-904e-0da2a3c63956)

***

## Pre-requisites

| **Pre-requisites** | **Description** |
| ------------------ | ---------------- |
| **AWS Account**    | Access to the AWS Management Console with credentials configured. |
| **Jenkins**        | To integrate infra through DSL Pipeline. |
| **Terraform**      | Terraform HCL (v1.7.4) | ****

***

## [Jenkinsfile](https://github.com/CodeOps-Hub/Jenkinsfile/blob/khushi/Employee_Pipeline/Employee_Pipeline/Jenkinsfile)

```shell
pipeline {
    agent any
    
    environment {
        AWS_ACCESS_KEY_ID     = credentials('shantanu_creds')
        AWS_SECRET_ACCESS_KEY = credentials('shantanu_creds')
        TF_CLI_ARGS           = '-input=false'
    }
    
    parameters {
        choice(name: 'ACTION', choices: ['Apply', 'Destroy'], description: 'Choose to apply or destroy the infrastructure')
    }
    
    stages {
        stage('Checkout') {
            steps {
                git branch: 'Khushi/EmployeePipeline', credentialsId: 'Harshit-Github-PAT', url: 'https://github.com/CodeOps-Hub/Terraform.git'
            }
        }
        
        stage('Copy Terraform Files') {
            steps {
                // Copy or move specific files from the repository to Jenkins workspace
                sh 'cp Dev_Infra/Static_Tf/Employee/* .'
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

**This Jenkins pipeline automates the deployment of a Attendance API infrastructure using Terraform. It's configured to perform the following actions:**

### Terraform Deployment Pipeline Overview

| Stage                   | Description                                                                                                                                                                      |
|-------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Checkout**            | Fetches the Terraform code from a GitHub repository branch (`main`). |                                                                                    
| **Copy Terraform Files**    | Copies Employee-related Terraform configuration files to the Jenkins workspace. |                                                                                                
| **Terraform Init**          | Initializes Terraform in the workspace directory. |                                                                                                                                
| **Terraform Plan**          | Generates a Terraform execution plan to preview the changes. |                                                                                                                     
| **Review and Approve Apply** | Asks for approval before applying Terraform changes if the selected action is "Apply". |                                                                                       
| **Review and Approve Destroy** | Asks for approval before destroying Terraform resources if the selected action is "Destroy". |                                                                            
| **Apply or Destroy**        | Executes Terraform apply or destroy based on the selected action. |                                                                                                               
| **Post**                    | Displays success or failure messages. |                                                                                                                                          
***

## Output

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/567a238a-ccf2-433b-a8b8-701f35662239)


**Blue Ocean Output**

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/2041deb3-52c6-4155-b186-0521edfba1a1)


***

**Console Output**

<details>
<summary> Click here to Console Output </summary>
<br>

```shell
Started by user Admin Broo
Lightweight checkout support not available, falling back to full checkout.
Checking out git https://github.com/CodeOps-Hub/Jenkinsfile.git into /var/lib/jenkins/workspace/Employee_API@script/5c437dca2a0dbfc0911c34629742fb588229e41b5397ea7e535d21bab42d1454 to read Employee_Pipeline/Jenkinsfile
Selected Git installation does not exist. Using Default
The recommended git tool is: NONE
using credential Harshit-Github-PAT
 > git rev-parse --resolve-git-dir /var/lib/jenkins/workspace/Employee_API@script/5c437dca2a0dbfc0911c34629742fb588229e41b5397ea7e535d21bab42d1454/.git # timeout=10
Fetching changes from the remote Git repository
 > git config remote.origin.url https://github.com/CodeOps-Hub/Jenkinsfile.git # timeout=10
Fetching upstream changes from https://github.com/CodeOps-Hub/Jenkinsfile.git
 > git --version # timeout=10
 > git --version # 'git version 2.34.1'
using GIT_ASKPASS to set credentials Harshit-Github-PAT
 > git fetch --tags --force --progress -- https://github.com/CodeOps-Hub/Jenkinsfile.git +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git rev-parse refs/remotes/origin/khushi/Employee_Pipeline^{commit} # timeout=10
 > git rev-parse khushi/Employee_Pipeline^{commit} # timeout=10
Checking out Revision f6a7bb17cc7b5a617f6502beafd81839915f5675 (refs/remotes/origin/khushi/Employee_Pipeline)
 > git config core.sparsecheckout # timeout=10
 > git checkout -f f6a7bb17cc7b5a617f6502beafd81839915f5675 # timeout=10
Commit message: "Update Jenkinsfile"
 > git rev-list --no-walk f6a7bb17cc7b5a617f6502beafd81839915f5675 # timeout=10
[Pipeline] Start of Pipeline
[Pipeline] node
Running on Jenkins in /var/lib/jenkins/workspace/Employee_API
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Declarative: Checkout SCM)
[Pipeline] checkout
Selected Git installation does not exist. Using Default
The recommended git tool is: NONE
using credential Harshit-Github-PAT
 > git rev-parse --resolve-git-dir /var/lib/jenkins/workspace/Employee_API/.git # timeout=10
Fetching changes from the remote Git repository
 > git config remote.origin.url https://github.com/CodeOps-Hub/Jenkinsfile.git # timeout=10
Fetching upstream changes from https://github.com/CodeOps-Hub/Jenkinsfile.git
 > git --version # timeout=10
 > git --version # 'git version 2.34.1'
using GIT_ASKPASS to set credentials Harshit-Github-PAT
 > git fetch --tags --force --progress -- https://github.com/CodeOps-Hub/Jenkinsfile.git +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git rev-parse refs/remotes/origin/khushi/Employee_Pipeline^{commit} # timeout=10
 > git rev-parse khushi/Employee_Pipeline^{commit} # timeout=10
Checking out Revision f6a7bb17cc7b5a617f6502beafd81839915f5675 (refs/remotes/origin/khushi/Employee_Pipeline)
 > git config core.sparsecheckout # timeout=10
 > git checkout -f f6a7bb17cc7b5a617f6502beafd81839915f5675 # timeout=10
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
 > git rev-parse --resolve-git-dir /var/lib/jenkins/workspace/Employee_API/.git # timeout=10
Fetching changes from the remote Git repository
 > git config remote.origin.url https://github.com/CodeOps-Hub/Terraform.git # timeout=10
Fetching upstream changes from https://github.com/CodeOps-Hub/Terraform.git
 > git --version # timeout=10
 > git --version # 'git version 2.34.1'
using GIT_ASKPASS to set credentials Harshit-Github-PAT
 > git fetch --tags --force --progress -- https://github.com/CodeOps-Hub/Terraform.git +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git rev-parse refs/remotes/origin/Khushi/EmployeePipeline^{commit} # timeout=10
Checking out Revision c42c7d9fbd636cb3ccbc3458d75fd6a613e21499 (refs/remotes/origin/Khushi/EmployeePipeline)
 > git config core.sparsecheckout # timeout=10
 > git checkout -f c42c7d9fbd636cb3ccbc3458d75fd6a613e21499 # timeout=10
 > git branch -a -v --no-abbrev # timeout=10
 > git branch -D Khushi/EmployeePipeline # timeout=10
 > git checkout -b Khushi/EmployeePipeline c42c7d9fbd636cb3ccbc3458d75fd6a613e21499 # timeout=10
Commit message: "Update variables.tf"
 > git rev-list --no-walk c42c7d9fbd636cb3ccbc3458d75fd6a613e21499 # timeout=10
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Copy Terraform Files)
[Pipeline] sh
+ cp Dev_Infra/Static_Tf/Employee/main.tf Dev_Infra/Static_Tf/Employee/output.tf Dev_Infra/Static_Tf/Employee/provider.tf Dev_Infra/Static_Tf/Employee/script.sh Dev_Infra/Static_Tf/Employee/variables.tf .
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
- Reusing previous version of hashicorp/local from the dependency lock file
- Reusing previous version of hashicorp/tls from the dependency lock file
- Reusing previous version of hashicorp/aws from the dependency lock file
- Using previously-installed hashicorp/aws v5.40.0
- Using previously-installed hashicorp/local v2.4.1
- Using previously-installed hashicorp/tls v4.0.5

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
[0m[1mtls_private_key.private_key: Refreshing state... [id=c6fb51f6b1205e5c07cace9eaef398e9c524c9ac][0m
[0m[1mlocal_file.private_key: Refreshing state... [id=91db992418b891f134384b57c0202c790d50a1d4][0m
[0m[1maws_key_pair.key_pair: Refreshing state... [id=Dev_Key][0m
[0m[1maws_ami_from_instance.AMI: Refreshing state... [id=ami-01f2a686842bd4f9a][0m
[0m[1maws_lb_target_group.Target_group: Refreshing state... [id=arn:aws:elasticloadbalancing:ap-southeast-1:441247711986:targetgroup/Dev-Employee-TG/ed6bb1877b8fd605][0m
[0m[1maws_security_group.security_group: Refreshing state... [id=sg-07c9785cb1aee5ae4][0m
[0m[1maws_lb_listener_rule.path_rule: Refreshing state... [id=arn:aws:elasticloadbalancing:ap-southeast-1:441247711986:listener-rule/app/Dev-ALB/8f76dff48c859255/20e10c3edb27bcd1/d4d8363f086b1548][0m

Terraform used the selected providers to generate the following execution
plan. Resource actions are indicated with the following symbols:
  [32m+[0m create[0m

Terraform will perform the following actions:

[1m  # aws_autoscaling_group.Employee_asg[0m will be created
[0m  [32m+[0m[0m resource "aws_autoscaling_group" "Employee_asg" {
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
      [32m+[0m[0m name                             = "Dev_Employee_ASG"
      [32m+[0m[0m name_prefix                      = (known after apply)
      [32m+[0m[0m predicted_capacity               = (known after apply)
      [32m+[0m[0m protect_from_scale_in            = false
      [32m+[0m[0m service_linked_role_arn          = (known after apply)
      [32m+[0m[0m target_group_arns                = [
          [32m+[0m[0m "arn:aws:elasticloadbalancing:ap-southeast-1:441247711986:targetgroup/Dev-Employee-TG/ed6bb1877b8fd605",
        ]
      [32m+[0m[0m vpc_zone_identifier              = [
          [32m+[0m[0m "subnet-029ac81220960564f",
        ]
      [32m+[0m[0m wait_for_capacity_timeout        = "10m"
      [32m+[0m[0m warm_pool_size                   = (known after apply)

      [32m+[0m[0m launch_template {
          [32m+[0m[0m id      = (known after apply)
          [32m+[0m[0m name    = (known after apply)
          [32m+[0m[0m version = "$Latest"
        }

      [32m+[0m[0m tag {
          [32m+[0m[0m key                 = "Name"
          [32m+[0m[0m propagate_at_launch = true
          [32m+[0m[0m value               = "Dev_Employee_ASG"
        }
    }

[1m  # aws_autoscaling_policy.Dev_ASG_Policy[0m will be created
[0m  [32m+[0m[0m resource "aws_autoscaling_policy" "Dev_ASG_Policy" {
      [32m+[0m[0m arn                     = (known after apply)
      [32m+[0m[0m autoscaling_group_name  = "Dev_Employee_ASG"
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

[1m  # aws_launch_template.Template[0m will be created
[0m  [32m+[0m[0m resource "aws_launch_template" "Template" {
      [32m+[0m[0m arn             = (known after apply)
      [32m+[0m[0m default_version = (known after apply)
      [32m+[0m[0m description     = "Template for Dev-Employee"
      [32m+[0m[0m id              = (known after apply)
      [32m+[0m[0m image_id        = "ami-01f2a686842bd4f9a"
      [32m+[0m[0m instance_type   = "t2.medium"
      [32m+[0m[0m key_name        = "Dev_Key"
      [32m+[0m[0m latest_version  = (known after apply)
      [32m+[0m[0m name            = "Dev-Employee-template"
      [32m+[0m[0m name_prefix     = (known after apply)
      [32m+[0m[0m tags            = {
          [32m+[0m[0m "Name" = "Dev-Employee-template"
        }
      [32m+[0m[0m tags_all        = {
          [32m+[0m[0m "Name" = "Dev-Employee-template"
        }
      [32m+[0m[0m user_data       = "IyEvYmluL2Jhc2gKY2QgZW1wbG95ZWUtYXBpLwptYWtlIGJ1aWxkCmdvIHRlc3QgJChnbyBsaXN0IC4vLi4uIHwgZ3JlcCAtdiBkb2NzIHwgZ3JlcCAtdiBtb2RlbCB8IGdyZXAgLXYgbWFpbi5nbykgLWNvdmVycHJvZmlsZSBjb3Zlci5vdXQKZ28gdG9vbCBjb3ZlciAtaHRtbD1jb3Zlci5vdXQKbWFrZSBydW4tbWlncmF0aW9ucwouL2VtcGxveWVlLWFwaQo="

      [32m+[0m[0m network_interfaces {
          [32m+[0m[0m security_groups = [
              [32m+[0m[0m "sg-07c9785cb1aee5ae4",
            ]
          [32m+[0m[0m subnet_id       = "subnet-029ac81220960564f"
        }
    }

[1mPlan:[0m 3 to add, 0 to change, 0 to destroy.
[0m
Changes to Outputs:
  [32m+[0m[0m Autoscaling_group_id    = [
      [32m+[0m[0m (known after apply),
    ]
  [32m+[0m[0m launch_template_id      = [
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
[0m[1mtls_private_key.private_key: Refreshing state... [id=c6fb51f6b1205e5c07cace9eaef398e9c524c9ac][0m
[0m[1mlocal_file.private_key: Refreshing state... [id=91db992418b891f134384b57c0202c790d50a1d4][0m
[0m[1maws_key_pair.key_pair: Refreshing state... [id=Dev_Key][0m
[0m[1maws_lb_target_group.Target_group: Refreshing state... [id=arn:aws:elasticloadbalancing:ap-southeast-1:441247711986:targetgroup/Dev-Employee-TG/ed6bb1877b8fd605][0m
[0m[1maws_security_group.security_group: Refreshing state... [id=sg-07c9785cb1aee5ae4][0m
[0m[1maws_ami_from_instance.AMI: Refreshing state... [id=ami-01f2a686842bd4f9a][0m
[0m[1maws_lb_listener_rule.path_rule: Refreshing state... [id=arn:aws:elasticloadbalancing:ap-southeast-1:441247711986:listener-rule/app/Dev-ALB/8f76dff48c859255/20e10c3edb27bcd1/d4d8363f086b1548][0m

Terraform used the selected providers to generate the following execution
plan. Resource actions are indicated with the following symbols:
  [32m+[0m create[0m

Terraform will perform the following actions:

[1m  # aws_autoscaling_group.Employee_asg[0m will be created
[0m  [32m+[0m[0m resource "aws_autoscaling_group" "Employee_asg" {
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
      [32m+[0m[0m name                             = "Dev_Employee_ASG"
      [32m+[0m[0m name_prefix                      = (known after apply)
      [32m+[0m[0m predicted_capacity               = (known after apply)
      [32m+[0m[0m protect_from_scale_in            = false
      [32m+[0m[0m service_linked_role_arn          = (known after apply)
      [32m+[0m[0m target_group_arns                = [
          [32m+[0m[0m "arn:aws:elasticloadbalancing:ap-southeast-1:441247711986:targetgroup/Dev-Employee-TG/ed6bb1877b8fd605",
        ]
      [32m+[0m[0m vpc_zone_identifier              = [
          [32m+[0m[0m "subnet-029ac81220960564f",
        ]
      [32m+[0m[0m wait_for_capacity_timeout        = "10m"
      [32m+[0m[0m warm_pool_size                   = (known after apply)

      [32m+[0m[0m launch_template {
          [32m+[0m[0m id      = (known after apply)
          [32m+[0m[0m name    = (known after apply)
          [32m+[0m[0m version = "$Latest"
        }

      [32m+[0m[0m tag {
          [32m+[0m[0m key                 = "Name"
          [32m+[0m[0m propagate_at_launch = true
          [32m+[0m[0m value               = "Dev_Employee_ASG"
        }
    }

[1m  # aws_autoscaling_policy.Dev_ASG_Policy[0m will be created
[0m  [32m+[0m[0m resource "aws_autoscaling_policy" "Dev_ASG_Policy" {
      [32m+[0m[0m arn                     = (known after apply)
      [32m+[0m[0m autoscaling_group_name  = "Dev_Employee_ASG"
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

[1m  # aws_launch_template.Template[0m will be created
[0m  [32m+[0m[0m resource "aws_launch_template" "Template" {
      [32m+[0m[0m arn             = (known after apply)
      [32m+[0m[0m default_version = (known after apply)
      [32m+[0m[0m description     = "Template for Dev-Employee"
      [32m+[0m[0m id              = (known after apply)
      [32m+[0m[0m image_id        = "ami-01f2a686842bd4f9a"
      [32m+[0m[0m instance_type   = "t2.medium"
      [32m+[0m[0m key_name        = "Dev_Key"
      [32m+[0m[0m latest_version  = (known after apply)
      [32m+[0m[0m name            = "Dev-Employee-template"
      [32m+[0m[0m name_prefix     = (known after apply)
      [32m+[0m[0m tags            = {
          [32m+[0m[0m "Name" = "Dev-Employee-template"
        }
      [32m+[0m[0m tags_all        = {
          [32m+[0m[0m "Name" = "Dev-Employee-template"
        }
      [32m+[0m[0m user_data       = "IyEvYmluL2Jhc2gKY2QgZW1wbG95ZWUtYXBpLwptYWtlIGJ1aWxkCmdvIHRlc3QgJChnbyBsaXN0IC4vLi4uIHwgZ3JlcCAtdiBkb2NzIHwgZ3JlcCAtdiBtb2RlbCB8IGdyZXAgLXYgbWFpbi5nbykgLWNvdmVycHJvZmlsZSBjb3Zlci5vdXQKZ28gdG9vbCBjb3ZlciAtaHRtbD1jb3Zlci5vdXQKbWFrZSBydW4tbWlncmF0aW9ucwouL2VtcGxveWVlLWFwaQo="

      [32m+[0m[0m network_interfaces {
          [32m+[0m[0m security_groups = [
              [32m+[0m[0m "sg-07c9785cb1aee5ae4",
            ]
          [32m+[0m[0m subnet_id       = "subnet-029ac81220960564f"
        }
    }

[1mPlan:[0m 3 to add, 0 to change, 0 to destroy.
[0m
Changes to Outputs:
  [32m+[0m[0m Autoscaling_group_id    = [
      [32m+[0m[0m (known after apply),
    ]
  [32m+[0m[0m launch_template_id      = [
      [32m+[0m[0m (known after apply),
    ]
[0m[1maws_launch_template.Template: Creating...[0m[0m
[0m[1maws_launch_template.Template: Creation complete after 2s [id=lt-0eb9ee3bf72ce8ab8][0m
[0m[1maws_autoscaling_group.Employee_asg: Creating...[0m[0m
[0m[1maws_autoscaling_group.Employee_asg: Still creating... [10s elapsed][0m[0m
[0m[1maws_autoscaling_group.Employee_asg: Still creating... [20s elapsed][0m[0m
[0m[1maws_autoscaling_group.Employee_asg: Still creating... [30s elapsed][0m[0m
[0m[1maws_autoscaling_group.Employee_asg: Still creating... [40s elapsed][0m[0m
[0m[1maws_autoscaling_group.Employee_asg: Still creating... [50s elapsed][0m[0m
[0m[1maws_autoscaling_group.Employee_asg: Still creating... [1m0s elapsed][0m[0m
[0m[1maws_autoscaling_group.Employee_asg: Still creating... [1m10s elapsed][0m[0m
[0m[1maws_autoscaling_group.Employee_asg: Still creating... [1m20s elapsed][0m[0m
[0m[1maws_autoscaling_group.Employee_asg: Creation complete after 1m21s [id=Dev_Employee_ASG][0m
[0m[1maws_autoscaling_policy.Dev_ASG_Policy: Creating...[0m[0m
[0m[1maws_autoscaling_policy.Dev_ASG_Policy: Creation complete after 1s [id=target-tracking-policy][0m
[0m[1m[32m
Apply complete! Resources: 3 added, 0 changed, 0 destroyed.
[0m[0m[1m[32m
Outputs:

[0mAMI_ID = [
  "ami-01f2a686842bd4f9a",
]
Autoscaling_group_id = [
  "Dev_Employee_ASG",
]
Autoscaling_policy_name = [
  "target-tracking-policy",
]
Security_Group_ID = [
  "sg-07c9785cb1aee5ae4",
]
Target_group_id = [
  "arn:aws:elasticloadbalancing:ap-southeast-1:441247711986:targetgroup/Dev-Employee-TG/ed6bb1877b8fd605",
]
key_pair_name = [
  "Dev_Key",
]
launch_template_id = [
  "lt-0eb9ee3bf72ce8ab8",
]
target_group_arn = [
  "arn:aws:elasticloadbalancing:ap-southeast-1:441247711986:targetgroup/Dev-Employee-TG/ed6bb1877b8fd605",
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


**AMI Output (Dev-Employee-AMI)**

It uses the aws_ami_from_instance resource to create an AMI from an existing EC2 instance (source_instance_id variable specifies the instance ID).

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/c8bb1338-0e2d-4cb0-89f4-c9746013342f)


***

**Security Group for Employee(Dev-Employee-sg)**
 
Defines a security group with inbound and outbound rules for controlling traffic to and from instances. It dynamically creates rules based on the provided inbound_ports and outbound_ports variables.

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/9f7f24be-c572-445a-9e47-58dcc594751b)

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/452ae80a-b2d5-486d-afee-8c7cb138aed7)

***

**SSH Key Pair for Employee(Dev_Key)**

It generates an SSH key pair using the tls_private_key and aws_key_pair resources.

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/098bd0a1-4f7b-4fe5-9579-4a5a1ff65343)

***

**Launch Template for Employee (Dev-Employee-template)**

Creates a launch template for EC2 instances with configurations such as AMI, instance type, key pair, security group, and user data script.

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/0958fa2c-7ca5-4d85-b08c-814d9f64f2f5)

***

**Load Balancer for Employee (Dev-ALB)**

Configures an Application Load Balancer (ALB) with a listener and default action forwarding requests to the target group.

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/08896efa-9e4a-4f54-bb91-9dfc9867f60d)

***

**Listner Rules for Employee**

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/089c0659-8ace-4e74-bf93-5f8f1e105aba)

***

**Auto Scaling Group for Employee (Dev_Employee_ASG)**

Sets up an auto-scaling group with configurations such as launch template, minimum size, maximum size, desired capacity, VPC zone identifier, and target group ARN.

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/a19c4d92-610a-49ee-b47f-14edc03b94c4)

***

**Auto Scaling Policy**

Defines an auto-scaling policy for the auto-scaling group. It uses target tracking scaling with predefined metric specifications.

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/a19c4d92-610a-49ee-b47f-14edc03b94c4)

***

**Target Group for Employee (Dev-TG)**

Defines a target group for routing requests to registered instances. It includes health check configurations.

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/db2993ef-981f-46fb-b41e-90a9e7e0db25)

***

**Archive Artifact (SSH key pair - Dev_Key)**

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/e87639a6-bd19-4a26-b2ea-d4f1458657d2)


***

# Related Works

| **References** |
| -------------- |
| [Employee API Terraform Code](https://github.com/CodeOps-Hub/Terraform/tree/Khushi/EmployeePipeline/Dev_Infra/Static_Tf/Employee) |

***

## Conclusion

In conclusion, our DSL Pipeline offers a powerful solution for creating and managing domain-specific languages, enabling developers to express complex ideas in a concise and understandable manner. By embracing DSLs, organizations can accelerate development cycles, improve collaboration between domain experts and developers, and ultimately deliver higher-quality software solutions. 

***

## Contact Information

| Name            | Email Address                        |
|-----------------|--------------------------------------|
| Khushi Malhotra | khushi.malhotra.snaatak@mygurukulam.co |

***

## References

| **Source** | **Description** |
| ---------- | --------------- |
| [Link](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GenericDoc/Terraform/terraform.md) | Terraform Generic Doc Link. |
| [Link](https://developer.hashicorp.com/terraform/language/modules) | Terraform Module Concept. |
| [Link](https://www.linkedin.com/pulse/how-run-terraform-script-jenkins-step-by-step-guide-praveen-dandu) | Reference Link For DSL Pipeline. |
| [Link](https://medium.com/appgambit/terraform-with-jenkins-pipeline-439babe4095c)  | Jenkins DSL Pipeline Doc reference link. |
