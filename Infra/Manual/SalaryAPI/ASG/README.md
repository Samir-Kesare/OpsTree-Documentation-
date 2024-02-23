# Setup Listener Rules for Load Balancer ( Salary API )
![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/64e2dc7e-b422-4f2d-bafd-51e475cde508)

| Author                                                           | Created on  | Version    | Last Updated by | Last Updated on |
| ---------------------------------------------------------------- | ----------- | ---------- | --------------- | --------------- |
| **[Harshit Singh](https://github.com/Panu-S-Harshit-Ninja-07)**  | 22-02-2024  | 1.0        | Harshit Singh   | 22-02-2024      |

***
## Table of Contents
1. [Introduction](#Introduction)
2. [Pre-requisites](#Pre-requisites)
3. [Steps to setup Listener Rules for Load Balancer](#Steps-to-setup-Listener-Rules-for-Load-Balancer)
4. [Output](#Output)
5. [Conclusion](#Conclusion)
6. [Contact Information](#Contact-Information)
7. [References](#References)

***

## Introduction
**_Load balancing_** in AWS refers to the process of distributing incoming network traffic across multiple servers or resources to ensure high availability and reliability of applications or services. The primary purpose of load balancing is to optimize resource utilization, maximize throughput, minimize response time, and avoid overloading any single resource.

A `load balancer` serves as the single point of contact for clients. Clients send requests to the load balancer, and the load balancer sends them to targets, such as EC2 instances. 

To configure your load balancer, you create `target groups`, and then register targets with your target groups. 

You also create `listeners` to check for connection requests from clients, and `listener rules` to route requests from clients to the targets in one or more target groups.

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/35961366-c45c-4b16-b1a1-c3b511578cb7)

***

## Pre-requisites
* Access to the AWS Management Console or AWS CLI with appropriate permissions.

* Understanding of your application's [network requirements](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Design/09-%20Cloud%20Infra%20Design/Cloud-Infra-Design-Dev.md).

***
## Steps to setup Listener Rules for Load Balancer

 
> [!NOTE]
> Please note that before hitting the DNS, ensure that API is running

## Output

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/bd814bb6-da87-4d0b-804a-e73ec1b15b9f)

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/96f01a2c-8f67-41ef-96d6-bb179286760c)
***
## Conclusion

This document offers a streamlined approach to implementing listener rules for load balancers within AWS. By understanding the significance of load balancing and the benefits provided by AWS Load Balancer, users can effectively optimize their application's performance, availability, and scalability. The step-by-step instructions provided in the document enable users to configure target groups, register targets, set up a load balancer and listener, and conduct thorough testing. This process ensures efficient traffic management, enhancing the overall reliability and responsiveness of applications hosted on AWS infrastructure.

***
## Contact Information

|     Name         | Email  |
| -----------------| ------------------------------------ |
| Harshit Singh    | harshit.singh.snaatak@mygurukulam.co |
***

## References

| Description                                   | References  
| --------------------------------------------  | -------------------------------------------------|
| Documentation Template | https://github.com/OT-MICROSERVICES/documentation-template/wiki/Application-Template |
| Dev Infra Design      | https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Design/09-%20Cloud%20Infra%20Design/Cloud-Infra-Design-Dev.md |
| Launch Template | https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/create-launch-template.html |
| Auto Scaling Group | https://docs.aws.amazon.com/autoscaling/ec2/userguide/create-asg-launch-template.html |
