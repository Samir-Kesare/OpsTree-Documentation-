# CD Pipeline for Ansible playbook

![1618942154331-removebg-preview](https://github.com/CodeOps-Hub/Documentation/assets/156056570/018bdd90-fea0-4c30-b56c-7e8b868645e9)



|   Author        |  Created on   |  Version   | Last updated by  | Last edited on |
| --------------- | --------------| -----------|----------------- | -------------- |
| Samir Kesare |  5-03-2024  |  Version 1 | Samir  | 05-03-2024    |

***
## Table of Contents
+ [Introduction](#Introduction)
+ [Why Ansible_CD](#Why-Ansible_CD)
+ [Flow Diagram](#Flow-Diagram)
+ [Pre-requisites](#Pre-requisites)
+ [Setup](#Setup)
+ [Jenkinsfile](#Jenkinsfile)
+ [Conclusion](#Conclusion)
+ [Contact Information](#Contact-Information)
+ [Resources and References](#Resources-and-References)
  
***
## Introduction

Continuous Deployment is an approach where code changes are automatically built, tested, and deployed to production environments frequently and consistently. It aims to streamline the software delivery process, reduce manual intervention, and ensure that the latest changes are available to users rapidly and reliably.
Continuous Deployment (CD) with Ansible involves automating the deployment process of software applications to various environments in a continuous and efficient manner. Ansible, a powerful automation tool, is commonly used in CD pipelines due to its simplicity, flexibility, and scalability.

***
## Why Ansible_CD?

| Feature / Benefit                      | Description                                                                                                               |
|---------------------------------------|---------------------------------------------------------------------------------------------------------------------------|
| Infrastructure as Code                | Ansible enables the definition and management of infrastructure through code, allowing for consistent and repeatable deployments. |
| Simplified Configuration Management  | Ansible simplifies configuration management tasks by using YAML syntax, making it easy to understand and maintain playbooks.    |
| Agentless Architecture                | Ansible's agentless architecture eliminates the need to install and manage agents on remote systems, reducing overhead and complexity. |
| Extensive Module Library              | Ansible provides a vast collection of modules for managing various infrastructure components, making it highly versatile and adaptable. |
| Integration with CI/CD Tools          | Ansible seamlessly integrates with Continuous Integration (CI) and Continuous Deployment (CD) tools such as Jenkins, GitLab CI/CD, etc. |
| Parallel Execution                    | Ansible allows for parallel execution of tasks across multiple hosts, improving performance and efficiency in large-scale deployments. |
| Idempotent Operations                 | Ansible ensures idempotency, meaning that running the same playbook multiple times results in the same desired state, reducing the risk of configuration drift. |
| Role-Based Organization               | Ansible enables the organization of playbooks and tasks into reusable roles, promoting modularity and code reusability across projects. |
| Comprehensive Error Handling          | Ansible provides robust error handling mechanisms, including try-catch blocks and error handling tasks, to manage failures gracefully during deployment. |
| Community and Support                 | Ansible benefits from a large and active community, offering extensive documentation, tutorials, and community-driven support channels. |
| Scalability and Flexibility           | Ansible scales effectively to manage both small and large infrastructures, offering flexibility in orchestrating complex deployment workflows. |
| Security and Compliance               | Ansible includes features for managing security and compliance requirements, such as encryption, role-based access control (RBAC), and auditing capabilities. |
| Continuous Feedback Loop              | Ansible facilitates a continuous feedback loop by providing detailed logs, reports, and monitoring capabilities, enabling developers to iterate and improve deployment processes. |

***
## Flow Diagram



***

## Pre-requisites

| Tool   | Description                          | 
|--------|--------------------------------------|
| Github Accounts | To store and manage the codes| 
| Jenkins | To check our codes and to setup pipelines         |  

## Runtime Prerequisites

| Tool   | Description                          | 
|--------|--------------------------------------|
| git | Git is required to manage the repo and running git clone| 
| Python | Python is required for ansible         |  
| Ansible-lint | Ansible-lint is required to run ansible-lint check         | 
| Jenkins | To check our codes and to setup pipelines         | 

***
## Jenkinsfile
```shell
pipeline {
    agent any
    
    stages {
        stage('Clean Workspace') {
            steps {
                // Clean up workspace
                deleteDir()
            }
        }
        stage('Checkout Stage') {
            steps {
                // Checkout the latest version of the Ansible playbook code from the repository
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'f941d7e1-ff1a-4bca-835c-a458a1b3d96a', url: 'https://github.com/CodeOps-Hub/Jenkins-Playbook.git']])
            }
        }
        stage('Credential Scanning') {
            steps {
                sh 'wget https://github.com/gitleaks/gitleaks/releases/download/v8.18.2/gitleaks_8.18.2_linux_x64.tar.gz'
                // Extract Gitleaks
                sh 'tar xvzf gitleaks_8.18.2_linux_x64.tar.gz'
                sh './gitleaks detect -r credScanReport.json'
            }
        }
        stage('Linting Stage') {
            steps {
                script {
                    try {
                        // Use Ansible Lint to perform linting on your Ansible playbook
                        sh 'ansible-lint /var/lib/jenkins/workspace/Ansible_CD/jenkins_playbook/install_debian.yml -q > lint_report.txt'
                    } catch (Exception e) {
                        // Ignore linting errors
                        echo 'Linting completed with errors. Ignoring...'
                    }
                }
            }
        }
        stage('Syntax Checking Stage') {
            steps {
                script {
                    try {
                        // Run ansible-playbook with the --syntax-check option to validate playbook syntax
                        sh 'ansible-playbook /var/lib/jenkins/workspace/Ansible_CD/jenkins_playbook/install_debian.yml --syntax-check > syntaxcheck_report.txt'
                    } catch (Exception e) {
                        // Ignore syntax check errors
                        echo 'Syntax checking completed with errors. Ignoring...'
                    }
                }
            }
        }
        stage('Dry Run Stage') {
            steps {
                // Perform a dry run (if applicable)
                sh 'ansible-playbook /var/lib/jenkins/workspace/Ansible_CD/jenkins_playbook/install_debian.yml --check'
            }
        }
        stage('Ansible Run Stage') {
            steps {
                // Run the ansible playbook
                sh 'ansible-playbook /var/lib/jenkins/workspace/Ansible_CD/jenkins_playbook/install_debian.yml'
            }
        }
    }
}

```

***
## Set Up
### Step 1:

Checkout Stage: The pipeline should start by checking out the latest version of the Ansible playbook code from the repository.

### Step 2:

Linting Stage: Use Ansible Lint or similar tools to perform linting on your Ansible playbook to ensure adherence to best practices and coding standards.

### Step 3:

Syntax Checking Stage: Run ansible-playbook with the --syntax-check option to validate the syntax of the playbook.

### Step 4:

Dry Run: Finally we can do a dry of our Ansible playbook where it will check that all the permissions and configuration are in place.

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056570/322c20a1-8c43-420b-899a-b817605efd95)

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056570/ce3b04c1-ac98-4dc9-a3b0-2516fde8eb08)


***
## Conclusion 

In summary, Ansible empowers organizations to implement robust and efficient CD pipelines by automating infrastructure provisioning, application deployment, and configuration management tasks. Its simplicity and versatility make it a popular choice for DevOps teams striving to achieve continuous delivery and deployment of software applications.

***
## Contact Information

| Name | Email address |
| ---- | ------------- |
| Samir Kesare | samir.kesare.snaatak@mygurukulam.co |

***
## Resources and References

|  **Description** |   **Source** |
| ---------------- | ------------ |
| How to run Ansible playbook from Jenkins pipeline job | [https://medium.com/globant/owasp-zap-integration-with-jenkins-795d65991404](https://www.youtube.com/watch?v=PRpEbFZi7nI)https://www.youtube.com/watch?v=PRpEbFZi7nI |
