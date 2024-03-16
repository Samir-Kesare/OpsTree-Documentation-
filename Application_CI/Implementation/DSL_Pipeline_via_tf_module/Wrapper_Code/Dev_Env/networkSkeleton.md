# DSL Jenkins Pipeline for Network Skeleton in Dev Env

<img width="360" length="100" alt="Terraform" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/556e50dc-0c8b-4262-be16-2c384d2cfa8a">
***

|   Author        |  Created on   |  Version   | Last updated by  | Last edited on |
| --------------- | --------------| -----------|----------------- | -------------- |
| **[Harshit Singh](https://github.com/Panu-S-Harshit-Ninja-07)**    | 15 March 2024 |  Version 1 | Harshit Singh     | 17 March 2024  |
***
## Table of contents

* [Introduction](#Introduction)
* [What is DSL Pipeline](#What-is-DSL-Pipeline)
* [Why DSL Pipeline](#Why-DSP-Pipeline)
* [Flow Diagram](#Flow-Diagram)
* [Pre-requisites](#Pre-requisites)
* [Jenkinsfile](#Jenkinsfile)
* [Jenkins Output](#Jenkins-Output)
* [AWS UI Output](#AWS-UI-Output)
* [Conclusion](#Conclusion)
* [Contact Information](#Contact-Information)
* [References](#References)

***

## Introduction

With the increasing complexity of modern networks and the need for agility in infrastructure management, Terraform has emerged as a powerful tool for automating the provisioning and configuration of network resources.This module is designed to provide a foundational framework for managing network infrastructure as code using Terraform. By leveraging this module, users can quickly establish a standardized and scalable network architecture within their cloud environment.As networks get more complicated and managing infrastructure becomes more important, specialized languages called Domain-Specific Languages (DSLs) have become really useful. They help simplify and automate different tasks.

***

## What is DSL Pipeline?

A Domain-Specific Language (DSL) is a programming language or specification language dedicated to a particular problem domain, a particular problem representation technique, and/or a particular solution technique.DSL Pipeline is a robust framework designed to facilitate the creation, deployment, and management of domain-specific languages within your software development projects. By employing DSLs, developers can express solutions in a concise, domain-specific syntax tailored to the problem at hand, thereby enhancing productivity and reducing the gap between domain experts and software implementation.
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
![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/eba3a9a6-999c-4e25-8c5b-294d676a18c0)

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
    parameters {
        choice choices: ['apply', 'destroy'], name: 'ACTION', description: 'Choose terraform ACTION to perform'
    }

    stages {
        stage('git checkout') {
              steps {
                checkout scmGit(branches: [[name: 'main']], extensions: [], userRemoteConfigs: [[credentialsId: 'Harshit-Github-PAT', url: 'https://github.com/CodeOps-Hub/Terraform-modules.git']])
              }
        }
        stage('Terraform init') {
            steps {
                script{
                    sh '''
                        cd wrapperCode/Network-Skeleton-Wrapper-Code/Dev-Network-Skeleton-Wrapper-Code/
                        terraform init
                    '''                    
                }
                
            }
        }
        stage('Terraform plan') {
            steps {
                withAWS(credentials: 'HARSHIT_AWS_CREDS') {
                    script{
                        sh '''
                            cd wrapperCode/Network-Skeleton-Wrapper-Code/Dev-Network-Skeleton-Wrapper-Code/
                            terraform plan
                        '''                    
                    }
                }
            }
        }
        stage('Apply Approval') {
            when {
                expression { params.ACTION == 'apply' }
            }
            steps {
                input 'Do you want to apply Terraform plan?'
            }
        }
        stage('Destroy Approval') {
            when {
                expression { params.ACTION == 'destroy' }
            }
            steps {
                input 'Do you want to perform Terraform destroy?'
            }
        }
        stage('Terraform apply or destroy') {
            steps {
                withAWS(credentials: 'HARSHIT_AWS_CREDS') {
                    script{
                        if (params.ACTION == 'apply') {
                            sh '''
                                cd wrapperCode/Network-Skeleton-Wrapper-Code/Dev-Network-Skeleton-Wrapper-Code/
                                terraform apply --auto-approve
                                '''
                        } 
                        else if (params.ACTION == 'destroy') {
                        sh '''
                            cd wrapperCode/Network-Skeleton-Wrapper-Code/Dev-Network-Skeleton-Wrapper-Code/
                            terraform destroy --auto-approve
                            '''
                        }
                    }
                }
            }
        }

    }
}
```
</details>

This Jenkins pipeline automates the deployment of a Frontend infrastructure using Terraform module and Wrapper code. It's configured to perform the following actions:

### Terraform Deployment Pipeline Overview

| Stage                   | Description                                                                                                                                                                      |
|-------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **git Checkout**            | Fetches the Terraform code from a GitHub repository branch (`main`). |
| **Terraform Init**          | Initializes Terraform in the workspace directory. |
| **Terraform Plan**          | Generates a Terraform execution plan to preview the changes. |
| **Apply Approval** | Asks for approval before applying Terraform changes if the selected action is "Apply". |
| **Destroy Approval** | Asks for approval before destroying Terraform resources if the selected action is "Destroy". |
| **Apply or Destroy**        | Executes Terraform apply or destroy based on the selected action. |
***

## Jenkins Output

### Pipeline view
![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/115c647e-0d41-4e6e-bbf0-72b98e2f885b)

### Console Output
![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/ac3377af-1728-4ce2-8344-f1fa92eb2478)

***

## AWS UI Output 

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/ba776a8e-a6de-4d0a-b00a-535d08b006ea)

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/1fc6665a-95bd-4f6f-9b27-3d300d2b2749)

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/a895e9c2-e733-4966-80fa-f0c137dbbf7d)

***

# Conclusion
In conclusion, our DSL Pipeline offers a powerful solution for creating and managing domain-specific languages, enabling developers to express complex ideas in a concise and understandable manner. By embracing DSLs, organizations can accelerate development cycles, improve collaboration between domain experts and developers, and ultimately deliver higher-quality software solutions. 

***

# Contact Information

| **Name** | **Email Address** |
| -------- | ----------------- |
| **Harshit Singh** | harshit.singh.snaatak@mygurukulam.co |

***

# References

| **Source** | **Description** |
| ---------- | --------------- |
| [**Link**](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GenericDoc/Terraform/terraform.md) | Terraform Generic Doc Link. |
| [**Link**](https://developer.hashicorp.com/terraform/language/modules) | Terraform Module Concept. |
| [**Link**](https://medium.com/appgambit/terraform-with-jenkins-pipeline-439babe4095c)  | Jenkins DSL Pipeline Doc reference link. |
| [**Link**](https://github.com/CodeOps-Hub/Terraform-modules/tree/main/Modules/Network_Skeleton_Module) | Network Skeleton Doc |
| [**Link**](https://github.com/CodeOps-Hub/Terraform-modules/tree/main/wrapperCode/Network-Skeleton-Wrapper-Code/Dev-Network-Skeleton-Wrapper-Code) | Network Skeleton Wrapper Code |
