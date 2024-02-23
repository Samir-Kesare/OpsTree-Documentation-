# Shared Library for Python Unit Testing

| **Author** | **Created On** | **Last Updated** | **Document Version** |
| ---------- | -------------- | ---------------- | -------------------- |
| **Shantanu** | 23-02-2024 | 23-02-2024 | V1 |
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
| **Pytest** | Facilitates Unit testing |
***

# Flow Diagram

![Screenshot 2024-02-23 at 6 06 52 PM](https://github.com/CodeOps-Hub/Documentation/assets/156056364/31336ab8-1f30-40b0-bc41-63c71e018011)
***

# Steps to run Pipeline

**1. Including Requirements in requirements.txt**

* Add dependency to the reuirements.txt file. Refer to the documentation [PythonUnit Testing]([https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Design/03-%20Java%20CI%20checks/Unit%20Testing/POC.md](https://github.com/CodeOps-Hub/Documentation/tree/main/Application_CI/Implementation/Python%20CI/UnitTesting/DeclarativePipeline)).

**2. Configure Shared library in Jenkins**
	
Follow below document

[Reference Document](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/sharedLibrary/setup.md)<br><br>


**3. Create and Configure your Jenkins Pipeline job**

Follow below document

[Reference Document](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/pipelinePOC.md)<br><br>

**4. Now Build your Pipeline**

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056364/d2fd5064-d5f9-4599-aac1-f0a098f220c0)

***
# Console Output

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056364/39af50b0-2af3-4915-a2c1-c6beb3c8071a)
***

# Jenkinsfile
```
@Library("unitTesting-python-library") _

def unitTesting = new org.avengers.template.python.unitTesting()

node {
    
    def url = 'https://github.com/CodeOps-Hub/Attendance-API.git'
    def branch = 'main'
    
    unitTesting.call(branch: branch,url: url)
    
}
```
***

# Shared Library

### installDependency.groovy

```
// installDependency.groovy
package org.avengers.python.unitTesting

def call() {
    stage('Install Dependencies') {
        script {
            sh 'pip install -r requirements.txt'
            sh 'pip install pytest pytest-html'
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

### virtENV.groovy
```
package org.avengers.python.unitTesting

def call() {           
    stage('Create Virtual ENV') {
        script {
            sh 'python3 -m venv myenv'
            sh '. myenv/bin/activate'
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

# # Contact Information
| Name | Email Address |
| ---- | ------------- |
| Shantanu  | shantanu.chauhan.snaatak@mygurukulam.co |
***
# References
| Source | Description  | 
| -------- | ------- |
| https://realpython.com/pytest-python-testing/ | Pytest |
| https://skamalakannan.dev/posts/jenkins-pipeline-python/ | Jenkin pipeline with python |
| https://www.jenkins.io/doc/book/pipeline/ | Jenkins pipeline |
