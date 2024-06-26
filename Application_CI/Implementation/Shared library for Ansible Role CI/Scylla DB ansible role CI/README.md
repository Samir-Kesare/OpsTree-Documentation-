# Shared library for Ansible Role CI

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056570/314f7657-1deb-4655-ab7b-9789d8853d6e)


|   Author        |  Created on   |  Version   | Last updated by  | Last edited on |
| --------------- | --------------| -----------|----------------- | -------------- |
| Samir Kesare |  8-03-2024  |  Version 1 | Samir  | 8-03-2024    |

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


![image](https://github.com/CodeOps-Hub/Documentation/assets/156056570/291f1f8a-a285-4eeb-9d68-c753aa151c8b)


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
@Library('my-shared-library') _
def ansibleRole_CD = new org.avengers.template.ansibleRole_CD.ansibleRoleCD()

node {
    
    def url = 'https://github.com/CodeOps-Hub/scyllaDB-ansible-role.git'
    def creds = 'cfb1a43a-bdbe-4b72-9966-6f42f75e98b1'
    def branch = 'main'
    def gitleaksVersion = '8.18.2'
    def tagVersion = '1.1'
    def path  = "/var/lib/jenkins/workspace/SharedLiabrary_CICD/scylla-ansible-role/tests/test.yml"
    
    
    ansibleRole_CD.call(url, creds, branch, gitleaksVersion, tagVersion, path)
    
}
```
***
## Jenkins Job Output

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056570/933aa3f0-8296-4426-ab1e-9ce2934ff900)

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
def call(String path) {
    stage('Linting Stage') {
       
            script {
                try {
                    // Use Ansible Lint to perform linting on your Ansible playbook
                    sh "ansible-lint ${path} -q > lint_report.txt"
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
def call(String path) {
  stage('Syntax Checking Stage') {
           
                script {
                    try {
                        // Run ansible-playbook with the --syntax-check option to validate playbook syntax
                        sh "ansible-playbook ${path} --syntax-check > syntaxcheck_report.txt"
                    } catch (Exception e) {
                        // Ignore syntax check errors
                        echo 'Syntax checking completed with errors. Ignoring...'
                    }
                }
            }
        }
  
```


### Step 4:

Git Tag Stage: 
```shell
package org.avengers.ansibleRole_CD
def call(String tagVersion) {
  stage('Git Tag Stage') {
            script {
                // Tag the version
                sh "git tag -a v${tagVersion} -m 'Version ${tagVersion}'"
            }
        }
}
```

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


![image](https://github.com/CodeOps-Hub/Documentation/assets/156056570/314f7657-1deb-4655-ab7b-9789d8853d6e)


|   Author        |  Created on   |  Version   | Last updated by  | Last edited on |
| --------------- | --------------| -----------|----------------- | -------------- |
| Samir Kesare |  2-03-2024  |  Version 1 | Samir  | 2-03-2024    |

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

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056570/7b1b5dcf-4454-4b61-b4a9-085c289d553d)
![image](https://github.com/CodeOps-Hub/Documentation/assets/156056570/291f1f8a-a285-4eeb-9d68-c753aa151c8b)


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
def ansible_CI = new org.avengers.template.ansible_CI.ansibleCI()

node {
    
    def url = 'https://github.com/CodeOps-Hub/Jenkins-Playbook.git'
    def creds = '890c8a72-7383-4986-8573-519aacdeb7d2'
    def branch = 'main'
    def gitleaksVersion = '8.18.2'
    def tagVersion = '1.0'
    
    ansible_CI.call(url, creds, branch, gitleaksVersion, tagVersion)
    
}

```
***
## Jenkins Job Output

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056570/2dbd285d-4e96-42d1-a775-fb473a273fa1)

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056570/17454703-533d-4698-a36b-f5e9ef22444b)


## Steps
### Step 1:

Credential Scanning Stage: The pipeline should start by checking out for passwords, access tokens etc in  Ansible playbook code from the repository.
```shell
package org.avengers.ansible_CI
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
package org.avengers.ansible_CI
def call() {
    stage('Linting Stage') {
       
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
```


### Step 3:

Syntax Checking Stage: Run ansible-playbook with the --syntax-check option to validate the syntax of the playbook
```shell
package org.avengers.ansible_CI
def call() {
  stage('Syntax Checking Stage') {
           
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
  
```


### Step 4:

Git Tag Stage: 
```shell
package org.avengers.ansible_CI
def call(String tagVersion) {
  stage('Git Tag Stage') {
            script {
                // Tag the version
                sh 'git tag -a v${tagVersion} -m "Version ${tagVersion}"'
            }
        }
}
```

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

