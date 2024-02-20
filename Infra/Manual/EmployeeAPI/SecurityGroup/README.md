# Employee API Manual Security Group Setup
| Author | Created On | Last Updated | Document Version | Last Updated By |
| ------ | ---------- | ------------ | ---------------- | --------------- |
| Shantanu | 12-02-2024 | 20-02-2024   |         v1     |     Shantanu    |
***

# Table of Content
[1. Introduction](#introduction)

[2. Overview](#overview)

[3.Pre-requisites](#Pre-requisites)

[3. Setting Up the Environment](#setting-up-the-environment)

[4. Best practices](#best-practices)

[5. Conclusion](#conclusion)

[6. Contact Information](#contact-information)

[7. Refrences](#references)
***

# Introduction
This document outlines the steps and considerations for conducting a Proof of Concept (POC) on AWS Security Group for Employee API, a fundamental component for securing resources in the Amazon Web Services (AWS) environment. The POC focuses on understanding and implementing AWS Security Group for a hypothetical application deployment in AWS.
***

# Overview
AWS Security Groups act as virtual firewalls for EC2 instances, controlling inbound and outbound traffic by defining rules based on ports, protocols, and source/destination IP addresses, enhancing the security posture within the Amazon Web Services environment.

### Features
| Key Features             | Description                                              |
|--------------------------|----------------------------------------------------------|
| Dynamic rule updates     | Security Groups allow real-time adjustments to rules, enabling immediate changes to access controls without instance restarts. |
| Stateful filtering        | Security Groups maintain state information, automatically allowing return traffic for established connections, simplifying rule management. |
| Granular control over traffic flow | Security Groups provide fine-grained control by specifying allowed ports, protocols, and source/destination IP addresses, enhancing security customization. |

### Use Cases
| Use Cases            | Description                                              |
|----------------------|----------------------------------------------------------|
| Web applications     | Security Groups can be tailored to permit web traffic on specific ports (e.g., 80 for HTTP, 443 for HTTPS), ensuring a secure and controlled environment for hosting web applications. |
| Database servers      | For database servers, Security Groups allow restriction to only necessary ports (e.g., 3306 for MySQL, 5432 for PostgreSQL), limiting access to databases and enhancing data security. |
| Multi-tier architectures | Security Groups support the creation of layered security in multi-tier architectures by defining rules for communication between different tiers, facilitating a secure flow of traffic within the infrastructure. |

### Benefits
| Benefits                        | Explanation                                              |
|---------------------------------|----------------------------------------------------------|
| Enhanced security posture       | Security Groups contribute to an enhanced security posture by allowing precise control over network traffic, minimizing attack surfaces, and enforcing the principle of least privilege. |
| Easy scalability               | Security Groups seamlessly scale with the infrastructure, facilitating the addition or removal of instances without the need for manual adjustments, ensuring security scales in tandem with workloads. |
| Flexible configuration options  | Security Groups offer flexibility in defining rules based on ports, protocols, and IP addresses, providing adaptability to diverse application requirements and network architectures. |
***

# Pre-requisites
* Access to the AWS Management Console or AWS CLI with appropriate permissions.

* Understanding of your application's network requirements.

# Setting Up The Environment

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
| Backend-sg          | 8080              | Backend-sg          |

![image](https://github.com/avengers-p7/Documentation/assets/156057205/6073c8a4-d39e-4c3b-b0fd-2dc5a491ddbf)

**Step-6 Define Outbound Rules**

* Click on the Outbound Rules tab.

* Click the Edit Outbound Rules button.

| Security Group Name | Outbound Rule Port | Outbound Rule Protocol | Outbound Rule Destination |
|---------------------|---------------------|------------------------|--------------------------|
| *                   | All traffic         | All                    | 0.0.0.0/0                | 


![image](https://github.com/CodeOps-Hub/Documentation/assets/156056709/1d86e360-8cd3-4edd-959b-fbab18a4e0b2)

---

# Best Practices
| Best Practices                               | Explanation                                              |
|----------------------------------------------|----------------------------------------------------------|
| Principle of Least Privilege                 | Adhering to the principle of least privilege involves granting only the minimum access necessary for users or systems to perform their tasks, reducing the risk of unauthorized access and potential security breaches. |
| Regularly Reviewing and Updating Rules        | Establishing a routine process for reviewing and updating Security Group rules ensures that access controls align with changing application requirements and evolving security postures, maintaining an effective defense. |
| Combining Security Groups and Network ACLs    | Leveraging both Security Groups and Network Access Control Lists (ACLs) provides a layered security approach, enhancing control and protection by filtering traffic at both the instance and subnet levels within the AWS infrastructure. |
| Integrating with AWS Identity and Access Management (IAM) | Integrating Security Groups with AWS Identity and Access Management (IAM) allows for fine-grained access control, enabling the association of specific rules with IAM identities and roles, contributing to a more robust security architecture. |
***

# Conclusion
This POC demonstrates the process of creating a Security Group in AWS for hosting Employee API. Adjustment of parameters and settings based on specific requirements and preferences could be made.
***

# Contact Information
| Name | Email Address |
| ---- | ------------- |
| Shantanu  | shantanu.chauhan.snaatak@mygurukulam.co |
***

# References
| Source | Description  | 
| -------- | ------- | 
| [Link](https://github.com/CodeOps-Hub/Documentation/blob/main/OT%20Micro%20Services/Application/Employee_API/README.md) | Employee API |
| [Link](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Design/09-%20Cloud%20Infra%20Design/Cloud-Infra-Design-Dev.md) | Dev Infra Link |
