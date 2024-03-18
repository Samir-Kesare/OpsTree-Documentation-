# DSL Jenkins pipeline for Employee setup in Dev Env
![image](https://github.com/CodeOps-Hub/Documentation/assets/156056364/b7501107-272b-4144-bfef-e33043c14add)
***
| **Author** | **Created On** | **Last Updated** | **Document version** |
| ---------- | -------------- | ---------------- | -------------------- |
| **Shantanu** | **18 March 2024** | **18 March 2024** | **v1** |
***

# Table of contents

* [Introduction](#Introduction)
* [What is DSL Pipeline](#What-is-DSL-Pipeline)
* [Why DSL Pipeline](#Why-DSP-Pipeline)
* [Flow Diagram](#Flow-Diagram)
* [Pre-requisites](#Pre-requisites)
* [Jenkinsfile](#Jenkinsfile)
* [Jenkins Output](#Jenkins-Output)
* [AWS Console Output](#AWS-Console-Output)
* [Conclusion](#Conclusion)
* [Contact Information](#Contact-Information)
* [References](#References)

***

# Introduction
Terraform has become essential for automating network resource provisioning and configuration in today's intricate networks. 
This module offers a fundamental framework for managing network infrastructure through Terraform, enabling users to swiftly establish standardized and scalable 
architectures in their cloud environments. With the growing complexity of networks and the increasing significance of infrastructure management, specialized 
Domain-Specific Languages (DSLs) have proven invaluable for simplifying and automating various tasks.
***

# What is DSL Pipeline?

A Domain-Specific Language (DSL) is a specialized programming language tailored to address specific problem domains, representation techniques, or solution methods.
DSL Pipeline is a robust framework crafted to simplify the development, deployment, and management of such languages within software projects. By utilizing DSLs, 
developers can articulate solutions in a focused, domain-specific syntax, leading to increased efficiency and bridging the gap between domain experts and software 
implementation.

DSLs come in two primary forms: external DSLs and internal DSLs. External DSLs possess their unique syntax and are typically interpreted or compiled by separate 
tools. Conversely, internal DSLs are integrated within a host programming language, leveraging its syntax and capabilities to create domain-specific syntax.
***

# Why DSL Pipeline

| Key Features  | Description                                                                                                              |
|---------------|--------------------------------------------------------------------------------------------------------------------------|
| **Modularity**    | The DSL Pipeline offers a modular architecture, allowing developers to define and integrate custom DSL components seamlessly. |
| **Extensibility** | Extend the capabilities of the DSL Pipeline by incorporating new DSL constructs, transformations, and integrations with existing tools and libraries. |
| **Automation**    | Automate repetitive tasks in the development lifecycle through pipeline automation, including parsing, validation, transformation, and code generation. |
| **Flexibility**   | Accommodate diverse DSL requirements with flexible configuration options, support for various syntax styles, and compatibility with multiple target platforms. |
***

# Flow Diagram


***

# Pre-requisites

| **Pre-requisites** | **Description** |
| ------------------ | ---------------- |
| **AWS Account**    | Access to the AWS Management Console with credentials configured. |
| **Jenkins**        | To integrate infra through DSL Pipeline. |
| **Terraform**      | Terraform HCL (v1.7.4) |
***

# Jenkinsfile



***

**This Jenkins pipeline automates the deployment of a Employee API infrastructure using Terraform module and Wrapper code. It's configured to perform the following actions:**


### Terraform Deployment Pipeline Overview

| Stage                   | Description                                                                                                                                                                      |
|-------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Checkout**            | Fetches the Terraform code from a GitHub repository branch (`main`). |                                                                                    
| **Copy Terraform Files**    | Copies Frontend-related Terraform configuration files to the Jenkins workspace. |                                                                                                
| **Terraform Init**          | Initializes Terraform in the workspace directory. |                                                                                                                                
| **Terraform Plan**          | Generates a Terraform execution plan to preview the changes. |                                                                                                                     
| **Review and Approve Apply** | Asks for approval before applying Terraform changes if the selected action is "Apply". |                                                                                       
| **Review and Approve Destroy** | Asks for approval before destroying Terraform resources if the selected action is "Destroy". |                                                                            
| **Apply or Destroy**        | Executes Terraform apply or destroy based on the selected action. |                                                                                                               
| **Post**                    | Displays success or failure messages. |                                                                                                                                          
***

# Jenkins Output

### Pipeline view

### Archive Artifact (SSH key pair)

### Console Output
<details>
<summary><strong>Click here to see Console output</strong></summary>
<br>

```shell


```
</details>

***

# AWS Console Output 

### Security Group

***
### Launch Template

***
### Listener rule of ALB

***
### Auto Scaling Group

***
### Auto Scaling Group Policies

***

# Conclusion
To sum up, our DSL Pipeline provides an effective means of crafting and overseeing domain-specific languages, allowing developers to articulate intricate concepts
in a clear and succinct manner. Embracing DSLs enables companies to expedite development processes, enhance cooperation between domain experts and developers, 
and ultimately deliver superior software solutions.
***

# Contact Information

| **Name** | **Email Address** |
| -------- | ----------------- |
| **Shantanu** | shantanu.chauhan.snaatak@mygurukulam.co |
***

# References

| **Source** | **Description** |
| ---------- | --------------- |
| [**Link**](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GenericDoc/Terraform/terraform.md) | Terraform Generic Doc Link. |
| [**Link**](https://developer.hashicorp.com/terraform/language/modules) | Terraform Module Concept. |
| [**Link**](https://medium.com/appgambit/terraform-with-jenkins-pipeline-439babe4095c)  | Jenkins DSL Pipeline Doc reference link. |
| [**Link**](https://github.com/CodeOps-Hub/Documentation/blob/main/Terraform/Design/Module/Auto-scaling.md) | ASG Module Doc |


