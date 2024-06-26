# Terraform Unit Testing 

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056349/7caabe30-3948-4e62-90d0-4dca4c7fc44f)


|   Authors        |  Created on   |  Version   | Last updated by | Last edited on |
| -----------------| --------------| -----------|---------------- | -------------- |
| Vidhi Yadav      | 31 March 2024   |     v1     | Vidhi Yadav     | 31 March 2024    |

***
## Table of Contents 
+ [Introduction](#Introduction)
+ [Key Components](#key-features)
+ [How Unit Testing Functions](#How-Unit-Testing-Functions)
+ [Comparing Terraform Testing Framework with Traditional Unit Testing](#Comparing-Terraform-Testing-Framework-with-Traditional-Unit-Testing)
+ [Essential Block Components](#Essential-Block-Components)
+ [Proof of Concept (POC)](Proof-of-Concept-(POC))
+ [Best Practices](#best-practices)
+ [Conclusion](#conclusion)
+ [Contact Information](#contact-information)
+ [References](#references)

***
## Introduction

When running 'terraform apply', it's crucial to avoid any adverse impact on critical business applications. To mitigate this risk, we implement a unit testing strategy. Unit testing ensures that resources and configurations possess the accurate metadata by verifying attributes and settings. These tests are executed independently, without dependence on external resources or API calls, and they do not interact with live infrastructure or external services.

With the release of Terraform v1.7.0, a native testing framework was introduced, enabling users to thoroughly test their Terraform resources

<img width="1793" alt="Screenshot 2024-03-31 at 10 13 26 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/58453375-722a-4048-8235-4f8e36eaaa3c">

*** 
## Key Features

**In addition to testing attributes in the Terraform plan, unit tests can validate:**

* The number of resources or attributes generated by for_each or count.
* Values generated by for expressions.
* Values generated by built-in functions.
* Dependencies between modules.
* Values associated with interpolated values.
* Expected variables or outputs marked as sensitive.

***
## How Unit Testing Functions

The Terraform test mocking framework is designed to simulate resources, providers, and modules. By default, it operates with the `command = apply` , generating resources or infrastructure. However, it offers flexibility by allowing users to override this behavior with `command = plan` . In this mode, it avoids connecting to the actual API and instead leverages a **community tool** to mimic the behavior of the cloud provider API. Overall, this tool serves to mitigate costs associated with resource creation and prevents potential slowdowns in real-time API interactions and environment related dependencies.

***
## Comparing Terraform Testing Framework with Traditional Unit Testing

| Aspect                                   | Traditional Unit Testing                                   | Terraform Unit Testing                                        |
|------------------------------------------|-----------------------------------------------------------|---------------------------------------------------------------|
| **Language Support**                     | Uses any programming language capable of parsing Terraform files | Utilizes native Terraform testing framework                   |
| **Parsing Limitations**                  | Faces difficulties in parsing variable interpolation and list iteration within Terraform configurations | Directly parses Terraform plan representation for comprehensive testing |
| **Understanding Terraform Constructs**   | Lacks native support for Terraform-specific syntax and constructs | Understands Terraform-specific behaviors including variable interpolation and dynamic behaviors |
| **Approach**                             | Relies on external tools or custom solutions               | Utilizes built-in functionality provided by Terraform         |
| **Complexity**                           | May require additional setup and integration efforts        | Provides streamlined testing process with native support      |

*** 
## Essential Block Components

<img width="688" alt="Screenshot 2024-03-31 at 10 35 19 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/bf56cfe1-a830-46d1-a1f2-f8b47b973085">


Each Terraform test lives in a test file. Terraform discovers test files are based on their file extension: `.tftest.hcl` or `.tftest.json`.

Each test file contains the following root level attributes and blocks:

* One to many `run` blocks.
* Zero to one `variables` block.
* Zero to many `provider` blocks.

1. **run** Block

A run block in Terraform's testing framework defines a test case where Terraform commands are executed within the configuration directory. It specifies operations like apply or plan, along with options such as variables and providers. Assertions within the run block validate expected outcomes, helping ensure the correctness of Terraform configurations. Additionally, run blocks facilitate testing different scenarios by defining various configurations and assertions within a single test file.

2. **variable** Block

In Terraform's testing framework, the variables block allows you to define input variable values directly within test files, providing flexibility in configuring test scenarios. These variable values can be specified at both the root level of the test file and within individual run blocks. When Terraform executes tests, it passes all variable values from the test file into all run blocks within the file.

The precedence of variable values within tests follows a hierarchy, with values defined in test files taking the highest precedence. This means that variable values specified within the test file will override values from other sources such as environment variables, variable files, or command-line input.

4. **provider** Block

In Terraform's testing framework, the providers block allows you to set or override provider configurations within your test files. This block resembles provider configurations in the main Terraform configuration and enables you to define provider settings specific to each run block or globally at the root level of the test file.

***
## Proof of Concept (POC)

 * It is highly recommended to gain hands-on experience through our detailed Proof of Concept (POC) guide for Terraform Unit Testing. This comprehensive document walks you through a practical demonstration, providing step-by-step instructions on how to test your Terraform components. The POC guide delves into essential concepts for identifying early issues through unit testing, utilizing each block discussed in this document. You can access the guide [here](https://github.com/CodeOps-Hub/Documentation/blob/main/Terraform/Testing/Unit%20Testing/Unit%20Testing%20POC/README.md).

***
## Best Practices

| **Best Practices**      | **Description**                                                                                                             |
|-------------------------|-----------------------------------------------------------------------------------------------------------------------------|
| **Clear Assertions**        | Write clear and concise assertions in your unit tests to verify the expected behavior of your Terraform configurations. Use descriptive error messages to aid in debugging failures. |
| **Focus on Small Units**    | Unit tests should focus on testing individual Terraform resources, modules, or configuration blocks in isolation. Keep the scope of each test small to ensure clarity and maintainability. |
| **Continuous Refinement**   | Continuously refine and update your unit tests as your Terraform configurations evolve. Regularly review and refactor tests to maintain effectiveness and keep pace with changes in your infrastructure. |
| **Test Idempotency**        | Verify that your Terraform configurations are idempotent by testing multiple apply operations and ensuring that the resulting infrastructure remains consistent. |


***
## Conclusion

Overall, Terraform unit testing plays a vital role in ensuring the reliability and stability of infrastructure deployments managed through Terraform configurations. With the introduction of the native Terraform testing framework, developers now have a powerful tool at their disposal to comprehensively test Terraform configurations and behaviors.

***
## Contact Information

|Vidhi Yadav                     | vidhi.yadhav.snaatak@mygurukulam.co                                                                                      
|---------------------------------|------------------------------------------------------------|

***
## References

| Title                                      | URL                                           |
|--------------------------------------------|-----------------------------------------------|
| Terraform Official Doc           | [Link](https://developer.hashicorp.com/terraform/language/tests#expecting-failures)   |
| IaC Testing     | [Link](https://www.hashicorp.com/blog/testing-hashicorp-terraform) |




