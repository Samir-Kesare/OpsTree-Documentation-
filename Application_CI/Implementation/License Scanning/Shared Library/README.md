# Shared Library : License Scanning

  

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
+ [Setup of License Scanning](#Setup-of-License-Scanning-Via-Shared-Library)
+ [Report](#Report)
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
![Screenshot 2024-02-19 171556](https://github.com/CodeOps-Hub/Documentation/assets/156056344/74a9d1f8-aee4-4c1f-9e93-797045f68d6a)



***
## Pre-requisites
| **Pre-requisites** | **Version** |
| ------------------ | ----------- |
| Jenkins | 2.426.3 | 
| FOSSA CLI | 3.9.5 |

 

***
## Setup of License Scanning Via Shared Library
* Follow this document for Setup [**Cilck here**](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/sharedLibrary/setup.md)

  ![Screenshot 2024-02-19 165417](https://github.com/CodeOps-Hub/Documentation/assets/156056344/41680948-a8f7-4cb5-854e-79be309aee63)

* Build
  
 ![Screenshot 2024-02-19 174751](https://github.com/CodeOps-Hub/Documentation/assets/156056344/0baf48db-dc07-47bc-b9bc-529b261b7885)


* Console Output:

 ![Screenshot 2024-02-19 174735](https://github.com/CodeOps-Hub/Documentation/assets/156056344/97671a20-c24c-4b8f-a8f0-91fb869ad51b)



> [!NOTE]
> **Changes**
> *  **Pipeline name**       **-**  `License Scanning via Shared Library`
> *  **Jenkinsfile Path**    **-**  `SharedLibrary/License_Scan/Jenkinsfile`  
![Screenshot 2024-02-19 174826](https://github.com/CodeOps-Hub/Documentation/assets/156056344/8614679e-e9eb-441e-9b1a-6dd5feef0f68)


***

## Report
 * Cilck [**here**](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/License%20Scanning/Shared%20Library/project-attribution-custom%2B42731_github.com_OT-MICROSERVICES_salary-api%2479356799a4e74ff24c7bda42371bbece4f35d4d7-1708344219859.csv)

The report is available at fossa website. A live link of the report can also be created. 
![Screenshot 2024-02-19 174223](https://github.com/CodeOps-Hub/Documentation/assets/156056344/f642a24a-595b-46b1-adfc-820fc550f6f5)

 
***
## Jenkinsfile
  * [**Jenkinsfie**](https://github.com/CodeOps-Hub/Jenkinsfile/blob/main/SharedLibrary/License_Scan/Jenkinsfile)
  ```shell
@Library("my-shared-library") _

def licenseScan  = new org.avengers.template.genericCi.LicenseScan()

node {
    
    def url = 'https://github.com/OT-MICROSERVICES/employee-api.git'
    def branch = 'main'
   withCredentials([string(credentialsId: 'fossaToken', variable: 'FOSSA_API_KEY')]){
   licenseScan.call(branch: branch,url: url)
   }
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
  * [**CleanWorkSpace.groovy**]()
  ```shell
package org.avengers.common
// Always Clean 
def call(){
  stage('Clean Workspace') {
        script {
           cleanWs()
        }
    }
  
}
```
  * [**Fossa.groovy**](https://github.com/CodeOps-Hub/SharedLibrary/blob/main/src/org/avengers/licenseScanning/Fossa.groovy)
  ```shell
package org.avengers.licenseScanning

def call() {
    stage('Download and Install FOSSA') {
        script {           
            sh 'curl -H \'Cache-Control: no-cache\' https://raw.githubusercontent.com/fossas/fossa-cli/master/install-latest.sh | bash'
        }
    }
}
```
  * [**Scan.groovy**](https://github.com/CodeOps-Hub/SharedLibrary/blob/main/src/org/avengers/licenseScanning/Scan.groovy)
  ```shell
package org.avengers.licenseScanning

def call() {
    stage('FOSSA Analyze & Test') {
        script {
            sh 'fossa analyze'
            sh 'fossa test'
        }
    }
}
```

  * [**LicenseScan.groovy**](https://github.com/CodeOps-Hub/SharedLibrary/blob/main/src/org/avengers/template/genericCi/LicenseScan.groovy)
  ```shell
package org.avengers.template.genericCi

import org.avengers.common.*
import org.avengers.licenseScanning.*

def call(Map config = [:]){
  gitClone = new gitCheckout()
  fossa = new Fossa()
  scan = new Scan()
  cleanworkspace = new CleanWorkSpace()

  try {
    gitClone.call(branch: config.branch, url: config.url  )
    fossa.call()
    scan.call()
    } catch (Exception e) {
        echo "Check your code for License Issues: ${e.message}"
    } finally {
       cleanworkspace.call() 
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
| Jenkinsfile | [Link](https://github.com/CodeOps-Hub/Jenkinsfile/blob/main/SharedLibrary/License_Scan/Jenkinsfile) |
| Manual Setup | [Link](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Design/02-%20Generic%20CI%20operation/License%20Scanning/License%20Scanning%20via%20FOSSA%20POC.md) |
| Manual Pipeline | [Declarative](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/License%20Scanning/Declarative%20Pipeline/README.md) & [Scripted](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/License%20Scanning/Scripted%20Pipeline/README.md) |
| License Scanning | [Link](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Design/02-%20Generic%20CI%20operation/License%20Scanning/README.md) |

***


