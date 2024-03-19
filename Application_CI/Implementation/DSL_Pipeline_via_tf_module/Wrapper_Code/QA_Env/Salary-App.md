
# DSL Jenkins pipeline for Salary setup in QA Env Documentation

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

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056746/44f23637-1927-4cb0-b047-e026f9901a4c)


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
                git branch: 'Shikha/Salary-App-QA', credentialsId: 'shikha-PAT', url: 'https://github.com/CodeOps-Hub/Terraform-modules.git'
            }
        }
        
        stage('Copy Terraform Files') {
            steps {
                sh 'cp Wrapper-Code-Salary-QA/* .'
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

**This Jenkins pipeline automates the deployment of a Salary infrastructure using Terraform module and Wrapper code. It's configured to perform the following actions:**

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
Started by user Shikha Tripathi
Lightweight checkout support not available, falling back to full checkout.
Checking out git https://github.com/CodeOps-Hub/Jenkinsfile.git into /var/lib/jenkins/jobs/QA-Salary-App/workspace@script/2c624e68d9ac93966b0a6ecea74a8a9f93dbab47b6fffa7f2ebbef857f80f0b1 to read Wrapper-Code/QA_Env/Salary/Jenkinsfile
Selected Git installation does not exist. Using Default
The recommended git tool is: NONE
using credential shikha-PAT
 > git rev-parse --resolve-git-dir /var/lib/jenkins/jobs/QA-Salary-App/workspace@script/2c624e68d9ac93966b0a6ecea74a8a9f93dbab47b6fffa7f2ebbef857f80f0b1/.git # timeout=10
Fetching changes from the remote Git repository
 > git config remote.origin.url https://github.com/CodeOps-Hub/Jenkinsfile.git # timeout=10
Fetching upstream changes from https://github.com/CodeOps-Hub/Jenkinsfile.git
 > git --version # timeout=10
 > git --version # 'git version 2.34.1'
using GIT_ASKPASS to set credentials shikha-PAT
 > git fetch --tags --force --progress -- https://github.com/CodeOps-Hub/Jenkinsfile.git +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git rev-parse refs/remotes/origin/Shikha/QA-Salary-App^{commit} # timeout=10
 > git rev-parse Shikha/QA-Salary-App^{commit} # timeout=10
Checking out Revision b66e80db6440a8ee2965dfa4eae95a27cb334dce (refs/remotes/origin/Shikha/QA-Salary-App)
 > git config core.sparsecheckout # timeout=10
 > git checkout -f b66e80db6440a8ee2965dfa4eae95a27cb334dce # timeout=10
Commit message: "Update Jenkinsfile"
 > git rev-list --no-walk b66e80db6440a8ee2965dfa4eae95a27cb334dce # timeout=10
[Pipeline] Start of Pipeline
[Pipeline] node
Running on Jenkins in /var/lib/jenkins/jobs/QA-Salary-App/workspace
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Declarative: Checkout SCM)
[Pipeline] checkout
Selected Git installation does not exist. Using Default
The recommended git tool is: NONE
using credential shikha-PAT
 > git rev-parse --resolve-git-dir /var/lib/jenkins/jobs/QA-Salary-App/workspace/.git # timeout=10
Fetching changes from the remote Git repository
 > git config remote.origin.url https://github.com/CodeOps-Hub/Jenkinsfile.git # timeout=10
Fetching upstream changes from https://github.com/CodeOps-Hub/Jenkinsfile.git
 > git --version # timeout=10
 > git --version # 'git version 2.34.1'
using GIT_ASKPASS to set credentials shikha-PAT
 > git fetch --tags --force --progress -- https://github.com/CodeOps-Hub/Jenkinsfile.git +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git rev-parse refs/remotes/origin/Shikha/QA-Salary-App^{commit} # timeout=10
 > git rev-parse Shikha/QA-Salary-App^{commit} # timeout=10
Checking out Revision b66e80db6440a8ee2965dfa4eae95a27cb334dce (refs/remotes/origin/Shikha/QA-Salary-App)
 > git config core.sparsecheckout # timeout=10
 > git checkout -f b66e80db6440a8ee2965dfa4eae95a27cb334dce # timeout=10
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
 > git rev-parse --resolve-git-dir /var/lib/jenkins/jobs/QA-Salary-App/workspace/.git # timeout=10
Fetching changes from the remote Git repository
 > git config remote.origin.url https://github.com/CodeOps-Hub/Terraform-modules.git # timeout=10
Fetching upstream changes from https://github.com/CodeOps-Hub/Terraform-modules.git
 > git --version # timeout=10
 > git --version # 'git version 2.34.1'
using GIT_ASKPASS to set credentials shikha-PAT
 > git fetch --tags --force --progress -- https://github.com/CodeOps-Hub/Terraform-modules.git +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git rev-parse refs/remotes/origin/Shikha/Salary-App-QA^{commit} # timeout=10
Checking out Revision 08be076fd2862c7cd1408a00c3815790d5eaa342 (refs/remotes/origin/Shikha/Salary-App-QA)
 > git config core.sparsecheckout # timeout=10
 > git checkout -f 08be076fd2862c7cd1408a00c3815790d5eaa342 # timeout=10
 > git branch -a -v --no-abbrev # timeout=10
 > git branch -D Shikha/Salary-App-QA # timeout=10
 > git checkout -b Shikha/Salary-App-QA 08be076fd2862c7cd1408a00c3815790d5eaa342 # timeout=10
Commit message: "Update variables.tf"
 > git rev-list --no-walk 8791bfbc05b77569c29c5e431682dcae0e4ec124 # timeout=10
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Copy Terraform Files)
[Pipeline] sh
+ cp Wrapper-Code-Salary-QA/main.tf Wrapper-Code-Salary-QA/output.tf Wrapper-Code-Salary-QA/provider.tf Wrapper-Code-Salary-QA/script.sh Wrapper-Code-Salary-QA/terraform.tfvars Wrapper-Code-Salary-QA/variables.tf .
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Terraform Init)
[Pipeline] sh
+ terraform init

