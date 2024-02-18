# Setup Redis Security Group Manually

|   Author        |  Created on   |  Version   | Last updated by  | Last edited on |
| --------------- | --------------| -----------|----------------- | -------------- |
| Khushi Malhotra |  13 Feb 2024  |  Version 1 | Khushi Malhotra  | 13 Feb 2024    |
***
# Table of Contents
- [Introduction](https://github.com/CodeOps-Hub/Documentation/blob/main/Infra/Manual/Redis_Setup/Security_Group/README.md#introduction)
- [Pre-requisites](https://github.com/CodeOps-Hub/Documentation/blob/main/Infra/Manual/Redis_Setup/Security_Group/README.md#pre-requisites)
- [Setup Security Group for Redis Instances](https://github.com/CodeOps-Hub/Documentation/blob/main/Infra/Manual/Redis_Setup/Security_Group/README.md#setup-security-group-for-redis-instances)
- [In all my Redis Instances, I have set the following Inbound Rules](https://github.com/CodeOps-Hub/Documentation/blob/main/Infra/Manual/Redis_Setup/Security_Group/README.md#in-all-my-redis-instances-i-have-set-the-following-inbound-rules)
- [In all my Redis Instances, I have set the following Outbound Rules](https://github.com/CodeOps-Hub/Documentation/blob/main/Infra/Manual/Redis_Setup/Security_Group/README.md#in-all-my-redis-instances-i-have-set-the-following-outbound-rules)
- [Conclusion](https://github.com/CodeOps-Hub/Documentation/blob/main/Infra/Manual/Redis_Setup/Security_Group/README.md#conclusion)
- [Contact Information](https://github.com/CodeOps-Hub/Documentation/blob/main/Infra/Manual/Redis_Setup/Security_Group/README.md#contact-information)
- [Resources and References](https://github.com/CodeOps-Hub/Documentation/blob/main/Infra/Manual/Redis_Setup/Security_Group/README.md#resources-and-references)
***
# Introduction
In Amazon Web Services (AWS), a security group is a fundamental component of network security that acts as a virtual firewall for controlling inbound and outbound traffic to instances (such as EC2 instances) within a VPC (Virtual Private Cloud).

# Pre-requisites
| Tool         |  
|--------------|
| AWS Account  |

# Setup Security Group for [Redis Instances](https://github.com/CodeOps-Hub/Documentation/blob/main/Infra/Manual/Redis_Setup/Instances/README.md)
 
- Creating a security group in AWS involves several steps. Security groups act as virtual firewalls that control inbound and outbound traffic for EC2 instances. Here's a step-by-step guide on how to create a security group in the AWS Management Console:

- Sign in to the AWS Management Console: Go to https://aws.amazon.com/ and sign in to the AWS Management Console using your credentials.

- Navigate to the EC2 Dashboard: Once logged in, navigate to the EC2 Dashboard by clicking on the "Services" dropdown menu at the top left corner, then selecting "EC2" under the "Compute" section.

- Access Security Groups: In the EC2 Dashboard, locate the "Network & Security" section on the left-hand side menu and click on "Security Groups".

- Create Security Group: On the Security Groups page, click the "Create security group" button.

- Configure Security Group Settings:

- Name and Description: Enter a name and description for your security group to help you identify its purpose.
**Inbound Rules:** Define rules to allow inbound traffic. Click "Add rule" for each rule you want to add. Each rule requires the following information:
    1. Type: The type of traffic (e.g., HTTP, SSH, RDP).
    2. Protocol: The protocol used for the traffic (e.g., TCP, UDP, ICMP).
    3. Port Range: The port or port range for the traffic.
    4. Source: The source of the traffic (e.g., an IP address, another security group).
**Outbound Rules:** Define rules to allow outbound traffic. By default, outbound traffic is allowed to all destinations. 

# In all my [Redis Instances](https://github.com/CodeOps-Hub/Documentation/blob/main/Infra/Manual/Redis_Setup/Instances/README.md), I have set the following Inbound Rules

| Rule                 | Port(s)   | Protocol | Source                        |
|----------------------|-----------|----------|-------------------------------|
| SSH                  | 22        | TCP      | 0.0.0.0/0                     |
| Redis Default Port   | 6379      | TCP      | Custom from respective nodes  |
| Redis Cluster Bus    | 16379     | TCP      | Custom from respective nodes  |

![Untitled design (7)](https://github.com/CodeOps-Hub/Documentation/assets/156056460/1e9e5aa9-d0a5-4ab3-99bf-67cb5ed580cd)

# In all my [Redis Instances](https://github.com/CodeOps-Hub/Documentation/blob/main/Infra/Manual/Redis_Setup/Instances/README.md), I have set the following Outbound Rules

| Outbound Rule        | Port/Protocol | Destination       |
|----------------------|---------------|-------------------|
| Allow All Traffic    | All           | 0.0.0.0/0         |

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/9805e414-1db4-4443-a024-6175b9f60e3f)

 # Conclusion
Security groups play a crucial role in securing your cloud infrastructure by controlling inbound and outbound traffic to your instances. They provide granular control, flexibility, and scalability, helping you enforce a robust security posture and protect your applications and data from unauthorized access and malicious activity.

# Contact Information
| Name            | Email Address                        |
|-----------------|--------------------------------------|
| Khushi Malhotra | khushi.malhotra.snaatak@mygurukulam.co |

# Resources and References 
| Reference | Link |
|-----------|------|
| Redis Instances | [Instance Setup](https://github.com/CodeOps-Hub/Documentation/blob/main/Infra/Manual/Redis_Setup/Instances/README.md)|
| Node to node communication | [stackoverflow](https://stackoverflow.com/questions/39568561/how-to-solve-redis-cluster-waiting-for-the-cluster-to-join-issue)|
|  Ports Defining          |  [AWS official doc](https://repost.aws/questions/QUeQOeMFtxRNmgYfQD3cHR2Q/should-i-open-the-port-16379-bus-port-for-aws-elasticache-for-redis)
