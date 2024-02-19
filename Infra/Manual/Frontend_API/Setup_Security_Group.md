# Setup Security Group for (Frontend API)

 <img width="300" length="100" alt="Security" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/cb9f041f-a770-49f0-94a0-a0aaf06756eb"> 


|   Author        |  Created on   |  Version   | Last updated by  | Last edited on |
| --------------- | --------------| -----------|----------------- | -------------- |
| Vishal Kumar Kesarwani |  19-02-2024  |  Version 1 | Vishal  | 19-02-2024    |

***
## Table of Contents
+ [Introduction](#Introduction)
+ [How Do AWS Security Groups Work](#How-Do-AWS-Security-Groups-Work)
+ [Why Use Security Group](#Why-Use-Security-Group)
+ [AWS Security Groups Rules](#AWS-Security-Groups-Rules)
+ [Pre-requisites](#Pre-requisites)
+ [Steps to Create a Security Group](#Steps-to-Create-a-Security-Group)
+ [Conclusion](#Conclusion)
+ [Contact Information](#Contact-Information)
+ [Resources and References](#Resources-and-References)
  
***
## Introduction

<img width="300" length="100" alt="Security" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/722e1aca-906a-48cd-a904-b4bc2b4d3394"> 

AWS Security Groups are a vital component of AWS's network security and cloud data security. They act as a virtual firewall that controls inbound and outbound traffic to and from AWS resources. Each AWS resource, such as Amazon Elastic Compute Cloud (EC2) instances or Relational Database Service (RDS) instances, can be associated with one or more security groups.

Security groups operate at the instance level, meaning that they define rules that specify what traffic is allowed to reach the associated resources. These rules can be applied to both incoming and outgoing traffic, providing a granular way to manage access to your AWS resources.

***
## How Do AWS Security Groups Work

Here's a simplified breakdown of the process:

* **Inbound Traffic :** When an incoming packet arrives at an AWS resource, AWS evaluates the rules defined in the associated security group. If the packet matches any of the rules allowing the traffic, it is permitted; otherwise, it is denied.

* **Outbound Traffic :** Outbound traffic from an AWS resource is also controlled by the security group's rules. It follows the same principle: traffic is allowed or denied based on the rules defined for outbound traffic.
***
## Why Use Security Group

| Reasons to Use Security Groups in AWS                                              | Description                                                                                                                                                      |
|------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Controlled Access**                                                                   | Security Groups act as virtual firewalls, controlling inbound and outbound traffic to AWS resources. They allow you to define which traffic is allowed or denied.  |
| **Granular Security**                                                                   | You can specify security group rules at the port level and for specific IP ranges or other security groups, enabling precise control over access to resources.       |
| **Dynamic Adaptation**                                                                  | Security Groups can be updated in real-time, enabling quick adjustments to changing security requirements or responses to emerging threats.                         |
| **Scalability and Flexibility**                                                         | Security Groups can scale with your infrastructure and easily be applied to new resources or modified, providing flexibility without compromising security.           |
| **Centralized Management**                                                              | They can be managed centrally through the AWS Management Console, CLI, or API, ensuring consistent administration and configuration across your AWS environment.        |


***
## AWS Security Groups Rules

AWS Security Groups are defined by a set of rules that specify which traffic is allowed and which is denied. Each rule consists of the following components:

 * **Type:** The protocol type (e.g., TCP, UDP, ICMP) to which the rule applies.
 * **Port Range:** The range of ports to which the rule applies.
 * **Source/Destination:** The IP range or security group that is allowed to access the resource.
 * **Allow/Deny:** Whether the rule allows or denies traffic that matches the rule criteria.

***

## Pre-requisites
 * Active AWS Account.

***
## Steps to Create a Security Group 

  **Step-1 :** Go to the AWS console and sign into your account first.
 
  **Step-2 :** Visit the EC2 Dashboard after logging into the Amazon Management Console, and Select the "EC2" service. 
 
  **Step-3 :** Choose `Security Groups` from the panel. 

   <img width="700" length="100" alt="Security" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/ef9ca08e-168e-488a-a9c7-22995e59e890"> 
    
 **Step-4 :** Click the `Create Security Group` button after selecting the `Security Groups` option from the left-hand menu. 

   <img width="700" length="100" alt="Security" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/03a99b66-f5f2-49b6-8df9-9c2dd3ebc39b">  
 
 **Step-5 :** Configure Security Group Settings: 
 
   * **Security Group Name:** Give your security group a descriptive name.eg `Frontend-sg`
   * **Description:** Provide a brief description of the security group's purpose. eg `Allow for frontend Server`
   * **VPC info** Choose your choice for the VPC where the security group will be created.

     <img width="700" length="100" alt="Security" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/a82848f5-131b-463f-b39d-61d2b6897a24"> 

   * **Add Inbound Rules:** Under the "Inbound Rules" section, define rules for incoming traffic. Click the `Add Rule` button and specify the type, port range, and source IP or security group.

  <img width="700" length="100" alt="Security" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/cdde2342-a575-4383-a1ef-59f0a7d6ee92"> 

  <img width="700" length="100" alt="Security" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/ec468ded-7848-49e3-a2fd-fae8b7f39028"> 
 
***
## Conclusion

Security groups are a fundamental security feature in AWS, allowing you to control the traffic that is allowed to access your resources. In this article, we have discussed what a security group is and how to create it. By following the steps mentioned above, you can create security groups for your resources and ensure they are secure. 

***
## Contact Information
| Name | Email address |
| ---- | ------------- |
| Vishal | vishal.kesarwani.snaatak@mygurukulam.co |
***
## Resources and References
|  **Description** |   **Source** |
| ---------------- | ------------ |
| About Security Group | [Link](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-security-groups.html) |
| Creation Setup | [Link](https://www.geeksforgeeks.org/what-is-security-group-in-aws-and-how-to-create-it/) |
| Follow this Infra Diagram for setup | [Link](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Design/09-%20Cloud%20Infra%20Design/Cloud-Infra-Design-Dev.md) |

***

