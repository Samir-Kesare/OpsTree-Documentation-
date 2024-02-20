# Security Group Setup ( Salary API )
![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/cf209d64-d328-430c-b815-0035cd4d9ba2)

| Author                                                           | Created on  | Version    | Last Updated by | Last Updated on |
| ---------------------------------------------------------------- | ----------- | ---------- | --------------- | --------------- |
| **[Harshit Singh](https://github.com/Panu-S-Harshit-Ninja-07)**  | 20-02-2024  | 1.0        | Harshit Singh   | 20-02-2024      |


## Table  of Contents

1. [Introduction](#Introduction)
2. [Pre-requisites](#Pre-requisites)
3. [Important Ports](#Important-Ports)
4. [Flow Diagram](#Flow-Diagram)
5. [Setup](#Setup)
6. [Contact Information](#Contact-Information)
7. [References](#References)
***

## Introduction

This document provides a guide for setting up security groups for Salary API. By configuring inbound and outbound rules, you can control network traffic to and from your Salary API instances, enhancing the security of your infrastructure.

A security group controls the traffic that is allowed to reach and leave the resources that it is associated with. For example, after you associate a security group with an EC2 instance, it controls the inbound and outbound traffic for the instance.

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/c2985136-71f2-41a9-b796-d8dc9d9af76b)

***
## Pre-requisites
* Access to the AWS Management Console or AWS CLI with appropriate permissions.

* Understanding of your application's [network requirements](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Design/09-%20Cloud%20Infra%20Design/Cloud-Infra-Design-Dev.md).
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
**Step-1 Access the AWS Management Console**

Navigate to the AWS Management Console and sign in to your AWS account.

**Step-2 Open the EC2 Dashboard**

In the AWS Management Console, go to the Services drop down.

Under the "Compute" section, select EC2.

**Step-3 Navigate to Security Groups**

In the EC2 Dashboard, locate and click on Security Groups in the left navigation pane.

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056709/54e01965-722a-4db3-a66a-cd15f0fac52b)

**Step-4 Choose or Create a Security Group**

* Select an existing security group or create a new one by clicking the Create Security Group button.

* Provide a name, description, and VPC assignment for your new security group.

  ![image](https://github.com/CodeOps-Hub/Documentation/assets/156056709/82f6ed9b-8ea9-4092-9e3a-db318d806168)
  

**Step-5 Define Inbound Rules**
Attached the backend security group as the source for the Scylla-Security group:

* Click on the Inbound Rules tab.

* Click the Edit Inbound Rules button.

| Security Group Name | Inbound Rule Port | Inbound Rule Source |
|---------------------|-------------------|---------------------|
| Backend-sg          | 22                | 20.0.0.0/28         |
| Backend-sg          | 8080              | Frontend-lb-sg          |

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/d0c7fb00-c625-4547-aef3-81449b94ee63)

**Step-6 Define Outbound Rules**

* Click on the Outbound Rules tab.

* Click the Edit Outbound Rules button.

| Security Group Name | Outbound Rule Port | Outbound Rule Protocol | Outbound Rule Destination |
|---------------------|---------------------|------------------------|--------------------------|
| *                   | All traffic         | All                    | 0.0.0.0/0                | 

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/09859986-25c0-420f-a966-f90e7c28d3b3)
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
| Security Group | https://docs.aws.amazon.com/vpc/latest/userguide/vpc-security-groups.html |
