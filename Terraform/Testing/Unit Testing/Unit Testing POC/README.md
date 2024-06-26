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

**main.tf**

<details>
<summary> Click here to see main.tf </summary>
<br>
  
```shell
resource "aws_instance" "demo-instance" {
  ami             = "ami-0b622ae4dff08c413"  
  instance_type   = "t2.micro"               
  key_name        = "vd"             # Key pair for SSH access
  tags = {
    Name = var.instance_name
  }
  }
```
</details>

**variable.tf**

<details>
<summary> Click here to see variable.tf file </summary>
<br>
  
```shell
// AWS region in provider.tf
variable "region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "instance_name" {
  description = "Instance Name"
  default     = "demo-instance"
}
```
</details>

**data.tf**

<details>
<summary> Click here to see data.tf file </summary>
<br>
  
```shell
data "aws_key_pair" "existing_key_pair" {
  key_name = "vd"
}
```
</details>

**provider.tf**

<details>
<summary> Click here to see provider.tf file </summary>
<br>
  
```shell
//PROVIDER

// required terraform configuration
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.38.0"  # Using a minimum version constraint
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.region 
}
```
</details>

### Unit Testing 

The native unit testing framework consists of three blocks: 

1. **Provider Block:** Defines the provider configuration used in the test. It specifies details such as the provider type (e.g., AWS) and any necessary configurations (e.g., region).

2. **Variables Block:** Defines input variables for the test scenario. These variables can be referenced within the run block to customize test behavior.

3. **Run Block:** Represents a single test scenario. It specifies the Terraform command to execute (e.g., plan or apply) and includes assertions to validate the expected behavior of the Terraform configuration.

**Example Configuration:**

```hcl

variables {
  instance_name = "test"
}

run "valid_instance" {

  command = plan  // by default runs for apply

  assert {
    condition     = aws_instance.demo-instance.tags["Name"] == "test"
    error_message = "Instance name didn't match"
  }

}
```

This example demonstrates a unit test scenario named `valid_instance`, which verifies that the value of the instance_name variable matches the expected value "test" when running a Terraform plan command. You may also try using provider block to run your testing configuration in a different region. 

You can also utilize the provider block to execute your testing configuration in a different region, providing flexibility to test against various environments or regions.

**Example configuration:**

```hcl
provider "aws" {
 region = "us-east-2"
}

variables {
  instance_name = "test-instance"
}

run "valid_instance" {

  command = plan

  assert {
    condition     = var.instance_name == "test-instance"
    error_message = "Instance name didn't match"
  }

}
```

Similarly, you can explore unit testing scenarios involving list iteration, variable interpolation, and maps to ensure robustness and correctness in handling dynamic configurations and data structures.

**Example Configuration:**
```hcl

provider "aws" {
 region = "us-east-2"
}

variables {
  bucket_config = {
    name          = "example-bucket"
    force_destroy = false
  }
}

run "test_bucket_creation" {
  command = plan // scope of this command is limited to this run block

  assert {
    condition     = aws_s3_bucket.demo_bucket.bucket == var.bucket_config.name
    error_message = "Bucket name does not match the configured name"
  }

  assert {
    condition     = aws_s3_bucket.demo_bucket.force_destroy == var.bucket_config.force_destroy
    error_message = "Bucket force_destroy property does not match the configured value"
  }
}
```

### 3. Output 

Finally, if the unit test has passed successfully, you can expect an output similar to this: 

<img width="715" alt="Screenshot 2024-04-01 at 1 18 03 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/119f4090-991d-4e24-9096-615e68b73f19">

***
## Conclusion

This Proof of Concept (POC) document has provided a practical demonstration of unit testing for Terraform configurations. By leveraging Terraform's built-in testing framework, users can ensure the reliability and correctness of their infrastructure code. We explored the use of three key blocks - provider, variables, and run - to define and execute unit tests for different aspects of Terraform configurations. Through examples and explanations, users have gained insights into structuring test scenarios, defining assertions, and interpreting overall test results.

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



