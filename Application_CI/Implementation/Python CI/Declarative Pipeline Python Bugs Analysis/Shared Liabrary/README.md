# Shared Library Python Bugs Analysis

<img width="360" length="100" alt="Golang" src="https://github.com/avengers-p7/Documentation/assets/156056413/f94f127a-d207-4c76-bc32-d25e4fe48280"> 

| **Author** | **Created On** | **Last Updated** | **Document Version** |
| ---------- | -------------- | ---------------- | -------------------- |
| **Samir Kesare** | 17-02-2024 | 19-02-2024 | V1 |

***
## Table of Contents
+ [Introduction](#Introduction)
+ [Why Shared Library](#Why-Shared-Library)
+ [Why use src folder structure in a Jenkins shared library](#Why-use-src-folder-structure-in-a-Jenkins-shared-library)
+ [Flow Diagram](#Flow-Diagram)
+ [Prerequisites](#Prerequisites)
+ [Steps to run Pipeline](#Steps-to-run-Pipeline)
+ [Jenkinsfile](#Jenkinsfile)
+ [Shared Library](#Shared-Library)
+ [Conclusion](#Conclusion)
+ [Contact Information](#Contact-Information)
+ [Resources and References](#Resources-and-References)
  
***
## Introduction

A Jenkins Shared Library is a collection of reusable code that facilitates the sharing of common pipeline logic among teams in Jenkins. It simplifies CI/CD processes by abstracting complex tasks into functions, speeding up pipeline development. By keeping shared code separate from individual pipelines, teams ensure consistency and minimize duplication. This fosters collaboration, encourages best practices, and streamlines Jenkins pipeline creation, leading to better software delivery and development workflows.  
About more information [**Click Here**](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/sharedLibrary/README.md)

***
# Why Shared Library
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
# Why use `src` folder structure in a Jenkins shared library

| Benefit                    | Description                                                                                                                                                                    |
|----------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Organizational Structure**  | Placing source files in a `src` folder provides a clear and organized structure for the library, aiding developers in quickly locating files and understanding the layout.      |
| **Isolation of Source Code**  | Keeping source code separate from other files (e.g., documentation, configuration, tests) prevents clutter and confusion, making the codebase easier to manage.                 |
| **Easier Maintenance**        | With a clear structure, maintaining and updating the library becomes straightforward, as developers know where to find specific files and can make changes confidently.     |
| **Build and Packaging**       | Adhering to conventions like using a `src` folder facilitates integration with build tools and package managers, as they often expect a certain directory structure.           |
| **Compatibility with IDEs**   | Standard project structures, such as a `src` folder, improve compatibility with integrated development environments (IDEs), enabling features like code navigation and auto-completion. |
| **Readability and Maintainability** | A well-organized structure enhances readability and maintainability by making it easier for developers to understand the codebase's layout and locate relevant files efficiently. |

***
# Prerequisites

| Tool   | Description                          | Python3 Support | Purpose        |
|--------|--------------------------------------|-----------------|----------------|
| Bandit | A tool for bug analysis in Python   | Yes             | Python App     |
| Jenkins | CICD Tool                          |                 |                 |

***

# Flow Diagram

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056570/97576eeb-fc72-4198-a462-77adfd7056fc)


***

# Steps to run Pipeline

**1. Configure Shared library in Jenkins**
	
Follow below document

[Reference Document](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/sharedLibrary/setup.md)<br><br>


**4. Create and Configure your Jenkins Pipeline job**

Follow below document

[Reference Document](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/pipelinePOC.md)<br><br>



**5. Now Build your Pipeline**

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056570/92e41995-fa4e-49d4-b3db-ae62aa7e4f0a)

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056570/56bcc82c-fea3-41df-9317-6480a0a75e69)


# Console Output:

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056570/ed67ffe9-e8ed-4508-b127-e7ce60d426fd)



***
# Jenkinsfile

  * [**Jenkinsfie**](https://github.com/CodeOps-Hub/Jenkinsfile/blob/main/SharedLibrary/Python/BugsAnalysis/Jenkinsfile)
  

 ```shell
@Library('snaatak-p7') _
def bugsAnalysis = new org.avengers.template.python.PythonBugsAnalysis()

node {
    
    def url = 'https://github.com/CodeOps-Hub/attendance-api.git'
    def creds = '890c8a72-7383-4986-8573-519aacdeb7d2'
    def branch = 'main'
       
    bugsAnalysis.call(url, creds, branch)
    
}
```
# Shared Library

[**pythonbugsanalysis.groovy**](https://github.com/CodeOps-Hub/SharedLibrary/blob/main/src/org/avengers/template/python/PythonBugsAnalysis.groovy)

  ```shell
package  org.avengers.python.BugsAnalysis
def call() {
  stage('Bugs Analysis - Bandit') {
                script {
              
                        // Ensure Bandit is installed and run the analysis
                        sh 'bandit --version' 
                        sh 'bandit -r . -f json -o bandit_report.json'
                    
                    }
                }
            }

```
[**InstallDependencies.groovy**](https://github.com/CodeOps-Hub/SharedLibrary/blob/main/src/org/avengers/python/BugsAnalysis/InstallDependencies.groovy)

 ```shell

package  org.avengers.python.BugsAnalysis
def calll() {
  stage('Install Dependencies') {
    // Install necessary dependencies
    script {
      sh 'python3 -m venv myenv'
      sh '. myenv/bin/activate'
                }
            }
        }

```

[**PythonBugsAnalysis.groovy**](https://github.com/CodeOps-Hub/SharedLibrary/blob/main/src/org/avengers/template/python/PythonBugsAnalysis.groovy)

```shell
package org.avengers.template.python

import org.avengers.common.*
import org.avengers.python.BugsAnalysis.*

def call(String url, String creds, String branch){
  gitCheckoutPrivate = new GitCheckoutPrivate()
  cleanWorkspace = new cleanWorkspace()
  bugsAnalysisBandit = new BugsAnalysisBandit()
  installDependencies = new InstallDependencies()

  gitCheckoutPrivate.call(url, creds, branch)
  cleanWorkspace.call()
  bugsAnalysisBandit.call()
  installDependencies.call()
}
```

***
# Conclusion
The Jenkins Shared Library streamlines CI/CD processes by allowing teams to share reusable code and logic across various pipelines. It standardizes workflows, minimizes duplication, and ensures consistency. With abstracted complex tasks into reusable functions, it simplifies maintenance and fosters collaboration among teams. By promoting best practices and enabling version control, it enhances the efficiency and reliability of the CI/CD process, accessible even without Jenkins admin access.

***

# Contact Information

|    Name                                   | Email Address                    |
|-------------------------------------------|----------------------------------|
| **[Samir Kesare]((https://github.com/Snatak-SamirKesare)** | samir.kesare.snaatak@mygurukulam.co |

***
# Resources and References

|       **Description**                                   |           **References**                    |
|---------------------------------------------------------|-----------------------------------------------|
| Jenkins Pipeline Documentation   | [Link](https://www.jenkins.io/doc/book/pipeline/) |
| Bug Analysis Setup via Shared Library |[Link](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/sharedLibrary/setup.md)|
|Configure your Jenkins Pipeline job|[Link](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/pipelinePOC.md)|
|Configure your Shared Library|[Link](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/sharedLibrary/setup.md)|
