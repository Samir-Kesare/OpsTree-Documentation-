# Salary API CI (Shared Library)
![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/dc808906-6fa5-4307-b472-e13fbed8560d)

| Author                                                           | Created on  | Version    | Last Updated by | Last Updated on |
| ---------------------------------------------------------------- | ----------- | ---------- | --------------- | --------------- |
| **[Harshit Singh](https://github.com/Panu-S-Harshit-Ninja-07)**  | 21-02-2024  | 1.0        | Harshit Singh   | 21-02-2024      |


## Table  of Contents

1. [Introduction](#Introduction)
2. [What is Shared Library](#What-is-Shared-Library)
3. [Pre-requisites](#Prerequisites)
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

## Pre-requisites

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
1. **Setup and Configure plugins & tools in Jenkins**
- [gitCheckout](https://github.com/CodeOps-Hub/SharedLibrary/blob/main/src/org/avengers/common/gitCheckout.groovy)
- [Credential Scanning](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/Credential%20Scanning/Shared%20Library/README.md)
- [Licence Scanning](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/License%20Scanning/Shared%20Library/README.md)
- [Compile](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/Java%20CI/Code%20Compilation/Shared%20Library/README.md)
- [Bug Analysis](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/Java%20CI/Bug%20Analysis/Bug-Analysis-shared-Lib.md)
- [Dependency Check](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/Java%20CI/Dependency%20Scanning/Shared%20Library/README.md)
- [Static Code Analysis](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/Java%20CI/Static%20Code%20Analysis/Shared%20Library/README.md)
- [Unit Testing](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/Java%20CI/Unit%20Testing/Unit-Testing-Shared-Lib.md)
  
2. **Configure Shared library in Jenkins**
	
 	Follow below document

	[Reference Document](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/sharedLibrary/setup.md)<br><br>


![image](https://github.com/avengers-p7/Documentation/assets/156056444/1038a25c-7953-4e72-af36-9d4f9eb77f98)

3. **Create and Configure your Jenkins Pipeline job**

	Follow below document

	[Reference Document](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/pipelinePOC.md)

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/0243f7e0-f8dc-462b-8145-1a000fe4f374)

4. **Now Build your Pipeline**
![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/9f1bd614-8daa-462b-9af1-dae3dcf7efd0)
***
## Results
![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/52294d0e-03bf-4cc4-9d02-75a908546ab8)

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/5d1d0d40-9d62-4e6a-8c90-3a9637c61797)

***
## [Pipeline](https://github.com/CodeOps-Hub/Salary-API/blob/feature/slarayCI/Jenkinsfile)

```shell
@Library("my-shared-library") _

def salaryCI = new org.avengers.template.salaryCI.salaryCI()

node {
    
    def url = 'https://github.com/CodeOps-Hub/Salary-API.git'
    def branch = 'feature/slarayCI'
    def gitLeaksVersion = '8.18.2'
    def reportName = 'credScanReport.json'
    
    salaryCI.call(branch: branch,url: url, gitLeaksVersion, reportName)
    
}
```

## [Shared Library](https://github.com/CodeOps-Hub/SharedLibrary.git)
### [template/salaryCI/salaryCI.groovy](https://github.com/CodeOps-Hub/SharedLibrary/blob/main/src/org/avengers/template/salaryCI/salaryCI.groovy)
```shell
package org.avengers.template

import org.avengers.licenseScanning.licenceScan
import org.avengers.credScanning.*
import org.avengers.common.*
import org.avengers.java.compile.*
import org.avengers.java.staticCodeAnalysis.*
import org.avengers.java.dependencyCheck.*
import org.avengers.java.unitTesting.*
import org.avengers.java.bugAnalysis.*


def call(Map config = [:], String gitLeaksVersion, String reportName){
    
    def licenceScan = new licenceScan()
    def gitCheckout = new gitCheckout()
    def javaCompile = new compile()
    def staticCodeAnalysis = new staticCodeAnalysis()
    def cleanWorkspace = new cleanWorkspace()
    def dpCheck = new dpCheck()
    def javaUnitTesting = new test()
    def javaBugAnalysis = new bug()
    def javaPublishHtml = new publishHtml()
    def gitLeaks = new GitLeaks()
    def  scan = new Scan()
    cleanAfterArchive = new CleanAfterArchive()
    
    try{
    gitCheckout.call(branch: config.branch, url: config.url  )
    gitLeaks.call(gitLeaksVersion)
    scan.call(reportName)
    withCredentials([string(credentialsId: 'fossaToken', variable: 'FOSSA_API_KEY')]){
        licenceScan.installFossa()
        licenceScan.scan()
    }
    javaCompile.call()
    parallel dpCheck: {
        dpCheck.call()
    },
    statisCodeAnalysis: {
        staticCodeAnalysis.call()        
    },
    bugAnalysis: {
        javaBugAnalysis.call()
        javaPublishHtml.call()
    },
    unitTesting:{
        javaUnitTesting.call()   
    }
    }
    catch (e){
        echo 'Salary CI Failed'
        cleanWorkspace.call()
        throw e
    }
    finally {
         def currentResult = currentBuild.result ?: 'SUCCESS'
        if ((currentResult == 'UNSTABLE')||(currentResult == 'ABORTED')) {
        cleanWorkspace.call()
            // echo 'This will run only if the run was marked as unstable'
        }
        // cleanAfterArchive.call(reportName) 

    }
}
```

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
