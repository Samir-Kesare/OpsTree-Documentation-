# Proof of Concept (POC) of Terraform Unit Testing

|   Authors        |  Created on   |  Version   | Last updated by | Last edited on |
| -----------------| --------------| -----------|---------------- | -------------- |
| Vidhi Yadav      | 31 March 2024   |     v1     | Vidhi Yadav     | 31 March 2024    |

<img src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/5cc2f639-564c-47dc-83ff-eab07553d79e" alt="image" style="width:50%;height:auto;">

## Table of Contents
+ [Introduction](#Introduction)
+ [Pre-requisites](#pre-requisites)
+ [Proof of Concept](#Pre-requisite)
+ [Conclusion](#conclusion)
+ [Contact Information](#contact-information)
+ [References](#references)

***
## Introduction 
Terraform stands out as a powerful tool for provisioning and managing cloud resources. However, as organizations scale their infrastructure, ensuring the reliability and correctness of Terraform configurations becomes increasingly important. This is where unit testing comes into play.

One of the key benefits of Terraform unit testing is its ability to verify resource metadata, attributes, and settings without relying on external resources or API calls. This means tests can be executed quickly and independently, reducing the risk of unintended consequences on live infrastructure or external services. By isolating tests from external dependencies, developers can maintain a controlled environment for validation, leading to faster feedback loops and more reliable deployments.

For more information on Terraform unit testing and to gain a detailed understanding of the topic, please follow this link: [Terraform Unit Testing Documentation](https://github.com/CodeOps-Hub/Documentation/blob/main/Terraform/Testing/Unit%20Testing/README.md).
*** 
## Flow Diagram

<img width="1793" alt="Screenshot 2024-03-31 at 10 13 26 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/2f6cb3b9-90ab-4390-addc-96052375b063">

***
## Pre-requisite

 | Requirement | Recommendation |
 |-------------|----------------|
 | Terraform |  version 1.7 or above |
 
***
## Proof of Concept (PoC) - Unit Testing

### 1. Setup: Creating a Terraform Configuration for Unit Testing

To set up a Terraform configuration for unit testing, start by organizing your project in a dedicated directory. Write your Terraform configuration files to define the infrastructure resources you intend to test, including any necessary input variables. Create unit test files with the `.tftest.hcl` extension in the same directory, and use Terraform's built-in testing framework to write tests that validate the behavior of your configuration. With your project organized and tests written, you're ready to execute the tests and ensure the reliability of your Terraform code.

When setting up your Terraform project for unit testing, your directory structure might resemble the following:

```shell
unit-testing/
├── data.tf
├── main.tf
├── output.tf
├── provider.tf
├── terraform.tfstate
└── variable.tf

0 directories, 7 files
```

The Terraform configuration in this directory (`unit-testing/`) includes the following resources used for testing purposes:

- **`data.tf`**: Contains data sources used to fetch existing information required for testing scenarios.
- **`main.tf`**: Defines the main infrastructure resources that are being tested.
- **`output.tf`**: Specifies output values that are asserted during testing to ensure expected behavior.
- **`provider.tf`**: Specifies provider configurations required for interacting with external services during testing.
- **`variable.tf`**: Defines input variables that are parameterized for testing different scenarios.


***
## Conclusion


***
## Contact Information

|Vidhi Yadav                     | vidhi.yadhav.snaatak@mygurukulam.co                                                                                      
|---------------------------------|------------------------------------------------------------|

***
## References

| Title                                      | URL                                           |
|--------------------------------------------|-----------------------------------------------|
| Dependency-Check User Guide           | https://jeremylong.github.io/DependencyCheck/    |
| OWASP Dependency-Check GitHub Repository    | https://github.com/jeremylong/DependencyCheck  |



