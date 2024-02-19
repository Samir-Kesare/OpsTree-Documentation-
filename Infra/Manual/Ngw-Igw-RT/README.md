# Create NAT Gateway, Internet gateway and Route Table for Dev Environment Manually

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056709/7d24f291-6e81-48df-8b00-4e0b5495356e)

| **Author**           | **Created On** | **Last Updated** | **Document Version** |
| -------------------- | -------------- | ---------------- | -------------------- |
| **Parasharam Desai** | 19-01-2024     | 19-02-2024       | V1                   |

## Table of Contents

- [Introduction](#introduction)
- [Prerequisites](#prerequisites)
- [Create a Route Table](#create-a-route-table)
  * [Create a NAT Gateway](#create-a-nat-gateway)
  * [Create an Internet Gateway](#create-an-internet-gateway)
  * [Add Routes](#add-routes)
  * [Associate Subnets](#associate-subnets)
- [Conclusion](#conclusion)
- [Contact Information](#contact-information)
- [Resources and References](#resources-and-references)

## Introduction

This guide outlines the essential steps for manually configuring NAT Gateway, Internet Gateway, and Route Tables in AWS for a development environment. These components facilitate network communication within the Virtual Private Cloud (VPC) and with external networks, ensuring seamless connectivity and effective network management.
## Prerequisites

Ensure you have access to the AWS Management Console and necessary permissions.

## Create a Route Table

### Create a NAT Gateway

1. Go to the AWS Management Console.
   
2. Navigate to the VPC Dashboard.
   
3. In the left navigation pane, choose "NAT Gateway."
   
   ![image](https://github.com/CodeOps-Hub/Documentation/assets/156056709/94fe9f40-81c6-4ade-88ad-e258b49e7477)
   
4. Click on the "NAT Gateway." button.
   
5. Give the route table a name and select the VPC for which you want to create the NAT Gateway.
   
6. Click on "Create."
   
   ![image](https://github.com/CodeOps-Hub/Documentation/assets/156056709/2d5db5a6-dd6f-42d1-ab4d-2e8f49fc5154)
   
   ![image](https://github.com/CodeOps-Hub/Documentation/assets/156056709/c3f96057-7de4-4a23-a88e-8319f0c39955)

### Create an Internet Gateway

1. Go to the AWS Management Console.
   
2. Navigate to the VPC Dashboard.
   
3. In the left navigation pane, choose "Internet Gateway."
   
   ![image](https://github.com/CodeOps-Hub/Documentation/assets/156056709/013a3f66-61b2-4a41-b0c2-d9a73fceba7d)

4. Click on the "Internet Gateway" button.
   
5. Give the route table a name and select the VPC for which you want to create the Internet Gateway.
   
6. Click on "Create."
   
   ![image](https://github.com/CodeOps-Hub/Documentation/assets/156056709/7474ef7e-d17d-42b9-81a3-90a46ae86a97)
   
   ![image](https://github.com/CodeOps-Hub/Documentation/assets/156056709/11eaa23c-87df-45d9-a731-5b4af4ce2b3f)

7. Select Action then Attach VPC & choose the Dev Vpc.
   
   ![image](https://github.com/CodeOps-Hub/Documentation/assets/156056709/07f67bc6-dcfa-4c3a-b510-789c06c1cb21)

### Add Routes

1. Go to the AWS Management Console.
   
2. Navigate to the VPC Dashboard.
   
3. In the left navigation pane, choose "Route Tables."
   
   ![image](https://github.com/CodeOps-Hub/Documentation/assets/156056709/8c4daf8c-abee-403b-89f4-258bff67c505)

   ![image](https://github.com/CodeOps-Hub/Documentation/assets/156056709/41ccd34e-8300-49a3-936c-c7ed3b775f46)

4. Click on the "Create Route Table" button.
   
5. Give the route table a name and select the VPC for which you want to create the route table.
   
6. Click on "Create."
   
   ![image](https://github.com/CodeOps-Hub/Documentation/assets/156056709/214c356f-3e81-4d29-bb13-34678e5d17f0)

7. Follow Steps to Create Public-RT & Private-RT.
   
   ![image](https://github.com/CodeOps-Hub/Documentation/assets/156056709/3e4bbbbe-5005-4032-9d22-96cf72da349d)

### Associate Subnets

1. In the "Subnet Associations" tab, click on "Edit subnet associations."
   
2. Associate the route table with the desired subnets.
   
3. Then click on Save association.
   
   ![image](https://github.com/CodeOps-Hub/Documentation/assets/156056709/dbee0798-ac85-4fdf-b411-ca2cc038aac4)
   
   ![image](https://github.com/CodeOps-Hub/Documentation/assets/156056709/c91e119a-2026-4758-9760-b6c04906efb5)
   
   ![image](https://github.com/CodeOps-Hub/Documentation/assets/156056709/be2acd6e-c81f-4bd6-9779-217d8f941f0d)
   
4. Follow the same process to associate in Private-RT.
   
   ![image](https://github.com/CodeOps-Hub/Documentation/assets/156056709/e4a215d1-67bf-40db-b8b3-dfa167effc37)
   
   ![image](https://github.com/CodeOps-Hub/Documentation/assets/156056709/310ad803-5eac-4c10-97ba-33282e109f0a)
   
   ![image](https://github.com/CodeOps-Hub/Documentation/assets/156056709/e4de940d-6392-4c08-991c-f29cc52e7728)

## Conclusion

In conclusion, setting up a route table in a cloud environment involves several prerequisites to ensure the proper functioning and security of your network. By following the steps outlined above and adhering to best practices, you can create a well-organized and secure network infrastructure.

## Contact Information

| Name               | Email Address                               |
| ------------------ | ------------------------------------------- |
| Parasharam Desai   | parasharam.desai.snaatak
