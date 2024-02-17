# Java Dependency Check(Declarative Pipeline)

| Author                                                           | Created on  | Version    | Last Updated by | Last Updated on |
| ---------------------------------------------------------------- | ----------- | ---------- | --------------- | --------------- |
| Vidhi Yadav  | 17th Feb 2024  | 1.0        | Vidhi Yadav   | 17th Feb 2024      |


## Table  of Contents

1. [Introduction](#Introduction)
2. [What is Declarative Pipeline](#What-is-Declarative-Pipeline)
3. [Prerequisites](#Prerequisites)
4. [Flow Diagram](#Flow-Diagram)
5. [Runtime Prerequisites](#Runtime-Prerequisites)
6. [Pipeline Setup](#Pipeline-Setup)
7. [Contact Information](#Contact-Information)
8. [References](#References)
***

## Introduction 
Dependency scanning is a security practice that involves analyzing the dependencies of a software application for known vulnerabilities and security issues. It's particularly crucial in modern software development, where applications often rely on numerous third-party libraries and components that can cause security risk in your application.

**For more information visit the below document link:**

[\[ Reference Doc \]](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Design/03-%20Java%20CI%20checks/Dependency%20Scanning/%20README.md)

In this task, we are using Declarative Pipeline.
***
## What is Declarative Pipeline

Declarative Pipeline in Jenkins offers a simplified and structured approach for defining CI/CD pipelines, using a human-readable syntax with predefined sections like pipeline, stages, and agent. It's designed to be easy to read and maintain, making it suitable for users without strong scripting skills. While it may be less flexible in terms of allowing complex scripting logic, it is a newer and more concise way to define Jenkins pipeline.

**For more information visit the below document link:**

[\[ Reference Doc \]](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/jenkinsPipeline.md )

## Prerequisites

| Tool | Description |
| ---- | ----------- |
| **Jenkins(2.414.3)** | To build our pipeline |

***
## Runtime Prerequisites

|Language / Dependency|Description|
|-------|-------|
| **Maven Plugin** | to enable jenkins to build maven projects |
| **OWASP Dependency-Check Plugin** | for dependency-check configuration on your jenkins server |

***
## Flow Diagram

<img width="1262" alt="Screenshot 2024-02-17 at 5 54 37 PM" src="https://github.com/avengers-p7/Documentation/assets/156056349/70d80186-bae4-4168-a648-2975b6fca9fd">

***
## Pipeline Setup
1. **Fork the Github Repo**
```shell
https://github.com/avengers-p7/Salary-API/tree/main
```
[**Repo Link**](https://github.com/OT-MICROSERVICES/salary-api)

2. **Configure Maven tool in Jenkins**
* Go to `Dashboard--> Manage Jenkins--> Tools` and configure maven tool.

<img width="975" alt="Screenshot 2024-02-17 at 5 19 24 PM" src="https://github.com/avengers-p7/Documentation/assets/156056349/8ffb33b3-b11f-4ec8-a6b4-9764d5aca18c">


3. **Create and Configure your Jenkins Pipeline job**

* Follow below document to integrate Github with Jenkins:

	[Reference Document](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/pipelinePOC.md)

<img width="944" alt="Screenshot 2024-02-17 at 5 16 48 PM" src="https://github.com/avengers-p7/Documentation/assets/156056349/95c45d64-1789-4460-947a-b5328825e98c">


4. **Build Pipeline**

<img width="1256" alt="Screenshot 2024-02-17 at 5 22 36 PM" src="https://github.com/avengers-p7/Documentation/assets/156056349/ce072bee-07c3-4e4c-8ce5-97a0815f82b5">


***
## Console Output
* Resultant output for dependency check generated in all formats

<img width="500" alt="Screenshot 2024-02-17 at 5 51 39 PM" src="https://github.com/avengers-p7/Documentation/assets/156056349/284e2cde-82f7-4d60-8c7d-6eef5adb2458">

* HTML file reports generated as Artifacts

<img width="506" alt="Screenshot 2024-02-17 at 5 32 43 PM" src="https://github.com/avengers-p7/Documentation/assets/156056349/ded92a34-c8d1-482c-a528-3752b188082a">



***
## [Pipeline](https://github.com/avengers-p7/Jenkinsfile/blob/main/Declarative%20Pipeline/Java/Dependency%20Scanning/Jenkinsfile)

```shell
pipeline {
    agent any

    stages {
        stage('Cleanup Workspace') {
            steps {
                // Clean up the workspace
                cleanWs()
            }
        }
        stage('Clone Repository') {
            steps {
                // Clone the repository
                git branch: 'main', url: 'https://github.com/vyadavP7/Salary-API.git'
            }
        }
        stage('Package Artifacts') {
            steps {
                sh 'mvn clean package -DskipTests=true'
            }
        }
        stage('Owasp DP-Check') {
            steps {
                // Run DP-Check
                dependencyCheck additionalArguments: '--scan target/ --format ALL', odcInstallation: 'DP-check'
            }
        }
    }
    post {
        success {
            archiveArtifacts artifacts: '**/dependency-check-report.html'
            sh "ls $WORKSPACE/"
            echo 'DP check Successfull !'
            sh 'tree $WORKSPACE/'
        }
        failure {
            echo 'DP check Failed !'
        }
    }
}
```

***

## Contact Information

|     Name         | Email  |
| -----------------| ------------------------------------ |
| Vidhi Yadav   | vidhi.yadhav.snaatak@mygurukulam.co |
***

## References

| Description                                   | References  
| --------------------------------------------  | -------------------------------------------------|
| Clean Workspace | https://www.jenkins.io/doc/pipeline/tour/running-multiple-steps/#finishing-up |
| Pipeline (Generic Doc) | https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/jenkinsPipeline.md |
| Create Pipeline (Generic Doc)| https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/pipelinePOC.md |
| Pipeine Syntax | https://www.jenkins.io/doc/book/pipeline/#pipeline-syntax-overview |


