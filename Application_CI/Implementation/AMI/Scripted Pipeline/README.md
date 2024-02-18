# Documentation of Scripted Pipeline for AMI Creation

![image](https://github.com/avengers-p7/Documentation/assets/156057205/7ab97e86-1928-454d-8770-4b5e13487e95)

***

| **Author** | **Created On** | **Last Updated** | **Document Version** |
| ---------- | -------------- | ---------------- | -------------------- |
| **Shreya Jaiswal** | **08-02-2024** | **14-02-2024** | **v1** |

***

# Table Of Contents

1. [Introduction](#introduction)
2. [What is Scripted Pipeline?](#what-is-scripted-pipeline)
3. [Why Scripted Pipeline](#why-scripted-pipeline)
4. [What is Packer](#what-is-packer)
5. [Pre-requisites](#pre-requisites)
6. [Flow Diagram](#flow-diagram)
7. [AMI Setup](#ami-setup)
8. [Pipeline](#Pipeline)
9. [Conclusion](#conclusion)
10. [Contact Information](#contact-information)
11. [Reference](#reference)

***

# Introduction

Creating Amazon Machine Images (AMIs) using Packer with Jenkins pipelines allows for efficient and automated infrastructure provisioning in AWS environments. Packer is a tool that automates the creation of machine images for multiple platforms, including AWS EC2 instances. When integrated with Jenkins pipelines, the process becomes streamlined and reproducible.

***

# What is Scripted Pipeline?

A Scripted Pipeline in Jenkins is a Groovy-based approach to defining continuous integration and continuous delivery (CI/CD) pipelines. It allows users to write pipeline scripts using Groovy syntax, providing full flexibility and customization for defining build, test, and deployment stages. Scripted Pipelines enable users to incorporate conditional logic, loops, and functions within the pipeline script to handle complex workflows and custom requirements. While offering extensive power and flexibility, Scripted Pipelines require users to have knowledge of Groovy programming and scripting concepts. They are well-suited for projects with intricate build processes or those requiring advanced automation and customization capabilities.

***

# Why Scripted Pipeline

| Aspect | Description |
| ------ | ----------- |
| **Imperative Syntax**        | Write pipelines as Groovy scripts, providing full control over execution flow for complex logic and dynamic behavior.                                           |
| **Programmatic Constructs**  | Access to programming features like loops, conditions, variables, and functions for building highly customizable pipelines.                                       |
| **Direct Access to APIs**    | Scripts directly interact with Jenkins APIs, enabling fine-grained automation and integration with plugins and external systems.                                 |
| **Extensibility**            | Allows for defining custom functions and importing external libraries to enhance pipeline functionality and reusability.                                          |
| **Legacy Support**           | Widely used in environments with existing pipelines, providing familiarity and compatibility with legacy systems.                                               |
| **Learning Curve**           | Requires understanding of Groovy syntax and Jenkins pipeline concepts, posing a steeper learning curve, especially for newcomers.                                |
| **Debugging and Maintenance** | Imperative nature can make debugging and maintenance challenging, necessitating proper organization, documentation, and testing practices.                     |

***

# What is "Packer"

<img width="360" length="100" alt="Golang" src="https://github.com/avengers-p7/Documentation/assets/156057205/6b8c1ba2-9c57-4d55-8092-04ea2eccaf84">

Packer, a powerful open-source tool developed by HashiCorp, has emerged as a preferred choice for creating AMIs. Offering multi-platform support, an infrastructure-as-code paradigm, and extensibility through various builders and provisioners, Packer streamlines the AMI creation process.

***

# Note

> [!NOTE]
> POC for Manually AMI Creation is prepared in different doc,if you want to see the AMI Creation Process use this link [AMI POC](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Design/02-%20Generic%20CI%20operation/AMI/AMI%20via%20Packer.md) 

***

# Pre-requisites

| **Pre-requisites** | **Description** |
| ------------------ | --------------- |
| **Jenkins** | Latest version of Jenkins (2.426.2) |
| **Packer** | Latest version of Packer (Packer v1.10.1) |
| **Pipeline Plugin** | This is a must-have as it provides the infrastructure for defining and running your pipeline as code. |
| **AWS Credentials Plugin** | This plugin allows you to securely store your AWS credentials in Jenkins. |
| **Credentials Binding Plugin** | This plugin is useful for binding credentials to environment variables in your Jenkins pipeline. |
| **Pipeline AWS Plugin** | This plugin provides a set of reusable functions for working with AWS services in Jenkins pipelines. It's particularly helpful when interacting with AWS services like EC2 for building AMIs. |
| **Amazon EC2 Plugin** | While not directly related to Packer, this plugin is useful if you plan to use Jenkins to provision temporary build agents on EC2 instances. |

***

# Flow Diagram

<img width="590" alt="image" src="https://github.com/avengers-p7/Documentation/assets/156057205/8c52bd13-a66c-4b93-88be-697cc6991e97">

***

# AMI Setup

## Tool Installation

<img width="407" alt="image" src="https://github.com/avengers-p7/Documentation/assets/156057205/5dee9dff-af57-4556-96bf-8a2c1b3012d4">

***

## Variable File Creation

### variables.auto.pkrvars.hcl

**This file provides specific values for the variables declared in `variables.pkr.hcl`.It sets values for `ami_name`,`instance_type`,`region`, `source_ami`, and `ssh_username`.These values will be used as default inputs when executing Packer commands unless overridden.**

```shell
ami_name = "my-ami"
instance_type = "t2.micro"
region = "us-east-1"
source_ami = "ami-0faac859c9205201b"
ssh_username = "ubuntu"

```

### variables.pkr.hcl

**This file is used for defining input variables for your Packer configuration.It declares the variables `ami_name`,`instance_type`,`region`, `source_ami`, and `ssh_username`.These variables are defined without specific values, indicating that they need to be provided when running Packer commands or through variable files.**

```shell
variable "ami_name" {}
variable "instance_type" {}
variable "region" {}
variable "source_ami" {}
variable "ssh_username" {}

```

***

## Template File Creation

**This file is the main Packer configuration file where you define your build configuration.It starts with specifying required plugins, in this case, the Amazon plugin.It defines a builder named `amazon-ebs` with the alias example, which will create an Amazon Machine Image (AMI) using Amazon Elastic Block Store (EBS).The builder configuration utilizes the input variables declared in `variables.pkr.hcl`.Finally, it specifies the build process by indicating that the source of the build is `source.amazon-ebs.example`.**

```shell
packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1"
    }
  }
}

source "amazon-ebs" "example" {
  ami_name      = var.ami_name
  instance_type = var.instance_type
  region        = var.region
  source_ami    = var.source_ami
  ssh_username  = var.ssh_username
}

build {
  sources = ["source.amazon-ebs.example"]
}

```
***

## IAM User Creation

<img width="688" alt="image" src="https://github.com/avengers-p7/Documentation/assets/156057205/74abfc50-2637-4cf7-8c3c-b91e87f4f5a7">

***

## Policy Creation For IAM User

```shell
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ec2:AttachVolume",
                "ec2:AuthorizeSecurityGroupIngress",
                "ec2:CopyImage",
                "ec2:CreateImage",
                "ec2:CreateKeypair",
                "ec2:CreateSecurityGroup",
                "ec2:CreateSnapshot",
                "ec2:CreateTags",
                "ec2:CreateVolume",
                "ec2:DeleteKeyPair",
                "ec2:DeleteSecurityGroup",
                "ec2:DeleteSnapshot",
                "ec2:DeleteVolume",
                "ec2:DeregisterImage",
                "ec2:DescribeImageAttribute",
                "ec2:DescribeImages",
                "ec2:DescribeInstances",
                "ec2:DescribeInstanceStatus",
                "ec2:DescribeRegions",
                "ec2:DescribeSecurityGroups",
                "ec2:DescribeSnapshots",
                "ec2:DescribeSubnets",
                "ec2:DescribeTags",
                "ec2:DescribeVolumes",
                "ec2:DetachVolume",
                "ec2:GetPasswordData",
                "ec2:ModifyImageAttribute",
                "ec2:ModifyInstanceAttribute",
                "ec2:ModifySnapshotAttribute",
                "ec2:RegisterImage",
                "ec2:RunInstances",
                "ec2:StopInstances",
                "ec2:TerminateInstances"
            ],
            "Resource": "*"
        }
    ]
}
```
***

## Global AWS Configuration

<img width="554" alt="image" src="https://github.com/avengers-p7/Documentation/assets/156057205/2642d989-3ec9-4279-a949-6b565cfec4db">

***

## Path Of Jenkinsfile

<img width="629" alt="image" src="https://github.com/avengers-p7/Documentation/assets/156057205/4f1446c2-a4fe-4f20-ada5-000f1178389a">

***

## Console Output

<img width="948" alt="image" src="https://github.com/avengers-p7/Documentation/assets/156057205/e9bb9411-5761-4e9c-ade1-e7f5ce025abe">

***

<img width="680" alt="image" src="https://github.com/avengers-p7/Documentation/assets/156057205/a8399d73-ad38-4b32-9b26-f649703dc7b2">

***

## Confirmation Of AMI Creation

<img width="817" alt="image" src="https://github.com/avengers-p7/Documentation/assets/156057205/bb2c4eed-af86-41ab-a8a7-a52ebaa3bc25">

***

# Pipeline

```shell
node {
    // Define AWS credentials
    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'credentials', accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
        
        // Change to the directory containing the Packer configuration
        dir('/home/shreya/') {
            // Initialize Packer (if necessary)
            sh '/usr/bin/packer init .'
            
            // Build the AMI
            sh '/usr/bin/packer build .'
        }
    }
}

```

***

# Conclusion

In conclusion, integrating Packer with Jenkins pipelines offers a powerful solution for automating AMI creation in AWS environments. By defining infrastructure as code and leveraging the automation capabilities of Jenkins, teams can ensure consistency, reliability, and scalability in their infrastructure provisioning workflows. With Packer handling the image creation process and Jenkins orchestrating the pipeline execution, teams can streamline their development and deployment processes, ultimately leading to faster delivery of applications and services. 

***

# Contact Information

| **Name** | **Email Address** |
| -------- | ----------------- |
| **Shreya Jaiswal** | shreya.jaiswal.snaatak@mygurukulam.co |

***

# Reference

| **Source** | **Description** |
| ---------- | --------------- |
| [Link](https://devopscube.com/packer-tutorial-for-beginners/) | Reference Link For AMI Creation |
| [Link](https://flugel-it.medium.com/building-and-running-custom-amis-on-aws-using-packer-and-terraform-3db28c968b30) | Reference Link |
| [Link](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/jenkinsPipeline.md) | Generic Doc Link For Intro |
| [Link](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/pipelinePOC.md) | Jenkins POC Link |






