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


***
## Steps To create Auto Scaling
### Create AMI (Amazon Machine Image)

1. Select the Instance and Choose "Actions": Right-click on the instance or select it and click on the "Actions" dropdown menu.

<img width="1135" alt="Screenshot 2024-02-23 at 2 06 26 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/c52afc6f-8f44-4167-9f7c-d41e59fcf02c">

2. Provide Image Details: In the dialogue box that appears, provide details for the new AMI:

Image Name: Give a descriptive name for the AMI (e.g., Myinstance-AMI).
Image Description: Optionally, add a brief description for the AMI.

<img width="1026" alt="Screenshot 2024-02-23 at 2 08 19 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/96cb90bc-575a-4252-9495-1199334de4fd">

3. Now, click on "Create image (AMI)."

### Create Launch Template  

  *  Begin by accessing the Amazon EC2 console on the AWS Management Console.
  *  From the navigation pane, select "Launch Templates."

  <img width="938" alt="Screenshot 2024-02-23 at 1 01 10 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/95ca6b98-aa53-458d-b3f2-ac9283fe71e3">

  *  Click on the "Create launch template" button.

  <img width="1325" alt="Screenshot 2024-02-23 at 1 02 01 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/0a3b8301-05e7-44d7-a631-4200d3c87d1d">

  * Provide a name for the template (e.g., Frontend-template) and assign a version (e.g., version-1).

  <img width="784" alt="Screenshot 2024-02-23 at 1 19 44 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/acdbfafe-1ca3-4823-8a4f-16020e5c2709">

  * Choose an existing Amazon Machine Image (AMI) or select a custom one.

  <img width="750" alt="Screenshot 2024-02-23 at 1 21 22 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/72dda7b3-ae37-423f-9a68-61c68d28a036">

  * Specify the instance type, key pair, and subnet for the EC2 instances.
  
  <img width="734" alt="Screenshot 2024-02-23 at 1 22 30 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/2d2503c7-da21-4350-9f3f-d9efd2c02095">

   *  Assign the appropriate security group.
  <img width="711" alt="Screenshot 2024-02-23 at 1 23 30 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/35700a6a-f515-4694-b702-a13d6474b8d3">


  * Optionally, add a script in the user data section for custom setup.
  <img width="742" alt="Screenshot 2024-02-23 at 1 32 10 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/25b129b6-8a1b-49d9-b9bd-8b0c3561d64f">

    ```shell
    cd attendance
    cd attendance-api/
    poetry shell
    gunicorn app:app --log-config log.conf -b 0.0.0.0:8080
    ```
  * Complete the creation process by clicking on "Create Launch Template."

  <img width="614" alt="Screenshot 2024-02-23 at 1 34 06 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/b769b8d0-9c81-4522-a96f-7132152e94df">


### Create An Auto Scaling Group Using a Launch Template

  * Select "Auto Scaling Groups" from the EC2 dashboard and Click on "Create Auto Scaling group."
  
  <img width="848" alt="Screenshot 2024-02-23 at 1 41 16 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/da126c0c-b56e-4cbc-96d8-2a8ff3b0731f">

  * Provide a name for the Auto Scaling group (e.g., Attendance-ASG), and specify the previously created launch template and version.
  * Then Cilck `Next`.

  <img width="761" alt="Screenshot 2024-02-23 at 1 42 26 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/3ab34838-1cd3-4b02-b4d3-6a1c9a68b638">

   * Configure the VPC and select the desired availability zone.
   * Then Cilck `Next`.

  <img width="674" alt="Screenshot 2024-02-23 at 1 44 02 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/c7ec1583-b8e0-4bf3-9100-2b555f9195d9">

  * Attach load balancers and target groups as needed.

   <img width="780" alt="Screenshot 2024-02-23 at 1 45 02 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/6252ba87-483a-4cea-be1d-f1379b021905">

   * Define the group size and scaling policies based on requirements.
     
     Select as per your requirement:  
            * Desired: 2  
            * Minimum: 1  
            * Maximum: 2

  <img width="605" alt="Screenshot 2024-02-23 at 1 46 20 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/31a8ce53-aaf3-4c48-85ea-d26d26d08b57">

  * Choose the target tracking scaling policy for automatic adjustments.

  <img width="738" alt="Screenshot 2024-02-23 at 1 49 57 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/b5ac38ad-1ba9-4f1a-bbb2-0b7e8f2c603e">

  * Optionally, add notifications and tags for organizational purposes.

  <img width="815" alt="Screenshot 2024-02-23 at 1 51 19 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/28a78801-e30e-4a63-ae69-f749302620b3">
  <img width="807" alt="Screenshot 2024-02-23 at 1 51 50 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/514499fb-0a33-468e-87fb-e802d7fe48cf">


 * Review the configuration and create the Auto Scaling group.

 <img width="847" alt="Screenshot 2024-02-23 at 1 52 28 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/fe70a489-8420-4b08-8592-b4d18cf936e7">


 <img width="960" alt="Screenshot 2024-02-23 at 1 52 58 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/3e385d6a-839e-4d62-bb8d-08329f6a9bbd">

 * This is the ASG we created, as per the configuration, 2 instances were created .  

 <img width="1047" alt="Screenshot 2024-02-23 at 1 55 16 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/774798b8-83ba-4a21-8bb0-080738484ddb">

  
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


