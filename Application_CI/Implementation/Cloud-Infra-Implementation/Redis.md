# Redis Infra Documentation

|<img width="360" length="100" alt="Terraform" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/556e50dc-0c8b-4262-be16-2c384d2cfa8a">

***

| **Author** | **Created on** | **Last Updated** | **Document Version** |
| ---------- | -------------- | ---------------- | -------------------- |
| **Shreya Jaiswal** | **04 March 2024** | **05 March 2024** | **v1** |

***

# Table of contents
* [Introduction](#Introduction)
* [What is DSL Pipeline](#What-is-DSL-Pipeline)
* [Why DSL Pipeline](#Why-DSP-Pipeline)
* [Flow Diagram](#Flow-Diagram)
* [Pre-requisites](#Pre-requisites)
* [Jenkinsfile](#Jenkinsfile)
* [Output](#Output)
* [Related Works](#Related-Works)
* [Conclusion](#Conclusion)
* [Contact Information](#Contact-Information)
* [References](#References)

***

# Introduction

With the increasing complexity of modern networks and the need for agility in infrastructure management, Terraform has emerged as a powerful tool for automating the provisioning and configuration of network resources.This module is designed to provide a foundational framework for managing network infrastructure as code using Terraform. By leveraging this module, users can quickly establish a standardized and scalable network architecture within their cloud environment.As networks get more complicated and managing infrastructure becomes more important, specialized languages called Domain-Specific Languages (DSLs) have become really useful. They help simplify and automate different tasks.

***

# What is DSL Pipeline?

A Domain-Specific Language (DSL) is a programming language or specification language dedicated to a particular problem domain, a particular problem representation technique, and/or a particular solution technique.DSL Pipeline is a robust framework designed to facilitate the creation, deployment, and management of domain-specific languages within your software development projects. By employing DSLs, developers can express solutions in a concise, domain-specific syntax tailored to the problem at hand, thereby enhancing productivity and reducing the gap between domain experts and software implementation.

There are two main types of DSLs: external DSLs and internal DSLs. External DSLs have their own syntax and are typically parsed by a separate compiler or interpreter. Internal DSLs, on the other hand, are embedded within a host programming language, leveraging its syntax and features to create a domain-specific syntax.

***

# Why DSL Pipeline

| Key Features  | Description                                                                                                              |
|---------------|--------------------------------------------------------------------------------------------------------------------------|
| Modularity    | The DSL Pipeline offers a modular architecture, allowing developers to define and integrate custom DSL components seamlessly. |
| Extensibility | Extend the capabilities of the DSL Pipeline by incorporating new DSL constructs, transformations, and integrations with existing tools and libraries. |
| Automation    | Automate repetitive tasks in the development lifecycle through pipeline automation, including parsing, validation, transformation, and code generation. |
| Flexibility   | Accommodate diverse DSL requirements with flexible configuration options, support for various syntax styles, and compatibility with multiple target platforms. |

***

# Flow Diagram


***

# Pre-requisites

| **Pre-requisites** | **Description** |
| ------------------ | ---------------- |
| **AWS Account**    | Access to the AWS Management Console with credentials configured. |
| **Jenkins**        | To integrate infra through DSL Pipeline. |
| **Terraform**      | Terraform HCL (v1.7.4) | ****

***

# Jenkinsfile


***

# Output

**Console Output**

<img width="715" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/3f134493-6e49-4cca-bc8a-7c5070c30ee7">

***

**EC2 Instance Output (Standaloneredis)**

![Screenshot 2024-03-05 132014](https://github.com/CodeOps-Hub/Documentation/assets/156057205/4b1a4184-de45-4010-a683-78bf94c50c92)

***

**Security Group for redis(Redis-sg)**

![Screenshot 2024-03-05 132107](https://github.com/CodeOps-Hub/Documentation/assets/156057205/f9e9ef4d-689e-4415-bbb1-fdd076cd7be0)

***

**SSH Key Pair for redis server(redisKey.pem)**

![Screenshot 2024-03-05 132123](https://github.com/CodeOps-Hub/Documentation/assets/156057205/fbed8a49-6dfc-4513-9a4b-c50c32ccb7b4)

***

# Related Works

| **References** |
| -------------- |
| [Link](https://github.com/CodeOps-Hub/Terraform/blob/aakash/redis_server/Dev_Infra/EC2/main.tf) |

***

# Conclusion

In conclusion, our DSL Pipeline offers a powerful solution for creating and managing domain-specific languages, enabling developers to express complex ideas in a concise and understandable manner. By embracing DSLs, organizations can accelerate development cycles, improve collaboration between domain experts and developers, and ultimately deliver higher-quality software solutions. 

***

# Contact Information

| **Name** | **Email Address** |
| -------- | ----------------- |
| **Shreya Jaiswal** | shreya.jaiswal.snaatak@mygurukulam.co |

***

# References

| **Source** | **Description** |
| ---------- | --------------- |
| [Link](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GenericDoc/Terraform/terraform.md) | Terraform Generic Doc Link. |
| [Link](https://developer.hashicorp.com/terraform/language/modules) | Terraform Module Concept. |
| [Link](https://www.linkedin.com/pulse/how-run-terraform-script-jenkins-step-by-step-guide-praveen-dandu) | Reference Link For DSL Pipeline. |
| [Link](https://medium.com/appgambit/terraform-with-jenkins-pipeline-439babe4095c)  | Jenkins DSL Pipeline Doc reference link. |












