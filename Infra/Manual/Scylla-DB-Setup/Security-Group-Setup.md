# Scylla-DB Manual Security Group Setup

| **Author**           | **Created On** | **Last Updated** | **Document Version** |
| -------------------- | -------------- | ---------------- | -------------------- |
| **Parasharam Desai** | 19-02-2024     | 19-02-2024       | V-01                |

## Introduction

This document provides a guide for setting up security groups for Scylla-DB. By configuring inbound and outbound rules, you can control network traffic to and from your Scylla-DB instances, enhancing the security of your infrastructure.


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

**Step-6 Define Outbound Rules**

* Click on the Outbound Rules tab.

* Click the Edit Outbound Rules button.
![image](https://github.com/CodeOps-Hub/Documentation/assets/156056709/a2c7a204-f43a-4689-8c19-853afc0446ab)

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056709/1d86e360-8cd3-4edd-959b-fbab18a4e0b2)



---

## Contact Information

| Name               | Email Address                               |
| ------------------ | ------------------------------------------- |
| Parasharam Desai   | parasharam.desai.snaatak@mygurukulam.co     |

---

## Resources and References

| Description           | References                                                        |
| --------------------- | ----------------------------------------------------------------- |
| Documentation Template | [Link](https://github.com/OT-MICROSERVICES/documentation-template/wiki/Application-Template) |
| Dev Infra Design      | [Link](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Design/09-%20Cloud%20Infra%20Design/Cloud-Infra-Design-Dev.md) |
