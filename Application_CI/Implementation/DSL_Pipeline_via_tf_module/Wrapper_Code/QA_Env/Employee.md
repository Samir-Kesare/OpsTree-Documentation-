# DSL Jenkins pipeline for Employee setup in QA Env
![image](https://github.com/CodeOps-Hub/Documentation/assets/156056364/b7501107-272b-4144-bfef-e33043c14add)
***
| **Author** | **Created On** | **Last Updated** | **Document version** |
| ---------- | -------------- | ---------------- | -------------------- |
| **Shantanu** | **18 March 2024** | **19 March 2024** | **v1** |
***

# Table of contents

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

# Introduction
Terraform has become essential for automating network resource provisioning and configuration in today's intricate networks. 
This module offers a fundamental framework for managing network infrastructure through Terraform, enabling users to swiftly establish standardized and scalable 
architectures in their cloud environments. With the growing complexity of networks and the increasing significance of infrastructure management, specialized 
Domain-Specific Languages (DSLs) have proven invaluable for simplifying and automating various tasks.
***

# What is DSL Pipeline?

A Domain-Specific Language (DSL) is a specialized programming language tailored to address specific problem domains, representation techniques, or solution methods.
DSL Pipeline is a robust framework crafted to simplify the development, deployment, and management of such languages within software projects. By utilizing DSLs, 
developers can articulate solutions in a focused, domain-specific syntax, leading to increased efficiency and bridging the gap between domain experts and software 
implementation.

DSLs come in two primary forms: external DSLs and internal DSLs. External DSLs possess their unique syntax and are typically interpreted or compiled by separate 
tools. Conversely, internal DSLs are integrated within a host programming language, leveraging its syntax and capabilities to create domain-specific syntax.
***

# Why DSL Pipeline

| Key Features  | Description                                                                                                              |
|---------------|--------------------------------------------------------------------------------------------------------------------------|
| **Modularity**    | The DSL Pipeline offers a modular architecture, allowing developers to define and integrate custom DSL components seamlessly. |
| **Extensibility** | Extend the capabilities of the DSL Pipeline by incorporating new DSL constructs, transformations, and integrations with existing tools and libraries. |
| **Automation**    | Automate repetitive tasks in the development lifecycle through pipeline automation, including parsing, validation, transformation, and code generation. |
| **Flexibility**   | Accommodate diverse DSL requirements with flexible configuration options, support for various syntax styles, and compatibility with multiple target platforms. |
***

# Flow Diagram

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056364/744d1427-8c16-4695-9754-2b94b89c8865)

***

# Pre-requisites

| **Pre-requisites** | **Description** |
| ------------------ | ---------------- |
| **AWS Account**    | Access to the AWS Management Console with credentials configured. |
| **Jenkins**        | To integrate infra through DSL Pipeline. |
| **Terraform**      | Terraform HCL (v1.7.4) |
***

# Jenkinsfile
<details>
<summary><strong>Click here</strong></summary>
<br>

