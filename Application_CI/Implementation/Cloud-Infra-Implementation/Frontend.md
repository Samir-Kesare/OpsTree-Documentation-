# Frontend API Infra Documentation

|<img width="360" length="100" alt="Terraform" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/556e50dc-0c8b-4262-be16-2c384d2cfa8a">

***

| **Author** | **Created on** | **Last Updated** | **Document Version** |
| ---------- | -------------- | ---------------- | -------------------- |
| **Shreya Jaiswal** | **06 March 2024** | **06 March 2024** | **v1** |

***

# Table of contents
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

# Introduction

With the increasing complexity of modern networks and the need for agility in infrastructure management, Terraform has emerged as a powerful tool for automating the provisioning and configuration of network resources.This module is designed to provide a foundational framework for managing network infrastructure as code using Terraform. By leveraging this module, users can quickly establish a standardized and scalable network architecture within their cloud environment.As networks get more complicated and managing infrastructure becomes more important, specialized languages called Domain-Specific Languages (DSLs) have become really useful. They help simplify and automate different tasks.

***

# What is DSL Pipeline?

A Domain-Specific Language (DSL) is a programming language or specification language dedicated to a particular problem domain, a particular problem representation technique, and/or a particular solution technique.DSL Pipeline is a robust framework designed to facilitate the creation, deployment, and management of domain-specific languages within your software development projects. By employing DSLs, developers can express solutions in a concise, domain-specific syntax tailored to the problem at hand, thereby enhancing productivity and reducing the gap between domain experts and software implementation.

There are two main types of DSLs: external DSLs and internal DSLs. External DSLs have their own syntax and are typically parsed by a separate compiler or interpreter. Internal DSLs, on the other hand, are embedded within a host programming language, leveraging its syntax and features to create a domain-specific syntax.

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

<img width="500" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/89a37268-8284-4cf3-ae14-4663f388fae3">

***

# Pre-requisites

| **Pre-requisites** | **Description** |
| ------------------ | ---------------- |
| **AWS Account**    | Access to the AWS Management Console with credentials configured. |
| **Jenkins**        | To integrate infra through DSL Pipeline. |
| **Terraform**      | Terraform HCL (v1.7.4) | ****

***

# Jenkinsfile

```shell
pipeline {
    agent any
    
    environment {
        AWS_ACCESS_KEY_ID     = credentials('Frontend Creds')
        AWS_SECRET_ACCESS_KEY = credentials('Frontend Creds')
        TF_CLI_ARGS           = '-input=false'
    }
    
    parameters {
        choice(name: 'ACTION', choices: ['Apply', 'Destroy'], description: 'Choose to apply or destroy the infrastructure')
    }
    
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', credentialsId: 'GitHub Credentials for DSL PIpleline', url: 'https://github.com/CodeOps-Hub/Terraform.git'
            }
        }
        
        stage('Copy Terraform Files') {
            steps {
                // Copy or move specific files from the repository to Jenkins workspace
                sh 'cp Dev_Infra/Static_Tf/Frontend/* .'
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
            cleanWs()
        }
    }
}

```

**This Jenkins pipeline automates the deployment of a Frontend infrastructure using Terraform. It's configured to perform the following actions:**

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

# Output

**Blue Ocean Output**

<img width="946" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/8cb7e03f-d57f-4fc1-ae41-f3d73d52a3d6">

***

**Console Output**

<img width="728" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/a5eaffee-e414-42c8-b6d5-22bf67c6179f">

***

**AMI Output (Dev-Frontend-AMI)**

It uses the aws_ami_from_instance resource to create an AMI from an existing EC2 instance (source_instance_id variable specifies the instance ID).

