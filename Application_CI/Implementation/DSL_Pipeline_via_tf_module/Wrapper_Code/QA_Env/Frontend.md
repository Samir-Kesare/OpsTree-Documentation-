
# DSL Jenkins pipeline for Frontend setup in QA Env Documentation

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
                sh 'cp wrapperCode/Frontend_Wrapper_Code/QA_Env/* .'
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

<img width="700"  src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/0fe70450-ee14-4dcc-8e4e-c60a42506084">

***

### Archive Artifact (SSH key pair)

<img width="700"  src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/14942722-ff26-44e4-8474-ac104706ada2">

***

### Console Output

<details>
<summary><strong>Click here to see Console output</strong></summary>
<br>

```shell
Started by user Admin Broo
Lightweight checkout support not available, falling back to full checkout.
Checking out git https://github.com/CodeOps-Hub/Jenkinsfile.git into /var/lib/jenkins/workspace/QA_Frontend_DSL_Pipeline@script/5c437dca2a0dbfc0911c34629742fb588229e41b5397ea7e535d21bab42d1454 to read Wrapper-Code/QA_Env/Frontend/Jenkinsfile
Selected Git installation does not exist. Using Default
The recommended git tool is: NONE
using credential Vishal-PAT-DSL
Cloning the remote Git repository
Cloning repository https://github.com/CodeOps-Hub/Jenkinsfile.git
 > git init /var/lib/jenkins/workspace/QA_Frontend_DSL_Pipeline@script/5c437dca2a0dbfc0911c34629742fb588229e41b5397ea7e535d21bab42d1454 # timeout=10
Fetching upstream changes from https://github.com/CodeOps-Hub/Jenkinsfile.git
 > git --version # timeout=10
 > git --version # 'git version 2.34.1'
using GIT_ASKPASS to set credentials Vishal-PAT-DSL
 > git fetch --tags --force --progress -- https://github.com/CodeOps-Hub/Jenkinsfile.git +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git config remote.origin.url https://github.com/CodeOps-Hub/Jenkinsfile.git # timeout=10
 > git config --add remote.origin.fetch +refs/heads/*:refs/remotes/origin/* # timeout=10
Avoid second fetch
 > git rev-parse refs/remotes/origin/vishal/QA-Frontend-Pipeline^{commit} # timeout=10
 > git rev-parse vishal/QA-Frontend-Pipeline^{commit} # timeout=10
Checking out Revision 1f46fefc2ea244e421d33c90d2a6cab4b9a1d290 (refs/remotes/origin/vishal/QA-Frontend-Pipeline)
 > git config core.sparsecheckout # timeout=10
 > git checkout -f 1f46fefc2ea244e421d33c90d2a6cab4b9a1d290 # timeout=10
Commit message: "Create Jenkinsfile"
First time build. Skipping changelog.
[Pipeline] Start of Pipeline
[Pipeline] node
Running on Jenkins in /var/lib/jenkins/workspace/QA_Frontend_DSL_Pipeline
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Declarative: Checkout SCM)
[Pipeline] checkout
Selected Git installation does not exist. Using Default
The recommended git tool is: NONE
using credential Vishal-PAT-DSL
Cloning the remote Git repository
Cloning repository https://github.com/CodeOps-Hub/Jenkinsfile.git
 > git init /var/lib/jenkins/workspace/QA_Frontend_DSL_Pipeline # timeout=10
Fetching upstream changes from https://github.com/CodeOps-Hub/Jenkinsfile.git
 > git --version # timeout=10
 > git --version # 'git version 2.34.1'
using GIT_ASKPASS to set credentials Vishal-PAT-DSL
 > git fetch --tags --force --progress -- https://github.com/CodeOps-Hub/Jenkinsfile.git +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git config remote.origin.url https://github.com/CodeOps-Hub/Jenkinsfile.git # timeout=10
 > git config --add remote.origin.fetch +refs/heads/*:refs/remotes/origin/* # timeout=10
Avoid second fetch
 > git rev-parse refs/remotes/origin/vishal/QA-Frontend-Pipeline^{commit} # timeout=10
 > git rev-parse vishal/QA-Frontend-Pipeline^{commit} # timeout=10
Checking out Revision 1f46fefc2ea244e421d33c90d2a6cab4b9a1d290 (refs/remotes/origin/vishal/QA-Frontend-Pipeline)
 > git config core.sparsecheckout # timeout=10
 > git checkout -f 1f46fefc2ea244e421d33c90d2a6cab4b9a1d290 # timeout=10
Commit message: "Create Jenkinsfile"
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
using credential Vishal-PAT-DSL
 > git rev-parse --resolve-git-dir /var/lib/jenkins/workspace/QA_Frontend_DSL_Pipeline/.git # timeout=10
Fetching changes from the remote Git repository
 > git config remote.origin.url https://github.com/CodeOps-Hub/Terraform-modules.git # timeout=10
Fetching upstream changes from https://github.com/CodeOps-Hub/Terraform-modules.git
 > git --version # timeout=10
 > git --version # 'git version 2.34.1'
using GIT_ASKPASS to set credentials Vishal-PAT-DSL
 > git fetch --tags --force --progress -- https://github.com/CodeOps-Hub/Terraform-modules.git +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git rev-parse refs/remotes/origin/main^{commit} # timeout=10
Checking out Revision b2b400dc936460c910b025aba5fb63d27b6f7247 (refs/remotes/origin/main)
 > git config core.sparsecheckout # timeout=10
 > git checkout -f b2b400dc936460c910b025aba5fb63d27b6f7247 # timeout=10
 > git branch -a -v --no-abbrev # timeout=10
 > git checkout -b main b2b400dc936460c910b025aba5fb63d27b6f7247 # timeout=10
Commit message: "Update output.tf"
First time build. Skipping changelog.
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Copy Terraform Files)
[Pipeline] sh
+ cp wrapperCode/Frontend_Wrapper_Code/QA_Env/main.tf wrapperCode/Frontend_Wrapper_Code/QA_Env/output.tf wrapperCode/Frontend_Wrapper_Code/QA_Env/provider.tf wrapperCode/Frontend_Wrapper_Code/QA_Env/script.sh wrapperCode/Frontend_Wrapper_Code/QA_Env/terraform.tfvars wrapperCode/Frontend_Wrapper_Code/QA_Env/variables.tf .
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
Downloading git::ssh://git@github.com/CodeOps-Hub/Terraform-modules.git?ref=main for QA_Frontend_ASG...
- QA_Frontend_ASG in .terraform/modules/QA_Frontend_ASG/Modules/Auto_Sacling_Module

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

Terraform used the selected providers to generate the following execution
plan. Resource actions are indicated with the following symbols:
  [32m+[0m create[0m

Terraform will perform the following actions:

[1m  # module.QA_Frontend_ASG.aws_autoscaling_group.ASG[0m will be created
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
      [32m+[0m[0m name                             = "QA-Frontend-ASG"
      [32m+[0m[0m name_prefix                      = (known after apply)
      [32m+[0m[0m predicted_capacity               = (known after apply)
      [32m+[0m[0m protect_from_scale_in            = false
      [32m+[0m[0m service_linked_role_arn          = (known after apply)
      [32m+[0m[0m target_group_arns                = (known after apply)
      [32m+[0m[0m vpc_zone_identifier              = [
          [32m+[0m[0m "subnet-04c0c823118f48202",
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
          [32m+[0m[0m value               = "ASG"
        }
    }

[1m  # module.QA_Frontend_ASG.aws_autoscaling_policy.ASG_Policy[0m will be created
[0m  [32m+[0m[0m resource "aws_autoscaling_policy" "ASG_Policy" {
      [32m+[0m[0m arn                     = (known after apply)
      [32m+[0m[0m autoscaling_group_name  = "QA-Frontend-ASG"
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

[1m  # module.QA_Frontend_ASG.aws_key_pair.key_pair[0m will be created
[0m  [32m+[0m[0m resource "aws_key_pair" "key_pair" {
      [32m+[0m[0m arn             = (known after apply)
      [32m+[0m[0m fingerprint     = (known after apply)
      [32m+[0m[0m id              = (known after apply)
      [32m+[0m[0m key_name        = "QA_Frontend_Key"
      [32m+[0m[0m key_name_prefix = (known after apply)
      [32m+[0m[0m key_pair_id     = (known after apply)
      [32m+[0m[0m key_type        = (known after apply)
      [32m+[0m[0m public_key      = (known after apply)
      [32m+[0m[0m tags_all        = (known after apply)
    }

[1m  # module.QA_Frontend_ASG.aws_launch_template.Template[0m will be created
[0m  [32m+[0m[0m resource "aws_launch_template" "Template" {
      [32m+[0m[0m arn             = (known after apply)
      [32m+[0m[0m default_version = (known after apply)
      [32m+[0m[0m description     = "Template for QA-Frontend"
      [32m+[0m[0m id              = (known after apply)
      [32m+[0m[0m image_id        = "ami-0c335502f397b30c6"
      [32m+[0m[0m instance_type   = "t2.micro"
      [32m+[0m[0m key_name        = "QA_Frontend_Key"
      [32m+[0m[0m latest_version  = (known after apply)
      [32m+[0m[0m name            = "QA-Frontend-template"
      [32m+[0m[0m name_prefix     = (known after apply)
      [32m+[0m[0m tags            = {
          [32m+[0m[0m "Name" = "QA-Frontend-template"
        }
      [32m+[0m[0m tags_all        = {
          [32m+[0m[0m "Name" = "QA-Frontend-template"
        }
      [32m+[0m[0m user_data       = "IyEvYmluL2Jhc2gKCkFMQl9ETlM9IlFBLUFMQi0xNDI4OTg4NzM4LmFwLW5vcnRoZWFzdC0xLmVsYi5hbWF6b25hd3MuY29tIgojIE1vZGlmeSBwYWNrYWdlLmpzb24gd2l0aCB0aGUgQUxCIEROUyBwbGFjZWhvbGRlcgpzZWQgLWkgJ3MvImhvbWVwYWdlIjogImh0dHBzOlwvXC9vcHN0cmVlLmdpdGh1Yi5pbyIsLyJob21lcGFnZSI6ICJodHRwOlwvXC8ke0FMQl9ETlN9IiwvJyAvaG9tZS91YnVudHUvRnJvbnRlbmQvcGFja2FnZS5qc29uCnNlZCAtaSAnLyJwcm94eSI6ICJodHRwOlwvXC9sb2NhbGhvc3Q6MzAwMCIvZCcgL2hvbWUvdWJ1bnR1L0Zyb250ZW5kL3BhY2thZ2UuanNvbgoKIyBTdGFydCB5b3VyIGFwcGxpY2F0aW9uCmNkIC9ob21lL3VidW50dS9Gcm9udGVuZCAKbnBtIHN0YXJ0Cg=="

      [32m+[0m[0m network_interfaces {
          [32m+[0m[0m security_groups = (known after apply)
          [32m+[0m[0m subnet_id       = "subnet-04c0c823118f48202"
        }
    }

[1m  # module.QA_Frontend_ASG.aws_lb_listener_rule.path_rule[0m will be created
[0m  [32m+[0m[0m resource "aws_lb_listener_rule" "path_rule" {
      [32m+[0m[0m arn          = (known after apply)
      [32m+[0m[0m id           = (known after apply)
      [32m+[0m[0m listener_arn = "arn:aws:elasticloadbalancing:ap-northeast-1:133673781875:listener/app/QA-ALB/28944ea6f074d63f/4f0525f30ddcc2a5"
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
                  [32m+[0m[0m "*",
                ]
            }
        }
    }

[1m  # module.QA_Frontend_ASG.aws_lb_target_group.Target_group[0m will be created
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
      [32m+[0m[0m name                               = "QA-Frontend-TG"
      [32m+[0m[0m name_prefix                        = (known after apply)
      [32m+[0m[0m port                               = 3000
      [32m+[0m[0m preserve_client_ip                 = (known after apply)
      [32m+[0m[0m protocol                           = "HTTP"
      [32m+[0m[0m protocol_version                   = (known after apply)
      [32m+[0m[0m proxy_protocol_v2                  = false
      [32m+[0m[0m slow_start                         = 0
      [32m+[0m[0m tags                               = {
          [32m+[0m[0m "Name" = "QA-Frontend-TG"
        }
      [32m+[0m[0m tags_all                           = {
          [32m+[0m[0m "Name" = "QA-Frontend-TG"
        }
      [32m+[0m[0m target_type                        = "instance"
      [32m+[0m[0m vpc_id                             = "vpc-0383f4dc3af051efa"

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

[1m  # module.QA_Frontend_ASG.aws_security_group.security_group[0m will be created
[0m  [32m+[0m[0m resource "aws_security_group" "security_group" {
      [32m+[0m[0m arn                    = (known after apply)
      [32m+[0m[0m description            = "Security group for QA-Frontend-API"
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
                  [32m+[0m[0m "10.0.1.0/24",
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
                  [32m+[0m[0m "sg-0f470a22a92136557",
                ]
              [32m+[0m[0m self             = false
              [32m+[0m[0m to_port          = 22
            },
          [32m+[0m[0m {
              [32m+[0m[0m cidr_blocks      = []
              [32m+[0m[0m description      = ""
              [32m+[0m[0m from_port        = 3000
              [32m+[0m[0m ipv6_cidr_blocks = []
              [32m+[0m[0m prefix_list_ids  = []
              [32m+[0m[0m protocol         = "tcp"
              [32m+[0m[0m security_groups  = [
                  [32m+[0m[0m "sg-0b426399b2b19b0ae",
                ]
              [32m+[0m[0m self             = false
              [32m+[0m[0m to_port          = 3000
            },
        ]
      [32m+[0m[0m name                   = "QA-Frontend-sg"
      [32m+[0m[0m name_prefix            = (known after apply)
      [32m+[0m[0m owner_id               = (known after apply)
      [32m+[0m[0m revoke_rules_on_delete = false
      [32m+[0m[0m tags                   = {
          [32m+[0m[0m "Enviroment" = "QA-Frontend"
          [32m+[0m[0m "Name"       = "QA-Frontend-sg"
          [32m+[0m[0m "Owner"      = "Vishal"
        }
      [32m+[0m[0m tags_all               = {
          [32m+[0m[0m "Enviroment" = "QA-Frontend"
          [32m+[0m[0m "Name"       = "QA-Frontend-sg"
          [32m+[0m[0m "Owner"      = "Vishal"
        }
      [32m+[0m[0m vpc_id                 = "vpc-0383f4dc3af051efa"
    }

[1m  # module.QA_Frontend_ASG.local_file.private_key[0m will be created
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
      [32m+[0m[0m filename             = "QA_Frontend_Key.pem"
      [32m+[0m[0m id                   = (known after apply)
    }

[1m  # module.QA_Frontend_ASG.tls_private_key.private_key[0m will be created
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
          [32m+[0m[0m "QA_Frontend_Key",
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

[1m  # module.QA_Frontend_ASG.aws_autoscaling_group.ASG[0m will be created
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
      [32m+[0m[0m name                             = "QA-Frontend-ASG"
      [32m+[0m[0m name_prefix                      = (known after apply)
      [32m+[0m[0m predicted_capacity               = (known after apply)
      [32m+[0m[0m protect_from_scale_in            = false
      [32m+[0m[0m service_linked_role_arn          = (known after apply)
      [32m+[0m[0m target_group_arns                = (known after apply)
      [32m+[0m[0m vpc_zone_identifier              = [
          [32m+[0m[0m "subnet-04c0c823118f48202",
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
          [32m+[0m[0m value               = "ASG"
        }
    }

[1m  # module.QA_Frontend_ASG.aws_autoscaling_policy.ASG_Policy[0m will be created
[0m  [32m+[0m[0m resource "aws_autoscaling_policy" "ASG_Policy" {
      [32m+[0m[0m arn                     = (known after apply)
      [32m+[0m[0m autoscaling_group_name  = "QA-Frontend-ASG"
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

[1m  # module.QA_Frontend_ASG.aws_key_pair.key_pair[0m will be created
[0m  [32m+[0m[0m resource "aws_key_pair" "key_pair" {
      [32m+[0m[0m arn             = (known after apply)
      [32m+[0m[0m fingerprint     = (known after apply)
      [32m+[0m[0m id              = (known after apply)
      [32m+[0m[0m key_name        = "QA_Frontend_Key"
      [32m+[0m[0m key_name_prefix = (known after apply)
      [32m+[0m[0m key_pair_id     = (known after apply)
      [32m+[0m[0m key_type        = (known after apply)
      [32m+[0m[0m public_key      = (known after apply)
      [32m+[0m[0m tags_all        = (known after apply)
    }

[1m  # module.QA_Frontend_ASG.aws_launch_template.Template[0m will be created
[0m  [32m+[0m[0m resource "aws_launch_template" "Template" {
      [32m+[0m[0m arn             = (known after apply)
      [32m+[0m[0m default_version = (known after apply)
      [32m+[0m[0m description     = "Template for QA-Frontend"
      [32m+[0m[0m id              = (known after apply)
      [32m+[0m[0m image_id        = "ami-0c335502f397b30c6"
      [32m+[0m[0m instance_type   = "t2.micro"
      [32m+[0m[0m key_name        = "QA_Frontend_Key"
      [32m+[0m[0m latest_version  = (known after apply)
      [32m+[0m[0m name            = "QA-Frontend-template"
      [32m+[0m[0m name_prefix     = (known after apply)
      [32m+[0m[0m tags            = {
          [32m+[0m[0m "Name" = "QA-Frontend-template"
        }
      [32m+[0m[0m tags_all        = {
          [32m+[0m[0m "Name" = "QA-Frontend-template"
        }
      [32m+[0m[0m user_data       = "IyEvYmluL2Jhc2gKCkFMQl9ETlM9IlFBLUFMQi0xNDI4OTg4NzM4LmFwLW5vcnRoZWFzdC0xLmVsYi5hbWF6b25hd3MuY29tIgojIE1vZGlmeSBwYWNrYWdlLmpzb24gd2l0aCB0aGUgQUxCIEROUyBwbGFjZWhvbGRlcgpzZWQgLWkgJ3MvImhvbWVwYWdlIjogImh0dHBzOlwvXC9vcHN0cmVlLmdpdGh1Yi5pbyIsLyJob21lcGFnZSI6ICJodHRwOlwvXC8ke0FMQl9ETlN9IiwvJyAvaG9tZS91YnVudHUvRnJvbnRlbmQvcGFja2FnZS5qc29uCnNlZCAtaSAnLyJwcm94eSI6ICJodHRwOlwvXC9sb2NhbGhvc3Q6MzAwMCIvZCcgL2hvbWUvdWJ1bnR1L0Zyb250ZW5kL3BhY2thZ2UuanNvbgoKIyBTdGFydCB5b3VyIGFwcGxpY2F0aW9uCmNkIC9ob21lL3VidW50dS9Gcm9udGVuZCAKbnBtIHN0YXJ0Cg=="

      [32m+[0m[0m network_interfaces {
          [32m+[0m[0m security_groups = (known after apply)
          [32m+[0m[0m subnet_id       = "subnet-04c0c823118f48202"
        }
    }

[1m  # module.QA_Frontend_ASG.aws_lb_listener_rule.path_rule[0m will be created
[0m  [32m+[0m[0m resource "aws_lb_listener_rule" "path_rule" {
      [32m+[0m[0m arn          = (known after apply)
      [32m+[0m[0m id           = (known after apply)
      [32m+[0m[0m listener_arn = "arn:aws:elasticloadbalancing:ap-northeast-1:133673781875:listener/app/QA-ALB/28944ea6f074d63f/4f0525f30ddcc2a5"
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
                  [32m+[0m[0m "*",
                ]
            }
        }
    }

[1m  # module.QA_Frontend_ASG.aws_lb_target_group.Target_group[0m will be created
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
      [32m+[0m[0m name                               = "QA-Frontend-TG"
      [32m+[0m[0m name_prefix                        = (known after apply)
      [32m+[0m[0m port                               = 3000
      [32m+[0m[0m preserve_client_ip                 = (known after apply)
      [32m+[0m[0m protocol                           = "HTTP"
      [32m+[0m[0m protocol_version                   = (known after apply)
      [32m+[0m[0m proxy_protocol_v2                  = false
      [32m+[0m[0m slow_start                         = 0
      [32m+[0m[0m tags                               = {
          [32m+[0m[0m "Name" = "QA-Frontend-TG"
        }
      [32m+[0m[0m tags_all                           = {
          [32m+[0m[0m "Name" = "QA-Frontend-TG"
        }
      [32m+[0m[0m target_type                        = "instance"
      [32m+[0m[0m vpc_id                             = "vpc-0383f4dc3af051efa"

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

[1m  # module.QA_Frontend_ASG.aws_security_group.security_group[0m will be created
[0m  [32m+[0m[0m resource "aws_security_group" "security_group" {
      [32m+[0m[0m arn                    = (known after apply)
      [32m+[0m[0m description            = "Security group for QA-Frontend-API"
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
                  [32m+[0m[0m "10.0.1.0/24",
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
                  [32m+[0m[0m "sg-0f470a22a92136557",
                ]
              [32m+[0m[0m self             = false
              [32m+[0m[0m to_port          = 22
            },
          [32m+[0m[0m {
              [32m+[0m[0m cidr_blocks      = []
              [32m+[0m[0m description      = ""
              [32m+[0m[0m from_port        = 3000
              [32m+[0m[0m ipv6_cidr_blocks = []
              [32m+[0m[0m prefix_list_ids  = []
              [32m+[0m[0m protocol         = "tcp"
              [32m+[0m[0m security_groups  = [
                  [32m+[0m[0m "sg-0b426399b2b19b0ae",
                ]
              [32m+[0m[0m self             = false
              [32m+[0m[0m to_port          = 3000
            },
        ]
      [32m+[0m[0m name                   = "QA-Frontend-sg"
      [32m+[0m[0m name_prefix            = (known after apply)
      [32m+[0m[0m owner_id               = (known after apply)
      [32m+[0m[0m revoke_rules_on_delete = false
      [32m+[0m[0m tags                   = {
          [32m+[0m[0m "Enviroment" = "QA-Frontend"
          [32m+[0m[0m "Name"       = "QA-Frontend-sg"
          [32m+[0m[0m "Owner"      = "Vishal"
        }
      [32m+[0m[0m tags_all               = {
          [32m+[0m[0m "Enviroment" = "QA-Frontend"
          [32m+[0m[0m "Name"       = "QA-Frontend-sg"
          [32m+[0m[0m "Owner"      = "Vishal"
        }
      [32m+[0m[0m vpc_id                 = "vpc-0383f4dc3af051efa"
    }

[1m  # module.QA_Frontend_ASG.local_file.private_key[0m will be created
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
      [32m+[0m[0m filename             = "QA_Frontend_Key.pem"
      [32m+[0m[0m id                   = (known after apply)
    }

[1m  # module.QA_Frontend_ASG.tls_private_key.private_key[0m will be created
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
          [32m+[0m[0m "QA_Frontend_Key",
        ],
    ]
  [32m+[0m[0m launch_template_id      = [
      [32m+[0m[0m [
          [32m+[0m[0m (known after apply),
        ],
    ]
[0m[1mmodule.QA_Frontend_ASG.tls_private_key.private_key: Creating...[0m[0m
[0m[1mmodule.QA_Frontend_ASG.aws_security_group.security_group: Creating...[0m[0m
[0m[1mmodule.QA_Frontend_ASG.aws_lb_target_group.Target_group: Creating...[0m[0m
[0m[1mmodule.QA_Frontend_ASG.tls_private_key.private_key: Creation complete after 3s [id=e4608e2feefa9d80d898b4efb21d628822b010c9][0m
[0m[1mmodule.QA_Frontend_ASG.aws_key_pair.key_pair: Creating...[0m[0m
[0m[1mmodule.QA_Frontend_ASG.local_file.private_key: Creating...[0m[0m
[0m[1mmodule.QA_Frontend_ASG.local_file.private_key: Creation complete after 0s [id=cf9f7a563e3fd036f41cbda47ef89ddcf5d2ffab][0m
[0m[1mmodule.QA_Frontend_ASG.aws_key_pair.key_pair: Creation complete after 1s [id=QA_Frontend_Key][0m
[0m[1mmodule.QA_Frontend_ASG.aws_lb_target_group.Target_group: Creation complete after 3s [id=arn:aws:elasticloadbalancing:ap-northeast-1:133673781875:targetgroup/QA-Frontend-TG/5118f6d4ea10ca7d][0m
[0m[1mmodule.QA_Frontend_ASG.aws_lb_listener_rule.path_rule: Creating...[0m[0m
[0m[1mmodule.QA_Frontend_ASG.aws_lb_listener_rule.path_rule: Creation complete after 1s [id=arn:aws:elasticloadbalancing:ap-northeast-1:133673781875:listener-rule/app/QA-ALB/28944ea6f074d63f/4f0525f30ddcc2a5/d32eb4faab44a684][0m
[0m[1mmodule.QA_Frontend_ASG.aws_security_group.security_group: Creation complete after 5s [id=sg-0590c6e3b0fd4b8fb][0m
[0m[1mmodule.QA_Frontend_ASG.aws_launch_template.Template: Creating...[0m[0m
[0m[1mmodule.QA_Frontend_ASG.aws_launch_template.Template: Creation complete after 1s [id=lt-04a02bbe80b0a3006][0m
[0m[1mmodule.QA_Frontend_ASG.aws_autoscaling_group.ASG: Creating...[0m[0m
[0m[1mmodule.QA_Frontend_ASG.aws_autoscaling_group.ASG: Still creating... [10s elapsed][0m[0m
[0m[1mmodule.QA_Frontend_ASG.aws_autoscaling_group.ASG: Still creating... [20s elapsed][0m[0m
[0m[1mmodule.QA_Frontend_ASG.aws_autoscaling_group.ASG: Still creating... [30s elapsed][0m[0m
[0m[1mmodule.QA_Frontend_ASG.aws_autoscaling_group.ASG: Still creating... [40s elapsed][0m[0m
[0m[1mmodule.QA_Frontend_ASG.aws_autoscaling_group.ASG: Creation complete after 44s [id=QA-Frontend-ASG][0m
[0m[1mmodule.QA_Frontend_ASG.aws_autoscaling_policy.ASG_Policy: Creating...[0m[0m
[0m[1mmodule.QA_Frontend_ASG.aws_autoscaling_policy.ASG_Policy: Creation complete after 0s [id=target-tracking-policy][0m
[0m[1m[32m
Apply complete! Resources: 9 added, 0 changed, 0 destroyed.
[0m[0m[1m[32m
Outputs:

[0mAutoscaling_group_id = [
  [
    "QA-Frontend-ASG",
  ],
]
Autoscaling_policy_name = [
  [
    "target-tracking-policy",
  ],
]
Security_Group_ID = [
  [
    "sg-0590c6e3b0fd4b8fb",
  ],
]
Target_group_id = [
  [
    "arn:aws:elasticloadbalancing:ap-northeast-1:133673781875:targetgroup/QA-Frontend-TG/5118f6d4ea10ca7d",
  ],
]
key_pair_name = [
  [
    "QA_Frontend_Key",
  ],
]
launch_template_id = [
  [
    "lt-04a02bbe80b0a3006",
  ],
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

<img width="700"  src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/4dca4d40-bc9c-4490-b141-3f2bafa354a1"> 

***
### Launch Template

<img width="700"  src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/8d4089ff-3aba-49d5-a132-c38f6db5b7ea"> 

***

### Target Group

<img width="700"  src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/4bcfd162-c83f-476e-ad7b-b69bff81fe61">

***
### Listener rule of ALB

<img width="700" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/b25928a3-4913-4bf1-b099-d220c8a52e24">

***
### Auto Scaling Group

<img width="700" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/ed4f9bf0-1643-4abc-b716-a4d80505360b">

***
### Auto Scaling Group Policies

<img width="700"  src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/2a69f15d-05ca-4276-8c97-988b91a13cb8">

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
| [**Link**](https://github.com/CodeOps-Hub/Documentation/blob/main/Terraform/Design/Wrapper-Code/QA_Frontend_API_ASG.md) | QA Frontend Wrapper-Code |
