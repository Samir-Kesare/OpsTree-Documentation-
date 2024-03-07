# Documentation of Terraform Module CI/CD

|   Author        |  Created on   |  Version   | Last updated by  | Last edited on |
| --------------- | --------------| -----------|----------------- | -------------- |
| Khushi Malhotra | 06 March 2024 |  Version 1 | Khushi Malhotra  | 07 March 2024  |

![image](https://github.com/avengers-p7/Documentation/assets/156056460/44f80ab7-909e-48c2-8b1e-ea004054137e)

## What is Terraform Module?
A Terraform module is a collection of standard configuration files stored in a dedicated directory. Modules encapsulate groups of resources dedicated to specific tasks, reducing the amount of code needed for similar infrastructure components.
Modules are containers for multiple resources used together in a configuration. They package and reuse resource configurations, making it easier to manage and scale infrastructure as it grows.

## what is CI/CD?
**Continuous Integration (CI)** is a software development practice that automates the integration of code changes from multiple contributors into a shared software project repository. 
Automation and Integration: CI automates the process of integrating code changes frequently into a central repository, facilitating faster merging of code changes and ensuring their correctness through automated testing.

**Continuous deployment and delivery (CD)** is a software development practice that aims to automate the integration, testing, and delivery of code changes. It is a two-part process that involves continuous delivery and continuous deployment.

| Aspect                  | Continuous Delivery (CD)                                                                                                                                                                  | Continuous Deployment (CD)                                                                                                                              |
|-------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------|
| Definition              | An extension of continuous integration. It automates the release of validated code to a repository following the automation of builds and unit and integration tests.                       | A logical continuation of the practice of automating build and test steps. If a build passes all previous stages in the pipeline successfully, it is automatically released to production.                  |
| Deployment Process      | Each successful build is automatically deployed to pre-production environments (e.g., testing and acceptance testing environments) for QA and product professionals to verify changes. | As soon as any change to the software has passed all tests, it is automatically delivered to users, shortening the feedback loop from code change to use in production.                                 |
| Goal                    | Helps teams release software faster, shorten the feedback loop, and automate repetitive tasks.                                                                                             | Shortens the feedback loop from code change to use in production, providing timely insight into how changes perform in the real world without compromising quality.                                         |
| Automation              | Automates the release of validated code following successful builds and tests.                                                                                                             | Automates the release of code to production as soon as all tests have passed, eliminating manual intervention in the deployment process.                                                                              |
| Usage                   | Suitable for scenarios where a manual approval step is needed before deploying changes to production.                                                                                      | Suitable for scenarios where rapid deployment of changes to production is desired and where automated testing ensures the quality of changes before release.                                                   |
| Feedback                | Provides feedback through pre-production environments, allowing QA and product professionals to verify changes before release.                                                            | Provides timely feedback on how changes perform in the real world by deploying them directly to production, enabling quick iteration and improvement based on user feedback.                               |


## Terraform Module CI/CD: Automating Module Deployment
In the context of Terraform, combining Continuous Integration/Continuous Deployment (CI/CD) practices with modules allows for the automated testing, building, and deployment of Terraform modules. 
**CI/CD for Terraform Modules:** Integrating CI/CD practices with Terraform modules involves automating the process of uploading modules to the official Terraform registry. This automation streamlines the deployment of infrastructure configurations and ensures consistency in module publishing.

## Terraform CI

For Terraform CI, I am utilizing a comprehensive set of tools to ensure code quality, consistency, and security throughout the development process. These tools include:

| Tool             | Purpose                                                                                                                                                                  |
|------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Terraform fmt    | Automatically formats Terraform configuration files (.tf files) to ensure consistent styling and layout.                                                                   |
| Terraform validate | Verifies whether the configuration files are syntactically correct and internally consistent. It checks for errors in attribute names, argument types, and required inputs. |
| Terraform lint   | Performs static analysis of Terraform code to identify potential issues, such as deprecated syntax, unused variables, or non-idiomatic patterns.                           |
| Checkov          | A static code analysis tool for Infrastructure as Code (IaC), including Terraform. It scans Terraform configuration files for security and best practice issues.        |

> [!IMPORTANT]  
> For POC of Terraform Module CI [Click Here](https://github.com/avengers-p7/Documentation/blob/main/Terraform/Terraform_CI/Terraform_CI_POC.md).

## Terraform CD

For Terraform CD, I'm employing a streamlined approach to deployment using the terraform plan and terraform apply commands. These commands facilitate the automated deployment of infrastructure changes to the target environment. Here's a breakdown:

| Aspect           | Terraform CD                                                                                                                                              |
|------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------|
| terraform plan   | Generates an execution plan outlining the changes Terraform will apply to the infrastructure, including new resources, updated attributes, and deletions. |
| terraform apply  | Executes the planned changes in the Terraform configuration files, applying them to the target environment and automating the deployment process.        |

> [!IMPORTANT]  
> For POC of Terraform Module CD [Click Here](https://github.com/CodeOps-Hub/Documentation/blob/main/Terraform/Design/Terraform%20Modules%20CICD/TerraformModule_CD/POC_CD_TerraformModule.md).

## Contact Information
| Name            | Email Address                        |
|-----------------|--------------------------------------|
| Khushi Malhotra | khushi.malhotra.snaatak@mygurukulam.co |

## References

| Description                                   | References  
| --------------------------------------------  | -------------------------------------------------|
| Terraform Module | https://spacelift.io/blog/what-are-terraform-modules-and-how-do-they-work |
| What is CI | https://www.atlassian.com/continuous-delivery/continuous-integration |
| What is CD | https://www.atlassian.com/continuous-delivery/principles/continuous-integration-vs-delivery-vs-deployment |
| Terraform Module CI/CD | https://www.reddit.com/r/Terraform/comments/17ldr9i/cicd_for_creating_terraform_modules/ |
