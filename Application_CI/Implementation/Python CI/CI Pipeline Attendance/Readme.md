# Documentation of CI Pipeline Attendance (Python)

![image](https://github.com/avengers-p7/Documentation/assets/79625874/5419d5c8-ee87-4c28-9894-af831e8aba84)


***

| **Author** | **Created On** | **Last Updated** | **Document Version** |
| ---------- | -------------- | ---------------- | -------------------- |
| **Vikram Bisht** | **21-02-2024** | **21-02-2024** | **v1** |

***
# Table Of Contents

1. [Introduction](#Introduction)
2. [Pre-requisites](#Pre-requisites)
3. [Runtime Pre-requisites](#Runtime-Pre-requisites)
4. [Flow Diagram](#Flow-diagram)
5. [Configure Pipeline job](#Configure-Pipeline-job)
6. [Best Pratices](#Best-Pratices)
7. [Declarative Syntax](#Declarative-Syntax)
8. [Output or Job Result](#Output-or-Job-Result)
9. [Conclusion](#conclusion)
10. [Contact Information](#contact-information)
11. [References](#References)


# Introduction

Here, we are going to implement a CI pipeline for the Python code. This pipeline facilitates teamwork on a Python project by automatically fetching the code, setting up a clean workspace, and performing essential checks such as code quality assessment, dependency scanning, bug analysis, and testing. It ensures that everyone is aligned and detects potential issues at an early stage.

# Pre-requisites

| **Tool**   | **Description**            | 
| ---------- | -------------------------  | 
| Jenkins    | For continuous integration | 


# Runtime Pre-requisites

| **Tool**   | **Description**                                         | 
| ---------- | -------------------------                               | 
| Python3    | For python                                              | 
| Pylint     | It will help to do Static code analysis. on python code |
| Bandit     | A tool for bug analysis in Python code                  |
| Owasp      | Tool for Dependency scanning                            |

# Flow Diagram

![image](https://github.com/CodeOps-Hub/Documentation/assets/79625874/f024e52f-b948-4850-b456-18c3b750b174)

# Configure Pipeline job

Set up Jenkins Pipeline job & Configure your pipeline using the detailed documentation provided in the following link:**

**[Reference Link](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/pipelinePOC.md)**



# Declarative Syntax

[Link to Declarative Syntax](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/Python%20CI/CI%20Pipeline%20Attendance/Declarative%20pipeline%20.md)










# Output or Job Result

![image](https://github.com/avengers-p7/Documentation/assets/79625874/e2532ce3-7ad7-4867-8e23-22941f91a1f9)

If you want to see Detail Report please follow this **[Link](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/Python%20CI/Static%20Code%20Analysis/Scripted%20Pipeline/pylint.log)**

# Conclusion
This pipeline will do Static Code Analysis against a python code and provide you details report.

# Contact Information

|  Name                     |        	Email Address         |
| ------------              | --------------------------------|
| Vikram Bisht              |  Vikram.Bisht@opstree.com       |  

# References

|  Source                                                                                 |        Description      |
| ------------                                                                            | ----------------------- |
|  **[Link](https://pylint.readthedocs.io/en/stable/)**                                               | Pylint Documentation    |  
|**[Link](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Design/04-%20Python%20CI%20Checks/Static%20code%20analysis(Python%20CI%20Checks).md )**                  | Static Code Analysis Documentation    |
|  **[Link](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/Python%20CI/Static%20Code%20Analysis/Scripted%20Pipeline/pylint.log)**                                               | Detailed Output    |
|  **[Link](https://github.com/avengers-p7/Jenkinsfile/blob/main/Declarative%20Pipeline/Python/StaticCodeAnalysis/Jenkinsfile)**                                               | Jenkins File    | 
|  **[Link](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/pipelinePOC.md)**   | How to Setup Jenkins Pipeline    |
