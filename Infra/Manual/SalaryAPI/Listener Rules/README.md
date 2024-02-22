# Setup Listener Rules for Load Balancer ( Salary API )
![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/64e2dc7e-b422-4f2d-bafd-51e475cde508)

| Author                                                           | Created on  | Version    | Last Updated by | Last Updated on |
| ---------------------------------------------------------------- | ----------- | ---------- | --------------- | --------------- |
| **[Harshit Singh](https://github.com/Panu-S-Harshit-Ninja-07)**  | 22-02-2024  | 1.0        | Harshit Singh   | 22-02-2024      |

***
## Table of Contents
1. [Introduction](#Introduction)
2. [Pre-requisites](#Pre-requisites)
3. [Important Ports](#Important-Ports)
4. [Setup](#Setup)
5. [Contact Information](#Contact-Information)
6. [References](#References)

***

## Introduction
**_Load balancing_** in AWS refers to the process of distributing incoming network traffic across multiple servers or resources to ensure high availability and reliability of applications or services. The primary purpose of load balancing is to optimize resource utilization, maximize throughput, minimize response time, and avoid overloading any single resource.

A **_load balancer_** serves as the single point of contact for clients. Clients send requests to the load balancer, and the load balancer sends them to targets, such as EC2 instances. 

To configure your load balancer, you create **_target groups_**, and then register targets with your target groups. 

You also create **_listeners_** to check for connection requests from clients, and **_listener rules_** to route requests from clients to the targets in one or more target groups.

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/35961366-c45c-4b16-b1a1-c3b511578cb7)

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
| **Operating System**      | Supports various OS including Linux, Microsoft Windows Server, CentOS, and Debian.                                                                                                                                                  |
| **Persistent Storage**    | Amazon's Elastic Block Storage (EBS) allows attaching block-level storage volumes to EC2 instances, enabling resizing and attachment to multiple instances simultaneously.                                                         |
| **Elastic IP Addresses**  | Elastic IP service allows associating IP addresses with instances, facilitating easy movement between instances without network administrator intervention. Suitable for failover clusters, load balancing, etc.      |
| **Amazon CloudWatch**     | Monitoring service for collecting, storing, and analyzing historical and real-time performance data of AWS cloud services and applications. Helps optimize costs, resource usage, and scaling based on workload changes.            |
| **Bare-metal Instances** | Virtual servers without virtualization overhead, providing direct access to hardware resources for enhanced security and processing power.                                                                                             |
| **Pause and Resume**      | Allows pausing and resuming instances from the same state, useful for optimizing resource usage and avoiding charges during inactivity.                                                                                               |


***
## Pre-requisites
* Access to the AWS Management Console or AWS CLI with appropriate permissions.

* Understanding of your application's [network requirements](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Design/09-%20Cloud%20Infra%20Design/Cloud-Infra-Design-Dev.md).

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
