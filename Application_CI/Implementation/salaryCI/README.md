# Slary API CI (Shared Library)
![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/dc808906-6fa5-4307-b472-e13fbed8560d)

| Author                                                           | Created on  | Version    | Last Updated by | Last Updated on |
| ---------------------------------------------------------------- | ----------- | ---------- | --------------- | --------------- |
| **[Harshit Singh](https://github.com/Panu-S-Harshit-Ninja-07)**  | 21-02-2024  | 1.0        | Harshit Singh   | 21-02-2024      |


## Table  of Contents

1. [Introduction](#Introduction)
2. [What is Shared Library](#What-is-Shared-Library)
3. [Prerequisites](#Prerequisites)
4. [Runtime Prerequisites](#Runtime-Prerequisites)
5. [Flow Diagram](#Flow-Diagram)
6. [Pipeline Setup](#Pipeline-Setup)
7. [Results](#results)
8. [Pipeline](#pipeline)
9. [Shared Library](#Shared-Library)
10. [Contact Information](#Contact-Information)
11. [References](#References)
***

## Introduction 

Continuous Integration (CI) is a development practice where developers integrate code into a shared repository frequently, preferably several times a day. Each integration can then be verified by an automated build and automated tests. While automated testing is not strictly part of CI it is typically implied. 

**For more information about CI checks performed in Salary API, use the following directory link:**

[\[ Reference Directory \]](https://github.com/CodeOps-Hub/Documentation/tree/main/Application_CI/Implementation/Java%20CI)

In this task, we are using Shared Library to perform CI on Salary API.
***
## What is Shared Library?

A shared library in Jenkins is a reusable collection of Groovy scripts that can be used by multiple Jenkins jobs. This allows you to share code and functionality between different jobs, which can make your builds more efficient and easier to maintain.
### Why
To understand the concept of shared libraries, let’s consider a real-time example. Imagine you have multiple Jenkins pipelines that require a common set of functions for interacting with a version control system, such as Git. Instead of duplicating the Git-related code in each pipeline, you can create a shared library that encapsulates the necessary Git operations.

![image](https://github.com/avengers-p7/Documentation/assets/156056444/f99a6591-da1b-42f4-a13c-8c4bb1bb947c)

**For more information visit the below document link:**

[\[ Reference Doc \]](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/sharedLibrary/README.md)

## Prerequisites

| Tool | Description |
| ---- | ----------- |
| **Jenkins(2.426.3)** | To build our pipeline |
|**Sonarqube(9.6.1.59531)**| for [Static code analysis](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Design/07-%20Sonarqube/README.md) |
| **FOSSA CLI(3.9.5)** | for [Licence Scanning](https://github.com/CodeOps-Hub/Documentation/tree/main/Application_CI/Implementation/License%20Scanning/Shared%20Library) |
| **GitLeaks(9.18.2)** | for [Credential Scanning](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/Credential%20Scanning/Shared%20Library/README.md?plain=1) |


> [!Important]
> I have installed the plugin bundle provided by Jenkins during setup. If you have not done the same, you may encounter plugin errors.

***
## Runtime Prerequisites

|Language / Dependency|Description|
|-------|-------|
| **Java 17** | For springboot project compilation | 
| **Maven Compiler Plugin** | For springboot project compilation |
|**Sonarque Scanner Plugin**| To integrate Jenkins with Sonarqube |
| **OWASP Dependency-Check Plugin** | for dependency-check configuration on your jenkins server |


***
## Flow Diagram
![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/da5e9ef3-7316-4886-9537-b217d8925750)

***
## Pipeline Setup
1. **Configure Maven tool in Jenkins**
Go to `Dashboard--> Manage Jenkins--> Tools` and configure maven tool.

![image](https://github.com/avengers-p7/Documentation/assets/156056444/d9ff8a0d-900a-4e4b-ac68-34507ef3348b)


2. **Install Sonarqube Scanner plugin in Jenkins**

![image](https://github.com/avengers-p7/Documentation/assets/156056444/28625f84-3ae7-45e3-8cea-d1d73daba895)

3. **Create  token in Sonarqube**
	- login to Sonarqube Server and go to `Administration --> Security --> Users`
		![image](https://github.com/avengers-p7/Documentation/assets/156056444/f01959ac-2a3a-4644-ba49-ea52e886f2db)

	- click on `Update Tokens`
		![image](https://github.com/avengers-p7/Documentation/assets/156056444/f2f5fcbd-15db-45f7-8e41-abcda2e21da3)

 	- give name of token , select no. of days and then genarate the token
		![image](https://github.com/avengers-p7/Documentation/assets/156056444/8a0838e5-e186-4f2a-8a55-8151bad09958)

  	- copy and keep your token
     		![image](https://github.com/avengers-p7/Documentation/assets/156056444/511a3b73-922b-4277-b2a1-01d782609aca)
     

4. **Add Sonarqube token in Jenkins Credentials**
   	- login to your jenkins Dashboard and go to `Dashboard --> Manage Jenkins --> Credentials`

   	  	Below, click on add `Add Credentials`

		![image](https://github.com/avengers-p7/Documentation/assets/156056444/125c1d80-6342-4e24-9d0d-4f122ddeaf95)
  
	- Select **`Secret Text`** and provide the token that you copied in secret section. Also, give ID and Description to your credential.
		![image](https://github.com/avengers-p7/Documentation/assets/156056444/2727ea81-3014-4910-93ef-77237529f313)

5.  **Configure Sonarqube Server  in `Dashboard --> Manage Jenkins --> System`**

![image](https://github.com/avengers-p7/Documentation/assets/156056444/1681289c-a3ef-4d6a-9e54-a2b2a948d660)

6. **Create and Configure your Jenkins Pipeline job**

	Follow below document

	[Reference Document](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/pipelinePOC.md)

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/0243f7e0-f8dc-462b-8145-1a000fe4f374)

7. **Now Build your Pipeline**
![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/9f1bd614-8daa-462b-9af1-dae3dcf7efd0)
***
## Results
![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/52294d0e-03bf-4cc4-9d02-75a908546ab8)

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/5d1d0d40-9d62-4e6a-8c90-3a9637c61797)

***
## [Pipeline](https://github.com/CodeOps-Hub/Jenkinsfile/blob/main/SharedLibrary/Java/StaticCodeAnalysis/Jenkinsfile)

```shell
@Library("my-shared-library") _

def staticCodeAnalysis = new org.avengers.template.java.codeAnalysis()

node {
    
    def url = 'https://github.com/OT-MICROSERVICES/salary-api.git'
    def branch = 'main'
    
    staticCodeAnalysis.call(branch: branch,url: url)
    
}
```

## [Shared Library](https://github.com/CodeOps-Hub/SharedLibrary.git)
### [template/java/codeAnalysis.groovy](https://github.com/CodeOps-Hub/SharedLibrary/blob/main/src/org/avengers/template/java/codeAnalysis.groovy)
```shell
package org.avengers.template

import org.avengers.common.gitCheckout
import org.avengers.common.cleanWorkspace
import org.avengers.java.compile.*
import org.avengers.java.staticCodeAnalysis.*

def call(Map config = [:]){
    def gitCheckout = new gitCheckout()
    def javaCompile = new compile()
    def staticCodeAnalysis = new staticCodeAnalysis()
    def cleanWorkspace = new cleanWorkspace()

    gitCheckout.call(branch: config.branch, url: config.url  )
    javaCompile.call()
    staticCodeAnalysis.call()
    cleanWorkspace.call()
  
}
```
### [gitCheckout.groovy](https://github.com/CodeOps-Hub/SharedLibrary/blob/main/src/org/avengers/common/gitCheckout.groovy)
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

### [cleanWorkspace.groovy](https://github.com/CodeOps-Hub/SharedLibrary/blob/main/src/org/avengers/common/cleanWorkspace.groovy)
```shell
// Will not clean workspace if build is Sucessful and vice versa
package org.avengers.common

def call() {
  stage('Clean Workspace'){
      cleanWs cleanWhenSuccess: false
  }
}
```

### [compile.groovy](https://github.com/CodeOps-Hub/SharedLibrary/blob/main/src/org/avengers/java/compile/compile.groovy)
```shell
package org.avengers.java.compile

def call() {
  stage('Compile'){
    script{
      sh 'mvn clean compile'
    }
  }
}
```
### [staticCodeAnalysis.groovy](https://github.com/CodeOps-Hub/SharedLibrary/blob/main/src/org/avengers/java/staticCodeAnalysis/staticCodeAnalysis.groovy)
```shell
package org.avengers.java.staticCodeAnalysis

def call() {
  stage('Static Code Analysis'){
        withSonarQubeEnv(installationName: 'sq1') { 
          sh './mvnw org.sonarsource.scanner.maven:sonar-maven-plugin:3.9.0.2155:sonar'
        }    
  }
}
```
***

## Contact Information

|     Name         | Email  |
| -----------------| ------------------------------------ |
| Harshit Singh    | harshit.singh.snaatak@mygurukulam.co |
***

## References

| Description                                   | References  
| --------------------------------------------  | -------------------------------------------------|
| Licence Scanning | https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Design/02-%20Generic%20CI%20operation/License%20Scanning/README.md |
| Sonarqube | https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Design/07-%20Sonarqube/README.md |
| Statis Code Analysis | https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Design/08-%20Jenkins/static%20code%20Analysis.md |
| Sonarqube Intergration | https://www.youtube.com/watch?v=KsTMy0920go&t=342s |
| Clean Workspace | https://www.jenkins.io/doc/pipeline/tour/running-multiple-steps/#finishing-up |
| Shared Library (Generic Doc) | https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/jenkinsPipeline.md |
| Shared Library Setup (Generic Doc) | https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/sharedLibrary/setup.md |
| Create Pipeline (Generic Doc)| https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/pipelinePOC.md |
| Pipeine Syntax | https://www.jenkins.io/doc/book/pipeline/#pipeline-syntax-overview |
| Pipeline Concepts | https://www.jenkins.io/doc/book/pipeline/#pipeline-concepts |
| Shared Library | https://www.jenkins.io/doc/book/pipeline/shared-libraries/ |
| What is shared Library | https://keentolearn.medium.com/how-to-improve-your-jenkins-builds-with-shared-libraries-5e225b7435fb#:~:text=A%20shared%20library%20in%20Jenkins,efficient%20and%20easier%20to%20maintain. |
