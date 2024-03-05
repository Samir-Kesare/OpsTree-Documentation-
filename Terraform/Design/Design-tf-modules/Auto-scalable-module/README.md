# Design for Auto scalable module

<img width="360" length="100" alt="Terraform" src="">

***

| **Author** | **Created On** | **Last Updated** | **Document version** |
| ---------- | -------------- | ---------------- | -------------------- |
| **Vishal Kumar Kesharwani** | **05 March 2024** | **05 March 2024** | **v1** |

***

## Table of Contents

* [Introduction](#Introduction)
* [Terraform Modules](#Terraform-Modules)
* [What is State file](#What-is-State-file)
* [Pre-requisites](#Pre-requisites)
* [Flow Diagram](#Flow-Diagram)
* [Directory Structure](#Directory-Structure)
* [Usage](#Usage)
* [Conclusion](#Conclusion) 
* [Contact Information](#Contact-Information) 
* [References](#References)

 ***

 ## Introduction

With the increasing complexity of modern networks and the need for agility in infrastructure management, Terraform has emerged as a powerful tool for automating the provisioning and configuration of network resources.This module is designed to provide a foundational framework for managing network infrastructure as code using Terraform. By leveraging this module, users can quickly establish a standardized and scalable network architecture within their cloud environment.

***

## Terraform Modules

<img width="360" length="100" alt="Terraform" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/b2ec5454-cc39-4212-9dd9-fbc7b9967317">

Terraform modules serve as fundamental building blocks within the Terraform infrastructure as code (IaC) framework, enabling users to encapsulate and reuse configuration logic across different projects and environments. Essentially, a Terraform module is a collection of resources and associated configuration files that define a specific piece of infrastructure, such as a virtual machine, network, or application. By organizing infrastructure components into modular units, users can achieve greater abstraction, maintainability, and scalability in their infrastructure provisioning workflows.Additionally, Terraform modules support parameterization, allowing users to customize module behavior through input variables and outputs, further enhancing flexibility and adaptability.

***

## What is State file?

<img width="360" length="100" alt="Terraform" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/40ac0ac5-1a6a-4221-b2a8-f97467608f01">

The state file is an artifact that you’re left with once an Infrastructure as Code framework finishes a deployment. It is the “single source of truth” about what was deployed, where it was deployed, and all the configuration needed to deploy it. 

***

## Pre-requisites

| **Pre-requisite** | **Description** |
| ----------------- | --------------- |
| **AWS Account**   | Access to the AWS Management Console with credentials configured. |
| **Hashicrop Terraform** | Terraform **(v1.7.4)** for configuration of AWS resources. |

***

## Flow Diagram

![image](https://github.com/CodeOps-Hub/Documentation/assets/156057205/9b5ae612-95d9-4cf4-9612-d9874fcfd843)

***

## Directory Structure

<img width="242" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/13a20fce-0900-4467-ab59-a24772f89a56">

***

# Usage

```shell
module "ASG" {
    source                         = "./Autoscaling"
    }
```

***

# Tags
* Tags are assigned to resources with name variable as prefix.
* Additial tags can be assigned by tags variables as defined above.
  
***

# Inputs

| Name | Description | Type | Default | 
| ---- | ----------- | ---- | ------- | 

***

# Outputs 

| Name | Description |
|------|-------------|

***

# Result

<img width="562" alt="image" src="">

***
 ## Conclusion

 ***

 ## Contact Information

 | **Name** | **Email Address** |
 | -------- | ----------------- |
 | **Vishal Kumar Kesharwani** | vishal.kumar.kesharwani.snaatak@mygurukulam.co |

 ***
 
 ## References

 | **Source** | **Description** |
 | ---------- | --------------- |
 | [Link](https://developer.hashicorp.com/terraform/intro) | Official Doc Link For Terraform |
 | [Link](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GenericDoc/Terraform/terraform.md) | Terraform Generic Doc Link. |
 | [Link](https://developer.hashicorp.com/terraform/language/modules) | Terraform Modules |
 | [Link]() |  |
 



