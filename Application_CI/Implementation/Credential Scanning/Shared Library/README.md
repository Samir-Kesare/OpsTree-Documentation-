# Shared Library : Credential Scanning

  

|   Author        |  Created on   |  Version   | Last updated by  | Last edited on |
| --------------- | --------------| -----------|----------------- | -------------- |
| Aakash Tripathi |  18-02-2024  |  Version 1 | Aakash  | 19-02-2024    |

***
## Table of Contents
+ [Introduction](#Introduction)
+ [Why Shared Library](#Why-Shared-Library)
+ [Why use src folder structure in a Jenkins shared library](#Why-use-src-folder-structure-in-a-Jenkins-shared-library)
+ [Flow Diagram](#Flow-Diagram)
+ [Pre-requisites](#Pre-requisites)
+ [Setup of Credential Scanning](#Setup-of-Credential-Scanning-Via-Shared-Library)
+ [JSON Report](#JSON-Report)
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
![image](https://github.com/CodeOps-Hub/Documentation/assets/156056344/5e78b5ce-9716-441d-98d8-262d8aa27dac)


***
## Pre-requisites
| **Pre-requisites** | **Version** |
| ------------------ | ----------- |
| Jenkins | 2.426.3 | 
| GitLeaks | 9.18.2 |

 

***
## Setup of Credential Scanning Via Shared Library
* Follow this document for Setup [**Cilck here**](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/sharedLibrary/setup.md)

  ![Screenshot 2024-02-19 165417](https://github.com/CodeOps-Hub/Documentation/assets/156056344/41680948-a8f7-4cb5-854e-79be309aee63)

* Build
  
  ![Screenshot 2024-02-19 165258](https://github.com/CodeOps-Hub/Documentation/assets/156056344/9422562c-40a2-4ea8-963d-400502a00b0a)

* Console Output:

 ![Screenshot 2024-02-19 165317](https://github.com/CodeOps-Hub/Documentation/assets/156056344/b376763a-e72b-4151-912c-27d0c489520c)



> [!NOTE]
> **Changes**
> *  **Pipeline name**       **-**  `Credential Scanning via Shared Library`
> *  **Jenkinsfile Path**    **-**  `SharedLibrary/Cred_Scanning/Jenkinsfile`  
![Screenshot 2024-02-19 165435](https://github.com/CodeOps-Hub/Documentation/assets/156056344/59ad509b-4b93-4a9c-85a7-c7e720e52b18)

***

## JSON Report
 * Cilck [**here**](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/Python%20CI/Dependency_Scanning/Shared_Library/Report.html)

***
## Jenkinsfile
  * [**Jenkinsfie**](https://github.com/CodeOps-Hub/Jenkinsfile/blob/main/SharedLibrary/Cred_Scanning/Jenkinsfile)
  ```shell

@Library("my-shared-library") _

def credScan  = new org.avengers.template.genericCi.CredScan()

node {
    
    def url = 'https://github.com/OT-MICROSERVICES/salary-api.git'
    def branch = 'main'
    def gitLeaksVersion = '8.18.2'
    def reportName = 'credScanReport.json'
    
   credScan.call(branch: branch,url: url, gitLeaksVersion, reportName)
    
}
```
## Shared Library
   * [**gitCheckout.groovy**](https://github.com/avengers-p7/SharedLibrary/blob/main/src/org/avengers/common/gitCheckout.groovy)
  ```shell
// Checkout Github Public Repository
package org.avengers.common

def call(Map config = [:]) {
    stage('GIT Checkout') {
        checkout scm: [
                $class: 'GitSCM',
                branches: [[name: config.branch]],
                userRemoteConfigs: [[url: config.url]]
            ]
    }
}
```
  * [**CleanAfterArchive.groovy**](https://github.com/avengers-p7/SharedLibrary/blob/main/src/org/avengers/common/CleanAfterArchive.groovy)
  ```shell
package org.avengers.common

def call(String reportName){
  stage('Archive and Clean Workspace') {
        script {
           archiveArtifacts artifacts: "**/${reportName}"
           cleanWs()
        }
    }
  
}
```
  * [**Gitleaks.groovy**](https://github.com/CodeOps-Hub/SharedLibrary/blob/main/src/org/avengers/credScanning/GitLeaks.groovy)
  ```shell
package org.avengers.credScanning

def call(String gitLeaksVersion){
  stage('Download and Install Gitleaks') {
        script {
           sh "wget https://github.com/gitleaks/gitleaks/releases/download/v${gitLeaksVersion}/gitleaks_${gitLeaksVersion}_linux_x64.tar.gz"
                  // Extract Gitleaks
            sh "tar xvzf gitleaks_${gitLeaksVersion}_linux_x64.tar.gz"
        }
    }
  
}
```
  * [**Scan.groovy**](https://github.com/CodeOps-Hub/SharedLibrary/blob/main/src/org/avengers/credScanning/Scan.groovy)
  ```shell
package org.avengers.credScanning

def call(String reportName){
  stage('Gitleaks Scan') {
        script {
           sh "./gitleaks detect -r ${reportName}"
        }
    }
  
}
```

  * [**CredScan.groovy**](https://github.com/CodeOps-Hub/SharedLibrary/blob/main/src/org/avengers/template/genericCi/CredScan.groovy)
  ```shell
package org.avengers.template.genericCi

import org.avengers.common.*
import org.avengers.credScanning.*

def call(Map config = [:], String gitLeaksVersion, String reportName){
  gitClone = new gitCheckout()
  gitLeaks = new GitLeaks()
  scan = new Scan()
  cleanAfterArchive = new CleanAfterArchive()

  try {
    gitClone.call(branch: config.branch, url: config.url  )
    gitLeaks.call(gitLeaksVersion)
    scan.call(reportName)
    } catch (Exception e) {
        echo "Check your code for credential Leak: ${e.message}"
    } finally {
       cleanAfterArchive.call(reportName) 
    }
  
}
  
```

***
## Conclusion
The Jenkins Shared Library streamlines CI/CD processes by allowing teams to share reusable code and logic across various pipelines. It standardizes workflows, minimizes duplication, and ensures consistency. With abstracted complex tasks into reusable functions, it simplifies maintenance and fosters collaboration among teams. By promoting best practices and enabling version control, it enhances the efficiency and reliability of the CI/CD process, accessible even without Jenkins admin access.

***
## Contact Information
| Name | Email address |
| ---- | ------------- |
| Aakash Tripathi | aakash.tripathi.snaatak@mygurukulam.co |
***
## Resources and References
|  **Description** |   **Source** |
| ---------------- | ------------ |
| About Jenkins Shared Library (Generic Document) | [Link](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/sharedLibrary/README.md) |
| POC Generic Document | [Link](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/sharedLibrary/setup.md) |
| Jenkinsfile | [Link](https://github.com/avengers-p7/Jenkinsfile/blob/main/SharedLibrary/Python/DependencySacnning/Jenkinsfile) |
| Manual Setup | [Link](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Design/04-%20Python%20CI%20Checks/Dependency%20Scanning/Dependency%20scanning(Python%20CI%20Checks).md) |
| Manual Pipeline | [Declarative](https://github.com/avengers-p7/Documentation/tree/main/Application_CI/Implementation/Python%20CI/Dependency_Scanning/Declarative_Pipeline) & [Scripted](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/Python%20CI/Dependency_Scanning/Scripted_Pipeline/Readme.md) |
| Credential Scanning | [Link](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Design/04-%20Python%20CI%20Checks/Dependency%20Scanning/Dependency%20Scanning%20Introduction.md) |

***