![Screenshot 2024-03-06 130025](https://github.com/CodeOps-Hub/Documentation/assets/156057205/8c71d8df-191c-4f8f-b6f3-4cd0b8c74adb)

***

**Security Group for Frontend(Dev-Frontend-sg)**
 
Defines a security group with inbound and outbound rules for controlling traffic to and from instances. It dynamically creates rules based on the provided inbound_ports and outbound_ports variables.
  
![Screenshot 2024-03-06 130526](https://github.com/CodeOps-Hub/Documentation/assets/156057205/0335446e-d0c0-4c50-b9ce-2f609f9bde53)

***

**SSH Key Pair for Frontend(Dev_Key)**

It generates an SSH key pair using the tls_private_key and aws_key_pair resources.

![Screenshot 2024-03-06 130558](https://github.com/CodeOps-Hub/Documentation/assets/156057205/3913273c-85ce-4b4b-91fe-f87042270027)

***

**Launch Template for Frontend (Dev-Frontend-template)**

Creates a launch template for EC2 instances with configurations such as AMI, instance type, key pair, security group, and user data script.

![Screenshot 2024-03-06 130619](https://github.com/CodeOps-Hub/Documentation/assets/156057205/30f74226-f39f-4acb-91eb-9dc17f411e88)

***

**Load Balancer for Frontend (Dev-ALB)**

Configures an Application Load Balancer (ALB) with a listener and default action forwarding requests to the target group.

![Screenshot 2024-03-06 130413](https://github.com/CodeOps-Hub/Documentation/assets/156057205/43118be8-80e3-4c22-9096-72e30172e102)

***

**Listner Rules for Frontend**

![Screenshot 2024-03-06 130428](https://github.com/CodeOps-Hub/Documentation/assets/156057205/5a9296fb-9ad4-4667-b85a-bfa5ae692aa5)

***

**Auto Scaling Group for Frontend (Dev-Frontend-ASG)**

Sets up an auto-scaling group with configurations such as launch template, minimum size, maximum size, desired capacity, VPC zone identifier, and target group ARN.

![Screenshot 2024-03-06 130209](https://github.com/CodeOps-Hub/Documentation/assets/156057205/25916c23-07e6-4826-be38-bcc0c606c5f0)

***

**Auto Scaling Policy**

Defines an auto-scaling policy for the auto-scaling group. It uses target tracking scaling with predefined metric specifications.

![Screenshot 2024-03-06 130334](https://github.com/CodeOps-Hub/Documentation/assets/156057205/5ea8554e-44f4-4bd5-a31c-019a97d9a9de)

***

**Target Group for Frontend(Dev-Frontend-TG)**

Defines a target group for routing requests to registered instances. It includes health check configurations.

![Screenshot 2024-03-06 130054](https://github.com/CodeOps-Hub/Documentation/assets/156057205/fc3516be-e14e-4b6b-9677-2727a8aac764)

***

**Archive Artifact (SSH key pair)**

<img width="950" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/57297b13-07f8-4707-9c91-e41f6e93d2d1">

***

# Related Works

| **References** |
| -------------- |
| [Link](https://github.com/CodeOps-Hub/Terraform/blob/feature/vishal/frontend-ASG-Policy/Dev_Infra/Static_Tf/Frontend/main.tf) |

***

# Conclusion

In conclusion, our DSL Pipeline offers a powerful solution for creating and managing domain-specific languages, enabling developers to express complex ideas in a concise and understandable manner. By embracing DSLs, organizations can accelerate development cycles, improve collaboration between domain experts and developers, and ultimately deliver higher-quality software solutions. 

***

# Contact Information

| **Name** | **Email Address** |
| -------- | ----------------- |
| **Shreya Jaiswal** | shreya.jaiswal.snaatak@mygurukulam.co |

***

# References

| **Source** | **Description** |
| ---------- | --------------- |
| [Link](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GenericDoc/Terraform/terraform.md) | Terraform Generic Doc Link. |
| [Link](https://developer.hashicorp.com/terraform/language/modules) | Terraform Module Concept. |
| [Link](https://www.linkedin.com/pulse/how-run-terraform-script-jenkins-step-by-step-guide-praveen-dandu) | Reference Link For DSL Pipeline. |
| [Link](https://medium.com/appgambit/terraform-with-jenkins-pipeline-439babe4095c)  | Jenkins DSL Pipeline Doc reference link. |
