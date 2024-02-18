# Shared Library for JAVA Bug Analysis

| **Author** | **Created On** | **Last Updated** | **Document Version** |
| ---------- | -------------- | ---------------- | -------------------- |
| **Parasharam Desai** | 16-02-2024 | 16-02-2024 | V1 |

***
# Table of Contents
+ [Introduction](#introduction)
+ [Why Shared Library](#why-shared-library)
+ [Why use src folder structure in a Jenkins shared library](#why-use-src-folder-structure-in-a-jenkins-shared-library)
+ [Flow Diagram](#flow-diagram)
+ [Pre-requisites](#pre-requisites)
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
# Prerequisites

| **Jenkins (2.426.3)** | Enables Continuous Integration |
| ---------------- | -------------------- |
| **Java 17** | Required for compiling Jenkins and Spring Boot projects |
| **Maven(3.6.9)** | Handles build automation and dependency management |
| **Spotbug (4.8.1)** | Employed for bug analysis |
***

# Flow Diagram

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056709/1530fff8-2637-4f14-b1a1-3af04738e1fc)


***

# Steps to run Pipeline

**1. Including Spotbugs Plugin in pom.xml**

To include the Spotbugs plugin in the `pom.xml` file, follow these steps:

* Add the Spotbugs-maven-plugin within the reporting section.
* Ensure that running `mvn site` will generate the Spot Bugs report.

For detailed instructions, please refer to the [Proof of Concept (POC) documentation](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Design/03-%20Java%20CI%20checks/Bug%20Analysis/POC.md).

**2. Configure Maven tool in Jenkins**

Go to `Dashboard--> Manage Jenkins--> Tools` and configure maven tool.

![image](https://github.com/avengers-p7/Documentation/assets/156056444/d9ff8a0d-900a-4e4b-ac68-34507ef3348b)



**3. Configure Shared library in Jenkins**
	
 	Follow below document

	[Reference Document](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/sharedLibrary/setup.md)<br><br>

**4. Create and Configure your Jenkins Pipeline job**

	Follow below document

	[Reference Document](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/pipelinePOC.md)<br><br>
![Screenshot from 2024-02-16 22-05-03](https://github.com/CodeOps-Hub/Documentation/assets/156056709/223fe9e6-be98-4ba6-bb94-9dd829682739)


**5. Now Build your Pipeline**

![Screenshot from 2024-02-16 22-24-40](https://github.com/CodeOps-Hub/Documentation/assets/156056709/e5391960-ff4c-4f6e-9274-b4ff2321da90)

# Console Output:

Based on the console output provided below, we can infer that there are a few bugs present

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056709/be56255c-ccd9-4c8a-b6c3-aa69a638e643)

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056709/e5ebe3b1-04c0-4533-863c-26316979dfa1)



***

# HTML Report

 * Cilck [**here**](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Design/03-%20Java%20CI%20checks/spotbugHtmlReports/spotbugs.html)

***
# Jenkinsfile

  * [**Jenkinsfie**](https://github.com/CodeOps-Hub/Jenkinsfile/blob/main/SharedLibrary/Java/BugAnalysis/Jenkinsfile)

 ```shell
@Library("my-shared-library") _

def javaBugAnalysis = new org.avengers.template.java.javaBugAnalysis()

node {
    
    def url = 'https://github.com/Parasharam-Desai/salary-api.git'
    def branch = 'main'
    
    javaBugAnalysis.call(branch: branch,url: url)
    
}
        
```
# Shared Library

[**gitCheckout.groovy**](https://github.com/CodeOps-Hub/SharedLibrary/blob/main/vars/gitCheckout.groovy)

  ```shell
// Checkout Github Public Repository
def call(Map config = [:]) {
            checkout scm: [
                $class: 'GitSCM',
                branches: [[name: config.branch]],
                userRemoteConfigs: [[url: config.url]]
            ]
}

```
[**bug.groovy**](https://github.com/CodeOps-Hub/SharedLibrary/blob/main/src/org/avengers/java/bugAnalysis/bug.groovy)

 ```shell

package org.avengers.java.bugAnalysis

def call(){           
        stage("Bug Analysis ") {
                script {
                    sh 'mvn compile'
                    sh 'mvn spotbugs:spotbugs'
                    sh 'mvn site'
                }
        }
}

```

[**publishHtml.groovy**](https://github.com/CodeOps-Hub/SharedLibrary/blob/main/src/org/avengers/java/bugAnalysis/publishHtml.groovy)

 ```shell

package org.avengers.java.bugAnalysis

def call() {
          stage('Publish HTML Report') {
                      publishHTML([
                          allowMissing: false,
                          alwaysLinkToLastBuild: true,
                          keepAll: true,
                          reportDir: 'target/site',
                          reportFiles: 'spotbugs.html',
                          reportName: 'SpotBugs Report'
                      ])
                  }
              }
```
[**javaBugAnalysis.groovy**](https://github.com/CodeOps-Hub/SharedLibrary/blob/main/src/org/avengers/template/java/javaBugAnalysis.groovy)

```shell
package org.avengers.template.java

import org.avengers.common.gitCheckout
import org.avengers.common.cleanWorkspace
import org.avengers.java.bugAnalysis.*

def call(Map config = [:]){
    def gitCheckout = new gitCheckout()
    def javaBugAnalysis = new bug()
    def javaPublishHtml = new publishHtml()
    def cleanWorkspace = new cleanWorkspace()

    gitCheckout.call(branch: config.branch, url: config.url  )
    javaBugAnalysis.call()
    javaPublishHtml.call()
    cleanWorkspace.call()
  
}
```
***
# Conclusion
The Jenkins Shared Library streamlines CI/CD processes by allowing teams to share reusable code and logic across various pipelines. It standardizes workflows, minimizes duplication, and ensures consistency. With abstracted complex tasks into reusable functions, it simplifies maintenance and fosters collaboration among teams. By promoting best practices and enabling version control, it enhances the efficiency and reliability of the CI/CD process, accessible even without Jenkins admin access.

***
# Contact Information

|    Name                                   | Email Address                    |
|-------------------------------------------|----------------------------------|
| **[Parasharam Desai](https://github.com/Parasharam-Desai)** | parasharam.desai.snaatak@mygurukulam.co |

***
# Resources and References

|       **Description**                                   |           **References**                    |
|---------------------------------------------------------|-----------------------------------------------|
| Jenkins Pipeline     | [Jenkins Pipeline Documentation](https://www.jenkins.io/doc/book/pipeline/) |
| Bug Analysis Setup via Shared Library* |[Link](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/sharedLibrary/setup.md)|
| Bug Analysis POC |[Link ](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Design/03-%20Java%20CI%20checks/Bug%20Analysis/POC.md)|
|Configure your Jenkins Pipeline job|[Link](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/pipelinePOC.md)|
