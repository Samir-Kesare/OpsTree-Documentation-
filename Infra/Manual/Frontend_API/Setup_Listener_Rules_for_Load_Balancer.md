# Setup Listener Rules for Load Balancer for (Frontend API)

<img width="300" length="100" alt="LB" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/6fd74997-5bda-4edc-bdc2-885df3b5e75f"> 

|   Author        |  Created on   |  Version   | Last updated by  | Last edited on |
| --------------- | --------------| -----------|----------------- | -------------- |
| Vishal Kumar Kesarwani |  20-02-2024  |  Version 1 | Vishal  | 20-02-2024    |

***
## Table of Contents
+ [Introduction](#Introduction)
+ [Why use AWS Load Balancer](#Why-use-AWS-Load-Balancer)
+ [Listener Rules](#Listener-Rules)
+ [Importance of Listener Rules](#Importance-of-Listener-Rules)
+ [Pre-requisites](#Pre-requisites)
+ [Steps to setup Listener Rules for Load Balancer](#Steps-to-setup-Listener-Rules-for-Load-Balancer)
+ [Conclusion](#Conclusion)
+ [Contact Information](#Contact-Information)
+ [Resources and References](#Resources-and-References)
  
***
## Introduction

<img width="260" length="100" alt="LB" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/3a7244d7-a6dc-471b-bd80-bf6d500b02d0"> 

Load balancing in AWS refers to the process of distributing incoming network traffic across multiple servers or resources to ensure high availability and reliability of applications or services. The primary purpose of load balancing is to optimize resource utilization, maximize throughput, minimize response time, and avoid overloading any single resource.

***
## Why use AWS Load Balancer

| Benefit             | Description                                                                                                                                                                   |
|---------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **High Availability**   | Load balancers ensure application availability by distributing traffic across multiple servers. This minimizes downtime by routing requests to healthy instances.         |
| **Scalability**         | Load balancers enable horizontal scaling by dynamically adding or removing servers based on traffic demands. They distribute incoming requests across available resources. |
| **Fault Tolerance**     | Load balancers detect unhealthy instances and route traffic only to healthy ones, improving fault tolerance and reliability.                                                  |
| **Improved Performance** | Load balancers optimize request distribution based on factors like server health, geographic location, and network latency, improving overall application performance.   |
| **SSL Termination**     | Load balancers offload SSL/TLS decryption and encryption tasks, reducing computational overhead on backend servers and enhancing system performance.                         |

***
## Listener Rules

Listener rules in AWS load balancers determine how incoming traffic is routed to target groups based on request characteristics. Each rule, associated with a listener, prioritizes conditions like HTTP method, path, and source IP address, with lower priority numbers taking precedence. Actions include forwarding to target groups, redirecting, or returning fixed responses. Default rules handle unmatched requests by routing to a default target group or returning an error response.

***
## Importance of Listener Rules

Applications have various use cases in which we have to set up traffic routing based on various factors. Some applications have their setup as distributed microservices where the requests need to serve on the basis of the path to the different services. Sometimes, we may need to use a single load balancer for multiple applications and route the traffic based on the application URLs. These rules provide us a way to design our load balancing strategies according to our use cases and apply them without any complexities.

***
## Pre-requisites

 * Active Aws Acount .

***
## Steps to setup Listener Rules for Load Balancer


  <img width="760" length="100" alt="Security" src=""> 


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
| About Listener Rules | [Link](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/listener-update-rules.html) |
| Types of Load Balancer | [Link](https://kavishbaghel.com/utilising-listener-rules-for-load-balancing-using-aws-application-load-balancer-8e090e0ba469) |
| Follow this Infra Diagram | [Link](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Design/09-%20Cloud%20Infra%20Design/Cloud-Infra-Design-Dev.md) | 


***
