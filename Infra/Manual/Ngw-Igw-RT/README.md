
# Create NAT Gateway, Internet gateway and Route Table for Dev Environment Manually

| **Author**           | **Created On** | **Last Updated** | **Document Version** |
| -------------------- | -------------- | ---------------- | -------------------- |
| **Parasharam Desai** | 19-02-2024     | 19-02-2024       | V1                   |

# Table of Contents

1. [Introduction](#introduction)
2. [Prerequisites](#prerequisites)
3. [Create a Route Table](#create-a-route-table)
4. [Create a NAT Gateway](#create-a-nat-gateway)
5. [Create an Internet Gateway](#create-an-internet-gateway)
6. [Add Routes](#add-routes)
7. [Associate Subnets](#associate-subnets)
8. [Conclusion](#conclusion)
9. [Resources and References](#resources-and-references)
10. [Contact Information](#contact-information)


# Introduction

Setting up networking in a cloud environment, such as AWS, involves several essential steps, including creating and associating route tables. This guide outlines the process of manually creating NAT Gateway, Internet Gateway, and Route Table for a Dev environment in AWS VPC. By following these steps, you can ensure proper networking configuration to facilitate communication within your VPC and with external resources.


# Create a NAT Gateway 
* Go to the AWS Management Console.

* Navigate to the VPC Dashboard.

* In the left navigation pane, choose "NAT Gateway."

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056709/94fe9f40-81c6-4ade-88ad-e258b49e7477)

* Click on the "NAT Gateway." button.

* Give the NAT Gateway a name and select the VPC for which you want to create the NAT Gateway.

* Click on "Create."

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056709/2d5db5a6-dd6f-42d1-ab4d-2e8f49fc5154)

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056709/c3f96057-7de4-4a23-a88e-8319f0c39955)


# Create a Internet Gateway 
* Go to the AWS Management Console.

* Navigate to the VPC Dashboard.

* In the left navigation pane, choose "Internet Gateway."

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056709/013a3f66-61b2-4a41-b0c2-d9a73fceba7d)


* Click on the "Internet Gateway" button.

* Give the Internet Gateway a name and select the VPC for which you want to create the Internet Gateway.

* Click on "Create."

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056709/7474ef7e-d17d-42b9-81a3-90a46ae86a97)

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056709/11eaa23c-87df-45d9-a731-5b4af4ce2b3f)

* Select "Actions" and then click on "Attach VPC."
* Choose the desired VPC, such as the Dev VPC, from the available options.
* 
![image](https://github.com/CodeOps-Hub/Documentation/assets/156056709/07f67bc6-dcfa-4c3a-b510-789c06c1cb21)



# Create a Route Table
* Go to the AWS Management Console.

* Navigate to the VPC Dashboard.

* In the left navigation pane, choose "Route Tables."

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056709/8c4daf8c-abee-403b-89f4-258bff67c505)

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056709/41ccd34e-8300-49a3-936c-c7ed3b775f46)

* Click on the "Create Route Table" button.

* Give the route table a name and select the VPC for which you want to create the route table.

* Click on "Create."

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056709/214c356f-3e81-4d29-bb13-34678e5d17f0)

* Follow Steps to Create Public-RT & Private-RT 

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056709/3e4bbbbe-5005-4032-9d22-96cf72da349d)

# Add Routes
* Select the newly created route table.

* In the "Routes" tab, click on "Edit routes."

* Add the necessary routes based on your requirements (e.g., a default route to the internet gateway).

then click on save the change 

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056709/d67a27ec-ddab-403a-81fb-70100845b4c7)

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056709/fd726a34-b7e3-4d71-8f1b-db4c6cd2eff8)


# Associate Subnets
* In the "Subnet Associations" tab, click on "Edit subnet associations."

* Associate the route table with the desired subnets. then click on Save association

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056709/dbee0798-ac85-4fdf-b411-ca2cc038aac4)

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056709/c91e119a-2026-4758-9760-b6c04906efb5)

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056709/be2acd6e-c81f-4bd6-9779-217d8f941f0d)

* Follow the same process to associate the private route table (Private-RT) with the desired subnets.


![image](https://github.com/CodeOps-Hub/Documentation/assets/156056709/e4a215d1-67bf-40db-b8b3-dfa167effc37)


![image](https://github.com/CodeOps-Hub/Documentation/assets/156056709/310ad803-5eac-4c10-97ba-33282e109f0a)


![image](https://github.com/CodeOps-Hub/Documentation/assets/156056709/e4de940d-6392-4c08-991c-f29cc52e7728)



# Conclusion

In this guide, we've provided a detailed walkthrough for creating NAT Gateway, Internet Gateway, and Route Table in AWS VPC. By following the outlined steps, you can establish the necessary networking infrastructure to support your Dev environment. Proper configuration of these components is crucial for enabling seamless communication between resources within the VPC and the broader internet. With this setup, you're well-equipped to proceed with deploying and managing your applications in the AWS cloud.




## Contact Information

| Name               | Email Address                               |
| ------------------ | ------------------------------------------- |
| Parasharam Desai   | parasharam.desai.snaatak@mygurukulam.co    |

---

## Resources and References

| Description           | References                                                        |
| --------------------- | ----------------------------------------------------------------- |
| Documentation Template | [Link](https://github.com/OT-MICROSERVICES/documentation-template/wiki/Application-Template) |
| Dev Infra Design      | [Link](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Design/09-%20Cloud%20Infra%20Design/Cloud-Infra-Design-Dev.md) |
|Configure route tables - Amazon Virtual Private Cloud |[Link](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Route_Tables.html)|
