# Terragrunt

|   Authors        |  Created on   |  Version   | Last updated by | Last edited on |
| -----------------| --------------| -----------|---------------- | -------------- |
| Vidhi Yadav      | 13th March 2024   |     v1     | Vidhi Yadav     | 13th March 2024    |

***
## Table of Contents 
+ [Introduction](#Introduction)
+ [Challenges Faced in Terraform](#challenges-faced-in-terraform)
+ [Key Benefits of Terragrunt](#key-benefits)
+ [Flow Diagram](#flow-diagram)
+ [POC Guide](#Proof-of-Concept-(POC)-Guide)
+ [Best Practices](#best-practices)
+ [Contact Information](#contact-information)
+ [References](#references)

***
## Introduction
<img src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/78aa81a8-604e-4178-ab80-3549f4a0c804" width="600">


Terragrunt is an open-source tool designed to make working with Terraform easier. Terraform itself is a widely-used infrastructure-as-code tool created by HashiCorp, used for building, changing, and versioning infrastructure safely and efficiently. While Terraform provides a powerful way to manage infrastructure, it can become complex to manage complex configurations across multiple environments and projects. Terragrunt simplifies this process to make your configurations less complex. 


***
## Challenges Faced in Terraform

| Challenge                 | Solution                                                                                                                                                                              |
|---------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Repeatability** - Repeatability is a common challenge in Terraform configurations, as they often need to be repeated across multiple environments. However, managing this repetition can become complex, particularly in cases where terraform configurations are complex.                          | Terragrunt simplifies the management of repeated configurations by providing features like dependency management, configuration inheritance, and environment-specific configurations. By abstracting common configurations into shared modules and promoting code reuse, Terragrunt helps ensure consistency and reliability across deployments. |
| **Managing Multiple Environments** - Terraform supports multiple environments through workspace management and variable files, but managing environment-specific configurations and dependencies can still be complex, especially as the number of environments (e.g., development, staging, production) grows. | Terragrunt helps in managing our workspace by creating a common configurations and parameterization which makes it easier to manage settings that are different to each environment while sharing the common configuration across those environments. |

*** 
## Key Benefits

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
## Best Practices

| Best Practice           | Description                                                                                                                                                             |
|-------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Modularization**      | Break down your infrastructure code into reusable modules to promote code reusability and maintainability. Terragrunt supports module reuse across different projects and environments. |
| **Configuration Inheritance** | Leverage Terragrunt's configuration inheritance feature to define common settings and configurations in a shared parent configuration file. This reduces duplication and promotes consistency across environments. |
| **Parameterization**    | Use Terragrunt variables to parameterize your configurations and make them more flexible. Parameterization allows you to customize configurations for different environments or pass inputs to Terraform modules. |

  
***
## Contact Information

|Vidhi Yadav                     | vidhi.yadhav.snaatak@mygurukulam.co                                                                                      
|---------------------------------|------------------------------------------------------------|

***
## References

| Title                                      | URL                                           |
|--------------------------------------------|-----------------------------------------------|
| Terragrunt official Doc           | [link](https://terragrunt.gruntwork.io/)    |





