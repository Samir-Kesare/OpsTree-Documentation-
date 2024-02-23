# Setup Auto Scaling for Attendance API


|   Author        |  Created on   |  Version   | Last updated by  | Last edited on |
| --------------- | --------------| -----------|----------------- | -------------- |
| Vidhi Yadav |  23rd Feb 2024  |  Version 1 | Vidhi Yadav  | 23rd Feb 2024    |

***
## Table of Contents
+ [Introduction](#Introduction)
+ [Key Features](#key-features)
+ [How AWS Auto Scaling Works](#How-AWS-Auto-Scaling-Works)
+ [Pre-requisites](#Pre-requisites)
+ [Steps To create Auto Scaling](#Steps-To-create-Auto-Scaling)
+ [Conclusion](#Conclusion)
+ [Contact Information](#Contact-Information)
+ [Resources and References](#Resources-and-References)
  
***
## Introduction

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056349/31833f9b-31ce-4749-88c8-0db4157f35e7)

Amazon EC2 Auto Scaling allows you to manage the number of EC2 instances for your application automatically. You create groups of EC2 instances called Auto Scaling groups. You set minimum and maximum limits for the number of instances in each group. You can also specify how many instances you want at any given time. EC2 Auto Scaling adjusts the number of instances based on demand, launching or terminating them as needed.


***
## Key Features

| Feature                                      | Description                                                                                                           |
|----------------------------------------------|-----------------------------------------------------------------------------------------------------------------------|
| Dynamic Resource Allocation                  | Auto scaling dynamically adjusts compute resources based on real-time demand, ensuring efficient workload management.  |
| Cost Optimization                           | Auto scaling optimizes costs by scaling resources up or down as needed, preventing over-provisioning and downtime.    |
| High Availability and Fault Tolerance       | It enhances reliability by replacing unhealthy instances and distributing traffic across healthy instances.|
| Seamless Integration with AWS Services       | It integrates with services like Elastic Load Balancing and CloudWatch for automatic load distribution.     |


***
## How AWS Auto Scaling Works

AWS autoscaling will scale the application based on the load of application. Instead of scaling manually AWS auto scaling will scale the application automatically when the incoming traffic is high it will scale up the application and when the traffic is low it will scale down the application.

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056349/a7e9ce32-72d4-4f67-9ec6-ba12ee2f3b55)

First you should choose which service or an application you want to scale then select the optimisation way like cost and performance and then keep track how the scaling is working.

***
## Pre-requisites

| Prerequisite      | Description                                                                                                                     |
|-------------------|---------------------------------------------------------------------------------------------------------------------------------|
| AWS Account       | Access to an AWS account with permissions to create and manage auto scaling groups, launch templates, and associated resources. |
| EC2 Instances     | Create or identify the EC2 instances you want to scale. These instances should be based on an Amazon Machine Image (AMI) and should be properly configured for your application. |


***
## Steps To create Auto Scaling
### Create Launch Template  

  *  Begin by accessing the Amazon EC2 console on the AWS Management Console.
  *  From the navigation pane, select "Launch Templates."

     <img width="760" length="100" alt="ASG" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/94584484-c221-4651-b20a-e0a22d7f8334"> 
 
  *  Click on the "Create launch template" button.

      <img width="460" length="100" alt="ASG" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/77e3fa2a-a442-46fd-87d0-b4f639135c0e">

  * Provide a name for the template (e.g., Frontend-template) and assign a version (e.g., version-1).

      <img width="560" length="100" alt="ASG" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/d9c2b358-7c77-4fa9-b9b2-981963da31ca">

  * Choose an existing Amazon Machine Image (AMI) or select a custom one.
      <img width="560" length="100" alt="ASG" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/a951c64f-4ac7-436d-91e7-1da9110d5951">
      
  * Specify the instance type, key pair, and subnet for the EC2 instances.
  
      <img width="760" length="100" alt="ASG" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/f9a787fc-6007-48f2-89f9-3466712032e4">

   *  Assign the appropriate security group.

      <img width="460" length="100" alt="ASG" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/be0ba791-be16-4684-8c56-41ea64b1d63e">

  * Optionally, add a script in the user data section for custom setup.
    ```shell
    #!/bin/bash
    cd /home/ubuntu/attendance/attendance
    poetry shell
    
    ```
  * Complete the creation process by clicking on "Create Launch Template."
           
      <img width="560" length="100" alt="ASG" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/4adc5f1a-9914-4360-a40a-ba0934f8cfda">

### Create An Auto Scaling Group Using a Launch Template

  * Select "Auto Scaling Groups" from the EC2 dashboard and Click on "Create Auto Scaling group."

      <img width="660" length="100" alt="ASG" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/666c3d72-ef83-4a43-8177-ec7b0d9e5f20">

  * Provide a name for the Auto Scaling group (e.g., Attendance-ASG), and specify the previously created launch template and version.
  * Then Cilck `Next`.

      <img width="660" length="100" alt="ASG" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/31ea1111-6f32-40e5-b9ea-8a4de2a476ac">

   * Configure the VPC and select the desired availability zone.
   * Then Cilck `Next`.

      <img width="660" length="100" alt="ASG" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/4863e403-bd8f-4c50-a7c9-5f97a8c414ef">

  * Attach load balancers and target groups as needed.
   
      <img width="660" length="100" alt="ASG" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/91095b2c-55a3-4fab-bc09-841a2a4094b7">

   * Define the group size and scaling policies based on requirements.
     
     Select as per your requirement:  
            * Desired: 2  
            * Minimum: 1  
            * Maximum: 2

      <img width="660" length="100" alt="ASG" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/873a836d-659f-4105-b32a-a82bd06d3888">  

  * Choose the target tracking scaling policy for automatic adjustments.

      <img width="660" length="100" alt="ASG" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/e7d48194-e62b-448a-a113-21593a0dc2f1">

  * Optionally, add notifications and tags for organizational purposes.

       <img width="660" length="100" alt="ASG" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/66eeef85-b6ae-46a1-ae63-7faf7ecfa6aa">

 * Review the configuration and create the Auto Scaling group.

     <img width="660" length="100" alt="ASG" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/3b1165d8-4974-496c-abff-dbd4e0512f99">

 * This is the ASG we created, as per the configuration, 2 instances were created .  

      <img width="660" length="100" alt="ASG" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/36d82468-641b-4114-a343-c6c7454f44d0">      
  
***
## Conclusion

Amazon EC2 Auto Scaling simplifies application scalability by managing instance groups dynamically. It adjusts instance counts based on demand, incorporating health monitoring, custom checks, and load balancing. Following these straightforward steps enables the creation of Auto Scaling groups, optimizing performance and costs effortlessly.

***
## Contact Information
| Name | Email address |
| ---- | ------------- |
| Vidhi Yadav | vidhi.yadhav.snaatak@mygurukulam.co |
***
## Resources and References
|  **Description** |   **Source** |
| ---------------- | ------------ |
| Setup ASG | [Link](https://www.youtube.com/watch?v=jkK29xGhQZo) |
| Infra Diagram | [Link](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Design/09-%20Cloud%20Infra%20Design/Cloud-Infra-Design-Dev.md) |

***


