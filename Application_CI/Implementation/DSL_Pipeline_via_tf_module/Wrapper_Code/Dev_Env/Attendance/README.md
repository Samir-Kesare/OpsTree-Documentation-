# DSL Jenkins pipeline for Attendance setup (Dev)

<img width="360" length="100" alt="Terraform" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/556e50dc-0c8b-4262-be16-2c384d2cfa8a">

***

| **Author** | **Created On** | **Last Updated** | **Document version** |
| ---------- | -------------- | ---------------- | -------------------- |
| **Vishal Kumar Kesharwani** | **14 March 2024** | **15 March 2024** | **v1** |

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

<img width="715" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/4c30ca5b-e159-4ad2-8c86-8c96d30be55b">

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
        AWS_ACCESS_KEY_ID     = credentials('aws-cred-vishal-self')
        AWS_SECRET_ACCESS_KEY = credentials('aws-cred-vishal-self')
        TF_CLI_ARGS           = '-input=false'
    }
    
    parameters {
        choice(name: 'ACTION', choices: ['Apply', 'Destroy'], description: 'Choose to apply or destroy the infrastructure')
    }
    
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', credentialsId: 'Vishal-PAT-DSL', url: 'https://github.com/CodeOps-Hub/Terraform-modules.git'
            }
        }
        
        stage('Copy Terraform Files') {
            steps {
                // Copy or move specific files from the repository to Jenkins workspace
                sh 'cp wrapperCode/Frontend_Wrapper_Code/Dev_Env/* .'
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

**This Jenkins pipeline automates the deployment of a Frontend infrastructure using Terraform module and Wrapper code. It's configured to perform the following actions:**

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

<img width="700"  src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/6156ef58-da03-42a7-9daa-42ca7e62dd0d">

***

### Archive Artifact (SSH key pair)

<img width="700"  src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/b3729786-b439-4caf-a088-70c3f551ffa3">

***

### Console Output

<details>
<summary><strong>Click here to see Console output</strong></summary>
<br>

```shell
Started by user Vidhi Yadav
Obtained Wrapper-Code/Dev_Env/Attendance/Jenkinsfile from git https://github.com/CodeOps-Hub/Jenkinsfile.git
[Pipeline] Start of Pipeline
[Pipeline] node
Running on Jenkins in /var/lib/jenkins/workspace/attendance_dev
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Declarative: Checkout SCM)
[Pipeline] checkout
Selected Git installation does not exist. Using Default
The recommended git tool is: NONE
using credential b9bd5b24-302c-4883-a2d1-c56372020b2e
 > git rev-parse --resolve-git-dir /var/lib/jenkins/workspace/attendance_dev/.git # timeout=10
Fetching changes from the remote Git repository
 > git config remote.origin.url https://github.com/CodeOps-Hub/Jenkinsfile.git # timeout=10
Fetching upstream changes from https://github.com/CodeOps-Hub/Jenkinsfile.git
 > git --version # timeout=10
 > git --version # 'git version 2.34.1'
using GIT_ASKPASS to set credentials 
 > git fetch --tags --force --progress -- https://github.com/CodeOps-Hub/Jenkinsfile.git +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git rev-parse refs/remotes/origin/Vidhi/Attendance-dev-jenkinsfile^{commit} # timeout=10
Checking out Revision c300523573a543b40c58c1933374e0dcc827a220 (refs/remotes/origin/Vidhi/Attendance-dev-jenkinsfile)
 > git config core.sparsecheckout # timeout=10
 > git checkout -f c300523573a543b40c58c1933374e0dcc827a220 # timeout=10
Commit message: "Update Jenkinsfile"
 > git rev-list --no-walk c300523573a543b40c58c1933374e0dcc827a220 # timeout=10
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
using credential new-token
 > git rev-parse --resolve-git-dir /var/lib/jenkins/workspace/attendance_dev/.git # timeout=10
Fetching changes from the remote Git repository
 > git config remote.origin.url https://github.com/CodeOps-Hub/Terraform-modules.git # timeout=10
Fetching upstream changes from https://github.com/CodeOps-Hub/Terraform-modules.git
 > git --version # timeout=10
 > git --version # 'git version 2.34.1'
using GIT_ASKPASS to set credentials 
 > git fetch --tags --force --progress -- https://github.com/CodeOps-Hub/Terraform-modules.git +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git rev-parse refs/remotes/origin/main^{commit} # timeout=10
Checking out Revision ed125bc0607cbe2e4bb2514f50445863841327a5 (refs/remotes/origin/main)
 > git config core.sparsecheckout # timeout=10
 > git checkout -f ed125bc0607cbe2e4bb2514f50445863841327a5 # timeout=10
 > git branch -a -v --no-abbrev # timeout=10
 > git branch -D main # timeout=10
 > git checkout -b main ed125bc0607cbe2e4bb2514f50445863841327a5 # timeout=10
Commit message: "Update variables.tf"
 > git rev-list --no-walk ed125bc0607cbe2e4bb2514f50445863841327a5 # timeout=10
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Copy Terraform Files)
[Pipeline] sh
+ cp wrapperCode/Attendance-API/Dev/main.tf wrapperCode/Attendance-API/Dev/output.tf wrapperCode/Attendance-API/Dev/provider.tf wrapperCode/Attendance-API/Dev/script.sh wrapperCode/Attendance-API/Dev/terraform.tfvars wrapperCode/Attendance-API/Dev/variable.tf .
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
- Reusing previous version of hashicorp/tls from the dependency lock file
- Reusing previous version of hashicorp/local from the dependency lock file
- Reusing previous version of hashicorp/aws from the dependency lock file
- Using previously-installed hashicorp/tls v4.0.5
- Using previously-installed hashicorp/local v2.5.1
- Using previously-installed hashicorp/aws v5.41.0

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
[0m[1mmodule.Dev_Attendance.tls_private_key.private_key: Refreshing state... [id=a60b801c404bf7895c40d7d484c08af4d57e9ce3][0m
[0m[1mmodule.Dev_Attendance.local_file.private_key: Refreshing state... [id=dd25f55526ee770ef993420016117986533f9894][0m
[0m[1mmodule.Dev_Attendance.aws_key_pair.key_pair: Refreshing state... [id=Dev_Attendance_Key][0m
[0m[1mmodule.Dev_Attendance.aws_lb_target_group.Target_group: Refreshing state... [id=arn:aws:elasticloadbalancing:us-east-1:905418193488:targetgroup/Dev-Attendance-TG/d74f8628f7631e35][0m
[0m[1mmodule.Dev_Attendance.aws_security_group.security_group: Refreshing state... [id=sg-0c5ea9d30b7275fb6][0m
[0m[1mmodule.Dev_Attendance.aws_lb_listener_rule.path_rule: Refreshing state... [id=arn:aws:elasticloadbalancing:us-east-1:905418193488:listener-rule/app/alb-heh/127dfdd55a957475/99ac24ae778e4e38/3812e663470d8283][0m
[0m[1mmodule.Dev_Attendance.aws_launch_template.Template: Refreshing state... [id=lt-0e024148868ff038b][0m
[0m[1mmodule.Dev_Attendance.aws_autoscaling_group.ASG: Refreshing state... [id=Dev-Attendance_ASG][0m
[0m[1mmodule.Dev_Attendance.aws_autoscaling_policy.ASG_Policy: Refreshing state... [id=target-tracking-policy][0m

[0m[1m[32mNo changes.[0m[1m Your infrastructure matches the configuration.[0m

[0mTerraform has compared your real infrastructure against your configuration
and found no differences, so no changes are needed.
[Pipeline] }
[Pipeline] // script
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Review and Approve Apply)
Stage "Review and Approve Apply" skipped due to when conditional
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Review and Approve Destroy)
[Pipeline] input
Do you want to destroy Terraform resources?
Proceed or Abort
Approved by Vidhi Yadav
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Apply or Destroy)
[Pipeline] script
[Pipeline] {
[Pipeline] sh
+ terraform destroy -auto-approve
[0m[1mmodule.Dev_Attendance.tls_private_key.private_key: Refreshing state... [id=a60b801c404bf7895c40d7d484c08af4d57e9ce3][0m
[0m[1mmodule.Dev_Attendance.local_file.private_key: Refreshing state... [id=dd25f55526ee770ef993420016117986533f9894][0m
[0m[1mmodule.Dev_Attendance.aws_key_pair.key_pair: Refreshing state... [id=Dev_Attendance_Key][0m
[0m[1mmodule.Dev_Attendance.aws_lb_target_group.Target_group: Refreshing state... [id=arn:aws:elasticloadbalancing:us-east-1:905418193488:targetgroup/Dev-Attendance-TG/d74f8628f7631e35][0m
[0m[1mmodule.Dev_Attendance.aws_security_group.security_group: Refreshing state... [id=sg-0c5ea9d30b7275fb6][0m
[0m[1mmodule.Dev_Attendance.aws_launch_template.Template: Refreshing state... [id=lt-0e024148868ff038b][0m
[0m[1mmodule.Dev_Attendance.aws_lb_listener_rule.path_rule: Refreshing state... [id=arn:aws:elasticloadbalancing:us-east-1:905418193488:listener-rule/app/alb-heh/127dfdd55a957475/99ac24ae778e4e38/3812e663470d8283][0m
[0m[1mmodule.Dev_Attendance.aws_autoscaling_group.ASG: Refreshing state... [id=Dev-Attendance_ASG][0m
[0m[1mmodule.Dev_Attendance.aws_autoscaling_policy.ASG_Policy: Refreshing state... [id=target-tracking-policy][0m

Terraform used the selected providers to generate the following execution
plan. Resource actions are indicated with the following symbols:
  [31m-[0m destroy[0m

Terraform will perform the following actions:

[1m  # module.Dev_Attendance.aws_autoscaling_group.ASG[0m will be [1m[31mdestroyed[0m
[0m  [31m-[0m[0m resource "aws_autoscaling_group" "ASG" {
      [31m-[0m[0m arn                              = "arn:aws:autoscaling:us-east-1:905418193488:autoScalingGroup:18d802f3-aea5-4aa4-b849-9bf335043019:autoScalingGroupName/Dev-Attendance_ASG" [90m-> null[0m[0m
      [31m-[0m[0m availability_zones               = [
          [31m-[0m[0m "us-east-1d",
        ] [90m-> null[0m[0m
      [31m-[0m[0m capacity_rebalance               = false [90m-> null[0m[0m
      [31m-[0m[0m default_cooldown                 = 300 [90m-> null[0m[0m
      [31m-[0m[0m default_instance_warmup          = 0 [90m-> null[0m[0m
      [31m-[0m[0m desired_capacity                 = 1 [90m-> null[0m[0m
      [31m-[0m[0m enabled_metrics                  = [] [90m-> null[0m[0m
      [31m-[0m[0m force_delete                     = false [90m-> null[0m[0m
      [31m-[0m[0m force_delete_warm_pool           = false [90m-> null[0m[0m
      [31m-[0m[0m health_check_grace_period        = 300 [90m-> null[0m[0m
      [31m-[0m[0m health_check_type                = "EC2" [90m-> null[0m[0m
      [31m-[0m[0m id                               = "Dev-Attendance_ASG" [90m-> null[0m[0m
      [31m-[0m[0m ignore_failed_scaling_activities = false [90m-> null[0m[0m
      [31m-[0m[0m load_balancers                   = [] [90m-> null[0m[0m
      [31m-[0m[0m max_instance_lifetime            = 0 [90m-> null[0m[0m
      [31m-[0m[0m max_size                         = 2 [90m-> null[0m[0m
      [31m-[0m[0m metrics_granularity              = "1Minute" [90m-> null[0m[0m
      [31m-[0m[0m min_size                         = 1 [90m-> null[0m[0m
      [31m-[0m[0m name                             = "Dev-Attendance_ASG" [90m-> null[0m[0m
      [31m-[0m[0m predicted_capacity               = 0 [90m-> null[0m[0m
      [31m-[0m[0m protect_from_scale_in            = false [90m-> null[0m[0m
      [31m-[0m[0m service_linked_role_arn          = "arn:aws:iam::905418193488:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling" [90m-> null[0m[0m
      [31m-[0m[0m suspended_processes              = [] [90m-> null[0m[0m
      [31m-[0m[0m target_group_arns                = [
          [31m-[0m[0m "arn:aws:elasticloadbalancing:us-east-1:905418193488:targetgroup/Dev-Attendance-TG/d74f8628f7631e35",
        ] [90m-> null[0m[0m
      [31m-[0m[0m termination_policies             = [] [90m-> null[0m[0m
      [31m-[0m[0m vpc_zone_identifier              = [
          [31m-[0m[0m "subnet-0a712151efeb16f4f",
        ] [90m-> null[0m[0m
      [31m-[0m[0m wait_for_capacity_timeout        = "10m" [90m-> null[0m[0m
      [31m-[0m[0m warm_pool_size                   = 0 [90m-> null[0m[0m

      [31m-[0m[0m launch_template {
          [31m-[0m[0m id      = "lt-0e024148868ff038b" [90m-> null[0m[0m
          [31m-[0m[0m name    = "Dev-Attendance-Launch-Template" [90m-> null[0m[0m
          [31m-[0m[0m version = "$Latest" [90m-> null[0m[0m
        }

      [31m-[0m[0m tag {
          [31m-[0m[0m key                 = "Name" [90m-> null[0m[0m
          [31m-[0m[0m propagate_at_launch = false [90m-> null[0m[0m
          [31m-[0m[0m value               = "Dev-Attendance_ASG" [90m-> null[0m[0m
        }

      [31m-[0m[0m traffic_source {
          [31m-[0m[0m identifier = "arn:aws:elasticloadbalancing:us-east-1:905418193488:targetgroup/Dev-Attendance-TG/d74f8628f7631e35" [90m-> null[0m[0m
          [31m-[0m[0m type       = "elbv2" [90m-> null[0m[0m
        }
    }

[1m  # module.Dev_Attendance.aws_autoscaling_policy.ASG_Policy[0m will be [1m[31mdestroyed[0m
[0m  [31m-[0m[0m resource "aws_autoscaling_policy" "ASG_Policy" {
      [31m-[0m[0m arn                       = "arn:aws:autoscaling:us-east-1:905418193488:scalingPolicy:a4bc9c4d-2fe5-4e1c-a929-5ef2b3d9423b:autoScalingGroupName/Dev-Attendance_ASG:policyName/target-tracking-policy" [90m-> null[0m[0m
      [31m-[0m[0m autoscaling_group_name    = "Dev-Attendance_ASG" [90m-> null[0m[0m
      [31m-[0m[0m cooldown                  = 0 [90m-> null[0m[0m
      [31m-[0m[0m enabled                   = true [90m-> null[0m[0m
      [31m-[0m[0m estimated_instance_warmup = 0 [90m-> null[0m[0m
      [31m-[0m[0m id                        = "target-tracking-policy" [90m-> null[0m[0m
      [31m-[0m[0m min_adjustment_magnitude  = 0 [90m-> null[0m[0m
      [31m-[0m[0m name                      = "target-tracking-policy" [90m-> null[0m[0m
      [31m-[0m[0m policy_type               = "TargetTrackingScaling" [90m-> null[0m[0m
      [31m-[0m[0m scaling_adjustment        = 0 [90m-> null[0m[0m

      [31m-[0m[0m target_tracking_configuration {
          [31m-[0m[0m disable_scale_in = false [90m-> null[0m[0m
          [31m-[0m[0m target_value     = 50 [90m-> null[0m[0m

          [31m-[0m[0m predefined_metric_specification {
              [31m-[0m[0m predefined_metric_type = "ASGAverageCPUUtilization" [90m-> null[0m[0m
            }
        }
    }

[1m  # module.Dev_Attendance.aws_key_pair.key_pair[0m will be [1m[31mdestroyed[0m
[0m  [31m-[0m[0m resource "aws_key_pair" "key_pair" {
      [31m-[0m[0m arn         = "arn:aws:ec2:us-east-1:905418193488:key-pair/Dev_Attendance_Key" [90m-> null[0m[0m
      [31m-[0m[0m fingerprint = "ed:e2:80:26:73:36:64:af:3d:cd:1a:c9:a2:b2:f4:27" [90m-> null[0m[0m
      [31m-[0m[0m id          = "Dev_Attendance_Key" [90m-> null[0m[0m
      [31m-[0m[0m key_name    = "Dev_Attendance_Key" [90m-> null[0m[0m
      [31m-[0m[0m key_pair_id = "key-07db706d240f086d2" [90m-> null[0m[0m
      [31m-[0m[0m key_type    = "rsa" [90m-> null[0m[0m
      [31m-[0m[0m public_key  = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDHplATnP4OpKMvpiOupaZLLwvngDSgr8ehOaKpHHSvgn8T+ogyFNwhUzwmThTHvMoflHZoYgg3pUTOm/ZoHnrI15p1DqrMuCKxvzuZ32Wg7Hp2dFw2kcfRuEdvxUP4P105GpKdI8A85GgWs1K/Ow63KrnYK0kDpBcIhSmg0ctfMXmHKxMtN4iOj4uF0abVevK+U4trojIsfX7uiARd6wImC32Ik0OjYvHdddjHqI7D3O6Xqfb56kiY/iW9aznDtdvETd9M9vHdqgui1xEPpgsqXaPIgPCoQHif6BuMYT4ATboAWBKMEXFlOpKGUJuAlotJXIZxloqmH5j9i1Vq3K3cZLz4yH2Zia5WLQioql9EhZhaeI+9KbO6Snye+4pLsJ2zqKKU4r60gXk9KAat3aVBHRVStoLUxS1LYJPlnoP7SFQ3CKoK5F0556YUIB9/0PqciyKPb80inSE4uqc3CJS8iBJG/c8LhFpZLh8eev9LCSLTXuIDbasPepNtlFAxamaLwiFyrVPf8RI4b+2RbHCwD6zUNqV0sMLpUT8yELQfBGdYGLsQC0R7X0rkLyUUTKs7YGh7NLu+5kcV2fKAciQj25s2GyhXMwr7oENIXimPs3+sxcsD6Ez0rXeEMnQ18GRRLVCn7yA9pxCa3rhWHyNyfZNITC6NF58CqN+9bQZP6w==" [90m-> null[0m[0m
      [31m-[0m[0m tags        = {} [90m-> null[0m[0m
      [31m-[0m[0m tags_all    = {} [90m-> null[0m[0m
    }

[1m  # module.Dev_Attendance.aws_launch_template.Template[0m will be [1m[31mdestroyed[0m
[0m  [31m-[0m[0m resource "aws_launch_template" "Template" {
      [31m-[0m[0m arn                     = "arn:aws:ec2:us-east-1:905418193488:launch-template/lt-0e024148868ff038b" [90m-> null[0m[0m
      [31m-[0m[0m default_version         = 1 [90m-> null[0m[0m
      [31m-[0m[0m description             = "Template for Attendance" [90m-> null[0m[0m
      [31m-[0m[0m disable_api_stop        = false [90m-> null[0m[0m
      [31m-[0m[0m disable_api_termination = false [90m-> null[0m[0m
      [31m-[0m[0m id                      = "lt-0e024148868ff038b" [90m-> null[0m[0m
      [31m-[0m[0m image_id                = "ami-0b622ae4dff08c413" [90m-> null[0m[0m
      [31m-[0m[0m instance_type           = "t2.micro" [90m-> null[0m[0m
      [31m-[0m[0m key_name                = "Dev_Attendance_Key" [90m-> null[0m[0m
      [31m-[0m[0m latest_version          = 1 [90m-> null[0m[0m
      [31m-[0m[0m name                    = "Dev-Attendance-Launch-Template" [90m-> null[0m[0m
      [31m-[0m[0m security_group_names    = [] [90m-> null[0m[0m
      [31m-[0m[0m tags                    = {
          [31m-[0m[0m "Name" = "Dev-Attendance-Launch-Template"
        } [90m-> null[0m[0m
      [31m-[0m[0m tags_all                = {
          [31m-[0m[0m "Name" = "Dev-Attendance-Launch-Template"
        } [90m-> null[0m[0m
      [31m-[0m[0m user_data               = "IyEvYmluL2Jhc2gKY2QgYXR0ZW5kYW5jZQpjZCBhdHRlbmRhbmNlLWFwaS8KcG9ldHJ5IHNoZWxsCmd1bmljb3JuIGFwcDphcHAgLS1sb2ctY29uZmlnIGxvZy5jb25mIC1iIDAuMC4wLjA6ODA4MA==" [90m-> null[0m[0m
      [31m-[0m[0m vpc_security_group_ids  = [] [90m-> null[0m[0m

      [31m-[0m[0m network_interfaces {
          [31m-[0m[0m device_index       = 0 [90m-> null[0m[0m
          [31m-[0m[0m ipv4_address_count = 0 [90m-> null[0m[0m
          [31m-[0m[0m ipv4_addresses     = [] [90m-> null[0m[0m
          [31m-[0m[0m ipv4_prefix_count  = 0 [90m-> null[0m[0m
          [31m-[0m[0m ipv4_prefixes      = [] [90m-> null[0m[0m
          [31m-[0m[0m ipv6_address_count = 0 [90m-> null[0m[0m
          [31m-[0m[0m ipv6_addresses     = [] [90m-> null[0m[0m
          [31m-[0m[0m ipv6_prefix_count  = 0 [90m-> null[0m[0m
          [31m-[0m[0m ipv6_prefixes      = [] [90m-> null[0m[0m
          [31m-[0m[0m network_card_index = 0 [90m-> null[0m[0m
          [31m-[0m[0m security_groups    = [
              [31m-[0m[0m "sg-0c5ea9d30b7275fb6",
            ] [90m-> null[0m[0m
          [31m-[0m[0m subnet_id          = "subnet-0a712151efeb16f4f" [90m-> null[0m[0m
        }
    }

[1m  # module.Dev_Attendance.aws_lb_listener_rule.path_rule[0m will be [1m[31mdestroyed[0m
[0m  [31m-[0m[0m resource "aws_lb_listener_rule" "path_rule" {
      [31m-[0m[0m arn          = "arn:aws:elasticloadbalancing:us-east-1:905418193488:listener-rule/app/alb-heh/127dfdd55a957475/99ac24ae778e4e38/3812e663470d8283" [90m-> null[0m[0m
      [31m-[0m[0m id           = "arn:aws:elasticloadbalancing:us-east-1:905418193488:listener-rule/app/alb-heh/127dfdd55a957475/99ac24ae778e4e38/3812e663470d8283" [90m-> null[0m[0m
      [31m-[0m[0m listener_arn = "arn:aws:elasticloadbalancing:us-east-1:905418193488:listener/app/alb-heh/127dfdd55a957475/99ac24ae778e4e38" [90m-> null[0m[0m
      [31m-[0m[0m priority     = 90 [90m-> null[0m[0m
      [31m-[0m[0m tags         = {} [90m-> null[0m[0m
      [31m-[0m[0m tags_all     = {} [90m-> null[0m[0m

      [31m-[0m[0m action {
          [31m-[0m[0m order            = 1 [90m-> null[0m[0m
          [31m-[0m[0m target_group_arn = "arn:aws:elasticloadbalancing:us-east-1:905418193488:targetgroup/Dev-Attendance-TG/d74f8628f7631e35" [90m-> null[0m[0m
          [31m-[0m[0m type             = "forward" [90m-> null[0m[0m
        }

      [31m-[0m[0m condition {
          [31m-[0m[0m path_pattern {
              [31m-[0m[0m values = [
                  [31m-[0m[0m "/api/v1/attendance/*",
                ] [90m-> null[0m[0m
            }
        }
    }

[1m  # module.Dev_Attendance.aws_lb_target_group.Target_group[0m will be [1m[31mdestroyed[0m
[0m  [31m-[0m[0m resource "aws_lb_target_group" "Target_group" {
      [31m-[0m[0m arn                                = "arn:aws:elasticloadbalancing:us-east-1:905418193488:targetgroup/Dev-Attendance-TG/d74f8628f7631e35" [90m-> null[0m[0m
      [31m-[0m[0m arn_suffix                         = "targetgroup/Dev-Attendance-TG/d74f8628f7631e35" [90m-> null[0m[0m
      [31m-[0m[0m deregistration_delay               = "300" [90m-> null[0m[0m
      [31m-[0m[0m id                                 = "arn:aws:elasticloadbalancing:us-east-1:905418193488:targetgroup/Dev-Attendance-TG/d74f8628f7631e35" [90m-> null[0m[0m
      [31m-[0m[0m ip_address_type                    = "ipv4" [90m-> null[0m[0m
      [31m-[0m[0m lambda_multi_value_headers_enabled = false [90m-> null[0m[0m
      [31m-[0m[0m load_balancer_arns                 = [
          [31m-[0m[0m "arn:aws:elasticloadbalancing:us-east-1:905418193488:loadbalancer/app/alb-heh/127dfdd55a957475",
        ] [90m-> null[0m[0m
      [31m-[0m[0m load_balancing_algorithm_type      = "round_robin" [90m-> null[0m[0m
      [31m-[0m[0m load_balancing_anomaly_mitigation  = "off" [90m-> null[0m[0m
      [31m-[0m[0m load_balancing_cross_zone_enabled  = "use_load_balancer_configuration" [90m-> null[0m[0m
      [31m-[0m[0m name                               = "Dev-Attendance-TG" [90m-> null[0m[0m
      [31m-[0m[0m port                               = 8080 [90m-> null[0m[0m
      [31m-[0m[0m protocol                           = "HTTP" [90m-> null[0m[0m
      [31m-[0m[0m protocol_version                   = "HTTP1" [90m-> null[0m[0m
      [31m-[0m[0m proxy_protocol_v2                  = false [90m-> null[0m[0m
      [31m-[0m[0m slow_start                         = 0 [90m-> null[0m[0m
      [31m-[0m[0m tags                               = {
          [31m-[0m[0m "Name" = "Dev-Attendance-TG"
        } [90m-> null[0m[0m
      [31m-[0m[0m tags_all                           = {
          [31m-[0m[0m "Name" = "Dev-Attendance-TG"
        } [90m-> null[0m[0m
      [31m-[0m[0m target_type                        = "instance" [90m-> null[0m[0m
      [31m-[0m[0m vpc_id                             = "vpc-0d744158f7f47f419" [90m-> null[0m[0m

      [31m-[0m[0m health_check {
          [31m-[0m[0m enabled             = true [90m-> null[0m[0m
          [31m-[0m[0m healthy_threshold   = 2 [90m-> null[0m[0m
          [31m-[0m[0m interval            = 30 [90m-> null[0m[0m
          [31m-[0m[0m matcher             = "200" [90m-> null[0m[0m
          [31m-[0m[0m path                = "/health" [90m-> null[0m[0m
          [31m-[0m[0m port                = "traffic-port" [90m-> null[0m[0m
          [31m-[0m[0m protocol            = "HTTP" [90m-> null[0m[0m
          [31m-[0m[0m timeout             = 5 [90m-> null[0m[0m
          [31m-[0m[0m unhealthy_threshold = 2 [90m-> null[0m[0m
        }

      [31m-[0m[0m stickiness {
          [31m-[0m[0m cookie_duration = 86400 [90m-> null[0m[0m
          [31m-[0m[0m enabled         = false [90m-> null[0m[0m
          [31m-[0m[0m type            = "lb_cookie" [90m-> null[0m[0m
        }

      [31m-[0m[0m target_failover {}

      [31m-[0m[0m target_health_state {}
    }

[1m  # module.Dev_Attendance.aws_security_group.security_group[0m will be [1m[31mdestroyed[0m
[0m  [31m-[0m[0m resource "aws_security_group" "security_group" {
      [31m-[0m[0m arn                    = "arn:aws:ec2:us-east-1:905418193488:security-group/sg-0c5ea9d30b7275fb6" [90m-> null[0m[0m
      [31m-[0m[0m description            = "Security group for Dev Attendance API" [90m-> null[0m[0m
      [31m-[0m[0m egress                 = [
          [31m-[0m[0m {
              [31m-[0m[0m cidr_blocks      = [
                  [31m-[0m[0m "0.0.0.0/0",
                ]
              [31m-[0m[0m description      = ""
              [31m-[0m[0m from_port        = 0
              [31m-[0m[0m ipv6_cidr_blocks = []
              [31m-[0m[0m prefix_list_ids  = []
              [31m-[0m[0m protocol         = "-1"
              [31m-[0m[0m security_groups  = []
              [31m-[0m[0m self             = false
              [31m-[0m[0m to_port          = 0
            },
        ] [90m-> null[0m[0m
      [31m-[0m[0m id                     = "sg-0c5ea9d30b7275fb6" [90m-> null[0m[0m
      [31m-[0m[0m ingress                = [
          [31m-[0m[0m {
              [31m-[0m[0m cidr_blocks      = [
                  [31m-[0m[0m "20.0.0.0/28",
                ]
              [31m-[0m[0m description      = ""
              [31m-[0m[0m from_port        = 22
              [31m-[0m[0m ipv6_cidr_blocks = []
              [31m-[0m[0m prefix_list_ids  = []
              [31m-[0m[0m protocol         = "tcp"
              [31m-[0m[0m security_groups  = []
              [31m-[0m[0m self             = false
              [31m-[0m[0m to_port          = 22
            },
          [31m-[0m[0m {
              [31m-[0m[0m cidr_blocks      = []
              [31m-[0m[0m description      = ""
              [31m-[0m[0m from_port        = 22
              [31m-[0m[0m ipv6_cidr_blocks = []
              [31m-[0m[0m prefix_list_ids  = []
              [31m-[0m[0m protocol         = "tcp"
              [31m-[0m[0m security_groups  = [
                  [31m-[0m[0m "sg-061f905ed2cbb0652",
                ]
              [31m-[0m[0m self             = false
              [31m-[0m[0m to_port          = 22
            },
          [31m-[0m[0m {
              [31m-[0m[0m cidr_blocks      = []
              [31m-[0m[0m description      = ""
              [31m-[0m[0m from_port        = 8080
              [31m-[0m[0m ipv6_cidr_blocks = []
              [31m-[0m[0m prefix_list_ids  = []
              [31m-[0m[0m protocol         = "tcp"
              [31m-[0m[0m security_groups  = [
                  [31m-[0m[0m "sg-061f905ed2cbb0652",
                ]
              [31m-[0m[0m self             = false
              [31m-[0m[0m to_port          = 8080
            },
        ] [90m-> null[0m[0m
      [31m-[0m[0m name                   = "Dev-Attendance-sg" [90m-> null[0m[0m
      [31m-[0m[0m owner_id               = "905418193488" [90m-> null[0m[0m
      [31m-[0m[0m revoke_rules_on_delete = false [90m-> null[0m[0m
      [31m-[0m[0m tags                   = {
          [31m-[0m[0m "Enviroment" = "Dev_Attendance"
          [31m-[0m[0m "Name"       = "Dev-Attendance-sg"
          [31m-[0m[0m "Owner"      = "Vidhi"
        } [90m-> null[0m[0m
      [31m-[0m[0m tags_all               = {
          [31m-[0m[0m "Enviroment" = "Dev_Attendance"
          [31m-[0m[0m "Name"       = "Dev-Attendance-sg"
          [31m-[0m[0m "Owner"      = "Vidhi"
        } [90m-> null[0m[0m
      [31m-[0m[0m vpc_id                 = "vpc-0d744158f7f47f419" [90m-> null[0m[0m
    }

[1m  # module.Dev_Attendance.local_file.private_key[0m will be [1m[31mdestroyed[0m
[0m  [31m-[0m[0m resource "local_file" "private_key" {
      [31m-[0m[0m content              = (sensitive value) [90m-> null[0m[0m
      [31m-[0m[0m content_base64sha256 = "V+QY8ASwCRFwPq8oCrIH/BbwImfoyVkZHVRsfHifOiw=" [90m-> null[0m[0m
      [31m-[0m[0m content_base64sha512 = "JDT0PQk16VkWkzaiWEarwpUmqYTKk0JheYOdat68Zazpwz0OjVQCHcUpxi5ZvMVtfhdE12Vfwo99YJpTCb0iWg==" [90m-> null[0m[0m
      [31m-[0m[0m content_md5          = "b6e919355069761da1f99b7570181250" [90m-> null[0m[0m
      [31m-[0m[0m content_sha1         = "dd25f55526ee770ef993420016117986533f9894" [90m-> null[0m[0m
      [31m-[0m[0m content_sha256       = "57e418f004b00911703eaf280ab207fc16f02267e8c959191d546c7c789f3a2c" [90m-> null[0m[0m
      [31m-[0m[0m content_sha512       = "2434f43d0935e959169336a25846abc29526a984ca93426179839d6adebc65ace9c33d0e8d54021dc529c62e59bcc56d7e1744d7655fc28f7d609a5309bd225a" [90m-> null[0m[0m
      [31m-[0m[0m directory_permission = "0777" [90m-> null[0m[0m
      [31m-[0m[0m file_permission      = "0777" [90m-> null[0m[0m
      [31m-[0m[0m filename             = "Dev_Attendance_Key.pem" [90m-> null[0m[0m
      [31m-[0m[0m id                   = "dd25f55526ee770ef993420016117986533f9894" [90m-> null[0m[0m
    }

[1m  # module.Dev_Attendance.tls_private_key.private_key[0m will be [1m[31mdestroyed[0m
[0m  [31m-[0m[0m resource "tls_private_key" "private_key" {
      [31m-[0m[0m algorithm                     = "RSA" [90m-> null[0m[0m
      [31m-[0m[0m ecdsa_curve                   = "P224" [90m-> null[0m[0m
      [31m-[0m[0m id                            = "a60b801c404bf7895c40d7d484c08af4d57e9ce3" [90m-> null[0m[0m
      [31m-[0m[0m private_key_openssh           = (sensitive value) [90m-> null[0m[0m
      [31m-[0m[0m private_key_pem               = (sensitive value) [90m-> null[0m[0m
      [31m-[0m[0m private_key_pem_pkcs8         = (sensitive value) [90m-> null[0m[0m
      [31m-[0m[0m public_key_fingerprint_md5    = "9b:ea:03:05:17:1d:98:d8:14:f2:e6:94:c8:85:80:7e" [90m-> null[0m[0m
      [31m-[0m[0m public_key_fingerprint_sha256 = "SHA256:3AeLYEgrZpKJrwFXUCwWfLXb6a4SwvD+XGgIbl0Yvfg" [90m-> null[0m[0m
      [31m-[0m[0m public_key_openssh            = <<-EOT
            ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDHplATnP4OpKMvpiOupaZLLwvngDSgr8ehOaKpHHSvgn8T+ogyFNwhUzwmThTHvMoflHZoYgg3pUTOm/ZoHnrI15p1DqrMuCKxvzuZ32Wg7Hp2dFw2kcfRuEdvxUP4P105GpKdI8A85GgWs1K/Ow63KrnYK0kDpBcIhSmg0ctfMXmHKxMtN4iOj4uF0abVevK+U4trojIsfX7uiARd6wImC32Ik0OjYvHdddjHqI7D3O6Xqfb56kiY/iW9aznDtdvETd9M9vHdqgui1xEPpgsqXaPIgPCoQHif6BuMYT4ATboAWBKMEXFlOpKGUJuAlotJXIZxloqmH5j9i1Vq3K3cZLz4yH2Zia5WLQioql9EhZhaeI+9KbO6Snye+4pLsJ2zqKKU4r60gXk9KAat3aVBHRVStoLUxS1LYJPlnoP7SFQ3CKoK5F0556YUIB9/0PqciyKPb80inSE4uqc3CJS8iBJG/c8LhFpZLh8eev9LCSLTXuIDbasPepNtlFAxamaLwiFyrVPf8RI4b+2RbHCwD6zUNqV0sMLpUT8yELQfBGdYGLsQC0R7X0rkLyUUTKs7YGh7NLu+5kcV2fKAciQj25s2GyhXMwr7oENIXimPs3+sxcsD6Ez0rXeEMnQ18GRRLVCn7yA9pxCa3rhWHyNyfZNITC6NF58CqN+9bQZP6w==
        EOT [90m-> null[0m[0m
      [31m-[0m[0m public_key_pem                = <<-EOT
            -----BEGIN PUBLIC KEY-----
            MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAx6ZQE5z+DqSjL6YjrqWm
            Sy8L54A0oK/HoTmiqRx0r4J/E/qIMhTcIVM8Jk4Ux7zKH5R2aGIIN6VEzpv2aB56
            yNeadQ6qzLgisb87md9loOx6dnRcNpHH0bhHb8VD+D9dORqSnSPAPORoFrNSvzsO
            tyq52CtJA6QXCIUpoNHLXzF5hysTLTeIjo+LhdGm1XryvlOLa6IyLH1+7ogEXesC
            Jgt9iJNDo2Lx3XXYx6iOw9zul6n2+epImP4lvWs5w7XbxE3fTPbx3aoLotcRD6YL
            Kl2jyIDwqEB4n+gbjGE+AE26AFgSjBFxZTqShlCbgJaLSVyGcZaKph+Y/YtVatyt
            3GS8+Mh9mYmuVi0IqKpfRIWYWniPvSmzukp8nvuKS7Cds6iilOK+tIF5PSgGrd2l
            QR0VUraC1MUtS2CT5Z6D+0hUNwiqCuRdOeemFCAff9D6nIsij2/NIp0hOLqnNwiU
            vIgSRv3PC4RaWS4fHnr/Swki017iA22rD3qTbZRQMWpmi8Ihcq1T3/ESOG/tkWxw
            sA+s1DaldLDC6VE/MhC0HwRnWBi7EAtEe19K5C8lFEyrO2BoezS7vuZHFdnygHIk
            I9ubNhsoVzMK+6BDSF4pj7N/rMXLA+hM9K13hDJ0NfBkUS1Qp+8gPacQmt64Vh8j
            cn2TSEwujRefAqjfvW0GT+sCAwEAAQ==
            -----END PUBLIC KEY-----
        EOT [90m-> null[0m[0m
      [31m-[0m[0m rsa_bits                      = 4096 [90m-> null[0m[0m
    }

[1mPlan:[0m 0 to add, 0 to change, 9 to destroy.
[0m
Changes to Outputs:
  [31m-[0m[0m Autoscaling_group_id    = [
      [31m-[0m[0m [
          [31m-[0m[0m "Dev-Attendance_ASG",
        ],
    ] [90m-> null[0m[0m
  [31m-[0m[0m Autoscaling_policy_name = [
      [31m-[0m[0m [
          [31m-[0m[0m "target-tracking-policy",
        ],
    ] [90m-> null[0m[0m
  [31m-[0m[0m Security_Group_ID       = [
      [31m-[0m[0m [
          [31m-[0m[0m "sg-0c5ea9d30b7275fb6",
        ],
    ] [90m-> null[0m[0m
  [31m-[0m[0m Target_group_id         = [
      [31m-[0m[0m [
          [31m-[0m[0m "arn:aws:elasticloadbalancing:us-east-1:905418193488:targetgroup/Dev-Attendance-TG/d74f8628f7631e35",
        ],
    ] [90m-> null[0m[0m
  [31m-[0m[0m key_pair_name           = [
      [31m-[0m[0m [
          [31m-[0m[0m "Dev_Attendance_Key",
        ],
    ] [90m-> null[0m[0m
  [31m-[0m[0m launch_template_id      = [
      [31m-[0m[0m [
          [31m-[0m[0m "lt-0e024148868ff038b",
        ],
    ] [90m-> null[0m[0m
[0m[1mmodule.Dev_Attendance.local_file.private_key: Destroying... [id=dd25f55526ee770ef993420016117986533f9894][0m[0m
[0m[1mmodule.Dev_Attendance.local_file.private_key: Destruction complete after 0s[0m
[0m[1mmodule.Dev_Attendance.aws_lb_listener_rule.path_rule: Destroying... [id=arn:aws:elasticloadbalancing:us-east-1:905418193488:listener-rule/app/alb-heh/127dfdd55a957475/99ac24ae778e4e38/3812e663470d8283][0m[0m
[0m[1mmodule.Dev_Attendance.aws_autoscaling_policy.ASG_Policy: Destroying... [id=target-tracking-policy][0m[0m
[0m[1mmodule.Dev_Attendance.aws_lb_listener_rule.path_rule: Destruction complete after 1s[0m
[0m[1mmodule.Dev_Attendance.aws_autoscaling_policy.ASG_Policy: Destruction complete after 1s[0m
[0m[1mmodule.Dev_Attendance.aws_autoscaling_group.ASG: Destroying... [id=Dev-Attendance_ASG][0m[0m
[0m[1mmodule.Dev_Attendance.aws_autoscaling_group.ASG: Still destroying... [id=Dev-Attendance_ASG, 10s elapsed][0m[0m
[0m[1mmodule.Dev_Attendance.aws_autoscaling_group.ASG: Still destroying... [id=Dev-Attendance_ASG, 20s elapsed][0m[0m
[0m[1mmodule.Dev_Attendance.aws_autoscaling_group.ASG: Still destroying... [id=Dev-Attendance_ASG, 30s elapsed][0m[0m
[0m[1mmodule.Dev_Attendance.aws_autoscaling_group.ASG: Still destroying... [id=Dev-Attendance_ASG, 40s elapsed][0m[0m
[0m[1mmodule.Dev_Attendance.aws_autoscaling_group.ASG: Still destroying... [id=Dev-Attendance_ASG, 50s elapsed][0m[0m
[0m[1mmodule.Dev_Attendance.aws_autoscaling_group.ASG: Still destroying... [id=Dev-Attendance_ASG, 1m0s elapsed][0m[0m
[0m[1mmodule.Dev_Attendance.aws_autoscaling_group.ASG: Still destroying... [id=Dev-Attendance_ASG, 1m10s elapsed][0m[0m
[0m[1mmodule.Dev_Attendance.aws_autoscaling_group.ASG: Still destroying... [id=Dev-Attendance_ASG, 1m20s elapsed][0m[0m
[0m[1mmodule.Dev_Attendance.aws_autoscaling_group.ASG: Destruction complete after 1m28s[0m
[0m[1mmodule.Dev_Attendance.aws_lb_target_group.Target_group: Destroying... [id=arn:aws:elasticloadbalancing:us-east-1:905418193488:targetgroup/Dev-Attendance-TG/d74f8628f7631e35][0m[0m
[0m[1mmodule.Dev_Attendance.aws_launch_template.Template: Destroying... [id=lt-0e024148868ff038b][0m[0m
[0m[1mmodule.Dev_Attendance.aws_lb_target_group.Target_group: Destruction complete after 0s[0m
[0m[1mmodule.Dev_Attendance.aws_launch_template.Template: Destruction complete after 0s[0m
[0m[1mmodule.Dev_Attendance.aws_key_pair.key_pair: Destroying... [id=Dev_Attendance_Key][0m[0m
[0m[1mmodule.Dev_Attendance.aws_security_group.security_group: Destroying... [id=sg-0c5ea9d30b7275fb6][0m[0m
[0m[1mmodule.Dev_Attendance.aws_key_pair.key_pair: Destruction complete after 0s[0m
[0m[1mmodule.Dev_Attendance.tls_private_key.private_key: Destroying... [id=a60b801c404bf7895c40d7d484c08af4d57e9ce3][0m[0m
[0m[1mmodule.Dev_Attendance.tls_private_key.private_key: Destruction complete after 0s[0m
[0m[1mmodule.Dev_Attendance.aws_security_group.security_group: Destruction complete after 1s[0m
[0m[1m[32m
Destroy complete! Resources: 9 destroyed.
[0m
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

***

## AWS Console Output 

### Security Group

<img width="700"  src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/358610dc-38fe-4178-bd59-94d5c27afd4d"> 

***
### Launch Template

<img width="700"  src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/88f6e58a-a000-49d9-aae1-c4012eb1d187"> 

***

### Target Group

<img width="700"  src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/ae53d546-b274-4582-8bb7-a8dcedc0e679">

***
### Listener rule of ALB

<img width="700" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/898f8481-5bc9-4b91-8776-9c747a2612c0">

***
### Auto Scaling Group

<img width="700" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/ec8ebaa1-f92f-48c7-9f85-daa0a7ce394c">

***
### Auto Scaling Group Policies

<img width="700"  src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/ad37d0cf-0ea4-4064-9da2-7a0105e8e449">

***

# Conclusion

In conclusion, our DSL Pipeline offers a powerful solution for creating and managing domain-specific languages, enabling developers to express complex ideas in a concise and understandable manner. By embracing DSLs, organizations can accelerate development cycles, improve collaboration between domain experts and developers, and ultimately deliver higher-quality software solutions. 

***

# Contact Information

| **Name** | **Email Address** |
| -------- | ----------------- |
| **Vishal Kumar Kesharwani** | vishal.kumar.kesharwani.snaatak@mygurukulam.co |

***

# References

| **Source** | **Description** |
| ---------- | --------------- |
| [**Link**](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GenericDoc/Terraform/terraform.md) | Terraform Generic Doc Link. |
| [**Link**](https://developer.hashicorp.com/terraform/language/modules) | Terraform Module Concept. |
| [**Link**](https://medium.com/appgambit/terraform-with-jenkins-pipeline-439babe4095c)  | Jenkins DSL Pipeline Doc reference link. |
| [**Link**](https://github.com/CodeOps-Hub/Documentation/blob/main/Terraform/Design/Module/Auto-scaling.md) | ASG Module Doc |
| [**Link**](https://github.com/CodeOps-Hub/Documentation/blob/main/Terraform/Design/Wrapper-Code/Dev_Frontend_API_ASG.md) | Dev Frontend Wrapper-Code |

