# Terragrunt

|   Authors        |  Created on   |  Version   | Last updated by | Last edited on |
| -----------------| --------------| -----------|---------------- | -------------- |
| Vidhi Yadav      | 13th March 2024   |     v1     | Vidhi Yadav     | 13th March 2024    |

***
## Table of Contents 
+ [Introduction](#Introduction)
+ [Challenges Faced in Terraform](#challenges-faced-in-terraform)
+ [Difference b/w terraform and terragrunt](#difference-between-terraform-and-terragrunt)
+ [Key Benefits of Terragrunt](#key-benefits-of-terragrunt)
+ [Flow Diagram](#flow-diagram)
+ [POC Guide](#Proof-of-Concept-(POC)-Guide)
+ [Best Practices](#best-practices)
+ [Conclusion](#conclusion)
+ [Contact Information](#contact-information)
+ [References](#references)

***
## Introduction
<img src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/78aa81a8-604e-4178-ab80-3549f4a0c804" width="600">


Terragrunt is an open-source tool designed to make working with Terraform easier. Terraform itself is a widely-used infrastructure-as-code tool created by HashiCorp, used for building, changing, and versioning infrastructure safely and efficiently. While Terraform provides a powerful way to manage infrastructure, it can become complex to manage complex configurations across multiple environments and projects. Terragrunt simplifies this process to make your configurations less complex. 


***
## Difference between terraform and terragrunt

| Feature                | Terraform                                                                                          | Terragrunt                                                                                                                             |
|------------------------|----------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------|
| **Purpose**            | Infrastructure as Code (IaC) tool for defining, provisioning, and managing infrastructure        | Thin wrapper for Terraform that adds extra functionality and simplifies Terraform configurations                                       |
| **Configuration**      | Uses HCL (HashiCorp Configuration Language) for defining infrastructure configurations             | Inherits Terraform configurations and adds features like configuration inheritance, parameterization, and environment management      |
| **Modularity**         | Supports module-based approach for organizing and reusing configurations                           | Enhances modularity with additional features like dependency management and module reuse across projects and environments              |
| **Environment**        | Offers workspace management for handling multiple environments                                      | Provides environment-specific configurations and management through inheritance                                   |                |
| **State Management**   | Stores state files locally or remotely in supported backends                                       | Integrates with Terraform's state management mechanism, offering enhanced features for remote state storage and locking mechanisms      |                                 |


## Challenges Faced in Terraform

| Challenge                 | Solution                                                                                                                                                                              |
|---------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Repeatability** - Repeatability is a common challenge in Terraform configurations, as they often need to be repeated across multiple environments. However, managing this repetition can become complex, particularly in cases where terraform configurations are complex.                          | Terragrunt simplifies the management of repeated configurations by providing features like dependency management, configuration inheritance, and environment-specific configurations. By abstracting common configurations into shared modules and promoting code reuse, Terragrunt helps ensure consistency and reliability across deployments. |
| **Managing Multiple Environments** - Terraform supports multiple environments through workspace management and variable files, but managing environment-specific configurations and dependencies can still be complex, especially as the number of environments (e.g., development, staging, production) grows. | Terragrunt helps in managing our workspace by creating a common configurations and parameterization which makes it easier to manage settings that are different to each environment while sharing the common configuration across those environments. |

*** 
## Key Benefits of Terragrunt

* Terragrunt acts as a thin wrapper around Terraform, providing additional functionality and enhancements to streamline Terraform configuration and management. It builds upon Terraform's core features while introducing new capabilities to simplify common workflows and address limitations.

* Terragrunt follows the `DRY (Don't Repeat Yourself)` principle, aiming to reduce code duplication and promote reusability across Terraform configurations. It allows you to define common configurations and modules once and reuse them across multiple environments or projects. This way, Instead of duplicating infrastructure configuration for each environment (e.g., dev, staging, prod), Terragrunt enables you to define shared modules or configurations and inherit them in environment-specific configurations, eliminating the need to duplicate code.

***
## Flow Diagram

<img width="1517" alt="Screenshot 2024-03-13 at 8 15 29 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/e9810d24-4d1a-44bb-8cff-9f546a9ba8e9">

* The folder structure in "Before" shows how to separate the code for each environment (dev, prod) and for each type of infrastructure (apps, databases, VPCs). However, the downside is that it isn’t DRY. The .tf files will contain a LOT of duplication.

* Now, to reduce duplication we would create the same folder structure you had before for all of your environments, but instead of lots of copy/pasted .tf files for each module, you have just a single `terragrunt.hcl` file. This file now calls your module and include the global terragrunt.hcl file which contains `backend.tf` and `provider.tf` which would almost be same for all environments.

  
***
## Proof of Concept (POC) Guide:

 * Gain practical experience with Terragrunt by following our detailed Proof of Concept (POC) guide available [here](https://github.com/CodeOps-Hub/Documentation/blob/main/Terragrunt/POC/README.md). This comprehensive document provides step-by-step instructions for setting up and utilizing Terragrunt in a sample project. Explore essential concepts and learn how to effectively implement Terragrunt in your infrastructure workflows.

***
## Advantages and Disadvantages

| Advantages                                                     | Disadvantages                                                  |
| -------------------------------------------------------------- | --------------------------------------------------------------- |
| 1. DRY Principle (Don't Repeat Yourself): Terragrunt allows you to abstract common Terraform configurations into reusable modules, reducing duplication across multiple environments or projects. | 1. Learning Curve: Terragrunt introduces additional complexity and a learning curve compared to raw Terraform, especially for beginners or teams unfamiliar with its concepts and syntax. |
| 2. Simplified Configuration: Terragrunt provides a simplified configuration syntax compared to raw Terraform, enhancing readability and maintainability of infrastructure code.                                            | 2. Compared to Terraform, Terragrunt has a smaller user base and community support, leading to fewer resources, tutorials, and troubleshooting assistance. |
                        

***
## Best Practices

| Best Practice           | Description                                                                                                                                                             |
|-------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Modularization**      | Break down your infrastructure code into reusable modules to promote code reusability and maintainability. Terragrunt supports module reuse across different projects and environments. |
| **Configuration Inheritance** | Leverage Terragrunt's configuration inheritance feature to define common settings and configurations in a shared parent configuration file. This reduces duplication and promotes consistency across environments. |
| **Parameterization**    | Use Terragrunt variables to parameterize your configurations and make them more flexible. Parameterization allows you to customize configurations for different environments or pass inputs to Terraform modules. |

  
***
## Conclusion

In conclusion, Terragrunt serves as a powerful complement to Terraform, enhancing its capabilities and simplifying infrastructure management. By leveraging Terragrunt alongside Terraform, users can achieve greater modularity, flexibility, and consistency in their infrastructure configurations.


***
## Contact Information

|Vidhi Yadav                     | vidhi.yadhav.snaatak@mygurukulam.co                                                                                      
|---------------------------------|------------------------------------------------------------|

***
## References

| Title                                      | URL                                           |
|--------------------------------------------|-----------------------------------------------|
| Terragrunt official Doc           | [link](https://terragrunt.gruntwork.io/)    |