```shell
pipeline {
    agent any
    
    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-access-key')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-key')
        TF_CLI_ARGS           = '-input=false'
    }
    
    parameters {
        choice(name: 'ACTION', choices: ['Apply', 'Destroy'], description: 'Choose to apply or destroy the infrastructure')
    }
    
    stages {
        stage('Checkout') {
            steps {
                git branch: 'Shantanu/Employee/QA', credentialsId: 'shantanu-pat', url: 'https://github.com/CodeOps-Hub/Terraform-modules.git'
            }
        }
        
        stage('Copy Terraform Files') {
            steps {
                sh 'cp wrapperCode/Employee_Wrapper_Code/Dev_QA/* .'
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


**This Jenkins pipeline automates the deployment of a Employee API infrastructure using Terraform module and Wrapper code. It's configured to perform the following actions:**


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

# Jenkins Output

### Pipeline view
![Screenshot 2024-03-20 at 12 29 51 AM](https://github.com/CodeOps-Hub/Documentation/assets/156056364/5572f6f1-41ff-4d20-879c-8176bed6b1d7)

### Archive Artifact (SSH key pair)
![Screenshot 2024-03-20 at 12 31 46 AM](https://github.com/CodeOps-Hub/Documentation/assets/156056364/f0dec74e-afc1-4538-b311-ed5e78f3ec0c)

***

### Console Output
<details>
<summary><strong>Click here</strong></summary>
<br>

```shell
Started by user Shantanu
[Pipeline] Start of Pipeline
[Pipeline] node
Running on Jenkins in /var/lib/jenkins/workspace/DSL_Employee_QA
[Pipeline] {
[Pipeline] withCredentials
Masking supported pattern matches of $AWS_ACCESS_KEY_ID or $AWS_SECRET_ACCESS_KEY
[Pipeline] {
[Pipeline] withEnv
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Checkout)
[Pipeline] git
The recommended git tool is: NONE
using credential shantanu-pat
 > git rev-parse --resolve-git-dir /var/lib/jenkins/workspace/DSL_Employee_QA/.git # timeout=10
Fetching changes from the remote Git repository
 > git config remote.origin.url https://github.com/CodeOps-Hub/Terraform-modules.git # timeout=10
Fetching upstream changes from https://github.com/CodeOps-Hub/Terraform-modules.git
 > git --version # timeout=10
 > git --version # 'git version 2.25.1'
using GIT_ASKPASS to set credentials shantanu-pat
 > git fetch --tags --force --progress -- https://github.com/CodeOps-Hub/Terraform-modules.git +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git rev-parse refs/remotes/origin/Shantanu/Employee/QA^{commit} # timeout=10
Checking out Revision 7b0703378c5055c5edf2eeb1ff8e901c8413b1f7 (refs/remotes/origin/Shantanu/Employee/QA)
 > git config core.sparsecheckout # timeout=10
 > git checkout -f 7b0703378c5055c5edf2eeb1ff8e901c8413b1f7 # timeout=10
 > git branch -a -v --no-abbrev # timeout=10
 > git branch -D Shantanu/Employee/QA # timeout=10
 > git checkout -b Shantanu/Employee/QA 7b0703378c5055c5edf2eeb1ff8e901c8413b1f7 # timeout=10
Commit message: "Update terraform.tfvars"
 > git rev-list --no-walk ab6858033375d15f873747dd991f0f5a2239ccaa # timeout=10
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Copy Terraform Files)
[Pipeline] sh
+ cp wrapperCode/Employee_Wrapper_Code/QA_Env/main.tf wrapperCode/Employee_Wrapper_Code/QA_Env/output.tf wrapperCode/Employee_Wrapper_Code/QA_Env/provider.tf wrapperCode/Employee_Wrapper_Code/QA_Env/script.sh wrapperCode/Employee_Wrapper_Code/QA_Env/terraform.tfvars wrapperCode/Employee_Wrapper_Code/QA_Env/variables.tf .
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Terraform Init)
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
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Terraform Plan)
[Pipeline] sh
+ terraform plan
[0m[1mmodule.QA_Employee.tls_private_key.private_key: Refreshing state... [id=fd7f1e293a9265a0e6ebe520c4bfbd6196aeb147][0m
[0m[1mmodule.QA_Employee.local_file.private_key: Refreshing state... [id=9e46a2e2c312711d0ce954a2b01fb042fe7d2fbb][0m
[0m[1mmodule.QA_Employee.aws_key_pair.key_pair: Refreshing state... [id=QA_Employee_Key][0m
[0m[1mmodule.QA_Employee.aws_lb_target_group.Target_group: Refreshing state... [id=arn:aws:elasticloadbalancing:ap-southeast-1:441247711986:targetgroup/QA-Employee-TG/ce1d87c41ab53a31][0m
[0m[1mmodule.QA_Employee.aws_security_group.security_group: Refreshing state... [id=sg-077db1c6439ddefce][0m
[0m[1mmodule.QA_Employee.aws_launch_template.Template: Refreshing state... [id=lt-090e7facf136ca9b4][0m
[0m[1mmodule.QA_Employee.aws_autoscaling_group.ASG: Refreshing state... [id=QA-Employee_ASG][0m
[0m[1mmodule.QA_Employee.aws_autoscaling_policy.ASG_Policy: Refreshing state... [id=target-tracking-policy][0m

[1m[36mNote:[0m[1m Objects have changed outside of Terraform
[0m
Terraform detected the following changes made outside of Terraform since the
last "terraform apply" which may have affected this plan:

[1m  # module.QA_Employee.aws_autoscaling_group.ASG[0m has been deleted
[0m  [31m-[0m[0m resource "aws_autoscaling_group" "ASG" {
      [31m-[0m[0m id                               = "QA-Employee_ASG" [90m-> null[0m[0m
      [31m-[0m[0m name                             = "QA-Employee_ASG" [90m-> null[0m[0m
        [90m# (26 unchanged attributes hidden)[0m[0m

        [90m# (3 unchanged blocks hidden)[0m[0m
    }

[1m  # module.QA_Employee.aws_autoscaling_policy.ASG_Policy[0m has been deleted
[0m  [31m-[0m[0m resource "aws_autoscaling_policy" "ASG_Policy" {
        id                        = "target-tracking-policy"
      [31m-[0m[0m name                      = "target-tracking-policy" [90m-> null[0m[0m
        [90m# (8 unchanged attributes hidden)[0m[0m

        [90m# (1 unchanged block hidden)[0m[0m
    }

[1m  # module.QA_Employee.aws_lb_target_group.Target_group[0m has been deleted
[0m  [31m-[0m[0m resource "aws_lb_target_group" "Target_group" {
      [31m-[0m[0m arn                                = "arn:aws:elasticloadbalancing:ap-southeast-1:441247711986:targetgroup/QA-Employee-TG/ce1d87c41ab53a31" [90m-> null[0m[0m
      [31m-[0m[0m id                                 = "arn:aws:elasticloadbalancing:ap-southeast-1:441247711986:targetgroup/QA-Employee-TG/ce1d87c41ab53a31" [90m-> null[0m[0m
        name                               = "QA-Employee-TG"
        tags                               = {
            "Name" = "QA-Employee-TG"
        }
        [90m# (16 unchanged attributes hidden)[0m[0m

        [90m# (4 unchanged blocks hidden)[0m[0m
    }

[1m  # module.QA_Employee.aws_security_group.security_group[0m has been deleted
[0m  [31m-[0m[0m resource "aws_security_group" "security_group" {
      [31m-[0m[0m id                     = "sg-077db1c6439ddefce" [90m-> null[0m[0m
        name                   = "QA-Employee-sg"
        tags                   = {
            "Enviroment" = "QA_Employee"
            "Name"       = "QA-Employee-sg"
            "Owner"      = "Employee"
        }
        [90m# (8 unchanged attributes hidden)[0m[0m
    }


Unless you have made equivalent changes to your configuration, or ignored the
relevant attributes using ignore_changes, the following plan may include
actions to undo or respond to these changes.
[90m
─────────────────────────────────────────────────────────────────────────────[0m

Terraform used the selected providers to generate the following execution
plan. Resource actions are indicated with the following symbols:
  [32m+[0m create[0m
  [33m~[0m update in-place[0m

Terraform will perform the following actions:

[1m  # module.QA_Employee.aws_autoscaling_group.ASG[0m will be created
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
      [32m+[0m[0m name                             = "QA-Employee_ASG"
      [32m+[0m[0m name_prefix                      = (known after apply)
      [32m+[0m[0m predicted_capacity               = (known after apply)
      [32m+[0m[0m protect_from_scale_in            = false
      [32m+[0m[0m service_linked_role_arn          = (known after apply)
      [32m+[0m[0m target_group_arns                = (known after apply)
      [32m+[0m[0m vpc_zone_identifier              = [
          [32m+[0m[0m "subnet-0abcfc7a31b6687b4",
        ]
      [32m+[0m[0m wait_for_capacity_timeout        = "10m"
      [32m+[0m[0m warm_pool_size                   = (known after apply)

      [32m+[0m[0m launch_template {
          [32m+[0m[0m id      = "lt-090e7facf136ca9b4"
          [32m+[0m[0m name    = (known after apply)
          [32m+[0m[0m version = "$Latest"
        }

      [32m+[0m[0m tag {
          [32m+[0m[0m key                 = "Name"
          [32m+[0m[0m propagate_at_launch = true
          [32m+[0m[0m value               = "QA-Employee_ASG"
        }
    }

[1m  # module.QA_Employee.aws_autoscaling_policy.ASG_Policy[0m will be created
[0m  [32m+[0m[0m resource "aws_autoscaling_policy" "ASG_Policy" {
      [32m+[0m[0m arn                     = (known after apply)
      [32m+[0m[0m autoscaling_group_name  = "QA-Employee_ASG"
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

[1m  # module.QA_Employee.aws_launch_template.Template[0m will be updated in-place
[0m  [33m~[0m[0m resource "aws_launch_template" "Template" {
        id                      = "lt-090e7facf136ca9b4"
      [33m~[0m[0m latest_version          = 1 -> (known after apply)
        name                    = "QA-Employee-template"
        tags                    = {
            "Name" = "QA-Employee-template"
        }
        [90m# (12 unchanged attributes hidden)[0m[0m

      [33m~[0m[0m network_interfaces {
          [33m~[0m[0m security_groups    = [
              [31m-[0m[0m "sg-077db1c6439ddefce",
            ] -> (known after apply)
            [90m# (11 unchanged attributes hidden)[0m[0m
        }
    }

[1m  # module.QA_Employee.aws_lb_listener_rule.path_rule[0m will be created
[0m  [32m+[0m[0m resource "aws_lb_listener_rule" "path_rule" {
      [32m+[0m[0m arn          = (known after apply)
      [32m+[0m[0m id           = (known after apply)
      [32m+[0m[0m listener_arn = "arn:aws:elasticloadbalancing:ap-southeast-1:441247711986:listener/app/emp-qa/35838b69cfc8ee74/995c5bfc07cb4270"
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
                  [32m+[0m[0m "/api/v1/employee/*",
                ]
            }
        }
    }

[1m  # module.QA_Employee.aws_lb_target_group.Target_group[0m will be created
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
      [32m+[0m[0m name                               = "QA-Employee-TG"
      [32m+[0m[0m name_prefix                        = (known after apply)
      [32m+[0m[0m port                               = 8080
      [32m+[0m[0m preserve_client_ip                 = (known after apply)
      [32m+[0m[0m protocol                           = "HTTP"
      [32m+[0m[0m protocol_version                   = (known after apply)
      [32m+[0m[0m proxy_protocol_v2                  = false
      [32m+[0m[0m slow_start                         = 0
      [32m+[0m[0m tags                               = {
          [32m+[0m[0m "Name" = "QA-Employee-TG"
        }
      [32m+[0m[0m tags_all                           = {
          [32m+[0m[0m "Name" = "QA-Employee-TG"
        }
      [32m+[0m[0m target_type                        = "instance"
      [32m+[0m[0m vpc_id                             = "vpc-037273df63a16de65"

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

[1m  # module.QA_Employee.aws_security_group.security_group[0m will be created
[0m  [32m+[0m[0m resource "aws_security_group" "security_group" {
      [32m+[0m[0m arn                    = (known after apply)
      [32m+[0m[0m description            = "Security group for QA-Employee-API"
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
                  [32m+[0m[0m "sg-04b7eb5f6320a1aa6",
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
                  [32m+[0m[0m "sg-04b7eb5f6320a1aa6",
                ]
              [32m+[0m[0m self             = false
              [32m+[0m[0m to_port          = 8080
            },
        ]
      [32m+[0m[0m name                   = "QA-Employee-sg"
      [32m+[0m[0m name_prefix            = (known after apply)
      [32m+[0m[0m owner_id               = (known after apply)
      [32m+[0m[0m revoke_rules_on_delete = false
      [32m+[0m[0m tags                   = {
          [32m+[0m[0m "Enviroment" = "QA_Employee"
          [32m+[0m[0m "Name"       = "QA-Employee-sg"
          [32m+[0m[0m "Owner"      = "Employee"
        }
      [32m+[0m[0m tags_all               = {
          [32m+[0m[0m "Enviroment" = "QA_Employee"
          [32m+[0m[0m "Name"       = "QA-Employee-sg"
          [32m+[0m[0m "Owner"      = "Employee"
        }
      [32m+[0m[0m vpc_id                 = "vpc-037273df63a16de65"
    }

[1mPlan:[0m 5 to add, 1 to change, 0 to destroy.
[0m
Changes to Outputs:
  [33m~[0m[0m Autoscaling_group_id    = [
      [31m-[0m[0m [
          [31m-[0m[0m "QA-Employee_ASG",
        ],
      [32m+[0m[0m [
          [32m+[0m[0m (known after apply),
        ],
    ]
  [33m~[0m[0m Security_Group_ID       = [
      [31m-[0m[0m [
          [31m-[0m[0m "sg-077db1c6439ddefce",
        ],
      [32m+[0m[0m [
          [32m+[0m[0m (known after apply),
        ],
    ]
  [33m~[0m[0m Target_group_id         = [
      [31m-[0m[0m [
          [31m-[0m[0m "arn:aws:elasticloadbalancing:ap-southeast-1:441247711986:targetgroup/QA-Employee-TG/ce1d87c41ab53a31",
        ],
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
Approved by Shantanu
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
[0m[1mmodule.QA_Employee.tls_private_key.private_key: Refreshing state... [id=fd7f1e293a9265a0e6ebe520c4bfbd6196aeb147][0m
[0m[1mmodule.QA_Employee.local_file.private_key: Refreshing state... [id=9e46a2e2c312711d0ce954a2b01fb042fe7d2fbb][0m
[0m[1mmodule.QA_Employee.aws_key_pair.key_pair: Refreshing state... [id=QA_Employee_Key][0m
[0m[1mmodule.QA_Employee.aws_lb_target_group.Target_group: Refreshing state... [id=arn:aws:elasticloadbalancing:ap-southeast-1:441247711986:targetgroup/QA-Employee-TG/ce1d87c41ab53a31][0m
[0m[1mmodule.QA_Employee.aws_security_group.security_group: Refreshing state... [id=sg-077db1c6439ddefce][0m
[0m[1mmodule.QA_Employee.aws_launch_template.Template: Refreshing state... [id=lt-090e7facf136ca9b4][0m
[0m[1mmodule.QA_Employee.aws_autoscaling_group.ASG: Refreshing state... [id=QA-Employee_ASG][0m
[0m[1mmodule.QA_Employee.aws_autoscaling_policy.ASG_Policy: Refreshing state... [id=target-tracking-policy][0m

[1m[36mNote:[0m[1m Objects have changed outside of Terraform
[0m
Terraform detected the following changes made outside of Terraform since the
last "terraform apply" which may have affected this plan:

[1m  # module.QA_Employee.aws_autoscaling_group.ASG[0m has been deleted
[0m  [31m-[0m[0m resource "aws_autoscaling_group" "ASG" {
      [31m-[0m[0m id                               = "QA-Employee_ASG" [90m-> null[0m[0m
      [31m-[0m[0m name                             = "QA-Employee_ASG" [90m-> null[0m[0m
        [90m# (26 unchanged attributes hidden)[0m[0m

        [90m# (3 unchanged blocks hidden)[0m[0m
    }

[1m  # module.QA_Employee.aws_autoscaling_policy.ASG_Policy[0m has been deleted
[0m  [31m-[0m[0m resource "aws_autoscaling_policy" "ASG_Policy" {
        id                        = "target-tracking-policy"
      [31m-[0m[0m name                      = "target-tracking-policy" [90m-> null[0m[0m
        [90m# (8 unchanged attributes hidden)[0m[0m

        [90m# (1 unchanged block hidden)[0m[0m
    }

[1m  # module.QA_Employee.aws_lb_target_group.Target_group[0m has been deleted
[0m  [31m-[0m[0m resource "aws_lb_target_group" "Target_group" {
      [31m-[0m[0m arn                                = "arn:aws:elasticloadbalancing:ap-southeast-1:441247711986:targetgroup/QA-Employee-TG/ce1d87c41ab53a31" [90m-> null[0m[0m
      [31m-[0m[0m id                                 = "arn:aws:elasticloadbalancing:ap-southeast-1:441247711986:targetgroup/QA-Employee-TG/ce1d87c41ab53a31" [90m-> null[0m[0m
        name                               = "QA-Employee-TG"
        tags                               = {
            "Name" = "QA-Employee-TG"
        }
        [90m# (16 unchanged attributes hidden)[0m[0m

        [90m# (4 unchanged blocks hidden)[0m[0m
    }

[1m  # module.QA_Employee.aws_security_group.security_group[0m has been deleted
[0m  [31m-[0m[0m resource "aws_security_group" "security_group" {
      [31m-[0m[0m id                     = "sg-077db1c6439ddefce" [90m-> null[0m[0m
        name                   = "QA-Employee-sg"
        tags                   = {
            "Enviroment" = "QA_Employee"
            "Name"       = "QA-Employee-sg"
            "Owner"      = "Employee"
        }
        [90m# (8 unchanged attributes hidden)[0m[0m
    }


Unless you have made equivalent changes to your configuration, or ignored the
relevant attributes using ignore_changes, the following plan may include
actions to undo or respond to these changes.
[90m
─────────────────────────────────────────────────────────────────────────────[0m

Terraform used the selected providers to generate the following execution
plan. Resource actions are indicated with the following symbols:
  [32m+[0m create[0m
  [33m~[0m update in-place[0m

Terraform will perform the following actions:

[1m  # module.QA_Employee.aws_autoscaling_group.ASG[0m will be created
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
      [32m+[0m[0m name                             = "QA-Employee_ASG"
      [32m+[0m[0m name_prefix                      = (known after apply)
      [32m+[0m[0m predicted_capacity               = (known after apply)
      [32m+[0m[0m protect_from_scale_in            = false
      [32m+[0m[0m service_linked_role_arn          = (known after apply)
      [32m+[0m[0m target_group_arns                = (known after apply)
      [32m+[0m[0m vpc_zone_identifier              = [
          [32m+[0m[0m "subnet-0abcfc7a31b6687b4",
        ]
      [32m+[0m[0m wait_for_capacity_timeout        = "10m"
      [32m+[0m[0m warm_pool_size                   = (known after apply)

      [32m+[0m[0m launch_template {
          [32m+[0m[0m id      = "lt-090e7facf136ca9b4"
          [32m+[0m[0m name    = (known after apply)
          [32m+[0m[0m version = "$Latest"
        }

      [32m+[0m[0m tag {
          [32m+[0m[0m key                 = "Name"
          [32m+[0m[0m propagate_at_launch = true
          [32m+[0m[0m value               = "QA-Employee_ASG"
        }
    }

[1m  # module.QA_Employee.aws_autoscaling_policy.ASG_Policy[0m will be created
[0m  [32m+[0m[0m resource "aws_autoscaling_policy" "ASG_Policy" {
      [32m+[0m[0m arn                     = (known after apply)
      [32m+[0m[0m autoscaling_group_name  = "QA-Employee_ASG"
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

[1m  # module.QA_Employee.aws_launch_template.Template[0m will be updated in-place
[0m  [33m~[0m[0m resource "aws_launch_template" "Template" {
        id                      = "lt-090e7facf136ca9b4"
      [33m~[0m[0m latest_version          = 1 -> (known after apply)
        name                    = "QA-Employee-template"
        tags                    = {
            "Name" = "QA-Employee-template"
        }
        [90m# (12 unchanged attributes hidden)[0m[0m

      [33m~[0m[0m network_interfaces {
          [33m~[0m[0m security_groups    = [
              [31m-[0m[0m "sg-077db1c6439ddefce",
            ] -> (known after apply)
            [90m# (11 unchanged attributes hidden)[0m[0m
        }
    }

[1m  # module.QA_Employee.aws_lb_listener_rule.path_rule[0m will be created
[0m  [32m+[0m[0m resource "aws_lb_listener_rule" "path_rule" {
      [32m+[0m[0m arn          = (known after apply)
      [32m+[0m[0m id           = (known after apply)
      [32m+[0m[0m listener_arn = "arn:aws:elasticloadbalancing:ap-southeast-1:441247711986:listener/app/emp-qa/35838b69cfc8ee74/995c5bfc07cb4270"
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
                  [32m+[0m[0m "/api/v1/employee/*",
                ]
            }
        }
    }

[1m  # module.QA_Employee.aws_lb_target_group.Target_group[0m will be created
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
      [32m+[0m[0m name                               = "QA-Employee-TG"
      [32m+[0m[0m name_prefix                        = (known after apply)
      [32m+[0m[0m port                               = 8080
      [32m+[0m[0m preserve_client_ip                 = (known after apply)
      [32m+[0m[0m protocol                           = "HTTP"
      [32m+[0m[0m protocol_version                   = (known after apply)
      [32m+[0m[0m proxy_protocol_v2                  = false
      [32m+[0m[0m slow_start                         = 0
      [32m+[0m[0m tags                               = {
          [32m+[0m[0m "Name" = "QA-Employee-TG"
        }
      [32m+[0m[0m tags_all                           = {
          [32m+[0m[0m "Name" = "QA-Employee-TG"
        }
      [32m+[0m[0m target_type                        = "instance"
      [32m+[0m[0m vpc_id                             = "vpc-037273df63a16de65"

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

[1m  # module.QA_Employee.aws_security_group.security_group[0m will be created
[0m  [32m+[0m[0m resource "aws_security_group" "security_group" {
      [32m+[0m[0m arn                    = (known after apply)
      [32m+[0m[0m description            = "Security group for QA-Employee-API"
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
                  [32m+[0m[0m "sg-04b7eb5f6320a1aa6",
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
                  [32m+[0m[0m "sg-04b7eb5f6320a1aa6",
                ]
              [32m+[0m[0m self             = false
              [32m+[0m[0m to_port          = 8080
            },
        ]
      [32m+[0m[0m name                   = "QA-Employee-sg"
      [32m+[0m[0m name_prefix            = (known after apply)
      [32m+[0m[0m owner_id               = (known after apply)
      [32m+[0m[0m revoke_rules_on_delete = false
      [32m+[0m[0m tags                   = {
          [32m+[0m[0m "Enviroment" = "QA_Employee"
          [32m+[0m[0m "Name"       = "QA-Employee-sg"
          [32m+[0m[0m "Owner"      = "Employee"
        }
      [32m+[0m[0m tags_all               = {
          [32m+[0m[0m "Enviroment" = "QA_Employee"
          [32m+[0m[0m "Name"       = "QA-Employee-sg"
          [32m+[0m[0m "Owner"      = "Employee"
        }
      [32m+[0m[0m vpc_id                 = "vpc-037273df63a16de65"
    }

[1mPlan:[0m 5 to add, 1 to change, 0 to destroy.
[0m
Changes to Outputs:
  [33m~[0m[0m Autoscaling_group_id    = [
      [31m-[0m[0m [
          [31m-[0m[0m "QA-Employee_ASG",
        ],
      [32m+[0m[0m [
          [32m+[0m[0m (known after apply),
        ],
    ]
  [33m~[0m[0m Security_Group_ID       = [
      [31m-[0m[0m [
          [31m-[0m[0m "sg-077db1c6439ddefce",
        ],
      [32m+[0m[0m [
          [32m+[0m[0m (known after apply),
        ],
    ]
  [33m~[0m[0m Target_group_id         = [
      [31m-[0m[0m [
          [31m-[0m[0m "arn:aws:elasticloadbalancing:ap-southeast-1:441247711986:targetgroup/QA-Employee-TG/ce1d87c41ab53a31",
        ],
      [32m+[0m[0m [
          [32m+[0m[0m (known after apply),
        ],
    ]
[0m[1mmodule.QA_Employee.aws_lb_target_group.Target_group: Creating...[0m[0m
[0m[1mmodule.QA_Employee.aws_security_group.security_group: Creating...[0m[0m
[0m[1mmodule.QA_Employee.aws_lb_target_group.Target_group: Creation complete after 1s [id=arn:aws:elasticloadbalancing:ap-southeast-1:441247711986:targetgroup/QA-Employee-TG/5c564332c8637b0f][0m
[0m[1mmodule.QA_Employee.aws_lb_listener_rule.path_rule: Creating...[0m[0m
[0m[1mmodule.QA_Employee.aws_lb_listener_rule.path_rule: Creation complete after 0s [id=arn:aws:elasticloadbalancing:ap-southeast-1:441247711986:listener-rule/app/emp-qa/35838b69cfc8ee74/995c5bfc07cb4270/d01a57c2694dc8f6][0m
[0m[1mmodule.QA_Employee.aws_security_group.security_group: Creation complete after 2s [id=sg-01128d9c9072e4aa6][0m
[0m[1mmodule.QA_Employee.aws_launch_template.Template: Modifying... [id=lt-090e7facf136ca9b4][0m[0m
[0m[1mmodule.QA_Employee.aws_launch_template.Template: Modifications complete after 0s [id=lt-090e7facf136ca9b4][0m
[0m[1mmodule.QA_Employee.aws_autoscaling_group.ASG: Creating...[0m[0m
[0m[1mmodule.QA_Employee.aws_autoscaling_group.ASG: Still creating... [10s elapsed][0m[0m
[0m[1mmodule.QA_Employee.aws_autoscaling_group.ASG: Still creating... [20s elapsed][0m[0m
[0m[1mmodule.QA_Employee.aws_autoscaling_group.ASG: Still creating... [30s elapsed][0m[0m
[0m[1mmodule.QA_Employee.aws_autoscaling_group.ASG: Still creating... [40s elapsed][0m[0m
[0m[1mmodule.QA_Employee.aws_autoscaling_group.ASG: Creation complete after 46s [id=QA-Employee_ASG][0m
[0m[1mmodule.QA_Employee.aws_autoscaling_policy.ASG_Policy: Creating...[0m[0m
[0m[1mmodule.QA_Employee.aws_autoscaling_policy.ASG_Policy: Creation complete after 0s [id=target-tracking-policy][0m
[0m[1m[32m
Apply complete! Resources: 5 added, 1 changed, 0 destroyed.
[0m[0m[1m[32m
Outputs:

[0mAutoscaling_group_id = [
  [
    "QA-Employee_ASG",
  ],
]
Autoscaling_policy_name = [
  [
    "target-tracking-policy",
  ],
]
Security_Group_ID = [
  [
    "sg-01128d9c9072e4aa6",
  ],
]
Target_group_id = [
  [
    "arn:aws:elasticloadbalancing:ap-southeast-1:441247711986:targetgroup/QA-Employee-TG/5c564332c8637b0f",
  ],
]
key_pair_name = [
  [
    "QA_Employee_Key",
  ],
]
launch_template_id = [
  [
    "lt-090e7facf136ca9b4",
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
[Pipeline] // node
[Pipeline] End of Pipeline
Finished: SUCCESS
```
</details>

***

# AWS Console Output 

### Security Group
![Screenshot 2024-03-20 at 12 52 27 AM](https://github.com/CodeOps-Hub/Documentation/assets/156056364/be750b27-7871-4139-af6e-fb4976b9e942)

***
### Instance
![Screenshot 2024-03-20 at 12 54 59 AM](https://github.com/CodeOps-Hub/Documentation/assets/156056364/a2bef749-dbbb-4c27-aa12-9037a49d4602)

### Launch Template
![Screenshot 2024-03-20 at 12 56 47 AM](https://github.com/CodeOps-Hub/Documentation/assets/156056364/82904a3e-bb08-4544-8ece-88b0535f39e2)

***

### Target Group
![Screenshot 2024-03-20 at 12 55 32 AM](https://github.com/CodeOps-Hub/Documentation/assets/156056364/e94998a8-838c-4ebe-be42-6cb0fe02f334)

***

### Auto Scaling Group
![Screenshot 2024-03-20 at 12 57 32 AM](https://github.com/CodeOps-Hub/Documentation/assets/156056364/e1a65a5b-3074-4e1f-b1a6-83b347f757cb)

***
### Auto Scaling Group Policies
![Screenshot 2024-03-20 at 12 58 11 AM](https://github.com/CodeOps-Hub/Documentation/assets/156056364/4c977010-bc50-45e2-b477-0c5520a1ce31)

***

# Conclusion
To sum up, our DSL Pipeline provides an effective means of crafting and overseeing domain-specific languages, allowing developers to articulate intricate concepts
in a clear and succinct manner. Embracing DSLs enables companies to expedite development processes, enhance cooperation between domain experts and developers, 
and ultimately deliver superior software solutions.
***

# Contact Information

| **Name** | **Email Address** |
| -------- | ----------------- |
| **Shantanu** | shantanu.chauhan.snaatak@mygurukulam.co |
***

# References

| **Source** | **Description** |
| ---------- | --------------- |
| [**Link**](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GenericDoc/Terraform/terraform.md) | Terraform Generic Doc Link. |
| [**Link**](https://developer.hashicorp.com/terraform/language/modules) | Terraform Module Concept. |
| [**Link**](https://medium.com/appgambit/terraform-with-jenkins-pipeline-439babe4095c)  | Jenkins DSL Pipeline Doc reference link. |
| [**Link**](https://github.com/CodeOps-Hub/Documentation/blob/main/Terraform/Design/Module/Auto-scaling.md) | ASG Module Doc |

