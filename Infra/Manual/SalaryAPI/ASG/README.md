# Setup Auto Scaling for Salary API
![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/96dc6672-d14f-41f4-8f2f-7d6642840df2)

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

## Introduction_
**Amazon EC2 Auto Scaling**_ helps you ensure that you have the correct number of Amazon EC2 instances available to handle the load for your application. You create collections of EC2 instances, called _**Auto Scaling groups**_. 

You can specify the minimum number of instances in each Auto Scaling group, and Amazon EC2 Auto Scaling ensures that your group never goes below this size. You can specify the maximum number of instances in each Auto Scaling group, and Amazon EC2 Auto Scaling ensures that your group never goes above this size. If you specify the desired capacity, either when you create the group or at any time thereafter, Amazon EC2 Auto Scaling ensures that your group has this many instances. 

If you specify scaling policies, then Amazon EC2 Auto Scaling can launch or terminate instances as demand on your application increases or decreases.

_**AWS Auto Scaling**_ monitors your applications and automatically adjusts capacity to maintain steady, predictable performance at the lowest possible cost.

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/a2d2437d-3c76-44a1-b0b8-d38128cc9888)

***

## Pre-requisites
* Access to the AWS Management Console or AWS CLI with appropriate permissions.

* Understanding of your application's [network requirements](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Design/09-%20Cloud%20Infra%20Design/Cloud-Infra-Design-Dev.md).

***
## Steps to setup Auto Scaling
### Step 1: Create AMI image of Salary API instance 
 1. Open the Amazon EC2 console at https://console.aws.amazon.com/ec2/ .
 
 2. Select `Dev-salary-API` instance, go to `Actions --> Image and templates --> Create image`

    ![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/e41c4d4e-0182-4cce-9bfe-ef1e1a4c9994)

 3. Enter **Name** and **Description** of image.

    ![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/374d4dcb-c5ba-41e9-ac70-522d3d790a08)

 4. Choose **Create image**

    ![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/df708075-3eac-4177-864d-ef1da9fcfaab)

It may take a few minutes for the AMI to be created. After it is created, it will appear in the **AMIs view** in AWS Explorer. To display this view, double-click the Amazon EC2 | AMIs node in AWS Explorer. To see your AMIs, from the Viewing drop-down list, choose **Owned By Me**. You may need to choose **Refresh** to see your AMI. When the AMI first appears, it may be in a **pending state**, but after a few moments, it transitions to an **available state**.
 
> [!NOTE]
> Please note that before hitting the DNS, ensure that API is running

## Output

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
| Documentation Template | https://github.com/OT-MICROSERVICES/documentation-template/wiki/Application-Template |
| Dev Infra Design      | https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Design/09-%20Cloud%20Infra%20Design/Cloud-Infra-Design-Dev.md |
| Launch Template | https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/create-launch-template.html |
| Auto Scaling Group | https://docs.aws.amazon.com/autoscaling/ec2/userguide/create-asg-launch-template.html |
