# Setup Listener Rules for Load Balancer ( Salary API )
![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/64e2dc7e-b422-4f2d-bafd-51e475cde508)

| Author                                                           | Created on  | Version    | Last Updated by | Last Updated on |
| ---------------------------------------------------------------- | ----------- | ---------- | --------------- | --------------- |
| **[Harshit Singh](https://github.com/Panu-S-Harshit-Ninja-07)**  | 22-02-2024  | 1.0        | Harshit Singh   | 22-02-2024      |

***
## Table of Contents
1. [Introduction](#Introduction)
2. [Pre-requisites](#Pre-requisites)
3 [Steps to setup Listener Rules for Load Balancer](#Steps-to-setup-Listener-Rules-for-Load-Balancer)
4. [Contact Information](#Contact-Information)
5. [References](#References)

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
### Step 1: Configure a target group
  
  1. Open the Amazon EC2 console at _**https://console.aws.amazon.com/ec2/**_ .
  2. In the navigation pane, choose `Target Groups`.
  3. Choose Create target group.
   <img width="800" length="100" alt="LB" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/af210fdd-50b2-4f76-b6ab-911ca8ca7f8a">   
    
   <img width="800" length="100" alt="LB" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/0274d078-fed6-419b-9d51-a974fd613279">  
  
  4. `Choose a target type` select `Instances` to specify targets by instance ID or IP addresses to specify targets by only IP address.
   ![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/1f3d4c87-a5d2-4703-a103-d436e5557400)

  5. `Target group name` enter a name for the target group.eg `Dev-salary-tg`.
    ![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/b21fcfac-42b3-4d3c-b71b-ab7886c80bc9)

  6. `VPC` select a virtual private cloud (VPC) with the targets that you want to include in your target group.eg `Dev-VPC`
   ![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/318d77cf-4ae9-4740-8e1b-1306d1df6cf1)

  7. Provide health check [endpoint](https://github.com/CodeOps-Hub/Salary-API?tab=readme-ov-file#endpoint-information).
   ![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/9401f626-b211-4e41-b911-ee9d8da0c838)

  8. Keep all other configurtion to default then Choose Next. 
   ![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/a5a3d5cd-ccd8-47c0-a7ce-bbf6fb683bd2)


  <img width="800" length="100" alt="LB" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/5a91aade-231d-4778-9c85-8400319040a5">  
  
   <img width="800" length="100" alt="LB" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/5fca6e2d-bdd7-4e00-be1d-bdeddc307dfe">

### Step 2: Register targets

  * Select one or more instances, enter one or more eg `3000` ports, and then choose Include as pending below.
  * Then Choose Create target group.
    
 <img width="800" length="100" alt="LB" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/afe80217-25ba-4be8-97be-b1949847de91"> 

### Step 3: Configure a load balancer and a listener
  
  *  Open the Amazon EC2 console at https://console.aws.amazon.com/ec2/.
  *  In the navigation pane, choose Load Balancers.
  *  Choose `Create Load Balancer`.
 
  <img width="760" length="100" alt="LB" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/63694869-46f0-4609-894a-e6253b8433dd">   
  
  * Under Application Load Balancer, choose Create.
    
  <img width="760" length="100" alt="LB" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/a27ebe0b-d905-42d8-a98e-8cbd63f80b0d"> 
  
  * `Load balancer name` enter a name for your load balancer. For example :- `DEV-ALB`.
  * Other  all configuration default .

 <img width="760" length="100" alt="LB" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/df209245-4109-471f-867e-cb3deb86f0af"> 

 * VPC select the VPC that you used for your EC2 instances.eg `DEV-VPC`
 * Mappings enable zones for your load balancer by selecting subnets from two or more Availability Zones.

 <img width="760" length="100" alt="LB" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/c2e9a346-a9ca-4675-9db5-5c036decaea3"> 

  * Security groups, select an existing security group, or create a new one. `with 80(HTTP) and 443(HTTPS)` `Frontend-lb-sg`
  * Listeners and routing, the default listener accepts HTTP traffic on port 80. You can keep the default protocol and port, or choose different ones.eg `frontend-tg`.
  * Other  all configuration default .
     
<img width="760" length="100" alt="LB" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/d020611f-830d-482f-bb3d-e376b873bc78"> 

  * Review your configuration and choose Create load balancer. 

<img width="760" length="100" alt="LB" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/12c8aedb-027c-4897-9a78-ce20a36c47f1"> 

### Step 4: Test the load balancer

* Select the newly created load balancer.
* Choose Description and copy the DNS name of the internet facing or internal load balancer
* (for example, `Dev-ALB-1442510364.us-east-1.elb.amazonaws.com`).
  
<img width="760" length="100" alt="LB" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/0e988d1d-543b-4152-ad13-7a84e8962cb4">     

  * Paste the DNS name into the address field of an internet connected web browser.
  
> [!NOTE]
> * Please note that before hitting the DNS, the machine active and `npm start` commands should be run.

  * [**DNS**](Dev-ALB-1442510364.us-east-1.elb.amazonaws.com)
   
<img width="760" length="100" alt="LB" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/9914249d-3f0f-496c-9d0c-b8f217957b37">

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
| Setup Instance | [Link](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EC2_GetStarted.html) |
