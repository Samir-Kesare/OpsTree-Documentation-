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
+ [Setup](#Setup)
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
### Steps To create Auto Scaling Launch Template  

  *  Open the Amazon EC2 console at https://console.aws.amazon.com/ec2/.
  *  In the navigation pane, choose `Target Groups`.

   <img width="760" length="100" alt="ASG" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/94584484-c221-4651-b20a-e0a22d7f8334"> 
 
  *  Click on the Create `launch template`.

    <img width="760" length="100" alt="ASG" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/77e3fa2a-a442-46fd-87d0-b4f639135c0e">
  
***
## Conclusion



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
| Infra Diagram | [Link](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Design/09-%20Cloud%20Infra%20Design/Cloud-Infra-Design-Dev.md) |


***
