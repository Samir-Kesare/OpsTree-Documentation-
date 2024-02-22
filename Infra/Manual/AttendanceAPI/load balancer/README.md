# Setup Listener Rules for Load Balancer for Attendance API

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056349/6cccf599-1e8b-45d6-9844-3483cb9b9f01)

***

|   Author        |  Created on   |  Version   | Last updated by  | Last edited on |
| --------------- | --------------| -----------|----------------- | -------------- |
| Vidhi Yadav |  22nd Feb 2024  |  Version 1 | Vidhi Yadav  | 22nd Feb 2024    |

***
## Table of Contents
+ [Introduction](#Introduction)
+ [Load Balancer](#Why-use-AWS-Load-Balancer)
+ [Listener Rules](#Listener-Rules)
+ [Importance of Listener Rules](#Importance-of-Listener-Rules)
+ [Pre-requisites](#Pre-requisites)
+ [Steps to setup Listener Rules for Load Balancer](#Steps-to-setup-Listener-Rules-for-Load-Balancer)
+ [Conclusion](#Conclusion)
+ [Contact Information](#Contact-Information)
+ [Resources and References](#Resources-and-References)
  
***
## Introduction

<img width="319" alt="Screenshot 2024-02-23 at 12 07 17 AM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/1144a799-e9db-4d81-8865-b561e9a14748">

In today's tech world, where online services need to be up all the time and handle lots of users, load balancers are super important. They're like traffic cops for the internet, making sure that when you visit a website or use an app, your requests get spread out evenly to different servers. This helps the servers stay balanced, so none of them get fully utilized. Basically, load balancers keep things running smoothly and make sure websites and apps stay available even when multiple users are using them.


***
## Why use AWS Load Balancer

1. **Enhanced Performance:** Load balancers spread traffic across servers, avoiding overload. This means faster response times for users.

2. **Improved Scalability:** Load balancers adjust requests among servers, so when traffic grows, more servers can be added without slowing things down.

3. **Increased Reliability and High Availability:** Load balancers reroute traffic from failing servers, keeping the app running smoothly even if some servers crash.

4. **Optimized Resource Utilization:** Load balancers evenly distribute traffic based on server capacity and response times, preventing any server from getting overwhelmed and maximizing efficiency.

***
## Listener Rules

Listener rules in AWS load balancers determine how incoming traffic is routed to target groups based on request characteristics. Each rule, associated with a listener, prioritizes conditions like HTTP method, path, and source IP address, with lower priority numbers taking precedence. Actions include forwarding to target groups, redirecting, or returning fixed responses. Default rules handle unmatched requests by routing to a default target group or returning an error response.

***
## Pre-requisites

| Prerequisite                     | Description                                                                                                                                              |
|---------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------|
| AWS Account                     | An active AWS account is required to access AWS services. You can sign up for an account on the AWS website.                                           |
| Instances or Lambda Functions   | Prepare instances or Lambda functions to serve as targets for your load balancer. These instances should be running and healthy to register them with the target groups. |


***
## Setting Up Listener Rules for AWS Load Balancer
### Step 1: Setting Up a Target Group
  
  *  **Access the Amazon EC2 Console:** Log in to your AWS account and navigate to the EC2 console.
  *  **Navigate to Target Groups:** In the navigation pane, click on `Target Groups`.
  *  **Create a New Target Group:** Select `Create target group` to begin configuring a new target group.
 
   <img width="1011" alt="Screenshot 2024-02-23 at 12 47 19 AM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/18f8f451-cdd8-4fd7-aac6-ec4a9076a621">
  
  * Select the target type, either "Instances" or "IP addresses".
  * Enter a name for the target group (e.g., attendance-tg) and specify the port (e.g., 8080).
  * Choose the appropriate VPC where your targets reside.
  * Proceed with default configurations and click "Next".
    
<img width="831" alt="Screenshot 2024-02-23 at 12 51 01 AM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/0c7bb3ae-6a20-4c84-a96a-e57143bbc1c1">

<img width="856" alt="Screenshot 2024-02-23 at 12 51 34 AM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/05dc8cd6-2d30-4b40-9426-f5bc2a0dcccc">

<img width="831" alt="Screenshot 2024-02-23 at 12 51 01 AM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/aef0717c-9e4e-46ca-b6d3-db9152110bca">

***
### Step 2: Register targets

  * Select Instances and Ports: Choose the instances you want to include and specify the ports (e.g., `3000`). Click "Include as pending" below.
  * Create Target Group: After selecting instances and ports, click "Create target group".
    
<img width="994" alt="Screenshot 2024-02-23 at 1 14 17 AM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/36b802ee-4348-499c-99f3-64653abae405">

***

### Step 3: Configuring Load Balancer and Listener
  
  *  Navigate to Load Balancers: Click on `Load Balancers` in the navigation pane.
  *  **Create Load Balancer:** Select "Create Load Balancer" to start configuring a new load balancer.
    
  <img width="1057" alt="Screenshot 2024-02-23 at 1 17 12 AM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/9c4b01c4-29a2-4235-99f9-27ad5acbc71e">

  * Under Application Load Balancer, choose Create.
<img width="711" alt="Screenshot 2024-02-23 at 1 18 53 AM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/59426e87-0d3d-4463-bbd7-5bf2de0787b2">


  * Enter a name for your load balancer (e.g., DEV-ALB) and proceed with default settings.

<img width="791" alt="Screenshot 2024-02-23 at 1 19 49 AM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/0414b0ae-66be-41c5-969c-ae64c3af3585">

 * Select the appropriate VPC and subnets for your load balancer.
 * Mappings enable zones for your load balancer by selecting subnets from two or more Availability Zones.
 
<img width="862" alt="Screenshot 2024-02-23 at 1 20 29 AM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/9b95327a-31da-4521-a552-f6da9aec7b53">

  * Choose or create a security group allowing traffic on ports `80 (HTTP)` and `443 (HTTPS)`.

<img width="920" alt="Screenshot 2024-02-23 at 1 23 16 AM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/0ce6d33d-90ae-4000-9696-fb2847aa228b">
  
  * Configure listeners to accept HTTP traffic on port 80 or choose custom settings.
     
<img width="964" alt="Screenshot 2024-02-23 at 1 23 13 AM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/7773b9d5-6a42-4eb5-859f-b59d97d1d821">

  * **Review and Create:** Review your configurations and click "Create load balancer".

<img width="1010" alt="Screenshot 2024-02-23 at 1 24 49 AM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/3c02dc93-ff8c-4487-8443-34f00a9d88e0">

### Step 4: Test the load balancer

* Select the newly created load balancer.
* Choose Description and copy the DNS name of the internet facing or internal load balancer
* (for example, `Dev-ALB-1442510364.us-east-1.elb.amazonaws.com`).
  

<img width="752" alt="Screenshot 2024-02-23 at 1 26 21 AM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/2fdc1ec8-8850-4e6a-914f-09def2463f92">

***
  * Test your Attendance API using Load Balancer's AWS domain
   
<img width="853" alt="Screenshot 2024-02-22 at 11 53 55 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/8a6929a1-857f-44e8-aec7-e4c291e535e5">

***
## Conclusion

This guide outlines a straightforward process for configuring listener rules for AWS load balancers. By leveraging AWS Load Balancer, users can enhance the performance, availability, and scalability of their applications. Following these step-by-step instructions ensures efficient traffic management, ultimately improving the reliability and responsiveness of applications hosted on AWS infrastructure.

***

## Contact Information
| Name | Email address |
| ---- | ------------- |
| **Vidhi Yadav** | vidhi.yadhav.snaatak@mygurukulam.co |

***

## Resources and References
|  **Description** |   **Source** |
| ---------------- | ------------ |
| About Listener Rules | [Link](https://www.youtube.com/watch?v=QWiSQCRoG6A) |
| About Load Balancer | [Link](https://www.youtube.com/watch?v=msSOxyvXNr8&t=1041s) |
| Follow this Infra Diagram | [Link](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Design/09-%20Cloud%20Infra%20Design/Cloud-Infra-Design-Dev.md) | 

***

