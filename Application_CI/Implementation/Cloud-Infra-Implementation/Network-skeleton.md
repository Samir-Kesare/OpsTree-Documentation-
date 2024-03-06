# Ntework Skeleton Infra Documentation

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

<img width="500" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/de4fd94f-f1de-4486-ba61-5aa58d5de178">

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
        AWS_ACCESS_KEY_ID     = credentials('snaatak-aws-cred')
        AWS_SECRET_ACCESS_KEY = credentials('snaatak-aws-cred')
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
                sh 'cp Dev_Infra/Static_Tf/network/* .'
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
        }
        failure {
            echo 'Terraform operation failed!'
        }
    }
}

```

**This Jenkins pipeline automates the deployment of a Network Skeleton infrastructure using Terraform. It's configured to perform the following actions:**

### Terraform Deployment Pipeline Overview

| Stage                   | Description                                                                                                                                                                      |
|-------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Checkout**            | Fetches the Terraform code from a GitHub repository branch (`main`). |                                                                                    
| **Copy Terraform Files**    | Copies Network-Skeleton-related Terraform configuration files to the Jenkins workspace. |                                                                                                
| **Terraform Init**          | Initializes Terraform in the workspace directory. |                                                                                                                                
| **Terraform Plan**          | Generates a Terraform execution plan to preview the changes. |                                                                                                                     
| **Review and Approve Apply** | Asks for approval before applying Terraform changes if the selected action is "Apply". |                                                                                       
| **Review and Approve Destroy** | Asks for approval before destroying Terraform resources if the selected action is "Destroy". |                                                                            
| **Apply or Destroy**        | Executes Terraform apply or destroy based on the selected action. |                                                                                                               
| **Post**                    | Displays success or failure messages. |                                                                                                                                          
***

# Output

**Blue Ocean Output**

![Screenshot 2024-03-06 221415](https://github.com/CodeOps-Hub/Documentation/assets/156057205/67c0827f-567a-4563-9e0b-7818c359e67c)

***

**Console Output**

![Screenshot 2024-03-06 221341](https://github.com/CodeOps-Hub/Documentation/assets/156057205/e5dbe5af-453e-4524-8a64-4db506107300)

***

**VPC and it's resource map (dev-vpc)**

Deploys a VPC (dev-vpc) and configured it's resources

![Screenshot 2024-03-06 220953](https://github.com/CodeOps-Hub/Documentation/assets/156057205/749d829f-6895-4340-b4a7-aabe712056f3)

***

**Elastic IP Address**

![Screenshot 2024-03-06 221023](https://github.com/CodeOps-Hub/Documentation/assets/156057205/11d49387-f134-4085-9e05-7bbaa854376c)

***

**Frontend Nacl (dev-frontend-nacl-01)**

![Screenshot 2024-03-06 221157](https://github.com/CodeOps-Hub/Documentation/assets/156057205/dd8fe6f2-77a1-48bc-b5cf-754feca1a294)

***

**Backend Nacl (dev-backend-nacl-01)**

![Screenshot 2024-03-06 221231](https://github.com/CodeOps-Hub/Documentation/assets/156057205/8e085006-40f0-408a-be19-0b8829496276)

***

**Database Nacl (dev-db-nacl-01)**

![Screenshot 2024-03-06 221211](https://github.com/CodeOps-Hub/Documentation/assets/156057205/ceec943d-5e5b-4125-9c20-41b0a831e1fe)

***

**Security Group for Network Skeleton Load Balancer(dev-alb-sg)**

 Defines a security group for Network Skeleton Load Balancer with specified ingress and egress rules.
 
![Screenshot 2024-03-06 220803](https://github.com/CodeOps-Hub/Documentation/assets/156057205/b6f86400-f1b7-4f35-8ced-01877dd89173)

***

**Load Balancer for Network Skeleton**

![Screenshot 2024-03-06 220706](https://github.com/CodeOps-Hub/Documentation/assets/156057205/71f5ea2b-83e0-4154-836f-08b21a4122af)

***

# Related Works

| **References** |
| -------------- |
| [Link](https://github.com/CodeOps-Hub/Terraform/blob/main/Dev_Infra/Static_Tf/network/main.tf) |

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
