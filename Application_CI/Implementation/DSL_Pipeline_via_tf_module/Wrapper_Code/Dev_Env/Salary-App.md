# DSL Jenkins pipeline for Salary setup in dev env Documentation

<img width="360" length="100" alt="Terraform" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/556e50dc-0c8b-4262-be16-2c384d2cfa8a">

***

| **Author** | **Created On** | **Last Updated** | **Document version** |
| ---------- | -------------- | ---------------- | -------------------- |
| **Shikha Tripathi** | **18 March 2024** | **18 March 2024** | **v1** |

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
        AWS_ACCESS_KEY_ID     = credentials('shikha_cred')
        AWS_SECRET_ACCESS_KEY = credentials('shikha_cred')
        TF_CLI_ARGS           = '-input=false'
    }
    
    parameters {
        choice(name: 'ACTION', choices: ['Apply', 'Destroy'], description: 'Choose to apply or destroy the infrastructure')
    }
    
    stages {
        stage('Checkout') {
            steps {
                git branch: 'Shikha/Salary/Salary-app', credentialsId: 'shikha-PAT', url: 'https://github.com/CodeOps-Hub/Terraform-modules.git'
            }
        }
        
        stage('Copy Terraform Files') {
            steps {
                sh 'cp wrapperCode/Salary-wrapper-code/Dev_Env/* .'
            }
        }
        
        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }
        
        stage('Terraform Plan') {
            steps {
                sh 'terraform plan'
            }
        }
        
        stage('Review and Approve Apply') {
            when {
                expression { params.ACTION == 'Apply' }
            }
            steps {
                input "Do you want to apply Terraform changes?"
            }
        }
        
        stage('Review and Approve Destroy') {
            when {
                expression { params.ACTION == 'Destroy' }
            }
            steps {
                input "Do you want to destroy Terraform resources?"
            }
        }
        
        stage('Apply or Destroy') {
            steps {
                script {
                    sh "terraform ${params.ACTION.toLowerCase()} -auto-approve"
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

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056746/4b46bf42-de3e-4429-bb04-eb88c0e4873d)


***

### Archive Artifact (SSH key pair)

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056746/cbfd1ef1-a1d1-433a-b6cc-f7872a456a05)


***

### Console Output

<details>
<summary><strong>Click here to see Console output</strong></summary>
<br>

```shell
Started by user Shikha Tripathi
Lightweight checkout support not available, falling back to full checkout.
Checking out git https://github.com/CodeOps-Hub/Jenkinsfile.git into /var/lib/jenkins/jobs/Dev_Salary_DSL_Pipeline/workspace@script/2c624e68d9ac93966b0a6ecea74a8a9f93dbab47b6fffa7f2ebbef857f80f0b1 to read Wrapper-Code/Dev_Env/Salary/Jenkinsfile
Selected Git installation does not exist. Using Default
The recommended git tool is: NONE
using credential shikha-PAT
 > git rev-parse --resolve-git-dir /var/lib/jenkins/jobs/Dev_Salary_DSL_Pipeline/workspace@script/2c624e68d9ac93966b0a6ecea74a8a9f93dbab47b6fffa7f2ebbef857f80f0b1/.git # timeout=10
Fetching changes from the remote Git repository
 > git config remote.origin.url https://github.com/CodeOps-Hub/Jenkinsfile.git # timeout=10
Fetching upstream changes from https://github.com/CodeOps-Hub/Jenkinsfile.git
 > git --version # timeout=10
 > git --version # 'git version 2.34.1'
using GIT_ASKPASS to set credentials shikha-PAT
 > git fetch --tags --force --progress -- https://github.com/CodeOps-Hub/Jenkinsfile.git +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git rev-parse refs/remotes/origin/Shikha/Dev-Salary-App^{commit} # timeout=10
 > git rev-parse Shikha/Dev-Salary-App^{commit} # timeout=10
Checking out Revision 6bc269b14f8a56d9d3606a5bddc7057d3c904676 (refs/remotes/origin/Shikha/Dev-Salary-App)
 > git config core.sparsecheckout # timeout=10
 > git checkout -f 6bc269b14f8a56d9d3606a5bddc7057d3c904676 # timeout=10
Commit message: "Update Jenkinsfile"
 > git rev-list --no-walk d52eef7349d18ab463e1f2f1f88bbe485cac3cf7 # timeout=10
[Pipeline] Start of Pipeline
[Pipeline] node
Running on Jenkins in /var/lib/jenkins/jobs/Dev_Salary_DSL_Pipeline/workspace
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Declarative: Checkout SCM)
[Pipeline] checkout
Selected Git installation does not exist. Using Default
The recommended git tool is: NONE
using credential shikha-PAT
 > git rev-parse --resolve-git-dir /var/lib/jenkins/jobs/Dev_Salary_DSL_Pipeline/workspace/.git # timeout=10
Fetching changes from the remote Git repository
 > git config remote.origin.url https://github.com/CodeOps-Hub/Jenkinsfile.git # timeout=10
Fetching upstream changes from https://github.com/CodeOps-Hub/Jenkinsfile.git
 > git --version # timeout=10
 > git --version # 'git version 2.34.1'
using GIT_ASKPASS to set credentials shikha-PAT
 > git fetch --tags --force --progress -- https://github.com/CodeOps-Hub/Jenkinsfile.git +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git rev-parse refs/remotes/origin/Shikha/Dev-Salary-App^{commit} # timeout=10
 > git rev-parse Shikha/Dev-Salary-App^{commit} # timeout=10
Checking out Revision 6bc269b14f8a56d9d3606a5bddc7057d3c904676 (refs/remotes/origin/Shikha/Dev-Salary-App)
 > git config core.sparsecheckout # timeout=10
 > git checkout -f 6bc269b14f8a56d9d3606a5bddc7057d3c904676 # timeout=10
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
using credential shikha-PAT
 > git rev-parse --resolve-git-dir /var/lib/jenkins/jobs/Dev_Salary_DSL_Pipeline/workspace/.git # timeout=10
Fetching changes from the remote Git repository
 > git config remote.origin.url https://github.com/CodeOps-Hub/Terraform-modules.git # timeout=10
Fetching upstream changes from https://github.com/CodeOps-Hub/Terraform-modules.git
 > git --version # timeout=10
 > git --version # 'git version 2.34.1'
using GIT_ASKPASS to set credentials shikha-PAT
 > git fetch --tags --force --progress -- https://github.com/CodeOps-Hub/Terraform-modules.git +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git rev-parse refs/remotes/origin/Shikha/Salary/Salary-app^{commit} # timeout=10
Checking out Revision 3b2068bcde71c118eb48947aa455089a8afe96bf (refs/remotes/origin/Shikha/Salary/Salary-app)
 > git config core.sparsecheckout # timeout=10
 > git checkout -f 3b2068bcde71c118eb48947aa455089a8afe96bf # timeout=10
 > git branch -a -v --no-abbrev # timeout=10
 > git branch -D Shikha/Salary/Salary-app # timeout=10
 > git checkout -b Shikha/Salary/Salary-app 3b2068bcde71c118eb48947aa455089a8afe96bf # timeout=10
Commit message: "Rename wrapperCode/Salary-app/variable.tf to wrapperCode/Salary-wrapper-code/Dev_Env/variable.tf"
 > git rev-list --no-walk 3b2068bcde71c118eb48947aa455089a8afe96bf # timeout=10
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Copy Terraform Files)
[Pipeline] sh
+ cp wrapperCode/Salary-wrapper-code/Dev_Env/main.tf wrapperCode/Salary-wrapper-code/Dev_Env/output.tf wrapperCode/Salary-wrapper-code/Dev_Env/provider.tf wrapperCode/Salary-wrapper-code/Dev_Env/script.sh wrapperCode/Salary-wrapper-code/Dev_Env/terraform.tfvars wrapperCode/Salary-wrapper-code/Dev_Env/variable.tf .
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Terraform Init)
[Pipeline] sh
+ terraform init

[0m[1mInitializing the backend...[0m
[0m[1mInitializing modules...[0m

[0m[1mInitializing provider plugins...[0m
- Reusing previous version of hashicorp/local from the dependency lock file
- Reusing previous version of hashicorp/aws from the dependency lock file
- Reusing previous version of hashicorp/tls from the dependency lock file
- Using previously-installed hashicorp/local v2.5.1
- Using previously-installed hashicorp/aws v5.41.0
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
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Terraform Plan)
[Pipeline] sh
+ terraform plan

Terraform used the selected providers to generate the following execution
plan. Resource actions are indicated with the following symbols:
  [32m+[0m create[0m

Terraform will perform the following actions:

[1m  # module.Dev_Salary.aws_autoscaling_group.ASG[0m will be created
[0m  [32m+[0m[0m resource "aws_autoscaling_group" "ASG" {
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
      [32m+[0m[0m name                             = "Dev-Salary_ASG"
      [32m+[0m[0m name_prefix                      = (known after apply)
      [32m+[0m[0m predicted_capacity               = (known after apply)
      [32m+[0m[0m protect_from_scale_in            = false
      [32m+[0m[0m service_linked_role_arn          = (known after apply)
      [32m+[0m[0m target_group_arns                = (known after apply)
      [32m+[0m[0m vpc_zone_identifier              = [
          [32m+[0m[0m "subnet-03e34296260c1c84d",
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
          [32m+[0m[0m value               = "Dev-Salary_ASG"
        }
    }

[1m  # module.Dev_Salary.aws_autoscaling_policy.ASG_Policy[0m will be created
[0m  [32m+[0m[0m resource "aws_autoscaling_policy" "ASG_Policy" {
      [32m+[0m[0m arn                     = (known after apply)
      [32m+[0m[0m autoscaling_group_name  = "Dev-Salary_ASG"
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

[1m  # module.Dev_Salary.aws_key_pair.key_pair[0m will be created
[0m  [32m+[0m[0m resource "aws_key_pair" "key_pair" {
      [32m+[0m[0m arn             = (known after apply)
      [32m+[0m[0m fingerprint     = (known after apply)
      [32m+[0m[0m id              = (known after apply)
      [32m+[0m[0m key_name        = "Dev_Salary_Key"
      [32m+[0m[0m key_name_prefix = (known after apply)
      [32m+[0m[0m key_pair_id     = (known after apply)
      [32m+[0m[0m key_type        = (known after apply)
      [32m+[0m[0m public_key      = (known after apply)
      [32m+[0m[0m tags_all        = (known after apply)
    }

[1m  # module.Dev_Salary.aws_launch_template.Template[0m will be created
[0m  [32m+[0m[0m resource "aws_launch_template" "Template" {
      [32m+[0m[0m arn             = (known after apply)
      [32m+[0m[0m default_version = (known after apply)
      [32m+[0m[0m description     = "Template for Dev-Salary"
      [32m+[0m[0m id              = (known after apply)
      [32m+[0m[0m image_id        = "ami-0b8b44ec9a8f90422"
      [32m+[0m[0m instance_type   = "t2.micro"
      [32m+[0m[0m key_name        = "Dev_Salary_Key"
      [32m+[0m[0m latest_version  = (known after apply)
      [32m+[0m[0m name            = "Dev-Salary-template"
      [32m+[0m[0m name_prefix     = (known after apply)
      [32m+[0m[0m tags            = {
          [32m+[0m[0m "Name" = "Dev-Salary-template"
        }
      [32m+[0m[0m tags_all        = {
          [32m+[0m[0m "Name" = "Dev-Salary-template"
        }
      [32m+[0m[0m user_data       = "ICMhL2Jpbi9iYXNoICAKIGphdmEgLWphciBTYWxhcnktQVBJL3RhcmdldC9zYWxhcnktMC4xLjAtUkVMRUFTRS5qYXIK"

      [32m+[0m[0m network_interfaces {
          [32m+[0m[0m security_groups = (known after apply)
          [32m+[0m[0m subnet_id       = "subnet-03e34296260c1c84d"
        }
    }

[1m  # module.Dev_Salary.aws_lb_listener_rule.path_rule[0m will be created
[0m  [32m+[0m[0m resource "aws_lb_listener_rule" "path_rule" {
      [32m+[0m[0m arn          = (known after apply)
      [32m+[0m[0m id           = (known after apply)
      [32m+[0m[0m listener_arn = "arn:aws:elasticloadbalancing:us-east-2:975050171850:listener/app/dev-alb/a2032332415dbebf/a9ca5d2d9b273581"
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

[1m  # module.Dev_Salary.aws_lb_target_group.Target_group[0m will be created
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
      [32m+[0m[0m port                               = 8080
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
      [32m+[0m[0m vpc_id                             = "vpc-00631f1bf6539cb88"

      [32m+[0m[0m health_check {
          [32m+[0m[0m enabled             = true
          [32m+[0m[0m healthy_threshold   = 2
          [32m+[0m[0m interval            = 30
          [32m+[0m[0m matcher             = (known after apply)
          [32m+[0m[0m path                = "/health"
          [32m+[0m[0m port                = "traffic-port"
          [32m+[0m[0m protocol            = "HTTP"
          [32m+[0m[0m timeout             = 5
          [32m+[0m[0m unhealthy_threshold = 2
        }
    }

[1m  # module.Dev_Salary.aws_security_group.security_group[0m will be created
[0m  [32m+[0m[0m resource "aws_security_group" "security_group" {
      [32m+[0m[0m arn                    = (known after apply)
      [32m+[0m[0m description            = "Security group for Dev-Salary-API"
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
                  [32m+[0m[0m "sg-00a65bcd92abcee70",
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
                  [32m+[0m[0m "sg-0d2e3609a8b620d52",
                ]
              [32m+[0m[0m self             = false
              [32m+[0m[0m to_port          = 8080
            },
        ]
      [32m+[0m[0m name                   = "Dev-Salary-sg"
      [32m+[0m[0m name_prefix            = (known after apply)
      [32m+[0m[0m owner_id               = (known after apply)
      [32m+[0m[0m revoke_rules_on_delete = false
      [32m+[0m[0m tags                   = {
          [32m+[0m[0m "Enviroment" = "Dev_Salary"
          [32m+[0m[0m "Name"       = "Dev-Salary-sg"
          [32m+[0m[0m "Owner"      = "Salary"
        }
      [32m+[0m[0m tags_all               = {
          [32m+[0m[0m "Enviroment" = "Dev_Salary"
          [32m+[0m[0m "Name"       = "Dev-Salary-sg"
          [32m+[0m[0m "Owner"      = "Salary"
        }
      [32m+[0m[0m vpc_id                 = "vpc-00631f1bf6539cb88"
    }

[1m  # module.Dev_Salary.local_file.private_key[0m will be created
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
      [32m+[0m[0m filename             = "Dev_Salary_Key.pem"
      [32m+[0m[0m id                   = (known after apply)
    }

[1m  # module.Dev_Salary.tls_private_key.private_key[0m will be created
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

[1mPlan:[0m 9 to add, 0 to change, 0 to destroy.
[0m
Changes to Outputs:
  [32m+[0m[0m Autoscaling_group_id    = [
      [32m+[0m[0m [
          [32m+[0m[0m (known after apply),
        ],
    ]
  [32m+[0m[0m Autoscaling_policy_name = [
      [32m+[0m[0m [
          [32m+[0m[0m "target-tracking-policy",
        ],
    ]
  [32m+[0m[0m Security_Group_ID       = [
      [32m+[0m[0m [
          [32m+[0m[0m (known after apply),
        ],
    ]
  [32m+[0m[0m Target_group_id         = [
      [32m+[0m[0m [
          [32m+[0m[0m (known after apply),
        ],
    ]
  [32m+[0m[0m key_pair_name           = [
      [32m+[0m[0m [
          [32m+[0m[0m "Dev_Salary_Key",
        ],
    ]
  [32m+[0m[0m launch_template_id      = [
      [32m+[0m[0m [
          [32m+[0m[0m (known after apply),
        ],
    ]
[90m
─────────────────────────────────────────────────────────────────────────────[0m

Note: You didn't use the -out option to save this plan, so Terraform can't
guarantee to take exactly these actions if you run "terraform apply" now.
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

[1m  # module.Dev_Salary.aws_autoscaling_group.ASG[0m will be created
[0m  [32m+[0m[0m resource "aws_autoscaling_group" "ASG" {
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
      [32m+[0m[0m name                             = "Dev-Salary_ASG"
      [32m+[0m[0m name_prefix                      = (known after apply)
      [32m+[0m[0m predicted_capacity               = (known after apply)
      [32m+[0m[0m protect_from_scale_in            = false
      [32m+[0m[0m service_linked_role_arn          = (known after apply)
      [32m+[0m[0m target_group_arns                = (known after apply)
      [32m+[0m[0m vpc_zone_identifier              = [
          [32m+[0m[0m "subnet-03e34296260c1c84d",
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
          [32m+[0m[0m value               = "Dev-Salary_ASG"
        }
    }

[1m  # module.Dev_Salary.aws_autoscaling_policy.ASG_Policy[0m will be created
[0m  [32m+[0m[0m resource "aws_autoscaling_policy" "ASG_Policy" {
      [32m+[0m[0m arn                     = (known after apply)
      [32m+[0m[0m autoscaling_group_name  = "Dev-Salary_ASG"
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

[1m  # module.Dev_Salary.aws_key_pair.key_pair[0m will be created
[0m  [32m+[0m[0m resource "aws_key_pair" "key_pair" {
      [32m+[0m[0m arn             = (known after apply)
      [32m+[0m[0m fingerprint     = (known after apply)
      [32m+[0m[0m id              = (known after apply)
      [32m+[0m[0m key_name        = "Dev_Salary_Key"
      [32m+[0m[0m key_name_prefix = (known after apply)
      [32m+[0m[0m key_pair_id     = (known after apply)
      [32m+[0m[0m key_type        = (known after apply)
      [32m+[0m[0m public_key      = (known after apply)
      [32m+[0m[0m tags_all        = (known after apply)
    }

[1m  # module.Dev_Salary.aws_launch_template.Template[0m will be created
[0m  [32m+[0m[0m resource "aws_launch_template" "Template" {
      [32m+[0m[0m arn             = (known after apply)
      [32m+[0m[0m default_version = (known after apply)
      [32m+[0m[0m description     = "Template for Dev-Salary"
      [32m+[0m[0m id              = (known after apply)
      [32m+[0m[0m image_id        = "ami-0b8b44ec9a8f90422"
      [32m+[0m[0m instance_type   = "t2.micro"
      [32m+[0m[0m key_name        = "Dev_Salary_Key"
      [32m+[0m[0m latest_version  = (known after apply)
      [32m+[0m[0m name            = "Dev-Salary-template"
      [32m+[0m[0m name_prefix     = (known after apply)
      [32m+[0m[0m tags            = {
          [32m+[0m[0m "Name" = "Dev-Salary-template"
        }
      [32m+[0m[0m tags_all        = {
          [32m+[0m[0m "Name" = "Dev-Salary-template"
        }
      [32m+[0m[0m user_data       = "ICMhL2Jpbi9iYXNoICAKIGphdmEgLWphciBTYWxhcnktQVBJL3RhcmdldC9zYWxhcnktMC4xLjAtUkVMRUFTRS5qYXIK"

      [32m+[0m[0m network_interfaces {
          [32m+[0m[0m security_groups = (known after apply)
          [32m+[0m[0m subnet_id       = "subnet-03e34296260c1c84d"
        }
    }

[1m  # module.Dev_Salary.aws_lb_listener_rule.path_rule[0m will be created
[0m  [32m+[0m[0m resource "aws_lb_listener_rule" "path_rule" {
      [32m+[0m[0m arn          = (known after apply)
      [32m+[0m[0m id           = (known after apply)
      [32m+[0m[0m listener_arn = "arn:aws:elasticloadbalancing:us-east-2:975050171850:listener/app/dev-alb/a2032332415dbebf/a9ca5d2d9b273581"
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

[1m  # module.Dev_Salary.aws_lb_target_group.Target_group[0m will be created
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
      [32m+[0m[0m port                               = 8080
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
      [32m+[0m[0m vpc_id                             = "vpc-00631f1bf6539cb88"

      [32m+[0m[0m health_check {
          [32m+[0m[0m enabled             = true
          [32m+[0m[0m healthy_threshold   = 2
          [32m+[0m[0m interval            = 30
          [32m+[0m[0m matcher             = (known after apply)
          [32m+[0m[0m path                = "/health"
          [32m+[0m[0m port                = "traffic-port"
          [32m+[0m[0m protocol            = "HTTP"
          [32m+[0m[0m timeout             = 5
          [32m+[0m[0m unhealthy_threshold = 2
        }
    }

[1m  # module.Dev_Salary.aws_security_group.security_group[0m will be created
[0m  [32m+[0m[0m resource "aws_security_group" "security_group" {
      [32m+[0m[0m arn                    = (known after apply)
      [32m+[0m[0m description            = "Security group for Dev-Salary-API"
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
                  [32m+[0m[0m "sg-00a65bcd92abcee70",
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
                  [32m+[0m[0m "sg-0d2e3609a8b620d52",
                ]
              [32m+[0m[0m self             = false
              [32m+[0m[0m to_port          = 8080
            },
        ]
      [32m+[0m[0m name                   = "Dev-Salary-sg"
      [32m+[0m[0m name_prefix            = (known after apply)
      [32m+[0m[0m owner_id               = (known after apply)
      [32m+[0m[0m revoke_rules_on_delete = false
      [32m+[0m[0m tags                   = {
          [32m+[0m[0m "Enviroment" = "Dev_Salary"
          [32m+[0m[0m "Name"       = "Dev-Salary-sg"
          [32m+[0m[0m "Owner"      = "Salary"
        }
      [32m+[0m[0m tags_all               = {
          [32m+[0m[0m "Enviroment" = "Dev_Salary"
          [32m+[0m[0m "Name"       = "Dev-Salary-sg"
          [32m+[0m[0m "Owner"      = "Salary"
        }
      [32m+[0m[0m vpc_id                 = "vpc-00631f1bf6539cb88"
    }

[1m  # module.Dev_Salary.local_file.private_key[0m will be created
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
      [32m+[0m[0m filename             = "Dev_Salary_Key.pem"
      [32m+[0m[0m id                   = (known after apply)
    }

[1m  # module.Dev_Salary.tls_private_key.private_key[0m will be created
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

[1mPlan:[0m 9 to add, 0 to change, 0 to destroy.
[0m
Changes to Outputs:
  [32m+[0m[0m Autoscaling_group_id    = [
      [32m+[0m[0m [
          [32m+[0m[0m (known after apply),
        ],
    ]
  [32m+[0m[0m Autoscaling_policy_name = [
      [32m+[0m[0m [
          [32m+[0m[0m "target-tracking-policy",
        ],
    ]
  [32m+[0m[0m Security_Group_ID       = [
      [32m+[0m[0m [
          [32m+[0m[0m (known after apply),
        ],
    ]
  [32m+[0m[0m Target_group_id         = [
      [32m+[0m[0m [
          [32m+[0m[0m (known after apply),
        ],
    ]
  [32m+[0m[0m key_pair_name           = [
      [32m+[0m[0m [
          [32m+[0m[0m "Dev_Salary_Key",
        ],
    ]
  [32m+[0m[0m launch_template_id      = [
      [32m+[0m[0m [
          [32m+[0m[0m (known after apply),
        ],
    ]
[0m[1mmodule.Dev_Salary.tls_private_key.private_key: Creating...[0m[0m
[0m[1mmodule.Dev_Salary.aws_security_group.security_group: Creating...[0m[0m
[0m[1mmodule.Dev_Salary.aws_lb_target_group.Target_group: Creating...[0m[0m
[0m[1mmodule.Dev_Salary.aws_lb_target_group.Target_group: Creation complete after 0s [id=arn:aws:elasticloadbalancing:us-east-2:975050171850:targetgroup/Dev-Salary-TG/f00bc37d51230aba][0m
[0m[1mmodule.Dev_Salary.aws_lb_listener_rule.path_rule: Creating...[0m[0m
[0m[1mmodule.Dev_Salary.aws_lb_listener_rule.path_rule: Creation complete after 1s [id=arn:aws:elasticloadbalancing:us-east-2:975050171850:listener-rule/app/dev-alb/a2032332415dbebf/a9ca5d2d9b273581/4f97429549204e72][0m
[0m[1mmodule.Dev_Salary.aws_security_group.security_group: Creation complete after 2s [id=sg-0cd1aa7f0581217e3][0m
[0m[1mmodule.Dev_Salary.tls_private_key.private_key: Creation complete after 3s [id=27bf66d75478cbb8b21060360228ff5fb1955d37][0m
[0m[1mmodule.Dev_Salary.aws_key_pair.key_pair: Creating...[0m[0m
[0m[1mmodule.Dev_Salary.local_file.private_key: Creating...[0m[0m
[0m[1mmodule.Dev_Salary.local_file.private_key: Creation complete after 0s [id=e09cc6a2e8373507a6cf0317edb623d3a226340c][0m
[0m[1mmodule.Dev_Salary.aws_key_pair.key_pair: Creation complete after 1s [id=Dev_Salary_Key][0m
[0m[1mmodule.Dev_Salary.aws_launch_template.Template: Creating...[0m[0m
[0m[1mmodule.Dev_Salary.aws_launch_template.Template: Creation complete after 0s [id=lt-0a3b1e30c9dab9d24][0m
[0m[1mmodule.Dev_Salary.aws_autoscaling_group.ASG: Creating...[0m[0m
[0m[1mmodule.Dev_Salary.aws_autoscaling_group.ASG: Still creating... [10s elapsed][0m[0m
[0m[1mmodule.Dev_Salary.aws_autoscaling_group.ASG: Still creating... [20s elapsed][0m[0m
[0m[1mmodule.Dev_Salary.aws_autoscaling_group.ASG: Still creating... [30s elapsed][0m[0m
[0m[1mmodule.Dev_Salary.aws_autoscaling_group.ASG: Still creating... [40s elapsed][0m[0m
[0m[1mmodule.Dev_Salary.aws_autoscaling_group.ASG: Creation complete after 46s [id=Dev-Salary_ASG][0m
[0m[1mmodule.Dev_Salary.aws_autoscaling_policy.ASG_Policy: Creating...[0m[0m
[0m[1mmodule.Dev_Salary.aws_autoscaling_policy.ASG_Policy: Creation complete after 1s [id=target-tracking-policy][0m
[0m[1m[32m
Apply complete! Resources: 9 added, 0 changed, 0 destroyed.
[0m[0m[1m[32m
Outputs:

[0mAutoscaling_group_id = [
  [
    "Dev-Salary_ASG",
  ],
]
Autoscaling_policy_name = [
  [
    "target-tracking-policy",
  ],
]
Security_Group_ID = [
  [
    "sg-0cd1aa7f0581217e3",
  ],
]
Target_group_id = [
  [
    "arn:aws:elasticloadbalancing:us-east-2:975050171850:targetgroup/Dev-Salary-TG/f00bc37d51230aba",
  ],
]
key_pair_name = [
  [
    "Dev_Salary_Key",
  ],
]
launch_template_id = [
  [
    "lt-0a3b1e30c9dab9d24",
  ],
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

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056746/aa769f35-7dae-4cbc-bebc-770547fa3fde)

***
### Launch Template

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056746/c7338a2d-2dde-45b2-b876-379653071824)


***

### Target Group

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056746/bd978832-42d7-419f-ab7a-d2e63390d7b0)


***
### Auto Scaling Group

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056746/6b24ceb6-af84-49b4-b151-c0f3b9d2f1f9)

### Auto Scaling Group Policies

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056746/e3b58ff5-a965-4252-a7b8-65cd2d630615)


***

# Conclusion

In conclusion, our DSL Pipeline offers a powerful solution for creating and managing domain-specific languages, enabling developers to express complex ideas in a concise and understandable manner. By embracing DSLs, organizations can accelerate development cycles, improve collaboration between domain experts and developers, and ultimately deliver higher-quality software solutions. 

***

# Contact Information

| **Name** | **Email Address** |
| -------- | ----------------- |
| **Shikha Tripathi** | shikha.tripathi.snaatak@mygurukulam.co |

***

# References

| **Source** | **Description** |
| ---------- | --------------- |
| [**Link**](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GenericDoc/Terraform/terraform.md) | Terraform Generic Doc Link. |
| [**Link**](https://developer.hashicorp.com/terraform/language/modules) | Terraform Module Concept. |
| [**Link**](https://github.com/CodeOps-Hub/Jenkinsfile/blob/Shikha/Dev-Salary-App/Wrapper-Code/Dev_Env/Salary/Jenkinsfile)  | Jenkins DSL Pipeline Doc reference link. |
| [**Link**](https://github.com/CodeOps-Hub/Documentation/blob/main/Terraform/Design/Module/Auto-scaling.md) | ASG Module Doc |
| [**Link**](https://github.com/CodeOps-Hub/Terraform-modules.git) | Dev Salary Wrapper-Code |
