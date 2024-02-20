# PostgreSQL Manual Security Group Setup

| **Author**           | **Created On** | **Last Updated** | **Document Version** |
| -------------------- | -------------- | ---------------- | -------------------- |
| **Vikram Bisht**     | 19-02-2024     | 20-02-2024       | V1                |


# Table of Contents

1. [Introduction](#introduction)
2. [Pre-requisites](#pre-requisites)
3. [Steps](#steps)
4. [Contact Information](#contact-information)
5. [Resources and References](#resources-and-references)


## Introduction

This document provides a guide for setting up security groups for PostgreSQL. By configuring inbound and outbound rules, you can control network traffic to and from your PostgreSQL instances, enhancing the security of your infrastructure.


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
Attached the backend security group as the source for the PostgreSQL-Security group:

* Click on the Inbound Rules tab.

* Click the Edit Inbound Rules button.

| Security Group Name                | Inbound Rule Port | Inbound Rule Source |
|------------------------------------|-------------------|---------------------|
| PostgreSQL Security Group          | 22                | 20.0.0.0/28         |
| PostgreSQL Security Group          | 5432              | PostgreSQL-sg       |


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

| Name               | Email Address                               |
| ------------------ | ------------------------------------------- |
| Vikram Bisht       | Vikram.bisht@opstree.com                    |

---

## Resources and References

| Description           | References                                                        |
| --------------------- | ----------------------------------------------------------------- |
| Documentation Template | [Link](https://github.com/OT-MICROSERVICES/documentation-template/wiki/Application-Template) |
| Dev Infra Design      | [Link](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Design/09-%20Cloud%20Infra%20Design/Cloud-Infra-Design-Dev.md) |