[0m[1mInitializing the backend...[0m
[0m[1mInitializing modules...[0m

[0m[1mInitializing provider plugins...[0m
- Reusing previous version of hashicorp/tls from the dependency lock file
- Reusing previous version of hashicorp/local from the dependency lock file
- Reusing previous version of hashicorp/aws from the dependency lock file
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
[0m[1mmodule.QA_Salary.tls_private_key.private_key: Refreshing state... [id=df771620e398753643df969bb5a8b2651ff8b3dc][0m
[0m[1mmodule.QA_Salary.local_file.private_key: Refreshing state... [id=d57fa1cd3996e82c9ecd490a5f6a2e6be7091a30][0m
[0m[1mmodule.QA_Salary.aws_key_pair.key_pair: Refreshing state... [id=QA_Salary_Key][0m
[0m[1mmodule.QA_Salary.aws_lb_target_group.Target_group: Refreshing state... [id=arn:aws:elasticloadbalancing:us-east-2:975050171850:targetgroup/QA-Salary-TG/1eccfb90d39b23d6][0m
[0m[1mmodule.QA_Salary.aws_security_group.security_group: Refreshing state... [id=sg-03c1ca5efbd3e1be1][0m
[0m[1mmodule.QA_Salary.aws_launch_template.Template: Refreshing state... [id=lt-03196e28466cc4d08][0m
[0m[1mmodule.QA_Salary.aws_autoscaling_group.ASG: Refreshing state... [id=QA-Salary-ASG][0m
[0m[1mmodule.QA_Salary.aws_autoscaling_policy.ASG_Policy: Refreshing state... [id=target-tracking-policy][0m

Terraform used the selected providers to generate the following execution
plan. Resource actions are indicated with the following symbols:
  [32m+[0m create[0m

Terraform will perform the following actions:

[1m  # module.QA_Salary.aws_lb_listener_rule.path_rule[0m will be created
[0m  [32m+[0m[0m resource "aws_lb_listener_rule" "path_rule" {
      [32m+[0m[0m arn          = (known after apply)
      [32m+[0m[0m id           = (known after apply)
      [32m+[0m[0m listener_arn = "arn:aws:elasticloadbalancing:us-east-2:975050171850:listener/app/QA-Salary-App/ac92eec3b47f02a1/736f0aca6a4d11a9"
      [32m+[0m[0m priority     = 100
      [32m+[0m[0m tags_all     = (known after apply)

      [32m+[0m[0m action {
          [32m+[0m[0m order            = (known after apply)
          [32m+[0m[0m target_group_arn = "arn:aws:elasticloadbalancing:us-east-2:975050171850:targetgroup/QA-Salary-TG/1eccfb90d39b23d6"
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

[1mPlan:[0m 1 to add, 0 to change, 0 to destroy.
[0m[90m
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
[0m[1mmodule.QA_Salary.tls_private_key.private_key: Refreshing state... [id=df771620e398753643df969bb5a8b2651ff8b3dc][0m
[0m[1mmodule.QA_Salary.local_file.private_key: Refreshing state... [id=d57fa1cd3996e82c9ecd490a5f6a2e6be7091a30][0m
[0m[1mmodule.QA_Salary.aws_lb_target_group.Target_group: Refreshing state... [id=arn:aws:elasticloadbalancing:us-east-2:975050171850:targetgroup/QA-Salary-TG/1eccfb90d39b23d6][0m
[0m[1mmodule.QA_Salary.aws_key_pair.key_pair: Refreshing state... [id=QA_Salary_Key][0m
[0m[1mmodule.QA_Salary.aws_security_group.security_group: Refreshing state... [id=sg-03c1ca5efbd3e1be1][0m
[0m[1mmodule.QA_Salary.aws_launch_template.Template: Refreshing state... [id=lt-03196e28466cc4d08][0m
[0m[1mmodule.QA_Salary.aws_autoscaling_group.ASG: Refreshing state... [id=QA-Salary-ASG][0m
[0m[1mmodule.QA_Salary.aws_autoscaling_policy.ASG_Policy: Refreshing state... [id=target-tracking-policy][0m

Terraform used the selected providers to generate the following execution
plan. Resource actions are indicated with the following symbols:
  [32m+[0m create[0m

Terraform will perform the following actions:

[1m  # module.QA_Salary.aws_lb_listener_rule.path_rule[0m will be created
[0m  [32m+[0m[0m resource "aws_lb_listener_rule" "path_rule" {
      [32m+[0m[0m arn          = (known after apply)
      [32m+[0m[0m id           = (known after apply)
      [32m+[0m[0m listener_arn = "arn:aws:elasticloadbalancing:us-east-2:975050171850:listener/app/QA-Salary-App/ac92eec3b47f02a1/736f0aca6a4d11a9"
      [32m+[0m[0m priority     = 100
      [32m+[0m[0m tags_all     = (known after apply)

      [32m+[0m[0m action {
          [32m+[0m[0m order            = (known after apply)
          [32m+[0m[0m target_group_arn = "arn:aws:elasticloadbalancing:us-east-2:975050171850:targetgroup/QA-Salary-TG/1eccfb90d39b23d6"
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

[1mPlan:[0m 1 to add, 0 to change, 0 to destroy.
[0m[0m[1mmodule.QA_Salary.aws_lb_listener_rule.path_rule: Creating...[0m[0m
[0m[1mmodule.QA_Salary.aws_lb_listener_rule.path_rule: Creation complete after 0s [id=arn:aws:elasticloadbalancing:us-east-2:975050171850:listener-rule/app/QA-Salary-App/ac92eec3b47f02a1/736f0aca6a4d11a9/41b9dd811c4772f7][0m
[0m[1m[32m
Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
[0m[0m[1m[32m
Outputs:

[0mAutoscaling_group_id = [
  [
    "QA-Salary-ASG",
  ],
]
Autoscaling_policy_name = [
  [
    "target-tracking-policy",
  ],
]
Security_Group_ID = [
  [
    "sg-03c1ca5efbd3e1be1",
  ],
]
Target_group_id = [
  [
    "arn:aws:elasticloadbalancing:us-east-2:975050171850:targetgroup/QA-Salary-TG/1eccfb90d39b23d6",
  ],
]
key_pair_name = [
  [
    "QA_Salary_Key",
  ],
]
launch_template_id = [
  [
    "lt-03196e28466cc4d08",
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
| **Shikha Tripathi** |shikha.tripathi.snaatak@mygurukulam.co|

***

# References

| **Source** | **Description** |
| ---------- | --------------- |
| [**Link**](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GenericDoc/Terraform/terraform.md) | Terraform Generic Doc Link. |
| [**Link**](https://developer.hashicorp.com/terraform/language/modules) | Terraform Module Concept. |
| [**Link**](https://github.com/CodeOps-Hub/Jenkinsfile/blob/Shikha/QA-Salary-App/Wrapper-Code/QA_Env/Salary/Jenkinsfile)  | Jenkins DSL Pipeline Doc reference link. |
| [**Link**](https://github.com/CodeOps-Hub/Documentation/blob/main/Terraform/Design/Module/Auto-scaling.md) | ASG Module Doc |
| [**Link**](https://github.com/CodeOps-Hub/Terraform-modules/tree/Shikha/Salary-App-QA/Wrapper-Code-Salary-QA) | QA Salary Wrapper-Code |
