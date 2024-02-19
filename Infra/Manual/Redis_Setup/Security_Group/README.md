# Setup Redis Security Group Manually

|   Author        |  Created on   |  Version   | Last updated by  | Last edited on |
| --------------- | --------------| -----------|----------------- | -------------- |
| Khushi Malhotra |  13 Feb 2024  |  Version 1 | Khushi Malhotra  | 13 Feb 2024    |
***

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/a51bc5e5-03c8-4f5c-a36a-8ee2ccc2af5e)

# Table of Contents
- [Introduction](https://github.com/CodeOps-Hub/Documentation/blob/main/Infra/Manual/Redis_Setup/Security_Group/README.md#introduction)
- [Pre-requisites](https://github.com/CodeOps-Hub/Documentation/blob/main/Infra/Manual/Redis_Setup/Security_Group/README.md#pre-requisites)
- [Setup Security Group for Redis Instances](https://github.com/CodeOps-Hub/Documentation/blob/main/Infra/Manual/Redis_Setup/Security_Group/README.md#setup-security-group-for-redis-instances)
- [Inbound Rules](https://github.com/CodeOps-Hub/Documentation/blob/main/Infra/Manual/Redis_Setup/Security_Group/README.md#inbound-rules)
- [Outbound Rules](https://github.com/CodeOps-Hub/Documentation/blob/main/Infra/Manual/Redis_Setup/Security_Group/README.md#outbound-rules)
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

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/ad003bc7-1ae3-4462-8bb7-d35c65f27a86)

- Access Security Groups: In the EC2 Dashboard, locate the "Network & Security" section on the left-hand side menu and click on "Security Groups".

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/ed088675-90ab-470d-8119-d8125e3395a5)


- Create Security Group: On the Security Groups page, click the "Create security group" button.

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/0e1b169c-9f13-437c-9b0c-a2577e3939af)


- Configure Security Group Settings.

- Name and Description: Enter a name and description for your security group to help you identify its purpose.
**Inbound Rules:** Define rules to allow inbound traffic. Click "Add rule" for each rule you want to add. Each rule requires the following information:
| Details       | Description                                                       |
|---------------|-------------------------------------------------------------------|
| Type          | The type of traffic (e.g., HTTP, SSH, RDP).                       |
| Protocol      | The protocol used for the traffic (e.g., TCP, UDP, ICMP).         |
| Port Range    | The port or port range for the traffic.                           |
| Source        | The source of the traffic (e.g., an IP address, another security group). |

**Outbound Rules:** Define rules to allow outbound traffic. By default, outbound traffic is allowed to all destinations. 

# Inbound Rules

| Rule                 | Port(s)   | Protocol | Source                        |
|----------------------|-----------|----------|-------------------------------|
| SSH                  | 22        | TCP      | 0.0.0.0/0                     |
| Redis Default Port   | 6379      | TCP      | Custom from respective nodes  |
| Redis Cluster Bus    | 16379     | TCP      | Custom from respective nodes  |

![Untitled design (7)](https://github.com/CodeOps-Hub/Documentation/assets/156056460/1e9e5aa9-d0a5-4ab3-99bf-67cb5ed580cd)

# Outbound Rules

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
