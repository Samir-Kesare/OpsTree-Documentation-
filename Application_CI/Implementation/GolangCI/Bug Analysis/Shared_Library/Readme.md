# Shared Library Go Lang Bug  Analysis

  <img width="360" length="100" alt="Golang" src="https://github.com/avengers-p7/Documentation/assets/156056413/8f646df3-4ed6-434e-9a69-b8fd8ccfb6b9">

|   Author        |  Created on   |  Version   | Last updated by  | Last edited on |
| --------------- | --------------| -----------|----------------- | -------------- |
| Vishal Kumar Kesarwani |  13-02-2024  |  Version 1 | Vishal  | 13-02-2024    |

***
## Table of Contents
+ [Introduction](#Introduction)
+ [Why Shared Library](#Why-Shared-Library)
+ [Why use src folder structure in a Jenkins shared library](#Why-use-src-folder-structure-in-a-Jenkins-shared-library)
+ [Flow Diagram](#Flow-Diagram)
+ [Pre-requisites](#Pre-requisites)
+ [Setup of Bug Analysis](#Setup-of-Bug-Analysis-Via-Shared-Library)
+ [HTML Report](#HTML-Report)
+ [Jenkinsfile](#Jenkinsfile)
+ [Shared Library](#Shared-Library)
+ [Conclusion](#Conclusion)
+ [Contact Information](#Contact-Information)
+ [Resources and References](#Resources-and-References)
  
***
## Introduction

 <img width="360" length="100" alt="Golang" src="https://github.com/avengers-p7/Documentation/assets/156056413/f94f127a-d207-4c76-bc32-d25e4fe48280"> 

A Jenkins Shared Library is a collection of reusable code that facilitates the sharing of common pipeline logic among teams in Jenkins. It simplifies CI/CD processes by abstracting complex tasks into functions, speeding up pipeline development. By keeping shared code separate from individual pipelines, teams ensure consistency and minimize duplication. This fosters collaboration, encourages best practices, and streamlines Jenkins pipeline creation, leading to better software delivery and development workflows.  
About more information [**Click Here**](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/sharedLibrary/README.md)

***
## Why Shared Library
| Advantage          | Description                                                                                                                                                          |
|--------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Reusability**        | Shared Libraries allow teams to write code once and reuse it across multiple pipelines. This reduces duplication of effort and promotes consistency in the CI/CD process. |
| **Centralization**     | By centralizing common pipeline logic, updates and improvements can be made in one place, benefiting all pipelines that use the library.                             |
| **Abstraction**        | Complex tasks can be abstracted into simple functions in the Jenkins Shared Library, making pipeline scripts cleaner and more maintainable.                            |
| **Standardization**    | Jenkins Shared Library allows organizations to define standardized practices, coding conventions, and security measures across all pipelines.                         |
| **Collaboration**      | Jenkins Shared Libraries encourage collaboration among teams, as they can share and contribute to a common set of pipeline tools and utilities.                         |
| **Versioning Control** | Jenkins Shared Library can be version-controlled, enabling teams to manage changes and rollbacks effectively.                                                        |
| **Ease of Maintenance** | As the Jenkins Shared Library is maintained separately from individual pipelines, updates and bug fixes can be implemented without impacting the pipelines directly. |

***
## Why use `src` folder structure in a Jenkins shared library

| Benefit                    | Description                                                                                                                                                                    |
|----------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Organizational Structure**  | Placing source files in a `src` folder provides a clear and organized structure for the library, aiding developers in quickly locating files and understanding the layout.      |
| **Isolation of Source Code**  | Keeping source code separate from other files (e.g., documentation, configuration, tests) prevents clutter and confusion, making the codebase easier to manage.                 |
| **Easier Maintenance**        | With a clear structure, maintaining and updating the library becomes straightforward, as developers know where to find specific files and can make changes confidently.     |
| **Build and Packaging**       | Adhering to conventions like using a `src` folder facilitates integration with build tools and package managers, as they often expect a certain directory structure.           |
| **Compatibility with IDEs**   | Standard project structures, such as a `src` folder, improve compatibility with integrated development environments (IDEs), enabling features like code navigation and auto-completion. |
| **Readability and Maintainability** | A well-organized structure enhances readability and maintainability by making it easier for developers to understand the codebase's layout and locate relevant files efficiently. |

***
## Flow Diagram  
![Screenshot from 2024-02-16 12-29-55](https://github.com/avengers-p7/Documentation/assets/156056413/4068fcf0-97db-402b-93eb-467cc86a42c6)

***
## Pre-requisites
| **Pre-requsisites** | **Version** |
| ------------------- | ----------- |
| Jenkins | 2.426.3 |
| golang | 1.21.6 |
| golangCI-lint | 1.55.2 |  

***
## Setup of Bug Analysis Via Shared Library
* Follow this document for Setup [**Cilck here**](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/sharedLibrary/setup.md)

  <img width="760" length="100" alt="Golang" src="https://github.com/avengers-p7/Documentation/assets/156056413/00013664-5cc9-47dc-8ab5-2eb1049f42e3"> 

* Console Output:

   <img width="760" length="100" alt="Golang" src="https://github.com/avengers-p7/Documentation/assets/156056413/f7e0cca0-b321-499a-939e-78e16ed4d757"> 


> [!NOTE]
> **Changes**
> *  **Pipeline name**       **-**  `Bug_Analysis_(GoLang_CI_Checks)`
> *  **Jenkinsfile Path**    **-**  `SharedLibrary/Golang/BugAnalysis/Jenkinsfile`  

***

## HTML Report
 * Cilck [**here**](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GolangCI/Bug%20Analysis/Shared_Library/Report.html)

***
## Jenkinsfile
  * [**Jenkinsfie**](https://github.com/avengers-p7/Jenkinsfile/blob/main/SharedLibrary/Golang/BugAnalysis/Jenkinsfile)
  ```shell
@Library('snaatak-p7') _
def golangBugAnalysis = new org.avengers.template.GolangBugAnalysis()

node {
    
    def url = 'https://github.com/OT-MICROSERVICES/employee-api.git'
    def creds = 'vishal-cred'
    def branch = 'main'
    
    golangUnitTesting.call(url, creds, branch)
    
}       
```
## Shared Library
  * [**GitCheckoutPrivate.groovy**](https://github.com/avengers-p7/SharedLibrary/blob/main/src/org/avengers/common/GitCheckoutPrivate.groovy)
  ```shell
//src/org/avengers/common/GitCheckoutPrivate.groovy
package org.avengers.common

def call(String url, String creds, String branch) {
    stage('Clone') {
        script {
            git branch: "${branch}", credentialsId: "${creds}", url: "${url}"
        }
    }
}
```
  * [**InstallationPreRequisites.groovy**](https://github.com/avengers-p7/SharedLibrary/blob/main/src/org/avengers/golang/bugAnalysis/InstallationPreRequisites.groovy)
  ```shell
//src/org/avengers/golang/bugAnalysis/InstallationPreRequisites.groovy

package org.avengers.golang.bugAnalysis

def call() {
    stage('Installation Pre-Requisites') {
        script {
            // Update apt packages
            sh 'sudo apt update'
            // Install Go using snap
            sh 'sudo snap install go --classic'
            // Remove golangci-lint using snap
            sh 'sudo snap remove golangci-lint || true'
            // Install GolangCI-lint
            sh 'go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest'
            // Add $HOME/go/bin to PATH
            env.PATH += ":$HOME/go/bin"
        }
    }
}
```
  * [**Linting.groovy**](https://github.com/avengers-p7/SharedLibrary/blob/main/src/org/avengers/golang/bugAnalysis/Linting.groovy)
  ```shell
//src/org/avengers/golang/bugAnalysis/Linting.groovy
package org.avengers.golang.bugAnalysis

def call() {
    stage('Linting') {
        script {
            // Run golangci-lint and ignore errors
            sh 'golangci-lint run ./... || true'
        }
    }
}
```
  * [**Report.groovy**](https://github.com/avengers-p7/SharedLibrary/blob/main/src/org/avengers/golang/bugAnalysis/Report.groovy)
  ```shell
//src/org/avengers/golang/bugAnalysis/Report.groovy
package org.avengers.golang.bugAnalysis

def call() {
    stage('Generate HTML Report') {
        script {
             // Run golangci-lint with the --out-format option to specify the output format
             sh 'golangci-lint run ./... --out-format html > report.html || true'
        }
    }
}
```
  * [**GolangBugAnalysis.groovy**](https://github.com/avengers-p7/SharedLibrary/blob/main/src/org/avengers/template/golang/GolangBugAnalysis.groovy)
  ```shell
//src/org/avengers/template/GolangBugAnalysis.groovy
package org.avengers.template

import org.avengers.common.*
import org.avengers.golang.bugAnalysis.*

def call(String url, String creds, String branch){
  installationPreRequisites = new InstallationPreRequisites()
  gitCheckoutPrivate = new GitCheckoutPrivate()
  linting = new Linting()
  report = new Report()

  installationPreRequisites.call()
  gitCheckoutPrivate.call(url, creds, branch)
  linting.call()
  report.call()
}
  
```

***
## Conclusion
The Jenkins Shared Library streamlines CI/CD processes by allowing teams to share reusable code and logic across various pipelines. It standardizes workflows, minimizes duplication, and ensures consistency. With abstracted complex tasks into reusable functions, it simplifies maintenance and fosters collaboration among teams. By promoting best practices and enabling version control, it enhances the efficiency and reliability of the CI/CD process, accessible even without Jenkins admin access.

***
## Contact Information
| Name | Email address |
| ---- | ------------- |
| Vishal | vishal.kesarwani.snaatak@mygurukulam.co |
***
## Resources and References
|  **Description** |   **Source** |
| ---------------- | ------------ |
| About Jenkins Shared Library (Generic Document) | [Link](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/sharedLibrary/README.md) |
| POC Generic Document | [Link](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/sharedLibrary/setup.md) |
| Jenkinsfile | [Link](https://github.com/avengers-p7/Jenkinsfile/blob/main/SharedLibrary/Golang/BugAnalysis/Jenkinsfile) |
| Manual Setup | [Link](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Design/05-%20GoLang%20CI%20Checks/Bug%20Analysis/POC%20of%20Bug%20Analysis%20(Golang%20CI%20Checks).md) |
| Manual Pipeline | [Declarative](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GolangCI/Bug%20Analysis/Declarative%20Pipeline/Readme.md) & [Scripted](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GolangCI/Bug%20Analysis/Scripted%20Pipeline/Readme.md) |
| Bug Analysis | [Link](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Design/05-%20GoLang%20CI%20Checks/Bug%20Analysis/Introduction%20of%20Bugs%20analysis%20(GoLang%20CI%20Checks).md#resources-and-references) |

***

