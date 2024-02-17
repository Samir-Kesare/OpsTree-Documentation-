# Java Dependency Check(Scripted Pipeline)

| Author                                                           | Created on  | Version    | Last Updated by | Last Updated on |
| ---------------------------------------------------------------- | ----------- | ---------- | --------------- | --------------- |
| Vidhi Yadav  | 17th Feb 2024  | 1.0        | Vidhi Yadav   | 17th Feb 2024      |


## Table  of Contents

1. [Introduction](#Introduction)
2. [What is Scripted Pipeline](#What-is-Declarative-Pipeline)
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

[\[ Reference Doc \]](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Design/03-%20Java%20CI%20checks/Dependency%20Scanning/%20README.md)

In this task, we are using Scripted Pipeline.
***
## Scripted Pipeline

**For more information visit the below document link:**

[\[ Reference Doc \]](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GenericDoc/jenkinsPipeline.md)

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

<img width="875" alt="Screenshot 2024-02-17 at 7 05 45 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/fe5c6164-ff6f-4265-b3d1-0e03da74d47f">

* HTML file reports generated as Artifacts

<img width="1000" alt="Screenshot 2024-02-17 at 7 17 18 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/ebecf8f6-3338-4bf0-954e-f7d3cc6ec43a">



***
## [Pipeline](https://github.com/CodeOps-Hub/Jenkinsfile/blob/main/Scripted%20Pipeline/Java/DependencyScanning/Jenkinsfile)

```shell
node {
    try {
        stage('Cleanup Workspace') {
            cleanWs()
        }

        stage('Clone Repository') {
            git branch: 'main', url: 'https://github.com/vyadavP7/Salary-API.git'
        }

        stage('Package Artifacts') {
            sh 'mvn clean package -DskipTests=true'
        }

        stage('Owasp DP-Check') {
            dependencyCheck additionalArguments: '--scan target/ --format ALL', odcInstallation: 'DP-check'
        }
    } catch (Exception e) {
        echo 'DP check Failed !'
    } finally {
        archiveArtifacts artifacts: '**/dependency-check-report.html'
        sh "ls ${WORKSPACE}"
        echo 'DP check Successful !'

        sh 'tree ${WORKSPACE}'
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



