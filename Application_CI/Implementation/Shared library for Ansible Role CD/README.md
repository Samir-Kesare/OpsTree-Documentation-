# Shared library for Ansible Role CD

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056570/314f7657-1deb-4655-ab7b-9789d8853d6e)


|   Author        |  Created on   |  Version   | Last updated by  | Last edited on |
| --------------- | --------------| -----------|----------------- | -------------- |
| Samir Kesare |  6-03-2024  |  Version 1 | Samir  | 6-03-2024    |

***
## Table of Contents
+ [Introduction](#Introduction)
+ [Why Shared Libraries](#Why-Shared-Libraries)
+ [Flow Diagram](#Flow-Diagram)
+ [Pre-requisites](#Pre-requisites)
+ [Jenkinsfile](#Jenkinsfile)
+ [Jenkins Job Output](#Jenkins-Job-Output)
+ [Steps](#Steps)
+ [Conclusion](#Conclusion)
+ [Contact Information](#Contact-Information)
+ [Resources and References](#Resources-and-References)
  
***
## Introduction

In this ticket we will be defining some of the functions that we will use to setup CI pipeline of our various Ansible roles. A Jenkins shared library is a way to define and share reusable code among your Jenkins pipelines. It allows you to encapsulate and reuse common code and functions across multiple pipelines, making it easier to maintain and update your Jenkins pipeline scripts. 

***
## Why Shared Libraries?

Shared libraries are essential components in software development for several reasons:
| Purpose               | Explanation                                                                                                                     |
|-----------------------|---------------------------------------------------------------------------------------------------------------------------------|
| Code Reusability      | Shared libraries allow multiple programs to use the same set of functions and data, reducing redundancy and improving consistency. |
| Modularity            | They help modularize code by separating commonly used functionalities into standalone libraries, making the codebase more organized and easier to manage. |
| Memory Efficiency     | Shared libraries are loaded into memory once and shared among multiple processes, reducing memory usage compared to static libraries where each program has its own copy of the library code. |
| Simplified Maintenance| Updates to shared libraries automatically propagate to all programs using them, simplifying maintenance and ensuring consistency across applications. |
| Promotes Collaboration| Shared libraries facilitate collaboration among developers by providing a common set of functionalities that can be utilized across different projects. |
| Interoperability      | Shared libraries enable interoperability between programs written in different languages through language bindings, allowing developers to leverage existing codebases in various environments. |

In summary, shared libraries play a crucial role in software development by promoting code reuse, reducing memory overhead, simplifying maintenance, fostering collaboration, enabling interoperability, and promoting standardization.

***
## Flow Diagram 

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056570/119eeabc-b80c-4606-9999-4ed0528165a2)


***
## Pre-requisites

| Tool   | Description                          | 
|--------|--------------------------------------|
| Github Accounts | To store and manage the codes| 
| Jenkins | To check our codes and to setup pipelines         |  

## Runtime Pre-requisites

| Tool   | Description                          | 
|--------|--------------------------------------|
| git | Git is required to manage the repo and running git clone| 
| Python | Python is required for ansible         |  
| Ansible-lint | Ansible-lint is required to run ansible-lint check         | 
| Jenkins | To check our codes and to setup pipelines         | 
| Gitleaks | for Credential Scanning   |

***
## Jenkinsfile
```shell
@Library('snaatak-p7') _
def ansibleRole_CD = new org.avengers.template.ansibleRole_CD.ansibleRoleCD()

node {
    
    def url = 'https://github.com/CodeOps-Hub/Jenkins-Playbook.git'
    def creds = '890c8a72-7383-4986-8573-519aacdeb7d2'
    def branch = 'main'
    def gitleaksVersion = '8.18.2'
    def tagVersion = '1.1'
    def path  = 'https://username:${PASSWORD}@github.com/CodeOps-Hub/Jenkins-Playbook.git v1.1
'
    
    ansibleRole_CD.call(url, creds, branch, gitleaksVersion, tagVersion, path)
    
}
```

***
## Jenkins Job Output

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056570/c4f40316-7e9e-4597-bf75-3daabaadb902)


***
## Steps
### Step 1:

Credential Scanning Stage: The pipeline should start by checking out for passwords, access tokens etc in  Ansible playbook code from the repository.
```shell
package org.avengers.ansibleRole_CD
def call(String gitleaksVersion) {
  stage('Credential Scanning') {
            script {
                sh "wget https://github.com/gitleaks/gitleaks/releases/download/v${gitleaksVersion}/gitleaks_${gitleaksVersion}_linux_x64.tar.gz"
                // Extract Gitleaks
                sh "tar xvzf gitleaks_${gitleaksVersion}_linux_x64.tar.gz"
                sh "./gitleaks detect -r credScanReport.json"
            }
        }
}
```


### Step 2:

Linting Stage: Use Ansible Lint or similar tools to perform linting on your Ansible playbook to ensure adherence to best practices and coding standards.
``shell
package org.avengers.ansibleRole_CD
def call() {
    stage('Linting Stage') {
       
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
```


### Step 3:

Syntax Checking Stage: Run ansible-playbook with the --syntax-check option to validate the syntax of the playbook
```shell
package org.avengers.ansibleRole_CD
def call() {
  stage('Syntax Checking Stage') {
           
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
```


### Step 4:

DryRun.groovy: 
```shell
package org.avengers.ansibleRole_CD
def call() {
  stage('Dry Run Stage') {
            script {
                // Perform a dry run 
                sh 'ansible-playbook /var/lib/jenkins/workspace/Ansible_CD/jenkins_playbook/install_debian.yml --check'
            }
        }
}
```

### Step 4:

gitTag.groovy: 
```shell
package org.avengers.ansibleRole_CD
def call(String tagVersion) {
  stage('Git Tag Stage') {
            script {
                // Tag the version
                sh 'git tag -a v${tagVersion} -m "Version ${tagVersion}"'
            }
        }
}
```
### Step 5

gitPushTag.groovy
```shell
package org.avengers.ansibleRole_CD
def call(String path) {
  stage('Git Push Version Stage') {
            script {
                // Push the tagged version to the remote repository
                withCredentials([usernamePassword(credentialsId: 'f941d7e1-ff1a-4bca-835c-a458a1b3d96a', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh 'git push ${path}'
                }
            }
        }
```
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
