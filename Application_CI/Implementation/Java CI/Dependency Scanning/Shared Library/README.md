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
To understand the concept of shared libraries, let’s consider a real-time example. Imagine you have multiple Jenkins pipelines that require a common set of functions for interacting with a version control system, such as Git. Instead of duplicating the Git-related code in each pipeline, you can create a shared library that encapsulates the necessary Git operations.

![image](https://github.com/avengers-p7/Documentation/assets/156056444/f99a6591-da1b-42f4-a13c-8c4bb1bb947c)

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
Go to `Dashboard--> Manage Jenkins--> Tools` and configure maven tool.

<img width="975" alt="Screenshot 2024-02-17 at 5 19 24 PM" src="https://github.com/avengers-p7/Documentation/assets/156056349/8ffb33b3-b11f-4ec8-a6b4-9764d5aca18c">

4. **Configure Shared library in Jenkins**
	
 Follow below document

[Reference Document](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/sharedLibrary/setup.md)<br><br>

<img width="925" alt="Screenshot 2024-02-18 at 3 08 16 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/013a320a-af4a-4d78-80f9-3d490fd5c3fe">



5. **Create and Configure your Jenkins Pipeline job**

	Follow below document

	[Reference Document](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/pipelinePOC.md)<br><br>

<img width="979" alt="Screenshot 2024-02-18 at 3 09 50 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/3d473b69-b730-46d0-9008-7af994cfdedf">


6. **Build Pipeline**
<img width="805" alt="Screenshot 2024-02-18 at 3 10 36 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/9d22a37e-df89-468a-8874-24046df8d813">


***
## Console Output
![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/614b3d13-9fa3-41b6-87a9-aee594326800)

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/e9767ba5-b4b0-43dd-8975-a61217d9026b)

***
## [Pipeline](https://github.com/CodeOps-Hub/Jenkinsfile/blob/main/SharedLibrary/Java/CodeCompilation/Jenkinsfile)

```shell
@Library("my-shared-library") _

def javaCodeCompile = new org.avengers.template.java.javaCodeCompilation()

node {
    
    def url = 'https://github.com/OT-MICROSERVICES/salary-api.git'
    def branch = 'main'
    
    javaCodeCompile.call(branch: branch,url: url)
    
}
```

## [Shared Library](https://github.com/CodeOps-Hub/SharedLibrary.git)
### [template/java/javaCodeCompilation.groovy](https://github.com/CodeOps-Hub/SharedLibrary/blob/main/src/org/avengers/template/java/javaCodeCompilation.groovy)
```shell
package org.avengers.template

import org.avengers.common.gitCheckout
import org.avengers.common.cleanWorkspace
import org.avengers.java.compile.*

def call(Map config = [:]){
    def gitCheckout = new gitCheckout()
    def javaCompile = new compile()
    def cleanWorkspace = new cleanWorkspace()
    try{
    gitCheckout.call(branch: config.branch, url: config.url  )
    javaCompile.call()   
    }
    // gitCheckout.call(branch: config.branch, url: config.url  )
    // javaCompile.call()
    catch (e) {
        echo 'Analysis Failed'
        cleanWorkspace.call()
        // Since we're catching the exception in order to report on it,
        // we need to re-throw it, to ensure that the build is marked as failed
        throw e
    } 
    finally {
         def currentResult = currentBuild.result ?: 'SUCCESS'
        if ((currentResult == 'UNSTABLE')||(currentResult == 'ABORTED')) {
        cleanWorkspace.call()
            // echo 'This will run only if the run was marked as unstable'
    }
  }
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
| Pipeine Syntax | https://www.jenkins.io/doc/book/pipeline/#pipeline-syntax-overview |
