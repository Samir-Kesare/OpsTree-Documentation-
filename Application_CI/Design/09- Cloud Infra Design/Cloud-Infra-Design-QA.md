# Cloud Infra Design QA

<img width="300" length="100" alt="QA Infra" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/a5bd713e-2bea-4257-baed-27798aef3b3b">

***

| **Author** | **Created On** | **Last Updated** | **Document Version** |
| ---------- | -------------- | ---------------- | -------------------- |
| **Shreya Jaiswal** | **27 Feb 2024** | **27 Feb 2024** | **v1** |

***

# Table of Contents

1. [Introduction](#introduction)
2. [Pre-requisites](#pre-requisites)
3. [Infrastructure Diagram](#infrastructure-diagram)
4. [Description](#description)
5. [Best Practices](#Best-Practices)
6. [Conclusion](#Conclusion)
7. [Contact Information](#contact-information)
8. [References](#References)

***

# Introduction

In the modern software development landscape, microservices architecture has become increasingly popular due to its scalability, flexibility, and resilience. Quality Assurance (QA) plays a crucial role in ensuring that microservices function as intended and meet the expectations of users. Cloud infrastructure further enhances the agility and reliability of microservices by providing scalable and elastic resources.

***

# Pre-requisites

| Tool                  | Description                                  |
|-----------------------|----------------------------------------------|
| AWS Management Console | Required for provisioning AWS resources.     |

***

# Infrastructure Diagram

![Ideal-Dev-Infra - Page 1](https://github.com/CodeOps-Hub/Documentation/assets/156057205/a578f20d-7f4c-4cf1-9943-13f9f681b61e)

*** 

# Description

| Component                           | Details                                                                                           |
| ----------------------------------- | ------------------------------------------------------------------------------------------------- |
| **User Access**                     | Users connect to the infrastructure through the internet.                                          |
| **Route53**                         | DNS service for routing traffic to various components.                                               |
| **Public Subnets**                  | Public subnets host components requiring direct internet access. Bastion Host facilitates secure access.|
| **Private Subnets**                 | Frontend app, Attendance, Employee, and Salary APIs hosted in separate private subnets. Databases (PostgreSQL, Scylla, Redis) in another private subnet. |
| **Security Groups**                 | - To provide security on instance level |
| **NACLs (Network ACLs)**           | Control inbound and outbound traffic at subnet level for specific private subnets.                  |
| **Internet Gateway & NAT Gateway**  | - Internet Gateway (Igw) for VPC internet access.<br>- NAT Gateway for outbound traffic from private subnets to the internet.|
| **Route Tables**                    | - Public-RT for public subnet internet access.<br>- Private-RT for communication within the VPC.    |
| **ALB (Application Load Balancer)** | Configured to distribute frontend traffic across multiple targets for high availability.            |
| **Auto Scaling Group (ASG)**        | Dynamically adjusts frontend and API service instances based on demand for scalability.              |
| **Region and Availability Zone**    | Deployed in Europe region, specifically Frankfurt (eu-central-1). Utilizes availability zones (eu-central-1a) for redundancy and fault tolerance. |
| **VPC (Virtual Private Cloud)**     | Created for Development environments, organizes components for scalability and availability.        |
            
***

### Security Groups and Inbound Rules

| Layer    | Security Group Name | Inbound Rule Port | Inbound Rule Source |
|----------|---------------------|-------------------|---------------------|
| Frontend | Frontend-lb-sg      | 80                | 0.0.0.0/0           | 
| Frontend | Frontend-sg         | 22, 3000                | Frontend-lb-sg   |               
| Backend  | Backend-sg          | 22, 8080             | Frontend-lb-sg     |               
| Database | Postgresql-sg      | 22, 5432              | Backend-sg       |               
| Database | Redis-sg         | 22, 6379              | Backend-sg       |            
| Database | Scylla-sg      | 22, 9042             | Backend-sg          |               

***

## NACL Rules

### Public NACL Inbound Rules

| Rule number | Type      | Protocol | Port range | Source       | Allow/Deny |
|-------------|-----------|----------|------------|--------------|------------|
| 100         | SSH       | TCP      | 22         | 0.0.0.0/0    | Allow      |
| 110         | Custom TCP      | TCP      | 1024-65535         | 10.0.1.16/28    | Allow      |
| *           | All traffic | All     | All        | 0.0.0.0/0    | Deny       |

### Public NACL Outbound Rules

| Rule number | Type      | Protocol | Port range | Destination  | Allow/Deny |
|-------------|-----------|----------|------------|--------------|------------|
| 100         | Custom TCP| TCP      | 1024-65535 | 0.0.0.0/0   | Allow      |
| *           | All traffic | All     | All       | 0.0.0.0/0    | Deny      |

### Frontend NACL Inbound Rules

| Rule number | Type      | Protocol | Port range | Source       | Allow/Deny |
|-------------|-----------|----------|------------|--------------|------------|
| 100         | SSH       | TCP      | 22         | 20.0.0.0/28  | Allow      |
| 110         | Custom TCP| TCP      | 3000       | 10.0.1.0/28  | Allow      |
| *           | All traffic | All     | All        | 0.0.0.0/0    | Deny       |

### Frontend NACL Outbound Rules

| Rule number | Type      | Protocol | Port range | Destination  | Allow/Deny |
|-------------|-----------|----------|------------|--------------|------------|
| 100         | SSH       | TCP      | 22         | 20.0.0.0/28  | Allow      |
| 110         | Custom TCP| TCP      | 3000       | 10.0.1.0/28 | Allow      |
| 120         | Custom TCP| TCP      | 1024-65535 | 20.0.0.0/28  | Allow      |
| 130         | Custom TCP| TCP      | 32768-65535| 10.0.1.0/28  | Allow      |
| *           | All traffic | All     | All        | 0.0.0.0/0    | Deny       |

### Backend NACL Inbound Rules

| Rule number | Type      | Protocol | Port range | Source       | Allow/Deny |
|-------------|-----------|----------|------------|--------------|------------|
| 100         | SSH       | TCP      | 22         | 20.0.0.0/28  | Allow      |
| 110         | Custom TCP| TCP      | 8080       | 10.0.1.0/28 | Allow      |
| 120         | Custom TCP      | TCP      | 1024-65535         | 10.0.1.48/28    | Allow      |
| 130         | Custom TCP      | TCP      | 1024-65535         | 10.0.1.64/28    | Allow      |
| *           | All traffic | All     | All        | 0.0.0.0/0    | Deny       |

### Backend NACL Outbound Rules

| Rule number | Type      | Protocol | Port range | Source       | Allow/Deny |
|-------------|-----------|----------|------------|--------------|------------|
| 100         | SSH       | TCP      | 22         | 20.0.0.0/28  | Allow      |
| 110         | Custom TCP| TCP      | 8080       | 10.0.1.0/28 | Allow      |
| 120         | Custom TCP| TCP      | 1024-65535 | 20.0.0.0/28  | Allow      |
| 130         | Custom TCP| TCP      | 1024-65535| 10.0.1.48/28 | Allow      |
| 140         | Custom TCP| TCP      | 1024-65535| 10.0.1.64/28 | Allow      |
| *           | All traffic | All     | All        | 0.0.0.0/0    | Deny       |

### Database NACL Inbound Rules

| Rule number | Type      | Protocol | Port range | Source       | Allow/Deny |
|-------------|-----------|----------|------------|--------------|------------|
| 100         | SSH       | TCP      | 22         | 20.0.0.0/28  | Allow      |
| 110         | Custom TCP(Redis)| TCP      | 6379       | 10.0.1.32/28 | Allow      |
| 120         | Custom TCP(Scylla)| TCP      | 9042       | 10.0.1.32/28 | Allow      |
| 130         | Custom TCP (PostgreSQL) | TCP| 5432    | 10.0.1.32/28 | Allow      |
| *           | All traffic | All     | All        | 0.0.0.0/0    | Deny       |

### Database NACL Outbound Rules

| Rule number | Type      | Protocol | Port range | Source       | Allow/Deny |
|-------------|-----------|----------|------------|--------------|------------|
| 100         | SSH       | TCP      | 22         | 20.0.0.0/28  | Allow      |
| 110         | Custom TCP(Redis)| TCP      | 6379       | 10.0.1.32/28 | Allow      |
| 120         | Custom TCP(Scylla)| TCP      | 9042       | 10.0.1.32/28 | Allow      |
| 130         | Custom TCP (PostgreSQL) | TCP| 5432    | 10.0.1.32/28 | Allow      |
| 140         | Custom TCP| TCP      | 1024-65535 | 10.0.1.32/28 | Allow      |
| 150         | Custom TCP| TCP      | 1024-65535 | 20.0.0.0/28 | Allow      |
| *           | All traffic | All     | All        | 0.0.0.0/0    | Deny       |

***

# Best Practices

| Practice | Description |
|------------- | ----------- |
| **Version Control** | Utilize version control systems like Git to manage documentation, enabling collaboration, tracking changes, and ensuring versioning.|
| **Clear Naming Conventions** | Adopt clear and consistent naming conventions for documents, folders, and files to facilitate easy navigation and understanding.|
| **Operational Excellence** | Involves monitoring systems and continuously improving the cloud architecture and internal processes. Implement incremental changes, document procedures, and focus on troubleshooting.|
| **Cost Optimization** | A major concern for businesses moving to the cloud. Incorporate cloud cost optimization strategies to reduce overall spending. Analyze expenses, drop components with high operational costs, and use automation for cost-efficient alternatives.|
| **Performance Efficiency** | Design cloud architecture with the right service provider to improve performance. Focus on structuring resources, selecting appropriate sizes/types, and utilizing automation and AI for optimization.|
| **Reliability** | Ensure workloads perform as expected and recover quickly from outages. Build automated recovery processes, use autoscaling to avoid under/overprovisioning, and establish change management processes for better resource monitoring and demand management.|
| **Security** | Maintain data integrity, detect security breaches, and manage user permissions. Establish secure procedures and continuously monitor for unauthorized access through automated notification.|
| **Sustainability** | Take proactive measures to minimize environmental impact. Maximize resource utilization, decrease costs, and establish responsible models for sustainability. Harden security for all applications and instances while continuously monitoring for breaches.|

***

# Conclusion

Documentation of QA processes for microservices on cloud infrastructure is vital for ensuring the reliability, scalability, and performance of the system. By following best practices outlined in this documentation, teams can streamline their QA processes, improve collaboration, and deliver high-quality microservices to users. Regular updates and revisions to the documentation will ensure that it remains relevant and useful as the system evolves over time.

***

# Contact Information

| **Name** | **Email Address** |
| -------- | ----------------- |
| **Shreya Jaiswal** | shreya.jaiswal.snaatak@mygurukulam.co |

***

# References 

| **Source** | **Description** |
| --------- | --------------- |
| [Link](https://github.com/OT-MICROSERVICES/documentation-template/wiki/Application-Template) | Template Reference Link |
| [Link](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Design/09-%20Cloud%20Infra%20Design/Cloud-Infra-Design-30K-Feet.md) | Cloud Infra Diagram 30k Feet  |
| [Link](https://www.nops.io/blog/cloud-architecture-best-practices/) | Cloud Infra Best Practices |


