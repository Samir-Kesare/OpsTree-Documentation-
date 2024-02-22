# Setup Listener Rules for Load Balancer ( Salary API )
![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/64e2dc7e-b422-4f2d-bafd-51e475cde508)

| Author                                                           | Created on  | Version    | Last Updated by | Last Updated on |
| ---------------------------------------------------------------- | ----------- | ---------- | --------------- | --------------- |
| **[Harshit Singh](https://github.com/Panu-S-Harshit-Ninja-07)**  | 22-02-2024  | 1.0        | Harshit Singh   | 22-02-2024      |

***
## Table of Contents
1. [Introduction](#Introduction)
2. [Pre-requisites](#Pre-requisites)
3. [Steps to setup Listener Rules for Load Balancer](#Steps-to-setup-Listener-Rules-for-Load-Balancer)
4. [Output](#Output)
5. [Conclusion](#Conclusion)
6. [Contact Information](#Contact-Information)
7. [References](#References)

***

## Introduction
**_Load balancing_** in AWS refers to the process of distributing incoming network traffic across multiple servers or resources to ensure high availability and reliability of applications or services. The primary purpose of load balancing is to optimize resource utilization, maximize throughput, minimize response time, and avoid overloading any single resource.

A `load balancer` serves as the single point of contact for clients. Clients send requests to the load balancer, and the load balancer sends them to targets, such as EC2 instances. 

To configure your load balancer, you create `target groups`, and then register targets with your target groups. 

You also create `listeners` to check for connection requests from clients, and `listener rules` to route requests from clients to the targets in one or more target groups.

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/35961366-c45c-4b16-b1a1-c3b511578cb7)

***

## Pre-requisites
* Access to the AWS Management Console or AWS CLI with appropriate permissions.

* Understanding of your application's [network requirements](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Design/09-%20Cloud%20Infra%20Design/Cloud-Infra-Design-Dev.md).

***
## Steps to setup Listener Rules for Load Balancer
### Step 1: Create target group
  
  1. Open the Amazon EC2 console at _**https://console.aws.amazon.com/ec2/**_ .
  
  2. In the navigation pane, choose `Target Groups`.

     <img width="800" length="100" alt="LB" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/af210fdd-50b2-4f76-b6ab-911ca8ca7f8a">   
 
  3. Choose Create target group.

     <img width="800" length="100" alt="LB" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/0274d078-fed6-419b-9d51-a974fd613279">  
  
  4. `Choose a target type` select `Instances` to specify targets by instance ID or IP addresses to specify targets by only IP address.

     ![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/1f3d4c87-a5d2-4703-a103-d436e5557400)

  5. `Target group name` enter a name for the target group.eg `Dev-salary-tg`.

     ![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/b21fcfac-42b3-4d3c-b71b-ab7886c80bc9)

  6. `VPC` select a virtual private cloud (VPC) with the targets that you want to include in your target group.eg `Dev-VPC`

     ![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/318d77cf-4ae9-4740-8e1b-1306d1df6cf1)

  7. Provide health check [**endpoint**](https://github.com/CodeOps-Hub/Salary-API?tab=readme-ov-file#endpoint-information).

      ![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/9401f626-b211-4e41-b911-ee9d8da0c838)

  8. Keep all other configurtion to default then Choose `Next`. 

      ![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/a5a3d5cd-ccd8-47c0-a7ce-bbf6fb683bd2)

  9. Register targets
     To register instances, choose Register targets. Select one or more instances, enter the default instance port as needed here, it is `8080` and then choose Include as pending below. When         you are finished adding instances, choose Register pending targets.

     ![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/d5ce63cd-956f-4748-98b0-e82617b7a5d0)
     <br><br>

     ![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/54f5f26d-40cb-42b0-82b0-9203af381fb0)

### Step 2: Add listener rule of load balancer 
  
  1. Open the Amazon EC2 console at https://console.aws.amazon.com/ec2/.
  2. In the navigation pane, choose Load Balancers.
  3. Click on `Dev-ALB`.

     ![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/141a7e43-4eed-43bc-ad76-8c93e50a5ba8)

  4. Click on Protocok Port `HTTP:80`

     ![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/fe1aab7a-7510-4aa5-bff5-0fd4f56d5bb8)

  5. Click on `Add Rule`

     ![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/0f1e118b-280a-42b0-9b50-6d2740306b03)

  6. Define **Name**, and other required tags. 

     ![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/7e59494f-d5ad-4a50-86d9-5991dddf134c)

  7. Choose **Next.**
  8. Choose **Add condition**. Select and define the **path**. For example: `/item/*` . To save the condition, choose **Confirm**.

     ![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/99ef3cfd-8bc4-42dd-a166-bb663a821073)

  9. Choose **Next.**
  
  10. **Forward to target groups –** Choose one or more target groups to forward traffic to. To add target groups choose Add target group. If using more than one target group, select a weight         for each target group and review the associated percentage.

      ![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/fc3a1375-043f-4593-aa0c-d1a9cca70d34)

  11. Choose **Next.**
  
  12. In the Rule section, specify the Priority of your rule from 1-50000. It's recommended to leave gaps between your listener rules priority numbers.

      ![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/150f15a2-617b-4a85-b3bb-ea6ffe5176bc)

  13. Choose **Next.**
  
  14. Review all the details and settings currently configured for your new rule. Once you're satisfied with your selections, choose **Create.**

      ![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/379bfbcb-2070-4fdf-9566-429a88be204b)
 
> [!NOTE]
> Please note that before hitting the DNS, ensure that API is running

## Output

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/bd814bb6-da87-4d0b-804a-e73ec1b15b9f)

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/96f01a2c-8f67-41ef-96d6-bb179286760c)
***
## Conclusion

This document offers a streamlined approach to implementing listener rules for load balancers within AWS. By understanding the significance of load balancing and the benefits provided by AWS Load Balancer, users can effectively optimize their application's performance, availability, and scalability. The step-by-step instructions provided in the document enable users to configure target groups, register targets, set up a load balancer and listener, and conduct thorough testing. This process ensures efficient traffic management, enhancing the overall reliability and responsiveness of applications hosted on AWS infrastructure.

***
## Contact Information

|     Name         | Email  |
| -----------------| ------------------------------------ |
| Harshit Singh    | harshit.singh.snaatak@mygurukulam.co |
***

## References

| Description                                   | References  
| --------------------------------------------  | -------------------------------------------------|
| Documentation Template | [Link](https://github.com/OT-MICROSERVICES/documentation-template/wiki/Application-Template) |
| Dev Infra Design      | [Link](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Design/09-%20Cloud%20Infra%20Design/Cloud-Infra-Design-Dev.md) |
| Listener Rules | https://docs.aws.amazon.com/elasticloadbalancing/latest/application/listener-update-rules.html |
