# Employee API CI (Shared Library)

<img width="560" length="100" alt="Employee" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/ed7edbe7-3bd0-431d-88f9-3750713e61e3">

***

|   Author        |  Created on   |  Version   | Last updated by  | Last edited on |
| --------------- | --------------| -----------|----------------- | -------------- |
| Vishal Kumar Kesarwani |  22-02-2024  |  Version 1 | Vishal  | 22-02-2024    |

***
## Table of Contents
+ [Introduction](#Introduction)
+ [What is Shared Library](#What-is-Shared-Library)
+ [Why use shared library](#Why-use-shared-library)
+ [Pre-requisites](#Pre-requisites)
+ [Runtime Pre-requisites](#Runtime-Pre-requisites)
+ [Flow Diagram](#Flow-Diagram)
+ [Pipeline Setup](#Pipeline-Setup)
+ [Results](#Results)
+ [Pipeline](#Pipeline)
+ [Shared Library](#)
+ [Contact Information](#Contact-Information)
+ [Resources and References](#Resources-and-References)
  
***
## Introduction 

Continuous Integration (CI) is a development practice where developers integrate code into a shared repository frequently, preferably several times a day. Each integration can then be verified by an automated build and automated tests. While automated testing is not strictly part of CI it is typically implied. 

**For more information about CI checks performed in Employee API, use the following directory link:**

[\[ Reference Directory \]](https://github.com/CodeOps-Hub/Documentation/tree/main/Application_CI/Implementation/GolangCI)

In this task, we are using Shared Library to perform CI on Employee API.
***
## What is Shared Library

 <img width="360" length="100" alt="Golang" src="https://github.com/avengers-p7/Documentation/assets/156056413/f94f127a-d207-4c76-bc32-d25e4fe48280"> 

A Jenkins Shared Library is a collection of reusable code that facilitates the sharing of common pipeline logic among teams in Jenkins. It simplifies CI/CD processes by abstracting complex tasks into functions, speeding up pipeline development. By keeping shared code separate from individual pipelines, teams ensure consistency and minimize duplication. This fosters collaboration, encourages best practices, and streamlines Jenkins pipeline creation, leading to better software delivery and development workflows.  

***

## Why use shared library
To understand the concept of shared libraries, let’s consider a real-time example. Imagine you have multiple Jenkins pipelines that require a common set of functions for interacting with a version control system, such as Git. Instead of duplicating the Git-related code in each pipeline, you can create a shared library that encapsulates the necessary Git operations.

<img width="460" length="100" alt="Employee" src="https://github.com/avengers-p7/Documentation/assets/156056444/f99a6591-da1b-42f4-a13c-8c4bb1bb947c">

**For more information visit the below document link:**

[\[ Reference Doc \]](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GenericDoc/sharedLibrary/README.md)

***

## Pre-requisites
| Tool | Description |
| ---- | ----------- |

***

## Runtime Pre-requisites

|Language / Dependency|Description|
|-------|-------|

***

## Flow Diagram

<img width="460" length="100" alt="Employee" src="">

***
## Pipeline Setup

1. **Setup and Configure plugins & tools in Jenkins**

  
2. **Configure Shared library in Jenkins**
	
 	Follow below document

	[Reference Document](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GenericDoc/sharedLibrary/setup.md)<br><br>

    <img width="960" length="100" alt="Employee" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/81425f04-a142-4fde-8e04-c8e8119e9845">

3. **Create and Configure your Jenkins Pipeline job**

	Follow below document

	[Reference Document](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GenericDoc/pipelinePOC.md)

    <img width="960" length="100" alt="Employee" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/8828f84c-82a9-45e4-9f89-356ec2708149">  

4. **Now Build your Pipeline**
   
    <img width="760" length="100" alt="Employee" src=""> 

***

## Results

   <img width="760" length="100" alt="Employee" src=""> 

***
## [Pipeline](https://github.com/CodeOps-Hub/Employee-API/blob/feature/employeeCI/Jenkinsfile)

```shell

```

## [Shared Library](https://github.com/CodeOps-Hub/SharedLibrary/blob/main/src/org/avengers/template/employeeCI/EmployeeCi.groovy)

```shell
// src/org/avengers/template/employeeCI

```

***

## Contact Information
| Name | Email address |
| ---- | ------------- |
| Vishal | vishal.kesarwani.snaatak@mygurukulam.co |

***
## Resources and References
|  **Description** |   **Source** |
| ---------------- | ------------ |
| Licence Scanning | [Link](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Design/02-%20Generic%20CI%20operation/License%20Scanning/README.md) |
| Credential Scanning | [Link](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Design/02-%20Generic%20CI%20operation/Credentials%20Scanning/README.md) |
| Shared Library (Generic Doc) | [Link](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GenericDoc/sharedLibrary/README.md) |
| Shared Library Setup (Generic Doc) | [Link](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GenericDoc/sharedLibrary/setup.md) |
| About Shared Library | [Link](https://www.jenkins.io/doc/book/pipeline/shared-libraries/) |
| All CI Checks used in Employee API (Both type Pipeline) | [Link](https://github.com/CodeOps-Hub/Documentation/tree/main/Application_CI/Implementation/GolangCI) |

***

***
