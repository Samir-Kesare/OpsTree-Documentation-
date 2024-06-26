# DSL Jenkins pipeline for Attendance API setup (QA)

<img width="360" length="100" alt="Terraform" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/556e50dc-0c8b-4262-be16-2c384d2cfa8a">

***

| **Author** | **Created On** | **Last Updated** | **Document version** |
| ---------- | -------------- | ---------------- | -------------------- |
| **Vidhi Yadav** | **19 March 2024** | **19 March 2024** | **v1** |

***

## Table of contents

* [Introduction](#Introduction)
* [DSL Pipeline](#DSL-Pipeline)
* [Key Benefits](#Key-Benefits-of-DSL-Pipeline)
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

This document helps to set up and maintain your resource for Attendance API using Terraform and Jenkins. With this pipeline, you can quickly deploy and manage your infrastructure without manual intervention, making your development and testing process smoother. It will walk you through each step, from setting up your AWS credentials to configuring Terraform and integrating it with Jenkins.

***

## DSL Pipeline

A Domain-Specific Language (DSL) is a programming language or specification language dedicated to a particular problem domain, a particular problem representation technique, and/or a particular solution technique.DSL Pipeline is a robust framework designed to facilitate the creation, deployment, and management of domain-specific languages within your software development projects. By employing DSLs, developers can express solutions in a concise, domain-specific syntax tailored to the problem at hand, thereby enhancing productivity and reducing the gap between domain experts and software implementation.

There are two main types of DSLs: external DSLs and internal DSLs. External DSLs have their own syntax and are typically parsed by a separate compiler or interpreter. Internal DSLs, on the other hand, are embedded within a host programming language, leveraging its syntax and features to create a domain-specific syntax.

***

## Key Benefits of DSL Pipeline

| Key Features  | Description                                                                                                              |
|---------------|--------------------------------------------------------------------------------------------------------------------------|
| **Modularity**    | The DSL Pipeline offers a modular architecture, allowing developers to define and integrate custom DSL components seamlessly. |
| **Extensibility** | Extend the capabilities of the DSL Pipeline by incorporating new DSL constructs, transformations, and integrations with existing tools and libraries. |
| **Automation**    | Automate repetitive tasks in the development lifecycle through pipeline automation, including parsing, validation, transformation, and code generation. |
| **Flexibility**   | Accommodate diverse DSL requirements with flexible configuration options, support for various syntax styles, and compatibility with multiple target platforms. |

***

## Flow Diagram


<img width="893" alt="Screenshot 2024-03-19 at 11 52 28 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/22d71e7f-4b15-4219-a34f-ff84d11501cd">


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
        AWS_ACCESS_KEY_ID     = credentials('vidhi-aws-creds')
        AWS_SECRET_ACCESS_KEY = credentials('vidhi-aws-creds')
        TF_CLI_ARGS           = '-input=false'
    }
    
    parameters {
        choice(name: 'ACTION', choices: ['Apply', 'Destroy'], description: 'Choose to apply or destroy the infrastructure')
    }
    
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', credentialsId: 'new-token', url: 'https://github.com/CodeOps-Hub/Terraform-modules.git'
            }
        }
        
        stage('Copy Terraform Files') {
            steps {
                // Copy or move specific files from the repository to Jenkins workspace
                sh 'cp wrapperCode/Attendance-API/QA/* .'

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
                // Prompt for approval before destroying
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

**This Jenkins pipeline automates the deployment of a Attendance infrastructure using Terraform module and Wrapper code. It's configured to perform the following actions:**

### Terraform Deployment Pipeline Overview

| Stage                   | Description                                                                                                                                                                      |
|-------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Checkout**            | Fetches the Terraform code from a GitHub repository branch (`main`). |                                                                                    
| **Copy Terraform Files**    | Copies Attendance-related Terraform configuration files to the Jenkins workspace. |                                                                                                
| **Terraform Init**          | Initializes Terraform in the workspace directory. |                                                                                                                                
| **Terraform Plan**          | Generates a Terraform execution plan to preview the changes. |                                                                                                                     
| **Review and Approve Apply** | Asks for approval before applying Terraform changes if the selected action is "Apply". |                                                                                       
| **Review and Approve Destroy** | Asks for approval before destroying Terraform resources if the selected action is "Destroy". |                                                                            
| **Apply or Destroy**        | Executes Terraform apply or destroy based on the selected action. |                                                                                                               
| **Post**                    | Displays success or failure messages. |                                                                                                                                          
***

## Jenkins Output

### Pipeline view
<img width="893" alt="Screenshot 2024-03-19 at 11 52 28 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/f3a83802-3d78-4def-9431-ac02ed86293a">


***

### Archive Artifact (SSH key pair)

<img width="461" alt="Screenshot 2024-03-20 at 12 06 34 AM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/021c4ca7-eee5-4302-8e1a-7e98f6d0c9bc">

***

### Console Output

<details>
<summary><strong>Click here to see Console output</strong></summary>
<br>

```shell
Started by user Vidhi Yadav
Obtained Wrapper-Code/QA_Env/Attendance/Jenkinsfile from git https://github.com/CodeOps-Hub/Jenkinsfile.git
[Pipeline] Start of Pipeline
[Pipeline] node
Running on Jenkins in /var/lib/jenkins/workspace/attendance_QA
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Declarative: Checkout SCM)
[Pipeline] checkout
Selected Git installation does not exist. Using Default
The recommended git tool is: NONE
using credential b9bd5b24-302c-4883-a2d1-c56372020b2e
 > git rev-parse --resolve-git-dir /var/lib/jenkins/workspace/attendance_QA/.git # timeout=10
Fetching changes from the remote Git repository
 > git config remote.origin.url https://github.com/CodeOps-Hub/Jenkinsfile.git # timeout=10
Fetching upstream changes from https://github.com/CodeOps-Hub/Jenkinsfile.git
 > git --version # timeout=10
 > git --version # 'git version 2.34.1'
using GIT_ASKPASS to set credentials 
 > git fetch --tags --force --progress -- https://github.com/CodeOps-Hub/Jenkinsfile.git +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git rev-parse refs/remotes/origin/Vidhi/Attendance-QA-jenkinsfile^{commit} # timeout=10
Checking out Revision fbb460000cd74e334d7c7ad9488571606c671340 (refs/remotes/origin/Vidhi/Attendance-QA-jenkinsfile)
 > git config core.sparsecheckout # timeout=10
 > git checkout -f fbb460000cd74e334d7c7ad9488571606c671340 # timeout=10
Commit message: "Update Jenkinsfile"
 > git rev-list --no-walk fbb460000cd74e334d7c7ad9488571606c671340 # timeout=10
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
 > git rev-parse --resolve-git-dir /var/lib/jenkins/workspace/attendance_QA/.git # timeout=10
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
+ cp wrapperCode/Attendance-API/QA/main.tf wrapperCode/Attendance-API/QA/output.tf wrapperCode/Attendance-API/QA/provider.tf wrapperCode/Attendance-API/QA/script.sh wrapperCode/Attendance-API/QA/terraform.tfvars wrapperCode/Attendance-API/QA/variable.tf .
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
[0m[1mmodule.QA_Attendance.tls_private_key.private_key: Refreshing state... [id=6324091d89704978a0a09c04a5e3aa8cfb13d021][0m
[0m[1mmodule.QA_Attendance.local_file.private_key: Refreshing state... [id=885e76b6d62c347fca087b802b0d4fd01db03d45][0m
[0m[1mmodule.QA_Attendance.aws_lb_target_group.Target_group: Refreshing state... [id=arn:aws:elasticloadbalancing:us-east-1:905418193488:targetgroup/QA-Attendance-TG/af00500b27d487cd][0m
[0m[1mmodule.QA_Attendance.aws_key_pair.key_pair: Refreshing state... [id=QA_Attendance_Key][0m
[0m[1mmodule.QA_Attendance.aws_security_group.security_group: Refreshing state... [id=sg-0064bc6643e84bf03][0m
[0m[1mmodule.QA_Attendance.aws_launch_template.Template: Refreshing state... [id=lt-0abea8bd681ee297d][0m
[0m[1mmodule.QA_Attendance.aws_autoscaling_group.ASG: Refreshing state... [id=QA-Attendance_ASG][0m
[0m[1mmodule.QA_Attendance.aws_autoscaling_policy.ASG_Policy: Refreshing state... [id=target-tracking-policy][0m

Terraform used the selected providers to generate the following execution
plan. Resource actions are indicated with the following symbols:
  [32m+[0m create[0m

Terraform will perform the following actions:

[1m  # module.QA_Attendance.aws_lb_listener_rule.path_rule[0m will be created
[0m  [32m+[0m[0m resource "aws_lb_listener_rule" "path_rule" {
      [32m+[0m[0m arn          = (known after apply)
      [32m+[0m[0m id           = (known after apply)
      [32m+[0m[0m listener_arn = "arn:aws:elasticloadbalancing:us-east-1:905418193488:listener/app/alb-heh/127dfdd55a957475/99ac24ae778e4e38"
      [32m+[0m[0m priority     = 90
      [32m+[0m[0m tags_all     = (known after apply)

      [32m+[0m[0m action {
          [32m+[0m[0m order            = (known after apply)
          [32m+[0m[0m target_group_arn = "arn:aws:elasticloadbalancing:us-east-1:905418193488:targetgroup/QA-Attendance-TG/af00500b27d487cd"
          [32m+[0m[0m type             = "forward"
        }

      [32m+[0m[0m condition {
          [32m+[0m[0m path_pattern {
              [32m+[0m[0m values = [
                  [32m+[0m[0m "/api/v1/attendance/*",
                ]
            }
        }
    }

[1mPlan:[0m 1 to add, 0 to change, 0 to destroy.
[0m[90m
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
Approved by Vidhi Yadav
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
[0m[1mmodule.QA_Attendance.tls_private_key.private_key: Refreshing state... [id=6324091d89704978a0a09c04a5e3aa8cfb13d021][0m
[0m[1mmodule.QA_Attendance.local_file.private_key: Refreshing state... [id=885e76b6d62c347fca087b802b0d4fd01db03d45][0m
[0m[1mmodule.QA_Attendance.aws_key_pair.key_pair: Refreshing state... [id=QA_Attendance_Key][0m
[0m[1mmodule.QA_Attendance.aws_lb_target_group.Target_group: Refreshing state... [id=arn:aws:elasticloadbalancing:us-east-1:905418193488:targetgroup/QA-Attendance-TG/af00500b27d487cd][0m
[0m[1mmodule.QA_Attendance.aws_security_group.security_group: Refreshing state... [id=sg-0064bc6643e84bf03][0m
[0m[1mmodule.QA_Attendance.aws_launch_template.Template: Refreshing state... [id=lt-0abea8bd681ee297d][0m
[0m[1mmodule.QA_Attendance.aws_autoscaling_group.ASG: Refreshing state... [id=QA-Attendance_ASG][0m
[0m[1mmodule.QA_Attendance.aws_autoscaling_policy.ASG_Policy: Refreshing state... [id=target-tracking-policy][0m

Terraform used the selected providers to generate the following execution
plan. Resource actions are indicated with the following symbols:
  [32m+[0m create[0m

Terraform will perform the following actions:

[1m  # module.QA_Attendance.aws_lb_listener_rule.path_rule[0m will be created
[0m  [32m+[0m[0m resource "aws_lb_listener_rule" "path_rule" {
      [32m+[0m[0m arn          = (known after apply)
      [32m+[0m[0m id           = (known after apply)
      [32m+[0m[0m listener_arn = "arn:aws:elasticloadbalancing:us-east-1:905418193488:listener/app/alb-heh/127dfdd55a957475/99ac24ae778e4e38"
      [32m+[0m[0m priority     = 90
      [32m+[0m[0m tags_all     = (known after apply)

      [32m+[0m[0m action {
          [32m+[0m[0m order            = (known after apply)
          [32m+[0m[0m target_group_arn = "arn:aws:elasticloadbalancing:us-east-1:905418193488:targetgroup/QA-Attendance-TG/af00500b27d487cd"
          [32m+[0m[0m type             = "forward"
        }

      [32m+[0m[0m condition {
          [32m+[0m[0m path_pattern {
              [32m+[0m[0m values = [
                  [32m+[0m[0m "/api/v1/attendance/*",
                ]
            }
        }
    }

[1mPlan:[0m 1 to add, 0 to change, 0 to destroy.
[0m[0m[1mmodule.QA_Attendance.aws_lb_listener_rule.path_rule: Creating...[0m[0m
[0m[1mmodule.QA_Attendance.aws_lb_listener_rule.path_rule: Creation complete after 0s [id=arn:aws:elasticloadbalancing:us-east-1:905418193488:listener-rule/app/alb-heh/127dfdd55a957475/99ac24ae778e4e38/1e67854d98617045][0m
[0m[1m[32m
Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
[0m[0m[1m[32m
Outputs:

[0mAutoscaling_group_id = [
  [
    "QA-Attendance_ASG",
  ],
]
Autoscaling_policy_name = [
  [
    "target-tracking-policy",
  ],
]
Security_Group_ID = [
  [
    "sg-0064bc6643e84bf03",
  ],
]
Target_group_id = [
  [
    "arn:aws:elasticloadbalancing:us-east-1:905418193488:targetgroup/QA-Attendance-TG/af00500b27d487cd",
  ],
]
key_pair_name = [
  [
    "QA_Attendance_Key",
  ],
]
launch_template_id = [
  [
    "lt-0abea8bd681ee297d",
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

<img width="1085" alt="Screenshot 2024-03-20 at 12 09 17 AM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/ab1b187b-aa11-459b-a550-9fd576500da0">

***
### Launch Template

<img width="1115" alt="Screenshot 2024-03-20 at 12 07 16 AM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/7619d4ca-3f2a-4ac3-a715-ea4737199ef0">

***

### Target Group

<img width="1073" alt="Screenshot 2024-03-20 at 12 07 43 AM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/3b49fe43-1e88-47dd-aad7-3693c08bc150">

***
### Listener rule of ALB
<img width="1055" alt="Screenshot 2024-03-20 at 12 08 01 AM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/a1786215-bded-48e8-b4e4-5b449470af1c">


***
### Auto Scaling Group
<img width="1054" alt="Screenshot 2024-03-20 at 12 08 22 AM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/197b31b8-5567-4fb7-a60d-95d6203ac095">


***
### Auto Scaling Group Policies

<img width="638" alt="Screenshot 2024-03-20 at 12 08 40 AM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/a19cedbf-a782-4edc-b2e6-3b8326677797">

***

# Conclusion

In conclusion, our DSL Pipeline offers a powerful solution for creating and managing domain-specific languages, enabling developers to express complex ideas in a concise and understandable manner. By embracing DSLs, organizations can accelerate development cycles, improve collaboration between domain experts and developers, and ultimately deliver higher-quality software solutions. 

***

# Contact Information

| **Name** | **Email Address** |
| -------- | ----------------- |
| **Vidhi Yadav** | vidhi.yadhav.snaatak@mygurukulam.co |

***

# References

| **Source** | **Description** |
| ---------- | --------------- |
| [**Link**](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GenericDoc/Terraform/terraform.md) | Terraform Generic Doc Link. |
| [**Link**](https://www.youtube.com/watch?v=iiF2iQV-3eM&t=776s)  | Credentials in AWS |
| [**Link**](https://github.com/CodeOps-Hub/Terraform-modules/tree/main/wrapperCode/Attendance-API) | QA Attendance Wrapper-Code |

