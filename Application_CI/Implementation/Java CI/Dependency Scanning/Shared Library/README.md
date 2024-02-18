# Java Dependency Scanning (Shared Library)

| Author                                                           | Created on  | Version    | Last Updated by | Last Updated on |
| ---------------------------------------------------------------- | ----------- | ---------- | --------------- | --------------- |
| Vidhi Yadav  | 18th Feb 2024  | 1.0        | Vidhi Yadav   | 18th Feb 2024      |


## Table  of Contents

1. [Introduction](#Introduction)
2. [What is Shared Library](#What-is-Shared-Library)
3. [Prerequisites](#Prerequisites)
4. [Runtime Prerequisites](#Runtime-Prerequisites)
5. [Flow Diagram](#Flow-Diagram)
6. [Pipeline Setup](#Pipeline-Setup)
7. [Contact Information](#Contact-Information)
8. [References](#References)
***

## Introduction 
Dependency scanning is a security practice that involves analyzing the dependencies of a software application for known vulnerabilities and security issues. It's particularly crucial in modern software development, where applications often rely on numerous third-party libraries and components that can cause security risk in your application.

**For more information visit the below document link:**

[\[ Reference Doc \]](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Design/03-%20Java%20CI%20checks/Dependency%20Scanning/%20README.md)

In this task, we are using Shared Library.

***
## What is Shared Library?

A shared library in Jenkins is a reusable collection of Groovy scripts that can be used by multiple Jenkins jobs. This allows you to share code and functionality between different jobs, which can make your builds more efficient and easier to maintain. 

A shared library is typically organized as a Git repository containing code that you want to share across pipelines. This repository would have a specific structure with directories like src, vars, resources, etc., where you place your Groovy scripts, classes, and other resources.

<img width="750" alt="Screenshot 2024-02-19 at 1 47 58 AM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/2a1d5804-8c7e-4eed-b8f7-941629fb46f2">


**For more information visit the below document link:**

[\[ Reference Doc \]](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/sharedLibrary/README.md)

## Prerequisites

| Tool | Description |
| ---- | ----------- |
| **Jenkins(2.414.3)** | To build our pipeline |

***
## Runtime Prerequisites

|Tool|Description|
|-------|-------|
| **Maven Plugin** | to enable jenkins to build maven projects |
| **OWASP Dependency-Check Plugin** | for dependency-check configuration on your jenkins server |


***
## Flow Diagram

<img width="934" alt="Screenshot 2024-02-18 at 2 23 33 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/d33ca34c-5227-4af1-8b47-bdccf92793fa">

***
## Pipeline Setup
1. **Fork the Github Repo**
```shell
https://github.com/CodeOps-Hub/p7-salary-API.git
```
[**Repo Link**](https://github.com/CodeOps-Hub/p7-salary-API.git)

2. **Configure Maven tool in Jenkins**

* Go to `Dashboard--> Manage Jenkins--> Tools` and configure maven tool.

<img width="975" alt="Screenshot 2024-02-17 at 5 19 24 PM" src="https://github.com/avengers-p7/Documentation/assets/156056349/8ffb33b3-b11f-4ec8-a6b4-9764d5aca18c">

3. **Install OWASP Plugin**

<img width="1327" alt="Screenshot 2024-02-18 at 4 17 25 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/16cb4a7f-430b-4423-9f73-7de330a4300a">

* For more information follow the [reference link](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Design/03-%20Java%20CI%20checks/Dependency%20Scanning%20POC/README.md)
5. **Configure Shared library in Jenkins**
	
* Follow below document

[Reference Document](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/sharedLibrary/setup.md)<br><br>

<img width="925" alt="Screenshot 2024-02-18 at 3 08 16 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/013a320a-af4a-4d78-80f9-3d490fd5c3fe">



5. **Create and Configure your Jenkins Pipeline job**

* Follow below document

	[Reference Document](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/pipelinePOC.md)<br><br>

<img width="979" alt="Screenshot 2024-02-18 at 3 09 50 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/3d473b69-b730-46d0-9008-7af994cfdedf">


6. **Build Pipeline**

<img width="903" alt="Screenshot 2024-02-18 at 3 18 24 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/34a8f989-a986-4545-a47d-1516a6924cf8">


***
## Output
* Dependency check reports generated in all formats 

<img width="536" alt="Screenshot 2024-02-18 at 3 27 13 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/d3e3a94e-b62f-41a1-9619-7b28d0de15b7">

* Archived HTML dependency check reports

<img width="810" alt="Screenshot 2024-02-18 at 3 34 43 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/c3079aa6-7f4b-4480-9051-f19fc812e371">

***
## [Jenkinsfile](https://github.com/CodeOps-Hub/Jenkinsfile/blob/main/SharedLibrary/Java/Dependency%20Scanning/Jenkinsfile)

```shell
@Library("shared_library") _

def dpcheck = new org.avengers.template.java.dependencyCheck()

node {
    
    def url = 'https://github.com/CodeOps-Hub/p7-salary-API.git'
    def branch = 'main'
    def creds = 'vyadavP7'
    
    dpcheck.call(url, creds, branch)
}
```

## [Shared Library](https://github.com/CodeOps-Hub/SharedLibrary/blob/main/src/org/avengers/template/java/dependencyCheck.groovy)
```shell
package org.avengers.template.java

import org.avengers.common.*
import org.avengers.java.dependencyCheck.dpCheck


def call(String url, String creds, String branch){

    def gitCheckout = new GitCheckoutPrivate()
    def dpCheck = new dpCheck()
    def cleanW = new cleanWorkspace()
  
    try {
        // Clone repository 
        gitCheckout.call(url, creds, branch)
        
        // perform Dependency Scanning 
        dpCheck.call()
      
    } catch (e) {
        echo 'DP check Failed !'

        // clean workspace 
        cleanW.call()
  
        throw e
    } finally {
     //   echo "In finally block"
      //  echo "Current build result: ${currentBuild.currentResult}"
        
        if (currentBuild.currentResult == 'SUCCESS') {
            echo 'DP check Successful!'

            // archive HTML reports as artifacts
            archiveArtifacts artifacts: '**/dependency-check-report.html'

            // show workspace in tree structure
            sh 'tree ${WORKSPACE}'
        }
    }
}
```
### [GitCheckoutPrivate.groovy](https://github.com/CodeOps-Hub/SharedLibrary/blob/main/src/org/avengers/common/GitCheckoutPrivate.groovy)
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

***

## Contact Information

|     Name         | Email  |
| -----------------| ------------------------------------ |
| Vidhi Yadav    | vidhi.yadhav.snaatak@mygurukulam.co |
***

## References

| Description                                   | References  
| --------------------------------------------  | -------------------------------------------------|
| Clean Workspace | https://www.jenkins.io/doc/pipeline/tour/running-multiple-steps/#finishing-up |
| Shared Library (Generic Doc) | https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/jenkinsPipeline.md |
| Shared Library Setup (Generic Doc) | https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/sharedLibrary/setup.md |
| Create Pipeline (Generic Doc)| https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/pipelinePOC.md |
| Shared library | https://stackoverflow.com/questions/52604334/how-to-use-currentbuild-result-to-indicate-success-not-null|
