# DSL Jenkins pipeline for Network Skeleton setup in QA env 

<img width="360" length="100" alt="Terraform" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/556e50dc-0c8b-4262-be16-2c384d2cfa8a">

***
|   Author        |  Created on   |  Version   | Last updated by  | Last edited on |
| --------------- | --------------| -----------|----------------- | -------------- |
| Khushi Malhotra |  18 March 2024  |  Version 1 | Khushi Malhotra  | 18 March 2024    |

## Table of contents

* [Introduction](#Introduction)
* [What is DSL Pipeline](#What-is-DSL-Pipeline)
* [Why DSL Pipeline](#Why-DSP-Pipeline)
* [Flow Diagram](#Flow-Diagram)
* [Pre-requisites](#Pre-requisites)
* [Implementation of DSL Pipeline](#Implementation-of-DSL-Pipeline)
* [Terraform Module](#Terraform-Module)
* [Jenkinsfile](#Jenkinsfile)
* [Output](#Output)
* [Conclusion](#Conclusion)
* [Contact Information](#Contact-Information)
* [References](#References)

***
## Introduction

With the increasing complexity of modern networks and the need for agility in infrastructure management, Terraform has emerged as a powerful tool for automating the provisioning and configuration of network resources.This module is designed to provide a foundational framework for managing network infrastructure as code using Terraform. The  wrapper code simplifies the deployment and management of Network Skeleton setup by automating configuration tasks and providing a user-friendly interface for users to connect securely to the Network.

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

<img width="950" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/9b5ae612-95d9-4cf4-9612-d9874fcfd843">

***

## Pre-requisites

| **Pre-requisites** | **Description** |
| ------------------ | ---------------- |
| **AWS Account**    | Access to the AWS Management Console with credentials configured. |
| **Jenkins**        | To integrate infra through DSL Pipeline. |
| **Terraform**      | Terraform HCL (v1.7.4) |

***

## Implementation of DSL Pipeline 

**Step-1** Create a New Pipeline Job

**Step-2** Configure Pipeline Script

**Step-3** Save the Configuration

**Step-4** Build the Pipeline

**Step-5** View Build Console Output

**This Jenkins pipeline automates the deployment of a NetworkSkeleton_QA Server using Terraform module and Wrapper code. It's configured to perform the following actions:**

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

<details>
<summary> <b> Click here for Console Output </b> </summary>
<br>

```shell

```
</details>

## [Terraform Module](https://github.com/CodeOps-Hub/Terraform-modules/tree/main/wrapperCode/Network-Skeleton-Wrapper-Code/QA-Network-Skeleton-Wrapper-Code)

## [Jenkinsfile](https://github.com/CodeOps-Hub/Jenkinsfile/blob/khushi/networkSkeleton_QA/Wrapper-Code/QA_Env/networkskeleton_QA/Jenkinsfile)

<details>
  <summary>Click here to see Jenkins file</summary>

  ```shell
pipeline {
    agent any
    
    environment {
        AWS_ACCESS_KEY_ID     = credentials('vishal_cred')
        AWS_SECRET_ACCESS_KEY = credentials('vishal_cred')
        TF_CLI_ARGS           = '-input=false'
    }
    
    parameters {
        choice(name: 'ACTION', choices: ['Apply', 'Destroy'], description: 'Choose to apply or destroy the infrastructure')
        string (defaultValue: 'wrapperCode/Network-Skeleton-Wrapper-Code/QA-Network-Skeleton-Wrapper-Code', description: 'define path of wrapper code directory', name: 'WrapperPath')
    }
    
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', credentialsId: 'Khushi_PAT', url: 'https://github.com/CodeOps-Hub/Terraform-modules.git'
            }
        }
        
        stage('Copy Terraform Files') {
            steps {
                // Copy or move specific files from the repository to Jenkins workspace
                sh "cp ${params.WrapperPath}/* ."
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

## Output

**Jenkins Output**

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/2fb508a3-dfae-42c3-a453-54cd62377fbd)

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/02922b8b-c2c5-40c1-9209-e9258ce4e6ec)


**VPC & it's resources**

<img width="800" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/bd03370b-9419-42a2-9c91-831176b8a8d3">

***

**Elastic IP**

<img width="800" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/2b642830-7a6e-4c58-a20d-52ce3488b3c0">

***

**Frontend NACL**

<img width="800" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/1bfe075f-c85e-49c2-ab89-668624ec2122">

***

**Backend NACL**

<img width="800" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/74b31c37-f664-4be3-bad3-e2eb6869cda3">

***

**DB NACL**

<img width="800" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/7f538afe-31df-4f56-b25e-e73603188528">

***

**Security Group**

<img width="800" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/b18405d2-68e8-4d8c-9944-b9fe037ac518">

***

**Load Balancer**

<img width="800" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/ee63527c-bd8a-4815-bc0e-744af1ba910e">

***

**Route53**

<img width="800" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/2d563ec3-61ef-4032-b86c-2787f68f4bdc">

***

## Conclusion

In conclusion, our DSL Pipeline offers a powerful solution for creating and managing domain-specific languages, enabling developers to express complex ideas in a concise and understandable manner. By embracing DSLs, organizations can accelerate development cycles, improve collaboration between domain experts and developers, and ultimately deliver higher-quality software solutions.The NetworkSkeleton_QA wrapper code streamlines the setup process, enhances security through standardized configurations, and improves usability by abstracting complex tasks, making it an efficient solution for deploying and managing network infrastructures. 

***


## Contact Information
| Name            | Email Address                        |
|-----------------|--------------------------------------|
| Khushi Malhotra | khushi.malhotra.snaatak@mygurukulam.co |

## References

| **Source** | **Description** |
| ---------- | --------------- |
| [**Link**](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GenericDoc/Terraform/terraform.md) | Terraform Generic Doc Link. |
| [**Link**](https://developer.hashicorp.com/terraform/language/modules) | Terraform Module Concept. |
| [**Link**](https://medium.com/appgambit/terraform-with-jenkins-pipeline-439babe4095c)  | Jenkins DSL Pipeline Doc reference link. |
