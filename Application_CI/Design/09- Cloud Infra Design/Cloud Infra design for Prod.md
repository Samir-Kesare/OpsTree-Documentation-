# Cloud Infra design for Prod

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056570/596c3540-7244-4540-8d7b-b70c1d91b00c)



| **Author**           | **Created On** | **Last Updated** | **Document Version** |
| -------------------- | -------------- | ---------------- | -------------------- |
| **Samir Kesare* | 02-03-2024     | 02-03-2024       | V1                   |
***
## Table of Contents

1. [Introduction](#introduction)
2. [Pre-requisites](#pre-requisites)
3. [Infrastructure Diagram](#infrastructure-diagram)
4. [Description](#description)
5. [Cloud Architecture Best Practices](#Cloud-Architecture-Best-Practices)
6. [Contact Information](#contact-information)
7. [Resources and References](#resources-and-references)

***
## Introduction

In today's rapidly evolving technological landscape, the need for robust and scalable infrastructure solutions for production environments is paramount. Cloud computing has emerged as a game-changer, offering unparalleled flexibility, scalability, and reliability to meet the demands of modern businesses.

A well-designed cloud infrastructure for production environments encompasses various components, including compute, storage, networking, security, and management services. Each component plays a crucial role in ensuring high availability, performance, and security of the production systems and applications.
***
## Pre-requisites
| Tool                  | Description                                  |
|-----------------------|----------------------------------------------|
| AWS Management Console | Required for provisioning AWS resources.     |

***
## Infrastructure Diagram

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056570/1493920b-fdd3-4734-8cba-5c8865525b2e)


---
## Description
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
| **Region and Availability Zone**    | Deployed in US Esat region, specifically N.Virginia (us-east-1). Utilizes availability zones (us-east-1a) for redundancy and fault tolerance. |
| **VPC (Virtual Private Cloud)**     | Created for Development environments, organizes components for scalability and availability.        |
            

***
## Security Groups and Inbound Rules

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
| 120         | Custom TCP      | TCP      | 1194        | 0.0.0.0/0   | Allow      |
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
| 130         | Custom TCP      | TCP      | 1194     | 10.0.1.0/28   | Allow      |
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
| 140         | Custom TCP      | TCP      | 1194     | 10.0.1.0/28   | Allow      |
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
| 140         | Custom TCP      | TCP      | 1194     | 10.0.1.0/28   | Allow      |
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
## Cloud Architecture Best Practices

| Aspect                 | Description                                                                                                                                                                                                                                                              |
|------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Operational Excellence | Involves monitoring systems and continuously improving the cloud architecture and internal processes. Implement incremental changes, document procedures, and focus on troubleshooting.                                                                                   |
| Cost Optimization      | A major concern for businesses moving to the cloud. Incorporate cloud cost optimization strategies to reduce overall spending. Analyze expenses, drop components with high operational costs, and use automation for cost-efficient alternatives.                     |
| Performance Efficiency | Design cloud architecture with the right service provider to improve performance. Focus on structuring resources, selecting appropriate sizes/types, and utilizing automation and AI for optimization.                                                                     |
| Reliability            | Ensure workloads perform as expected and recover quickly from outages. Build automated recovery processes, use autoscaling to avoid under/overprovisioning, and establish change management processes for better resource monitoring and demand management. |
| Security               | Maintain data integrity, detect security breaches, and manage user permissions. Establish secure procedures and continuously monitor for unauthorized access through automated notifications.                                                                                |
| Sustainability         | Take proactive measures to minimize environmental impact. Maximize resource utilization, decrease costs, and establish responsible models for sustainability. Harden security for all applications and instances while continuously monitoring for breaches.            |




***
## Contact Information

| Name               | Email Address                               |
| ------------------ | ------------------------------------------- |
| Samir Kesare   | samir.kesare.snaatak@mygurukulam.co     |

***
## Resources and References

|     Description                  | References  
| ---------------------------------| ------------------------------------------------------------------- |
| Documentation Template           | [Link](https://github.com/OT-MICROSERVICES/documentation-template/wiki/Application-Template) |
| Autoscaling with NGINX on AWS Blog| [Link](https://www.nginx.com/blog/announcing-new-autoscaling-support-with-nginx-plus-on-aws-cloud-quick-start/) |
| Route53           | [Link](https://alwinmathewabraham.wordpress.com/2017/08/20/lab-10-configuring-dns-with-route-53-url/) |
| Cloud Infra 30k feet          | [Link](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Design/09-%20Cloud%20Infra%20Design/Cloud-Infra-Design-30K-Feet.md) |
|Cloud Architecture Best Practices| [Link](https://www.nops.io/blog/cloud-architecture-best-practices/)|
