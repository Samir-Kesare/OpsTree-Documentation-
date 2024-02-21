# Setup Auto Scaling for (Frontend API)

<img width="360" length="100" alt="Security" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/697fb29c-b84f-43bf-a48d-6c86d0ec41fa"> 

|   Author        |  Created on   |  Version   | Last updated by  | Last edited on |
| --------------- | --------------| -----------|----------------- | -------------- |
| Vishal Kumar Kesarwani |  21-02-2024  |  Version 1 | Vishal  | 21-02-2024    |

***
## Table of Contents
+ [Introduction](#Introduction)
+ [Why use AWS Auto Scaling](#Why-use-AWS-Auto-Scaling)
+ [How AWS Auto Scaling Works](#How-AWS-Auto-Scaling-Works)
+ [Pre-requisites](#Pre-requisites)
+ [Steps To create Auto Scaling](#Steps-To-create-Auto-Scaling)
+ [Conclusion](#Conclusion)
+ [Contact Information](#Contact-Information)
+ [Resources and References](#Resources-and-References)
  
***
## Introduction

<img width="360" length="100" alt="Security" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/9061d024-a57d-47cf-8f73-5d3298a61441"> 

Amazon EC2 Auto Scaling allows you to manage the number of EC2 instances for your application automatically. You create groups of EC2 instances called Auto Scaling groups. You set minimum and maximum limits for the number of instances in each group. You can also specify how many instances you want at any given time. EC2 Auto Scaling adjusts the number of instances based on demand, launching or terminating them as needed.


***
## Why use AWS Auto Scaling

| Feature                                          | Description                                                                                                                |
|--------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------|
| **Monitoring the health of running instances**       | Automatically monitors instance health and replaces terminated or impaired instances to maintain desired capacity.         |
| **Custom health checks**                             | Define custom health checks to verify application response and automatically replace failing instances.                    |
| **Balancing capacity across Availability Zones**     | Distributes instances evenly across multiple Availability Zones for high availability and resiliency.                        |
| **Automated replacement of Spot Instances**          | Automatically requests replacement Spot capacity and proactively replaces instances at elevated interruption risk.         |
| **Load balancing**                                   | Utilizes Elastic Load Balancing for evenly distributing application traffic and automatically registering/deregistering instances. |
| **Scalability**                                      | Offers multiple scaling options to adjust capacity based on demand, maintaining availability and reducing costs.          |
| **Instance refresh**                                 | Updates instances in a rolling fashion with new AMIs or launch templates, supporting canary deployments for testing.       |
| **Lifecycle hooks**                                  | Defines custom actions triggered during instance launch or termination, useful for event-driven architectures.             |

***
## How AWS Auto Scaling Works

AWS autoscaling will scale the application based on the load of application. Instead of scaling manually AWS auto scaling will scale the application automatically when the incoming traffic is high it will scale up the application and when the traffic is low it will scale down the application.

<img width="460" length="100" alt="Security" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/9754a2aa-c29b-4969-8c20-f68bb20f032f"> 

First you should choose which service or an application you want to scale then select the optimisation way like cost and performance and then keep track how the scaling is working.
***
## Pre-requisites

  * Active AWS Account .

***
## Steps To create Auto Scaling
### Steps To create Launch Template  

  *  Open the Amazon EC2 console at https://console.aws.amazon.com/ec2/.
  *  In the navigation pane, choose `Launch Templates`.

     <img width="760" length="100" alt="ASG" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/94584484-c221-4651-b20a-e0a22d7f8334"> 
 
  *  Click on the Create `launch template`.

      <img width="460" length="100" alt="ASG" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/77e3fa2a-a442-46fd-87d0-b4f639135c0e">

  * Type the Template name. eg `Frontend-template` and give version `version-1`

      <img width="560" length="100" alt="ASG" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/d9c2b358-7c77-4fa9-b9b2-981963da31ca">

  * To select the Amazon Machine Image (AMI) that has already been created,eg `Fronted-AMI`

      <img width="560" length="100" alt="ASG" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/a951c64f-4ac7-436d-91e7-1da9110d5951">
      
  * Select the Instance Type and Key pair and subnet.eg `t2-micro` `snaatak` `Frontend-Pvt-Subnet`
  
      <img width="760" length="100" alt="ASG" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/f9a787fc-6007-48f2-89f9-3466712032e4">

   *  Select the Security Group eg `Frontend-lb-sg`

      <img width="460" length="100" alt="ASG" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/be0ba791-be16-4684-8c56-41ea64b1d63e">

  * Add a small scrpit in user data.
    ```shell
    #!/bin/bash
    cd /home/ubuntu/Frontend
    npm start
    ```
  * Click on the `Create Launch Template`.
           
      <img width="560" length="100" alt="ASG" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/4adc5f1a-9914-4360-a40a-ba0934f8cfda">

  * Now you can see the template is created. Now, scroll down and click on the `Auto Scaling Groups`.
    
      <img width="660" length="100" alt="ASG" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/94b70491-aa0f-4088-b556-f374e99f0fe2">

### Create An Auto Scaling Group Using a Launch Template

  * Click on the Create Auto Scaling group.

      <img width="660" length="100" alt="ASG" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/666c3d72-ef83-4a43-8177-ec7b0d9e5f20">

  * Type the Auto Scaling group name.eg `Frontend-ASG` and template name eg `Frontend-template`  and version eg `default(1)`.
  * Then Cilck `Next`.

      <img width="660" length="100" alt="ASG" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/31ea1111-6f32-40e5-b9ea-8a4de2a476ac">

   * Select the VPC or go with the default VPC and also select the Availability zone.eg `Dev-VPC` `Frontend-Pvt-subnet`
   * Then Cilck `Next`.

      <img width="660" length="100" alt="ASG" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/4863e403-bd8f-4c50-a7c9-5f97a8c414ef">

  * Attach Load Balancer and Target Group and rest of the configurations will be default then cilck next.
   
      <img width="660" length="100" alt="ASG" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/91095b2c-55a3-4fab-bc09-841a2a4094b7">

   * Configure the Group size and Scaling policies.
     
     Select as per your requirement:  
            * Desired: 2  
            * Minimum: 1  
            * Maximum: 2

      <img width="660" length="100" alt="ASG" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/873a836d-659f-4105-b32a-a82bd06d3888">  

  * Select the Target tracking scaling policy and rest of the configurations will be default then cilck next.

      <img width="660" length="100" alt="ASG" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/e7d48194-e62b-448a-a113-21593a0dc2f1">

  * This is optional step, if you want to add notificiation and tag, you can modify this otherewise, cilck next and skip this step. 

       <img width="660" length="100" alt="ASG" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/66eeef85-b6ae-46a1-ae63-7faf7ecfa6aa">

 * Review and click on the create `Auto Scaling Group`.

     <img width="660" length="100" alt="ASG" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/3b1165d8-4974-496c-abff-dbd4e0512f99">

 * This is the ASG we created, as per our configuration, 2 instances created .  

      <img width="660" length="100" alt="ASG" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/36d82468-641b-4114-a343-c6c7454f44d0">      
  
***
## Conclusion

Amazon EC2 Auto Scaling manages your application's scalability by organizing instances into groups. It adjusts instance counts based on demand, offering features like health monitoring, custom checks, and load balancing. Simple steps help create Auto Scaling groups for dynamic scaling, optimizing performance and costs.

***
## Contact Information
| Name | Email address |
| ---- | ------------- |
| Vishal | vishal.kesarwani.snaatak@mygurukulam.co |
***
## Resources and References
|  **Description** |   **Source** |
| ---------------- | ------------ |
| About Auto Scaling | [Link](https://docs.aws.amazon.com/autoscaling/ec2/userguide/what-is-amazon-ec2-auto-scaling.html) |
| Setup ASG | [Link](https://www.geeksforgeeks.org/create-and-configure-the-auto-scaling-group-in-ec2/) |
| Infra Diagram | [Link](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Design/09-%20Cloud%20Infra%20Design/Cloud-Infra-Design-Dev.md) |


***


