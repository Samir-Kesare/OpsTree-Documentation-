
# Python Static Code Analysis(Shared Library)

![image](https://github.com/CodeOps-Hub/Documentation/assets/79625874/9b34c66c-1ce1-4791-adfd-7fd8fcc21c45)



| Author        | Created on  | Version    | Last Updated by | Last Updated on |
| --------------| ----------- | ---------- | --------------- | --------------- |
| Vikram Bisht  | 17-02-2024  | 1.0        | Vikram Bisht    | 17-02-2024      |


***
# Table of Contents
+ [Introduction](#introduction)
+ [Why Shared Library](#why-shared-library)
+ [Why use src folder structure in a Jenkins shared library](#why-use-src-folder-structure-in-a-jenkins-shared-library)
+ [Flow Diagram](#flow-diagram)
+ [Pre-requisites](#pre-requisites)
+ [Runtime Pre-requisites](#pre-requisites)
+ [Steps to run Pipeline](#steps-to-run-pipeline)
+ [HTML Report](#html-report)
+ [Jenkinsfile](#jenkinsfile)
+ [Shared Library](#shared-library)
+ [Conclusion](#conclusion)
+ [Contact Information](#contact-information)
+ [Resources and References](#resources-and-references)

  
***
# Introduction

 <img width="360" length="100" alt="Golang" src="https://github.com/avengers-p7/Documentation/assets/156056413/f94f127a-d207-4c76-bc32-d25e4fe48280"> 

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

## Pre-requisites

| Tool | Description |
| ---- | ----------- |
| Jenkins(2.426.3) | To build our pipeline |


## Runtime Pre-requisites

|Language / Dependency|Description            |
|---------------------|-----------------------|
| python3             | latest version        |
| pylint              | It will help to do Static code analysis on python code   |

***
## Flow Diagram
![image](https://github.com/CodeOps-Hub/Documentation/assets/79625874/052a2f75-39c6-4c61-9d9b-6291a6626b08)

***
# Steps to run Pipeline


**1. Configure Shared library in Jenkins**

![image](https://github.com/CodeOps-Hub/Documentation/assets/79625874/302c7a21-a964-494d-b8ba-6aa1bec399f9)
	
Follow below document

[Reference Document](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/sharedLibrary/setup.md)<br><br>

**2. Create and Configure your Jenkins Pipeline job**

Follow below document

[Reference Document](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/pipelinePOC.md)<br><br>
![image](https://github.com/CodeOps-Hub/Documentation/assets/79625874/a802e7f1-4b54-430c-90a0-f47cce0906ce)


**3. Now Build your Pipeline**

![image](https://github.com/CodeOps-Hub/Documentation/assets/79625874/f94a20c2-d0d5-4a30-9eb6-bb35a872873a)

# Console Output:

Based on the console output provided below, we can see our pipeline has given us code snalysis report

![image](https://github.com/CodeOps-Hub/Documentation/assets/79625874/07ef4108-0690-4313-aaa0-4d00b3c32e0a)




***

# HTML Report

 * Cilck [**here**](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/Python%20CI/Static%20Code%20Analysis/Scripted%20Pipeline/pylint.log)

***
# Jenkinsfile

  * [**Jenkinsfie**](https://github.com/CodeOps-Hub/Jenkinsfile/blob/main/SharedLibrary/Python/StaticCodeAnalysis/Jenkinsfile)

 ```shell
@Library('snaatak-p7') _
def codeAnalysis = new org.avengers.template.python.PythonStaticCodeAnalysis()

node {
    
    def url = 'https://github.com/CodeOps-Hub/attendance-api.git'
    def creds = 'Attendance-creds'
    def branch = 'main'
       
    codeAnalysis.call(url, creds, branch)
    
}
        
```
# Shared Library

[**GitCheckoutPrivate.groovy**](https://github.com/CodeOps-Hub/SharedLibrary/blob/main/src/org/avengers/common/GitCheckoutPrivate.groovy)

  ```shell
package org.avengers.common

def call(String url, String creds, String branch) {
    stage('Clone') {
        script {
            git branch: "${branch}", credentialsId: "${creds}", url: "${url}"
        }
    }
}

```
[**virtualEnv.groovy**](https://github.com/CodeOps-Hub/SharedLibrary/blob/main/src/org/avengers/python/staticCodeAnalysis/virtualEnv.groovy)

 ```shell

package org.avengers.python.staticCodeAnalysis

def call() {
stage('Create Virtual ENV') {
                    script {
                    sh 'python3 -m venv myenv'
                    sh '. myenv/bin/activate'
                }
            }
          }
        

```

[**staticCodeAnalysis.groovy**](https://github.com/CodeOpsHub/SharedLibrary/blob/main/src/org/avengers/python/staticCodeAnalysis/staticCodeAnalysis.groovy)

 ```shell

package org.avengers.python.staticCodeAnalysis

def call() {
stage('Static Code Analysis') {
            
                script {
                    sh 'pylint router/ client/ models/ utils/ app.py | tee pylint.log'
                }
            }
        }
    
```
[**PythonStaticCodeAnalysis.groovy**](https://github.com/CodeOps-Hub/SharedLibrary/blob/main/src/org/avengers/template/python/PythonStaticCodeAnalysis.groovy)

```shell
package org.avengers.template.python

import org.avengers.common.*
import org.avengers.python.staticCodeAnalysis.*

def call(String url, String creds, String branch) {
  
    gitCheckoutPrivate = new GitCheckoutPrivate()
    virtual = new virtualEnv()
    dep = new dependencies()
    code = new staticCodeAnalysis()
    arch = new ArchiveArtifacts() 
  
    
  
  try {
    gitCheckoutPrivate.call(url, creds, branch)
    virtual.call()
    dep.call()
    code.call()
    } catch (Exception e) {
        // Handle any exceptions during static code analysis
        echo "An error occurred during static code analysis: ${e.message}"
    } finally {
        arch.call()
    }
  
}
```
***
# Conclusion
The Jenkins Shared Library streamlines CI/CD processes by allowing teams to share reusable code and logic across various pipelines. It standardizes workflows, minimizes duplication, and ensures consistency. With abstracted complex tasks into reusable functions, it simplifies maintenance and fosters collaboration among teams. By promoting best practices and enabling version control, it enhances the efficiency and reliability of the CI/CD process, accessible even without Jenkins admin access.

***
# Contact Information

|    Name                                   | Email Address                    |
|-------------------------------------------|----------------------------------|
| **[Vikram Bisht](https://github.com/vikram445)** | Vikram.bisht@opstree.com |

***
# Resources and References

|       **Description**                                   |           **References**                    |
|---------------------------------------------------------|-----------------------------------------------|
| Jenkins Pipeline     | [Link](https://www.jenkins.io/doc/book/pipeline/) |
|Configure your Jenkins Pipeline job|[Link](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/pipelinePOC.md)|
| Jenkins File     | [Link](https://github.com/CodeOps-Hub/Jenkinsfile/blob/main/SharedLibrary/Python/StaticCodeAnalysis/Jenkinsfile) |
| Static Code Analysis |  [Link](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Design/04-%20Python%20CI%20Checks/Python%20Static%20Code%20POC%20.md) |
