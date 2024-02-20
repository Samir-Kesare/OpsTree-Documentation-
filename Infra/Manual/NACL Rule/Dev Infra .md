# NACL Rules for DEV Infra

| **Author**           | **Created On** | **Last Updated** | **Document Version** |
| -------------------- | -------------- | ---------------- | -------------------- |
| **Vikram Bisht**     | 20-02-2024     | 20-02-2024       | V1                   |


# Table of Contents

1. [Introduction](#introduction)
2. [Pre-requisites](#pre-requisites)
3. [Steps](#steps)
4. [Conclusion](#Conclusion)
5. [Contact Information](#contact-information)
6. [Resources and References](#resources-and-references)


## Introduction

Network Access Control Lists (NACLs) in Amazon Virtual Private Clouds (VPCs) act as stateless firewalls that operate at the subnet level. They control both inbound and outbound traffic based on the rules configured within them. NACLs allow you to specify rules that allow or deny traffic based on IP addresses, protocols, and ports.

## Pre-requisites
* Access to the AWS Management Console or AWS CLI with appropriate permissions.

* Understanding of your application's network requirements.

## Steps
**Step-1 Access the AWS Management Console**

  Navigate to the AWS Management Console and sign in to your AWS account.
  
  ![image](https://github.com/CodeOps-Hub/Documentation/assets/79625874/5e5ea278-e130-430f-a440-b78418b55313)


**Step-2 Open the VPC Dashboard**

In the AWS Management Console, go to the Services dropdown

Under the "Networking & Content Delivery" section, select VPC.

In the VPC Dashboard, select Network ACLs from the left navigation pane. 

![image](https://github.com/CodeOps-Hub/Documentation/assets/79625874/602482a0-b0cc-463b-900b-7d4acac2ae23)


**Step-3 Create a new NACL**

you can create a new NACL  from “Create Network ACL “

![image](https://github.com/CodeOps-Hub/Documentation/assets/79625874/284daf14-502d-4cd4-9b68-7384d7fcf3d7)

Give NACL Name, Select VPC and then select create Network ACL as shown below

![image](https://github.com/CodeOps-Hub/Documentation/assets/79625874/64a0cd3a-c499-44fd-89b4-1703e1a0200d)


**Step-4 Configure Inbound Rules**

Click on the Inbound Rules tab.

Click the Action under the drop down select Edit Inbound Rule button or else you can select directly Edit Inbound Rule.

![image](https://github.com/CodeOps-Hub/Documentation/assets/79625874/ade40711-1a4e-4352-b08a-aa731ce0d9d2)

Add new rule according to the infra setup.

![image](https://github.com/CodeOps-Hub/Documentation/assets/79625874/70c45f01-2f3f-4c28-871c-44751e022639)

## We have followed below set of rules for our NACL Inbound rules
### Public NACL Inbound Rules

| Rule number | Type      | Protocol | Port range | Source       | Allow/Deny |
|-------------|-----------|----------|------------|--------------|------------|
| 100         | SSH       | TCP      | 22         | 0.0.0.0/0    | Allow      |
| *           | All traffic | All     | All        | 0.0.0.0/0    | Deny       

![image](https://github.com/CodeOps-Hub/Documentation/assets/79625874/2b21fd44-ddba-42dc-b4ad-847337fe9f78)

## Frontend NACL Inbound Rules

| Rule number | Type      | Protocol | Port range | Source       | Allow/Deny |
|-------------|-----------|----------|------------|--------------|------------|
| 100         | SSH       | TCP      | 22         | 10.0.1.0/28  | Allow      |
| 110         | Custom TCP| TCP      | 3000       | 10.0.1.0/28  | Allow      |
| *           | All traffic | All     | All        | 0.0.0.0/0    | Deny       |

![image](https://github.com/CodeOps-Hub/Documentation/assets/79625874/e965df8b-f00f-47c2-9bdd-c58c7db4f7f6)

## Backend NACL Inbound Rules

| Rule number | Type      | Protocol | Port range | Source       | Allow/Deny |
|-------------|-----------|----------|------------|--------------|------------|
| 100         | SSH       | TCP      | 22         | 10.0.1.0/28  | Allow      |
| 110         | Custom TCP| TCP      | 8080       | 10.0.1.16/28 | Allow      |
| *           | All traffic | All     | All        | 0.0.0.0/0    | Deny       |

![image](https://github.com/CodeOps-Hub/Documentation/assets/79625874/c05601dd-20a2-4076-90c7-ec6150d814b9)


**Step-5 Configure Outbound Rules**

Click on the Outbound Rules tab.

Click the Action under the drop down select Edit Outbound Rule button or else you can select directly Edit Outbound Rule.

![image](https://github.com/CodeOps-Hub/Documentation/assets/79625874/cfefcca5-f4a1-43b5-a1f7-245562ab8872)

Add new rule according to the infra setup

![image](https://github.com/CodeOps-Hub/Documentation/assets/79625874/c6089f27-b9d6-4e87-9573-387c4b34f474)

## We have followed below set of rules for our NACL Inbound rules
### Public NACL Outbound Rules

| Rule number | Type      | Protocol | Port range | Destination  | Allow/Deny |
|-------------|-----------|----------|------------|--------------|------------|
| 100         | SSH       | TCP      | 22         | 10.0.1.0/28  | Allow      |
| 110         | Custom TCP| TCP      | 1024-65535 | 10.0.0.0/28  | Allow      |
| *           | All traffic | All     | All       | 0.0.0.0/0    | Deny      |

![image](https://github.com/CodeOps-Hub/Documentation/assets/79625874/f2fbd1da-b002-470e-81f2-c4f528193f60)

## Frontend NACL Outbound Rules

| Rule number | Type       | Protocol | Port range | Destination  | Allow/Deny |
|-------------|----------- |----------|------------|--------------|------------|
| 100         | SSH        | TCP      | 22         | 10.0.1.0/28  | Allow      |
| 110         | Custom TCP | TCP      | 3000       | 10.0.1.0/28  | Allow      |
| 120         | Custom TCP | TCP      | 32768-65535| 10.0.1.0/28  | Allow      |
| 130         | Custom TCP | TCP      | 1024-65535 | 10.0.1.0/28  | Allow      |
| *           | All traffic | All     | All        | 0.0.0.0/0    | Deny       |

![image](https://github.com/CodeOps-Hub/Documentation/assets/79625874/310e3499-f430-4d49-aa43-02f9c9264aea)

## Backend NACL Outbound Rules

| Rule number | Type      | Protocol | Port range | Source       | Allow/Deny |
|-------------|-----------|----------|------------|--------------|------------|
| 100         | SSH       | TCP      | 22         | 10.0.1.0/28  | Allow      |
| 110         | Custom TCP| TCP      | 8080       | 10.0.1.16/28 | Allow      |
| 130         | Custom TCP| TCP      | 32768-65535| 10.0.1.16/28 | Allow      |
| *           | All traffic | All     | All        | 0.0.0.0/0    | Deny      |

![image](https://github.com/CodeOps-Hub/Documentation/assets/79625874/c16cc6d3-b9b8-445e-a1c6-dc2809968305)

## Database NACL Outbound Rules

| Rule number | Type      | Protocol | Port range | Source       | Allow/Deny |
|-------------|-----------|----------|------------|--------------|------------|
| 100         | SSH       | TCP      | 22         | 10.0.1.0/28  | Allow      |
| 120         | Custom TCP(Redis)| TCP      | 6379       | 10.0.1.32/28 | Allow      |
| 130         | Custom TCP(Scylla)| TCP      | 9042       | 10.0.1.32/28 | Allow      |
| 140         | Custom TCP (PostgreSQL) | TCP| 5432    | 10.0.1.32/28 | Allow      |
| 150         | Custom TCP| TCP      | 1024-65535 | 10.0.1.32/28 | Allow      |
| *           | All traffic | All     | All        | 0.0.0.0/0    | Deny       |

![image](https://github.com/CodeOps-Hub/Documentation/assets/79625874/b1eaa024-4de4-4765-a27c-e2593c1fae67)


## Conclusion
Effectively configuring NACL rules is essential for securing your VPC at the subnet level. Regularly review and update these rules based on changing application requirements and security best practices. 



---

## Contact Information

| Name               | Email Address                               |
| ------------------ | ------------------------------------------- |
| Vikram Bisht       | Vikram.bisht@opstree.com                    |

---

## Resources and References

| Description                                   | References                                                        |
| --------------------------------------------- | ----------------------------------------------------------------- |
| Control traffic to subnets using network ACLs | [Link](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-network-acls.html) |
| Dev Infra Design      | [Link](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Design/09-%20Cloud%20Infra%20Design/Cloud-Infra-Design-Dev.md) |
