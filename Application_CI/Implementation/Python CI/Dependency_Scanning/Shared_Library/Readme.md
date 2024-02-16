# Shared Library Python Dependency Scanning

  <img width="360" length="100" alt="Python" src="https://github.com/avengers-p7/Documentation/assets/156056413/ffb4fd31-eda0-4587-8774-2f694cddfec6"> 

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
+ [Setup of Dependency Scanning](#Setup-of-Dependency-Scanning-Via-Shared-Library)
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
![Screenshot from 2024-02-11 00-12-01](https://github.com/avengers-p7/Documentation/assets/156056413/07ac7433-56db-46d6-94d4-ea6cc9d1bce1)

***
## Pre-requisites
| **Pre-requisites** | **Version** |
| ------------------ | ----------- |
| Jenkins | 2.426.3 | 
| Java | 17 |
| OWASP Dependency-Check | 9.0.9 |
 

***
## Setup of Dependency Scanning Via Shared Library
* Follow this document for Setup [**Cilck here**](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/sharedLibrary/setup.md)

  <img width="760" length="100" alt="python" src="https://github.com/avengers-p7/Documentation/assets/156056413/a0bb9810-02de-4c58-851c-671de028c6df"> 

* Console Output:

   <img width="760" length="100" alt="python" src="https://github.com/avengers-p7/Documentation/assets/156056413/e682a483-b102-4a67-ac0e-08bfcf39dddd"> 


> [!NOTE]
> **Changes**
> *  **Pipeline name**       **-**  `Dependency_Scanning_(Python)`
> *  **Jenkinsfile Path**    **-**  `SharedLibrary/Python/DependencySacnning/Jenkinsfile`  

***

## HTML Report
 * Cilck [**here**](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/Python%20CI/Dependency_Scanning/Shared_Library/Report.html)

***
## Jenkinsfile
  * [**Jenkinsfie**](https://github.com/avengers-p7/Jenkinsfile/blob/main/SharedLibrary/Python/DependencySacnning/Jenkinsfile)
  ```shell

@Library('snaatak-p7') _
def pythonDependencyScanning = new org.avengers.template.PythonDependencyScanning()

node {
    
    def url = 'https://github.com/OT-MICROSERVICES/attendance-api.git'
    def creds = 'vishal-cred'
    def branch = 'main'
    def depVersion = '9.0.9'
    def javaVersion = '17'
    
    pythonDependencyScanning.call(url, creds, branch, depVersion, javaVersion)
    
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
  * [**JavaDownload.groovy**](https://github.com/avengers-p7/SharedLibrary/blob/main/src/org/avengers/common/JavaDownload.groovy)
  ```shell
//src/org/avengers/common/JavaDownload.groovy
package org.avengers.common

def call(String javaVersion) {
    stage('Install Java') {
        script {
            sh "sudo apt update && sudo apt install -y openjdk-${javaVersion}-jdk"
        }
    }
}
```
  * [**DownloadDependencyCheck.groovy**](https://github.com/avengers-p7/SharedLibrary/blob/main/src/org/avengers/python/dependencyScanning/DownloadDependencyCheck.groovy)
  ```shell
//src/org/avengers/python/dependencyScanning/DownloadDependencyCheck.groovy
package org.avengers.python.dependencyScanning

def call(String depVersion) {
    stage('Download Dependency Check') {
            script {
                sh "wget -q https://github.com/jeremylong/DependencyCheck/releases/download/v${depVersion}/dependency-check-${depVersion}-release.zip"
                sh "sudo apt install unzip -y"
                sh "unzip -q dependency-check-${depVersion}-release.zip"
            }
    }
}
```
  * [**DependencyCheck.groovy**](https://github.com/avengers-p7/SharedLibrary/blob/main/src/org/avengers/python/dependencyScanning/DependencyCheck.groovy)
  ```shell
//src/org/avengers/python/dependencyScanning/DependencyCheck.groovy
package org.avengers.python.dependencyScanning

def call() {
    stage('Run Dependency Check') {
        script {
           sh "dependency-check/bin/dependency-check.sh --scan /var/lib/jenkins/workspace/ --out dep-check.html"
        }
    }
}
```
  * [**Clean.groovy**](https://github.com/avengers-p7/SharedLibrary/blob/main/src/org/avengers/python/dependencyScanning/Clean.groovy)
  ```shell
//src/org/avengers/python/dependencyScanning/Clean.groovy
package org.avengers.python.dependencyScanning

def call() {
    stage('Clean workspace') {
        script {
           sh "rm -rf *.zip"
           sh "rm -rf dependency-check"
        }
    }
}
```
  * [**PythonDependencyScanning.groovy**](https://github.com/avengers-p7/SharedLibrary/blob/main/src/org/avengers/template/python/PythonDependencyScanning.groovy)
  ```shell
//src/org/avengers/template/PythonDependencyScanning.groovy
package org.avengers.template

import org.avengers.common.*
import org.avengers.python.dependencyScanning.*

def call(String url, String creds, String branch, String depVersion, String javaVersion){
  javaDownload = new JavaDownload()
  downloadDependencyCheck = new DownloadDependencyCheck()
  gitCheckoutPrivate = new GitCheckoutPrivate()
  dependencyCheck = new DependencyCheck()
  clean = new Clean()

  javaDownload.call(javaVersion)
  downloadDependencyCheck.call(depVersion) 
  gitCheckoutPrivate.call(url, creds, branch)
  dependencyCheck.call()
  clean.call()
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
| Jenkinsfile | [Link](https://github.com/avengers-p7/Jenkinsfile/blob/main/SharedLibrary/Python/DependencySacnning/Jenkinsfile) |
| Manual Setup | [Link](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Design/04-%20Python%20CI%20Checks/Dependency%20Scanning/Dependency%20scanning(Python%20CI%20Checks).md) |
| Manual Pipeline | [Declarative](https://github.com/avengers-p7/Documentation/tree/main/Application_CI/Implementation/Python%20CI/Dependency_Scanning/Declarative_Pipeline) & [Scripted](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/Python%20CI/Dependency_Scanning/Scripted_Pipeline/Readme.md) |
| Dependency Scanning | [Link](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Design/04-%20Python%20CI%20Checks/Dependency%20Scanning/Dependency%20Scanning%20Introduction.md) |

***
