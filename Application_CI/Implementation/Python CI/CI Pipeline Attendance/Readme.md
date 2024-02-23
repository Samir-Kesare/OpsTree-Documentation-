# CI Pipeline Attendance (Shared Library)

![image](https://github.com/CodeOps-Hub/Documentation/assets/79625874/380377f6-6d0f-426f-9026-8b34105c8357)



***

| **Author** | **Created On** | **Last Updated** | **Document Version** |
| ---------- | -------------- | ---------------- | -------------------- |
| **Vikram Bisht** | **21-02-2024** | **21-02-2024** | **v1** |

***
## Table Of Contents

1. [Introduction](#Introduction)
2. [What is Shared Library](#What-is-Shared-Library)
3. [Pre-requisites](#Pre-requisites)
4. [Runtime Pre-requisites](#Runtime-Pre-requisites)
5. [Flow Diagram](#Flow-diagram)
6. [Pipeline Setup](#Pipeline-Setup)
9. [Output or Job Result](#Output-or-Job-Result)
10. [Pipeline](#pipeline)
9. [Shared Library](#Shared-Library)
11. [Conclusion](#conclusion)
12. [Contact Information](#contact-information)
13. [References](#References)


## Introduction

Here, we are going to implement a CI pipeline for the Python code. This pipeline facilitates teamwork on a Python project by automatically fetching the code, setting up a clean workspace, and performing essential checks such as code quality assessment, dependency scanning, bug analysis, and testing. It ensures that everyone is aligned and detects potential issues at an early stage.

## What is Shared Library?

A shared library in Jenkins is a reusable collection of Groovy scripts that can be used by multiple Jenkins jobs. This allows you to share code and functionality between different jobs, which can make your builds more efficient and easier to maintain.
### Why
To understand the concept of shared libraries, let’s consider a real-time example. Imagine you have multiple Jenkins pipelines that require a common set of functions for interacting with a version control system, such as Git. Instead of duplicating the Git-related code in each pipeline, you can create a shared library that encapsulates the necessary Git operations.

![image](https://github.com/avengers-p7/Documentation/assets/156056444/f99a6591-da1b-42f4-a13c-8c4bb1bb947c)

**For more information visit the below document link:**

[\[ Reference Doc \]](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/sharedLibrary/README.md)

## Pre-requisites

| **Tool**   | **Description**            | 
| ---------- | -------------------------  | 
| Jenkins    | For continuous integration | 


## Runtime Pre-requisites

| **Tool**   | **Description**                                         | 
| ---------- | -------------------------                               | 
| Python3    | For python                                              | 
| Pylint     | It will help to do Static code analysis. on python code |
| Bandit     | A tool for bug analysis in Python code                  |
| Owasp      | Tool for Dependency scanning                            |

## Flow Diagram

![image](https://github.com/CodeOps-Hub/Documentation/assets/79625874/b9bde010-7c4f-4709-8f7b-d706823b22de)

## Pipeline Setup
1. **Setup and Configure plugins & tools in Jenkins**
- [Static Code Analysis](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/Python%20CI/Static%20Code%20Analysis/Shared%20Library%20.md)
- [Bugs Analysis](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/Python%20CI/Declarative%20Pipeline%20Python%20Bugs%20Analysis/Shared%20Liabrary/README.md)
- [Dependency Scanning](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/Python%20CI/Dependency_Scanning/Shared_Library/Readme.md)
  
**Configure Shared library in Jenkins**
	
 Follow below document

[Reference Document](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/sharedLibrary/setup.md)<br><br>


![image](https://github.com/avengers-p7/Documentation/assets/156056444/1038a25c-7953-4e72-af36-9d4f9eb77f98)

3. **Create and Configure your Jenkins Pipeline job**

	Follow below document

	[Reference Document](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/pipelinePOC.md)

![image](https://github.com/CodeOps-Hub/Documentation/assets/79625874/c85f8733-1270-4e4a-8e3d-0d1f67eee1ca)

4. **Now Build your Pipeline**

![image](https://github.com/CodeOps-Hub/Documentation/assets/79625874/68aec9d8-3924-4cd4-8618-2842879ed561)

# Output or Job Result

![image](https://github.com/CodeOps-Hub/Documentation/assets/79625874/151900fe-d23c-4477-bf1e-94fb6f117098)

If you want to see Detail Report  

**[Static Code Analysis](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/Python%20CI/Static%20Code%20Analysis/Scripted%20Pipeline/pylint.log)**

**[Bugs Analysis](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/Python%20CI/Declarative%20Pipeline%20Python%20Bugs%20Analysis/Declarative%20Pipeline/JSON%20Report)**

**[Dependency Scanning](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/Python%20CI/Dependency_Scanning/Shared_Library/Report.html)**


## [Pipeline](https://github.com/CodeOps-Hub/Jenkinsfile/blob/main/SharedLibrary/Python/CI_Pipeline/Jenkinsfile)

```shell
@Library("my-shared-library") _

def Attandance_CI = new org.avengers.template.Attandance_CI.attandanceCI()
    
node {
    
    def url = 'https://github.com/CodeOps-Hub/attendance-api.git'
    def branch = 'main'
    def creds = 'vikram445'    
   
    Attandance_CI.call(url, creds, branch)
   
    }
```

## [Shared Library](https://github.com/CodeOps-Hub/SharedLibrary/blob/main/src/org/avengers/template/Attandance_CI/attandanceCI.groovy)
```shell
package org.avengers.template.Attandance_CI

import org.avengers.python.BugsAnalysis.*
import org.avengers.python.dependencyScanning.*
import org.avengers.python.staticCodeAnalysis.*
import org.avengers.common.*  

def call(String url, String creds, String branch, String depVersion, String javaVersion) {
    //common definition
    def gitCheckoutPrivate = new GitCheckoutPrivate()
    def cleanW = new cleanWorkspace()
    def javaDownload = new JavaDownload()
    
    // Static code analysis definition
    def VirtualEnv = new virtualEnv()
    def Dependencies = new dependencies()
    def StaticCodeAnalysis = new staticCodeAnalysis()
    def archive = new ArchiveArtifacts() 

    // bugs analysis definition
    def bugsAnalysisBandit = new BugsAnalysisBandit()
    def installDependencies = new InstallDependencies()

    // // dependency scanning definition
    def downloadDependencyCheck = new DownloadDependencyCheck()
    def dependencyCheck = new DependencyCheck()
    def cleandp = new Clean()

    // static code analysis 
      try {
        gitCheckoutPrivate.call(url, creds, branch)
        VirtualEnv.call()
        Dependencies.call()
        StaticCodeAnalysis.call()
    } catch (Exception e) {
        // Handle any exceptions during static code analysis
        echo "An error occurred during static code analysis: ${e.message}"
    } finally {
        archive.call()
    }

     // bugs analysis 
     bugsAnalysisBandit.call()
     installDependencies.call()

  // dependency scanning 
  javaDownload.call(javaVersion)
  downloadDependencyCheck.call(depVersion) 
  gitCheckoutPrivate.call(url, creds, branch)
  dependencyCheck.call()
  cleandp.call()
 
} 
```



# Conclusion
This pipeline will do Static Code Analysis against a python code and provide you details report.

# Contact Information

|  Name                     |        	Email Address         |
| ------------              | --------------------------------|
| Vikram Bisht              |  Vikram.Bisht@opstree.com       |  

# References

| Source | Description |
| ------ | ----------- |
| [Link](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/Python%20CI/Dependency_Scanning/Shared_Library/Readme.md) | Shared Library Dependency Scanning |
| [Link](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/Python%20CI/Static%20Code%20Analysis/Shared%20Library%20.md) | Shared Library Static Code Analysis |
| [Link](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/sharedLibrary/setup.md) | Configure Shared library in Jenkins |
| [Link](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/Python%20CI/Declarative%20Pipeline%20Python%20Bugs%20Analysis/Shared%20Liabrary/README.md) | Shared Library Bugs Analysis |
| [Link](https://github.com/CodeOps-Hub/SharedLibrary/blob/main/src/org/avengers/template/Attandance_CI/attandanceCI.groovy) | Shared Library CI Pipeline |
