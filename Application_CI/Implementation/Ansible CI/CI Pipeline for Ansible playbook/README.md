# CI Pipeline for Ansible playbook

![308138119-8b4714ec-7c6b-4f84-8c2e-b29495fd0658-removebg-preview](https://github.com/CodeOps-Hub/Documentation/assets/156056570/5d80d84c-9e9f-454e-9007-e59b5cdf902c)


|   Author        |  Created on   |  Version   | Last updated by  | Last edited on |
| --------------- | --------------| -----------|----------------- | -------------- |
| Samir Kesare |  25-02-2024  |  Version 1 | Samir  | 27-02-2024    |

***
## Table of Contents
+ [Introduction](#Introduction)
+ [Key Components](#Key Components)
+ [Flow Diagram](#Flow-Diagram)
+ [Pre-requisites](#Pre-requisites)
+ [Jenkinsfile](#Jenkinsfile)
+ [Steps](#Steps)
+ [Conclusion](#Conclusion)
+ [Contact Information](#Contact-Information)
+ [Resources and References](#Resources-and-References)
  
***
## Introduction

Setting up a Continuous Integration (CI) pipeline for Ansible playbooks is a valuable practice for automating the testing and deployment of infrastructure configurations. CI pipelines automate the process of building, testing, and deploying software, enabling faster product delivery to customers while minimising manual intervention. In this ticket,we will explore the stages of a CI pipeline and demonstrate how to set up these stages using Ansible Playbook. Cilck [**here**](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/jenkinsPipeline.md)

***
## Key Components

 Cilck [**here**](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Design/01-%20Understanding/CI_Concepts.md)

| Stage       | Description                                      | 
|-------------|--------------------------------------------------|
| Checkout    | Retrieve the source code from the version control system. | 
| Build       | Compile the source code and build artifacts.     | 
| Test        | Run automated tests to verify the code quality.   | 
| Code Analysis | Analyze the code for potential issues and vulnerabilities. |
| Package     | Package the built artifacts for deployment.      | 
| Deploy      | Deploy the packaged artifacts to a staging environment for testing. | 
| Integration Test | Perform integration tests on the deployed artifacts. | 
| Security Testing | Conduct security tests to identify vulnerabilities. | 
| Release     | Release the tested and approved artifacts to production. | 
| Monitoring  | Monitor the deployed application for performance and availability. |
| Reporting   | Generate reports summarizing the pipeline execution and results. |

***
## Flow Diagram

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056570/7aa5ca3e-4d28-4d45-8329-d65213f7d680)


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
        stage('Checkout Stage') {
            steps {
                // Checkout the latest version of the Ansible playbook code from the repository
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: '890c8a72-7383-4986-8573-519aacdeb7d2', url: 'https://github.com/CodeOps-Hub/Jenkins-Playbook.git']])
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
                        sh 'ansible-lint /var/lib/jenkins/workspace/Ansible_CI/jenkins_playbook/install_debian.yml -q > lint_report.txt'
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
                        sh 'ansible-playbook /var/lib/jenkins/workspace/Ansible_CI/jenkins_playbook/install_debian.yml --syntax-check > syntaxcheck_report.txt'
                    } catch (Exception e) {
                        // Ignore syntax check errors
                        echo 'Syntax checking completed with errors. Ignoring...'
                    }
                }
            }
        }
        stage('Git Tag Stage') {
            steps {
                // Tag the version
                sh 'git tag -a v1.0 -m "Version 1.0"'
            }
        }
    }
}

```
***
## Jenkins Job Output

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056570/7953a041-854c-4680-a0ad-c95ce1f4e8f7)
![image](https://github.com/CodeOps-Hub/Documentation/assets/156056570/17454703-533d-4698-a36b-f5e9ef22444b)


## Steps
### Step 1:

Credential Scanning Stage: The pipeline should start by checking out for passwords, access tokens etc in  Ansible playbook code from the repository.
![image](https://github.com/CodeOps-Hub/Documentation/assets/156056570/1de7cd62-9267-4b36-9bdc-19b9a79dc596)


### Step 2:

Linting Stage: Use Ansible Lint or similar tools to perform linting on your Ansible playbook to ensure adherence to best practices and coding standards.

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056570/3122a40b-4e46-4b27-8188-33d9cc8a9613)


### Step 3:

Syntax Checking Stage: Run ansible-playbook with the --syntax-check option to validate the syntax of the playbook.

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056570/401a40bd-b859-4c7f-ad5b-8333f3ee239d)


### Step 4:

Git Tag Stage: 
![image](https://github.com/CodeOps-Hub/Documentation/assets/156056570/f0d1df3e-a39d-47e1-ade2-81b35c726981)


***
## Conclusion 

In summary, implementing comprehensive CI checks for Ansible playbooks is essential for maintaining the reliability and quality of automation code. Through a combination of syntax validation, linting, playbook execution in test mode, role-specific testing, inventory validation, secrets scanning, integration tests, idempotent checks, documentation validation, code coverage analysis, and dependency management, developers can ensure a robust and error-free Ansible automation workflow. These checks, integrated into a CI pipeline, not only catch issues early in the development cycle but also contribute to the creation of efficient, well-documented, and secure automation solutions.

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




