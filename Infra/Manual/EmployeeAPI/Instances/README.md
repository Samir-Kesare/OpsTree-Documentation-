# Setup Instances for (Frontend API)

 <img width="360" length="100" alt="Instance" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/c4c13cff-908f-48fb-b8c1-a811c6e751bf"> 

|   Author        |  Created on   |  Version   | Last updated by  | Last edited on |
| --------------- | --------------| -----------|----------------- | -------------- |
| Shantanu |  19-02-2024  |  Version 1 | Vishal  | 19-02-2024    |

***
## Table of Contents
+ [Introduction](#Introduction)
+ [EC2 instance types](#EC2-instance-types)
+ [Why use AWS EC2 Instance](#Why-use-AWS-EC2-Instance)
+ [Pre-requisites](#Pre-requisites)
+ [Steps to Launch an Ec2 Instance](#Steps-to-Launch-an-Ec2-Instance)
+ [Conclusion](#Conclusion)
+ [Contact Information](#Contact-Information)
+ [Resources and References](#Resources-and-References)
  
***
## Introduction

An instance in Amazon EC2 is essentially a virtual server that users can create and manage within the AWS cloud. These instances are configurable with varying amounts of CPU, memory, storage, and networking resources, allowing users to tailor them to specific application requirements. Instances are launched from pre-configured Amazon Machine Images (AMIs), which serve as templates containing the necessary operating system and software configurations. Users can start, stop, terminate, and resize instances as needed, providing scalability and flexibility to accommodate changing workloads and demands. Instances play a vital role in enabling users to deploy and run their applications and services in a scalable, reliable, and cost-effective manner on the AWS platform.

***
## EC2 instance types

| Instance Type          | Description                                                                                     | Common Use Cases                                                                                              |
|------------------------|-------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------|
| **General Purpose**        | Designed for handling a variety of workloads with a high number of CPU cores, on-demand storage, and memory.                                                    | Web server hosting, software development and testing.                                                          |
| **Compute Optimized**      | Optimized for running big data applications requiring large processing power, memory, fast network performance, extensive availability, and high I/O operations. | Scientific and financial modeling, machine learning, enterprise data warehousing, business intelligence.      |
| **Graphics Processing Unit (GPU)** | Accelerates graphics-intensive applications such as gaming and design work.                   | Rendering graphical user interfaces, improving compression speeds, speeding up database queries.                 |
| **Memory Optimized**       | Utilizes high-speed solid-state drives for ultra-fast data access, suitable for memory-intensive applications with less CPU power.                                | Open-source databases, real-time big data analytics, in-memory caches.                                          |
| **Storage Optimized**      | Ideal for high I/O performance applications like NoSQL databases, data processing, warehousing, analytics, and log processing.                                    | NoSQL databases, data processing, warehousing, analytics, log processing.                                      |
| **Micro**                  | Suitable for low-throughput applications, such as small database servers, software testing platforms, or web servers with low transaction rates.                | Small database servers, software testing, web servers with low transaction rates.                                |

***
## Why use AWS EC2 Instance

| Feature               | Description                                                                                                                                                                                                                          |
|-----------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Operating System**      | Supports various OSes including Linux, Microsoft Windows Server, CentOS, and Debian.                                                                                                                                                  |
| **Persistent Storage**    | Amazon's Elastic Block Storage (EBS) allows attaching block-level storage volumes to EC2 instances, enabling resizing and attachment to multiple instances simultaneously.                                                         |
| **Elastic IP Addresses**  | Elastic IP service allows associating IP addresses with instances, facilitating easy movement between instances without network administrator intervention. Suitable for failover clusters, load balancing, etc.      |
| **Amazon CloudWatch**     | Monitoring service for collecting, storing, and analyzing historical and real-time performance data of AWS cloud services and applications. Helps optimize costs, resource usage, and scaling based on workload changes.            |
| **Bare-metal Instances** | Virtual servers without virtualization overhead, providing direct access to hardware resources for enhanced security and processing power.                                                                                             |
| **Pause and Resume**      | Allows pausing and resuming instances from the same state, useful for optimizing resource usage and avoiding charges during inactivity.                                                                                               |


***
## Pre-requisites

  * Active AWS Acount.

***
## Steps to Launch an Ec2 Instance

  **Step-1 :** Go to the AWS console and sign into your account first.
 
  **Step-2 :** After logging into the Amazon Management Console, visit the EC2 Dashboard .
 
  **Step-3 :** Choose `Launch Instance` from the panel. 

<img width="760" length="100" alt="Instance" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/c056ec77-d471-4309-9500-bfa7e05d6af1">

 **Step-4 :** Choose an appropriate name for the instance and choose Ubuntu AMI

 <img width="760" length="100" alt="Instance" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/996e6018-08ec-42ce-a5f7-5718b368f5d5">

  **Step-5 :** Select the instance type as t2-micro. Generate a key pair with an appropriate name.In the network settings, pick a VPC; in this case, choose the `Dev-VPC`. Choose a subnet , preferably a `Backend-Pvt-subnet`. Disable auto-assign IP.
  
   <img width="760" length="100" alt="Instance" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/57fd5a64-9733-4b6d-bc1d-2d2093832c5e">
  
  **Step-6 :** Navigate to the security group settings, Choose your security group .eg `Backend-sg` ,Leave other settings as default for now. Finally click on launch instance. That's it, we have successfully launched the instance.
  
 <img width="760" length="100" alt="Instance" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/03958a2c-4adc-4337-b800-25e8db2e4f7d">

> [!NOTE]
> * After successfully launching the instance follow this [**Link**](https://github.com/CodeOps-Hub/Documentation/blob/main/OT%20Micro%20Services/Application/Employee_API/README.md) to setup Frontend-API.

> [!Important]
> * After configuring Load-Balancer, use the DNS of the load-balancer and hit in web browser, you wil see the  
  UI of Frontend-API. [**DNS**]() 
***
## Conclusion

Amazon EC2 offers customizable virtual servers (instances) in the cloud. Users can tailor resources to fit specific needs and choose from various instance types optimized for different workloads. Key features include support for multiple operating systems, flexible storage options, elastic IP addresses, monitoring with CloudWatch, bare-metal instances, and the ability to pause and resume instances. EC2 provides scalability, reliability, and cost-efficiency for deploying applications and services on the AWS platform.

***
## Contact Information
| Name | Email address |
| ---- | ------------- |
| Shantanu | shantanu.chauhan.snaatak@mygurukulam.co |
***
## Resources and References
|  **Description** |   **Source** |
| ---------------- | ------------ |
| Poc Document | [Link](https://github.com/CodeOps-Hub/Documentation/blob/main/OT%20Micro%20Services/Application/Employee_API/README.md) |
| About Instance | [Link](https://aws.amazon.com/what-is/cloud-instances/#:~:text=You%20can%20run%20multiple%20virtual,of%20sharing%20and%20scaling%20resources.) |
| Infra Diagram | [Link](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Design/09-%20Cloud%20Infra%20Design/Cloud-Infra-Design-Dev.md) | 


***
