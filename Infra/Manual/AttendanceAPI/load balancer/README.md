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
## Importance of Listener Rules

Applications have various use cases in which we have to set up traffic routing based on various factors. Some applications have their setup as distributed microservices where the requests need to serve on the basis of the path to the different services. Sometimes, we may need to use a single load balancer for multiple applications and route the traffic based on the application URLs. These rules provide us a way to design our load balancing strategies according to our use cases and apply them without any complexities.

***
## Pre-requisites

 * Active Aws Account

***
## Steps to setup Listener Rules for Load Balancer
### Step 1: Configure a target group
  
  *  Open the Amazon EC2 console at https://console.aws.amazon.com/ec2/.
  *  In the navigation pane, choose `Target Groups`.
  *  Choose Create target group.
 
   <img width="800" length="100" alt="LB" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/af210fdd-50b2-4f76-b6ab-911ca8ca7f8a">   
   
  *  Choose Create target group.
    
  <img width="800" length="100" alt="LB" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/0274d078-fed6-419b-9d51-a974fd613279">  
  
  * `Choose a target type` select `Instances` to specify targets by instance ID or IP addresses to specify targets by only IP address.
  * `Target group name` enter a name for the target group.eg `frontend-tg` and Port `3000`.
  * `VPC` select a virtual private cloud (VPC) with the targets that you want to include in your target group.eg `Dev-VPC`
  *  All configurtion default then Choose Next. 

 <img width="409" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/feeab858-d9c3-406a-a8b4-7708a51b3f9b">

 ***

### Step 2: Register targets

  * Select one or more instances, enter one or more eg `3000` ports, and then choose Include as pending below.
  * Then Choose Create target group.
    
 <img width="724" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/01d96d2f-5085-4541-ba1c-8e9fd9892c0c">

***

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
 
 <img width="760" length="100" alt="LB" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/a9fc8a8a-d0c5-4718-9a68-a86805694888"> 

  * Security groups, select an existing security group, or create a new one. `with 80(HTTP) and 443(HTTPS)` `Frontend-lb-sg`
  * Listeners and routing, the default listener accepts HTTP traffic on port 80. You can keep the default protocol and port, or choose different ones.eg `frontend-tg`.
  * Other  all configuration default .
     
<img width="760" length="100" alt="LB" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/c3c02a66-e419-4c07-9c9f-c2aaeb9a0259"> 

  * Review your configuration and choose Create load balancer. 

<img width="760" length="100" alt="LB" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/12c8aedb-027c-4897-9a78-ce20a36c47f1"> 

### Step 4: Test the load balancer

* Select the newly created load balancer.
* Choose Description and copy the DNS name of the internet facing or internal load balancer
* (for example, `Dev-ALB-1442510364.us-east-1.elb.amazonaws.com`).
  
<img width="760" length="100" alt="LB" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/0e988d1d-543b-4152-ad13-7a84e8962cb4">     

***

  * [**DNS**](Dev-ALB-1442510364.us-east-1.elb.amazonaws.com)
   
<img width="760" length="100" alt="LB" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/9914249d-3f0f-496c-9d0c-b8f217957b37">

***
## Conclusion

This document offers a streamlined approach to implementing listener rules for load balancers within AWS. By understanding the significance of load balancing and the benefits provided by AWS Load Balancer, users can effectively optimize their application's performance, availability, and scalability. The step-by-step instructions provided in the document enable users to configure target groups, register targets, set up a load balancer and listener, and conduct thorough testing. This process ensures efficient traffic management, enhancing the overall reliability and responsiveness of applications hosted on AWS infrastructure.

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
| About Listener Rules | [Link](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/listener-update-rules.html) |
| About Load Balancer | [Link](https://www.nginx.com/resources/glossary/load-balancing/) |
| Types of Load Balancer | [Link](https://kavishbaghel.com/utilising-listener-rules-for-load-balancing-using-aws-application-load-balancer-8e090e0ba469) |
| Follow this Infra Diagram | [Link](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Design/09-%20Cloud%20Infra%20Design/Cloud-Infra-Design-Dev.md) | 


***

