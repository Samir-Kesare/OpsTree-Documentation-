# Salary API Security Group Setup

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


## Pre-requisites
* Access to the AWS Management Console or AWS CLI with appropriate permissions.

* Understanding of your application's network requirements.

## Steps
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
| Scylla-sg          | 22                | 20.0.0.0/28         |
| Scylla-sg          | 9042              | Backend-sg          |


![image](https://github.com/CodeOps-Hub/Documentation/assets/156056709/a2c7a204-f43a-4689-8c19-853afc0446ab)



**Step-6 Define Outbound Rules**

* Click on the Outbound Rules tab.

* Click the Edit Outbound Rules button.

| Security Group Name | Outbound Rule Port | Outbound Rule Protocol | Outbound Rule Destination |
|---------------------|---------------------|------------------------|--------------------------|
| *                   | All traffic         | All                    | 0.0.0.0/0                | 


![image](https://github.com/CodeOps-Hub/Documentation/assets/156056709/1d86e360-8cd3-4edd-959b-fbab18a4e0b2)



**Output**

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056709/7237be06-321a-4953-b804-e9799bf18ab8)

---

## Contact Information

|     Name         | Email  |
| -----------------| ------------------------------------ |
| Harshit Singh    | harshit.singh.snaatak@mygurukulam.co |
***

## References

| Description                                   | References  
| --------------------------------------------  | -------------------------------------------------|
| Clean Workspace | https://www.jenkins.io/doc/pipeline/tour/running-multiple-steps/#finishing-up |
| Pipeline (Generic Doc) | https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/jenkinsPipeline.md |
| Create Pipeline (Generic Doc)| https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/pipelinePOC.md |
| Pipeine Syntax | https://www.jenkins.io/doc/book/pipeline/#pipeline-syntax-overview |
| Pipeline Concepts | https://www.jenkins.io/doc/book/pipeline/#pipeline-concepts |
