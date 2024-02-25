# Shared Library for Python DAST

| **Author** | **Created On** | **Last Updated** | **Document Version** |
| ---------- | -------------- | ---------------- | -------------------- |
| **Shantanu** | 23-02-2024 | 24-02-2024 | V1 |
***

# Table of Content

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

# Introduction
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

| Tool | Description |
| ---- | ----------- |
| **Jenkins (2.426.3)** | Enables Continuous Integration |
| **Java 17** | Required for compiling Jenkins and Spring Boot projects |
| **OWASP ZAP** | Facilitates DAST |
***

# Flow Diagram

![Screenshot 2024-02-25 at 11 40 04 PM](https://github.com/CodeOps-Hub/Documentation/assets/156056364/744267d2-fbd6-4ece-890d-bc86cae15caa)

***

# Steps to run Pipeline

**Configure Shared library in Jenkins**

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056364/9d5dbd3a-34be-4508-b4e3-3d02f8ea4c41)

[Reference Doc](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/sharedLibrary/setup.md)



**Now Build your Pipeline**

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056364/ada93ec0-4ac2-48f6-a6ff-1c8c12e3193e)

***
# Console Output

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056364/5eb61244-26ef-4e67-9145-9da2e861e3df)

[Report](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/Python%20CI/DAST/DeclarativePipeline/out2.html)
***

# Jenkinsfile
```
@Library('snaatak-p7') _
def dast = new org.avengers.template.python.PythonDast()


node {
    
    def url = 'https://github.com/OT-MICROSERVICES/attendance-api.git'
    def creds = '890c8a72-7383-4986-8573-519aacdeb7d2'
    def branch = 'main'
    def zapVersion = '2.14.0'
    
    dast.call(url, creds, branch, zapVersion)
    
}
```
***

# Shared Library

### OwaspZapInstallation.groovy

```
package org.avengers.python.dast
def call(String zapVersion) {
  stage('Install ZAP') {
    script {
         // Download and install OWASP ZAP
          sh "wget https://github.com/zaproxy/zaproxy/releases/download/v${zapVersion}/ZAP_${zapVersion}_Linux.tar.gz"
          sh "tar -xvf ZAP_${zapVersion}_Linux.tar.gz"
                    
                }
            }
        }
```
### testing.groovy

```
package org.avengers.python.unitTesting

def call() {
    stage('Unit Test') {
        script {
            sh '. myenv/bin/activate'
            sh 'pytest router/tests/test_cache.py'
        }
    }
}
```

### RunZap.groovy
```
package org.avengers.python.dast
def call(String zapVersion) {
stage('Run ZAP Scan') {
            script {
                 // Start ZAP and perform the scan
                  sh "/var/lib/jenkins/workspace/'DAST_declarative'/ZAP_${zapVersion}/zap.sh -cmd -port 8090 -quickurl http://34.100.232.65:8080/api/v1/attendance/health -quickprogress -quickout out2.html"
                }
            }
        }
```
***
# Conclusion

The Jenkins Shared Library streamlines CI/CD processes by allowing teams to share reusable code and logic across various pipelines.
It standardizes workflows, minimizes duplication, and ensures consistency. With abstracted complex tasks into reusable functions, it simplifies maintenance and fosters collaboration among teams. 
By promoting best practices and enabling version control, it enhances the efficiency and reliability of the CI/CD process, accessible even without Jenkins admin access.
***

#  Contact Information
| Name | Email Address |
| ---- | ------------- |
| Shantanu  | shantanu.chauhan.snaatak@mygurukulam.co |
***
# References
| Source | Description  | 
| -------- | ------- |
| https://medium.com/globant/owasp-zap-integration-with-jenkins-795d65991404 | OWASP ZAP Integration with jenkins |
