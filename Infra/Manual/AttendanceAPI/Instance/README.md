# Instance Setup for Attendance API

<img width="512" alt="Screenshot 2024-02-21 at 10 24 44 AM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/e5cdbef2-07a6-41de-964c-1ebc948d496d">


| Author                                                           | Created on  | Version    | Last Updated by | Last Updated on |
| ---------------------------------------------------------------- | ----------- | ---------- | --------------- | --------------- |
| Vidhi Yadav  | 21st Feb 2024 | 1.0        | Vidhi Yadav   | 21st Feb 2024      |

***
## Table of Contents
+ [Introduction](#Introduction)
+ [EC2 Instance](#EC2-Instance)
+ [EC2 instance types](#EC2-instance-types)
+ [Pre-requisites](#Pre-requisites)
+ [Launch Ec2 Instance](#Steps-to-Launch-an-Ec2-Instance)
+ [Conclusion](#Conclusion)
+ [Contact Information](#Contact-Information)
+ [References](#References)
  
***
## Introduction

This document provides step-by-step instructions for setting up an Amazon EC2 instance.

![ec2-basic-arch](https://github.com/CodeOps-Hub/Documentation/assets/156056349/72351bcb-ec46-4d65-a260-1d750701fb9a)

## EC2

Amazon Elastic Compute Cloud (EC2) is a web service offered by Amazon Web Services (AWS) that are virtual servers which you can use to run applications and workloads.Instances are launched from pre-configured Amazon Machine Images (AMIs), which serve as templates containing the necessary operating system and software configurations. Users can start, stop, terminate, and resize instances as needed, providing scalability and flexibility to accommodate changing workloads and demands.


| Key Feature       | Description                                                                                                                            |
|-------------------|----------------------------------------------------------------------------------------------------------------------------------------|
| Scalability       | EC2 allows you to scale compute capacity up or down based on demand, easily increasing or decreasing the number of instances as needed. |
| Flexibility       | Offers a wide selection of instance types optimized for various use cases, including compute, memory, and storage optimization.        |
| Customization     | Provides full control over instance configuration, including OS choice, instance type, storage, and network settings.                   |
| Pay-As-You-Go    | Pricing model where you only pay for the compute capacity used, suitable for both small startups and large enterprises.                  |

***
## Instance types

| Instance Type          | Description                                                                                     | Common Use Cases                                                                                              |
|------------------------|-------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------|
| **General Purpose**        | Designed for handling a variety of workloads with a high number of CPU cores, on-demand storage, and memory.                                                    | Web server hosting, software development and testing.                                                          |
| **Compute Optimized**      | Optimized for running big data applications requiring large processing power, memory, fast network performance, extensive availability, and high I/O operations. | Scientific and financial modeling, machine learning, enterprise data warehousing, business intelligence.      |
| **Graphics Processing Unit (GPU)** | Accelerates graphics-intensive applications such as gaming and design work.                   | Rendering graphical user interfaces, improving compression speeds, speeding up database queries.                 |
| **Memory Optimized**       | Utilizes high-speed solid-state drives for ultra-fast data access, suitable for memory-intensive applications with less CPU power.                                | Open-source databases, real-time big data analytics, in-memory caches.                                          |
| **Storage Optimized**      | Ideal for high I/O performance applications like NoSQL databases, data processing, warehousing, analytics, and log processing.                                    | NoSQL databases, data processing, warehousing, analytics, log processing.                                      |
| **Micro**                  | Suitable for low-throughput applications, such as small database servers, software testing platforms, or web servers with low transaction rates.                | Small database servers, software testing, web servers with low transaction rates.                                |
                                            
***
## Pre-requisites

| Requirement                                               | Description                                                                                       |
|-----------------------------------------------------------|---------------------------------------------------------------------------------------------------|
| AWS account    | Users need to have an AWS account with appropriate permissions to create and manage EC2 instances.       |                    
| SSH key pair       | If users plan to access their EC2 instances via SSH, they need to generate an SSH key pair         |


***
## Steps to Launch an Ec2 Instance

  **Step-1 :** Go to the AWS console and sign into your account first.
 
  **Step-2 :** After logging into the Amazon Management Console, visit the EC2 Dashboard .
 
  **Step-3 :** Choose `Launch Instance` from the panel. 

  ![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/7e7c1c3b-624e-49ee-975b-99a3f154078a)

  **Step-4 :** Under **Name and tags**, for **Name**, enter a descriptive name for your instance.
  
  ![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/04a13c51-3270-4600-b9ee-2720fb1d9538)

  **Step-5 :** Under Application and OS Images (Amazon Machine Image), do the following:

  - Choose Quick Start, and then choose Amazon Linux. This is the operating system (OS) for your instance.

  - From Amazon Machine Image (AMI), select an Amazon Machine Image (AMI).

   ![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/929ae488-96dc-4ba3-b303-c1a0f9c314ed)

  
  **Step-6 :** Select Instance type, Key Pair and Network 
  - Under Instance type, from the Instance type list,
  - Slect an existing or create a new key pair with an appropriate name.
  - In the network settings, select a VPC; in this case, we will select `Dev-VPC`.
  - Select a subnet , here `Backend-Pvt-subnet` and disable auto-assign IP.
  
  ![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/e9cbf3a1-3a50-4de4-9f91-b0a6fea36ac4)

  **Step-7 :** Navigate to the security group settings, Choose your security group .eg `Frontend-sg` ,Leave other settings as default for now. Finally click on launch instance. That's it, we      have successfully launched the instance.

  ![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/72ad719e-ffc2-49a6-8b42-a3e09a32c3a5)

  **Step-8 :** A confirmation page lets you know that your instance is launching. Choose **View all instances** to close the confirmation page and return to the console.

  On the **Instances** screen, you can view the status of the launch. It takes a short time for an instance to launch. 

  It can take a few minutes for the instance to be ready for you to connect to it. Check that your instance has passed its status checks; you can view this information in the **Status check**     
  column.
  
  ![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/bfb5ee1b-70ca-4327-be01-543c3d3764fd)


> [!NOTE]
> * After successfully launching the instance follow this [**Salary API Setup Document**](https://github.com/CodeOps-Hub/Documentation/blob/main/OT%20Micro%20Services/Application/Salary%20API/README.md).

***
## Conclusion

Amazon EC2 offers customizable virtual servers (instances) in the cloud. Users can tailor resources to fit specific needs and choose from various instance types optimized for different workloads. Key features include support for multiple operating systems, flexible storage options, elastic IP addresses, monitoring with CloudWatch, bare-metal instances, and the ability to pause and resume instances. EC2 provides scalability, reliability, and cost-efficiency for deploying applications and services on the AWS platform.

***
## Contact Information

|     Name         | Email  |
| -----------------| ------------------------------------ |
| Harshit Singh    | harshit.singh.snaatak@mygurukulam.co |
***

## References

| Description                                   | References  
| --------------------------------------------  | -------------------------------------------------|
| Documentation Template | [Link](https://github.com/OT-MICROSERVICES/documentation-template/wiki/Application-Template) |
| Dev Infra Design      | [Link](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Design/09-%20Cloud%20Infra%20Design/Cloud-Infra-Design-Dev.md) |
| Setup Instance | [Link](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EC2_GetStarted.html) |
