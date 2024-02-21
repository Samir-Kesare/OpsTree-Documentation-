# Instance Setup for Attendance API

<img width="512" alt="Screenshot 2024-02-21 at 10 24 44 AM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/e5cdbef2-07a6-41de-964c-1ebc948d496d">


| Author                                                           | Created on  | Version    | Last Updated by | Last Updated on |
| ---------------------------------------------------------------- | ----------- | ---------- | --------------- | --------------- |
| Vidhi Yadav  | 21st Feb 2024 | 1.0        | Vidhi Yadav   | 21st Feb 2024      |

***
## Table of Contents
+ [Introduction](#Introduction)
+ [EC2 Features](#key-features)
+ [Instance types](#EC2-instance-types)
+ [Pre-requisites](#Pre-requisites)
+ [Launch Ec2 Instance](#Steps-to-Launch-an-Ec2-Instance)
+ [Output](#output)
+ [Conclusion](#Conclusion)
+ [Contact Information](#Contact-Information)
+ [References](#References)
  
***
## Introduction

This document provides step-by-step instructions for setting up an Amazon EC2 instance.

**Amazon Elastic Compute Cloud (EC2)** is a web service offered by Amazon Web Services (AWS) that are virtual servers which you can use to run applications and workloads.Instances are launched from pre-configured Amazon Machine Images (AMIs), which serve as templates containing the necessary operating system and software configurations. Users can start, stop, terminate, and resize instances as needed, providing scalability and flexibility to accommodate changing workloads and demands.

![ec2-basic-arch](https://github.com/CodeOps-Hub/Documentation/assets/156056349/72351bcb-ec46-4d65-a260-1d750701fb9a)

***
## Key Features

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
## Launch an Ec2 Instance

1. Go to the AWS console and sign into your account first.
 
2. After logging into the Amazon Management Console, visit the EC2 Dashboard .

  <img width="1088" alt="Screenshot 2024-02-21 at 4 42 55 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/eaff3a4b-12cf-4fbd-868a-ca467639455f">

3. Click on the **Launch Instance** button to start the instance creation wizard. 

<img width="872" alt="Screenshot 2024-02-21 at 4 44 13 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/777657ff-a99e-4760-bce0-3f6f887f9b21">

4. Under **Name and tags**, for **Name**, enter a descriptive name for your instance.

  <img width="828" alt="Screenshot 2024-02-21 at 12 49 00 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/beae9961-550f-4ec2-ad46-22672c918b50">

5. Select an Amazon Machine Image (AMI) based on your requirements (e.g., Amazon Linux 2, Ubuntu, etc.).

  - Choose Quick Start, and then choose your preferred AMI.

<img width="788" alt="Screenshot 2024-02-21 at 12 49 26 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/0c2e0dc2-7b11-457e-9df1-bfb570bce665">

6. From the "Instance Type" list, choose the appropriate instance type based on your workload requirements. This determines the computing power, memory, and storage capacity of your EC2 instance.
  
<img width="812" alt="Screenshot 2024-02-21 at 12 49 48 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/aa2538a3-a34c-496b-8850-3db4909a364f">
  
7. Select an existing key pair from the dropdown menu if you have one, or create a new key pair .

<img width="797" alt="Screenshot 2024-02-21 at 1 19 31 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/9c4c2f5f-2fcd-4ca2-9a89-74066020821e">

8. Choose the Virtual Private Cloud (VPC) from the dropdown menu. In this case, we will select **Dev-VPC** as the VPC.
    - From the available subnets within the selected VPC, choose the appropriate subnet. Here, we will select **Backend-Pvt-subnet**.
    - Ensure to disable auto-assign IP for the selected subnet to prevent automatic assignment of public IP.  
       
<img width="779" alt="Screenshot 2024-02-21 at 1 19 47 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/ffc14f3d-8763-4f8b-8c98-100be9e5d395">
  
9. Navigate to the security group settings and select your designated security group, such as Attendance-sg. Leave all other settings as default for now. 

<img width="778" alt="Screenshot 2024-02-21 at 12 51 27 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/a9c327db-79f2-44ea-81d5-0fc90f40d33c">

10. Specify the size of the **root volume**. Add additional volumes if needed. Finally, click on **Launch Instance**. After this step, your instance would successfully be launched!

<img width="796" alt="Screenshot 2024-02-21 at 12 52 01 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/697fe22d-c390-4f01-98c7-f1a8530b3517">

11. On the **Instances** screen, you can track the launch status. Instances typically take a short time to launch.

<img width="713" alt="Screenshot 2024-02-21 at 12 52 49 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/cab4dc52-462f-4286-84da-93f40daa0e85">
  
* It may take a few minutes for the instance to become available for connection. Verify that your instance has passed its status checks by checking the **Status check** column.
  
<img width="1050" alt="Screenshot 2024-02-21 at 5 08 51 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/f7bbcf95-d022-45b4-af16-f0bf7fc0035d">



> [!NOTE]
> * After successfully launching the instance follow this [**Attendance API Document**](https://github.com/CodeOps-Hub/Documentation/blob/main/OT%20Micro%20Services/Application/Attendance_API/README.md) to setup Attendance-API.

***
# Output 

* After setting up the Attendance API on your instance, you can access the Swagger API documentation at http://instance-IP:8080/apidocs/. To view the Swagger documentation, you can use the following command with curl:
```
curl http://instance-IP:8080/apidocs/
```
* Make sure to replace `instance-IP` with the actual Public IP address of your EC2 instance.

* This command will enable you to determine whether the Swagger API is visible on port 8080 or not.

<img width="1149" alt="Screenshot 2024-02-21 at 5 26 21 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/5129fb71-a031-4cd0-870e-1b3623d5a6ca">

***
## Conclusion

In this documentation, we have provided comprehensive instructions for setting up an Amazon EC2 instance. By following these steps, you have successfully launched an EC2 instance tailored to your specific requirements, including selecting the instance type, configuring network settings, and choosing appropriate security groups.

***
## Contact Information

|     Name         | Email  |
| -----------------| ------------------------------------ |
| Vidhi Yadav    | vidhi.yadhav.snaatak@mygurukulam.co |
***

## References

| Description                                   | References  
| --------------------------------------------  | -------------------------------------------------|
| attendance Documentation Template | [Link](https://github.com/CodeOps-Hub/Documentation/blob/main/OT%20Micro%20Services/Application/Attendance_API/README.md) |
| Dev Infra Design      | [Link](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Design/09-%20Cloud%20Infra%20Design/Cloud-Infra-Design-Dev.md) |
| Setup Instance | [Link](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EC2_GetStarted.html) |
