# Security Group Setup for Attendance API

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056349/00b05f8a-24ba-4ab4-83a2-805a7c79459e)


| Author                                                           | Created on  | Version    | Last Updated by | Last Updated on |
| ---------------------------------------------------------------- | ----------- | ---------- | --------------- | --------------- |
| Vidhi Yadav  | 21st Feb 2024  | 1.0        | Vidhi Yadav  | 21st Feb 2024     |


## Table  of Contents

1. [Introduction](#Introduction)
2. [Key Feature](#Key-principles-of-security-groups)
3. [Pre-requisites](#Pre-requisites)
4. [Important Ports](#Important-Ports)
5. [Setup](#Setup)
6. [Conclusion](#conclusion)
7. [Contact Information](#Contact-Information)
8. [References](#References)
***

## Introduction

This document serves as a comprehensive manual for establishing security groups for the Attendance API. Through the configuration of inbound and outbound rules, you can gain the ability to manage network traffic flowing to and from your Attendance API instances, thereby fortifying the security of your infrastructure.

A security group functions like a gatekeeper, dictating the types of traffic permitted to enter and exit the resources it's linked to. For instance, upon linking a security group with an EC2 instance, it governs both incoming and outgoing traffic for that instance.

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056349/751dccb2-a2de-4f9c-800b-5c73bf0dce97)


***
# Key Principles of Security Groups
| Feature                                             | Description                                                                                                                                   |
|-----------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------|
| **Traffic Filtering**                               | Security groups act as virtual firewalls controlling inbound and outbound traffic for instances within a subnet, based on user-defined rules. |
|                                                     | Rules can specify allowed traffic based on IP ranges and ports, enhancing network security by filtering incoming and outgoing traffic. |
| **Granular Control**                            | Users can define rules at the instance level, specifying allowed protocols, ports, and source/destination IP ranges for inbound and outbound traffic. |                                                             |


***
## Pre-requisites

| Prerequisite                                | Description                                           |
|---------------------------------------------|-------------------------------------------------------|
| Access to the AWS Management Console        | Ability to log in and navigate the AWS Management Console. |
| Basic understanding of networking concepts | Fundamental knowledge of networking principles such as IP addressing, subnets, routing, etc. |
| Familiarity with EC2 instances              | Understanding of Amazon EC2 (Elastic Compute Cloud) instances, including launching, configuring, and managing them. |


***
## Important Ports
### Inbound Rule
| Security Group Name | Inbound Rule Port | Inbound Rule Source |
|---------------------|-------------------|---------------------|
| Backend-sg          | 22                | 20.0.0.0/28         |
| Backend-sg          | 8080              | Frontend-lb-sg          |

### Outbound Rule
| Security Group Name | Outbound Rule Port | Outbound Rule Protocol | Outbound Rule Destination |
|---------------------|---------------------|------------------------|--------------------------|
| *                   | All traffic         | All                    | 0.0.0.0/0                | 

***
## Setup

1. **Access the AWS Management Console**

Navigate to the AWS Management Console website and log in using your AWS account credentials.

2. **Open the EC2 Dashboard**

Once logged in, locate the "Services" dropdown menu at the top of the page. Under the "Compute" section, choose "EC2".

Under the "Compute" section, select EC2.

3. **Navigate to Security Groups**

Inside the EC2 Dashboard, find and click on the "Security Groups" option located in the left-hand navigation pane.

<img width="716" alt="Screenshot 2024-02-21 at 10 09 19 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/efb9cb93-febc-4308-971b-779a746dd4e1">

4. **Choose or Create a Security Group**

You can either select an existing security group or create a new one. To create a new security group, click on the "Create Security Group" button. Provide a name, description, and select the VPC where you want to associate this security group.

  <img width="1070" alt="Screenshot 2024-02-21 at 10 11 54 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/1a99909e-9b56-43c7-a880-bcee90ea4b84">

<img width="820" alt="Screenshot 2024-02-21 at 10 13 09 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/3ca3bd95-d9f7-4548-8dae-4dac660aa04d">


5. **Define Inbound Rules**

Inbound traffic on port 8080 is restricted to originate from the frontend subnet. This rule allows the attendance API instance to receive incoming requests from the frontend instances for web application access.

Attached the backend security group as the source for your backend group:

* Click on the Inbound Rules tab.

* Click the Edit Inbound Rules button.

| Security Group Name | Inbound Rule Port | Inbound Rule Source |
|---------------------|-------------------|---------------------|
| Backend-sg          | 22                | 20.0.0.0/28         |
| Backend-sg          | 8080              | Frontend-lb-sg          |

<img width="1240" alt="Screenshot 2024-02-21 at 10 14 45 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/dc475356-6e70-473d-bf7e-564095bc0eb0">


6. **Define Outbound Rules**

* Click on the Outbound Rules tab.

* Click the Edit Outbound Rules button.

| Security Group Name | Outbound Rule Port | Outbound Rule Protocol | Outbound Rule Destination |
|---------------------|---------------------|------------------------|--------------------------|
| *                   | All traffic         | All                    | 0.0.0.0/0                | 

<img width="1228" alt="Screenshot 2024-02-21 at 10 14 50 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/fdcb0c53-14fd-47fb-9dd4-141e55bd496c">

7. Finally, click on **Create Security Group** and you're all set!
***

# Conclusion


In conclusion, setting up Security Groups in AWS is an essential aspect of ensuring the security and integrity of your cloud infrastructure. By leveraging the key features of Security Groups with other AWS services, you can establish robust security policies that safeguard your EC2 instances and data from unauthorized access and malicious threats.

With Security Groups, you have the flexibility to define and manage inbound and outbound traffic rules efficiently, adapt to evolving security requirements, and maintain consistency across your infrastructure.

***
## Contact Information

|     Name         | Email  |
| -----------------| ------------------------------------ |
| Vidhi Yadav    | vidhi.yadav.snaatak@mygurukulam.co |
***

## References

| Description                                   | References  
| --------------------------------------------  | -------------------------------------------------|
| Dev Infra Design      | https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Design/09-%20Cloud%20Infra%20Design/Cloud-Infra-Design-Dev.md |
| Security Group | https://docs.aws.amazon.com/vpc/latest/userguide/vpc-security-groups.html |
