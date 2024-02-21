# Setup Auto Scaling for (Employee-API)

<img width="360" length="100" alt="Security" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/697fb29c-b84f-43bf-a48d-6c86d0ec41fa"> 

***

|   Author        |  Created on   |  Version   | Last updated by  | Last edited on |
| --------------- | --------------| -----------|----------------- | -------------- |
| Shreya Jaiswal |  21-02-2024  |  Version 1 | Shreya  | 21-02-2024    |
| Parasharam Desai | 21-02-2024 | Version 1 | Parasharam | 21-02-2024 |


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

  * Type the Template name. eg `Dev-Employee-LT` and click on create launch template

      <img width="587" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/22263022-dfa2-431f-b57e-e3ab3b3a8d1a">


  * select the Amazon Machine Image (AMI) that has already been created,eg `Emloyee-API-AMI`

     <img width="656" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/3b67da77-4ee2-487e-b74c-e0c64aa75153">

  * Select the `Instance Type` and `Key Pair` and `subnet`.eg `t2-micro` `snaatak` `Backend-Pvt-Subnet` then click on create launch template.
  
     <img width="467" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/23ee3cea-4a70-4d00-b477-3af9010b42a1">
  
  * Now you can see the template is created. Now, scroll down and click on the `Auto Scaling Groups`.
    
     <img width="794" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/4910dde9-c2b8-40a3-88c9-ed109a18a195">


### Create An Auto Scaling Group Using a Launch Template

  * Click on the Create Auto Scaling group.

      <img width="660" length="100" alt="ASG" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/666c3d72-ef83-4a43-8177-ec7b0d9e5f20">

  * Type the Auto Scaling group name.eg `Dev-Employee-ASG` and template name eg `Dev-Employee-LT` and version eg `default(1)`.
  * Then Cilck `Next`.

     <img width="560" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/73cc9093-1e84-478b-bee5-bae1eb38f991">

   * Select the VPC and also select the Availability zone.eg `Dev-VPC` `Backend-Pvt-subnet`
   * Then Cilck `Next`.

     <img width="432" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/a41fdd4f-55a8-4afe-bb2e-e615843afee1">

  * Attach Load Balancer and Target Group and rest of the configurations will be default then cilck next.
   
     <img width="426" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/e019a14b-75a9-426b-8984-860a936fe9a9">

   * Configure the Group size and Scaling policies.
     
     Select as per your requirement:  
            * Desired: 1  
            * Minimum: 1  
            * Maximum: 2

      <img width="472" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/8e2cb560-2fe8-4ba4-86ff-097deff6bfa4">

  * Select the Target tracking scaling policy and rest of the configurations will be default then cilck next.

      <img width="660" length="100" alt="ASG" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/e7d48194-e62b-448a-a113-21593a0dc2f1">

  * This is optional step, if you want to add notificiation and tag, you can modify this otherewise, cilck next and skip this step, then click on `Create Auto Scaling group`.

     <img width="620" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/9d5b618c-42a9-447a-88ab-5c9c78ad8bde">

 * This is the ASG we created, as per our configuration, 2 instances created .  

     <img width="938" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/c92890ab-010c-463d-bbbe-33ad199d63f0">
  
  
***

## Conclusion

Amazon EC2 Auto Scaling manages your application's scalability by organizing instances into groups. It adjusts instance counts based on demand, offering features like health monitoring, custom checks, and load balancing. Simple steps help create Auto Scaling groups for dynamic scaling, optimizing performance and costs.

***

## Contact Information
| Name | Email address |
| ---- | ------------- |
| **Shreya Jaiswal** | shreya.jaiswal.snaatak@mygurukulam.co |
| **Parasharam Desai** | parasharam.desai.snaatak@mygurukulam.co |

***

## Resources and References

|  **Description** |   **Source** |
| ---------------- | ------------ |
| About Auto Scaling | [Link](https://docs.aws.amazon.com/autoscaling/ec2/userguide/what-is-amazon-ec2-auto-scaling.html) |
| Setup ASG | [Link](https://www.geeksforgeeks.org/create-and-configure-the-auto-scaling-group-in-ec2/) |
| Infra Diagram | [Link](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Design/09-%20Cloud%20Infra%20Design/Cloud-Infra-Design-Dev.md) |


***


