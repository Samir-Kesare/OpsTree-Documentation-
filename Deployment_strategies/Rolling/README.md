# Deployment strategies ( Rolling Deployments )

<img width="360" length="100" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/4520c3c2-6636-438b-928c-ea461f21c422">

***

| **Author** | **Created On** | **Last Updated** | **Document version** |
| ---------- | -------------- | ---------------- | -------------------- |
| **Vishal Kumar Kesharwani** | **12 March 2024** | **12 March 2024** | **v1** |

***

## Table of Contents

* [Introduction](#Introduction)
* [What is software deployment](#What-is-software-deployment)
* [Why is software deployment important](#Why-is-software-deployment-important)
* [Rolling Deployments](#Rolling-Deployments)
* [Flow Diagram](#Flow-Diagram)
* [Advantages of Rolling Deployments](#Advantages-of-Rolling-Deployments)
* [Disadvantages of Rolling Deployments](#Disadvantages-of-Rolling-Deployments)
* [Conclusion](#Conclusion) 
* [Contact Information](#Contact-Information) 
* [References](#References)

 ***
## Introduction

Software deployment is the process of delivering updates and new applications to users. It's crucial for keeping software up-to-date and meeting user needs. Streamlining deployment processes helps teams respond quickly to user demands. Rolling deployments are one such method that aims to make this process smoother. Understanding software deployment is essential for teams to deliver quality products efficiently.

***

## What is software deployment?

<img width="360" length="100" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/be6a4359-7e60-4ace-8e66-d3512e41fd45">

Software deployment includes all of the steps, processes, and activities that are required to make a software system or update available to its intended users. Today, most IT organizations and software developers deploy software updates, patches and new applications with a combination of manual and automated processes. Some of the most common activities of software deployment include software release, installation, testing, deployment, and performance monitoring.

***

## Why is software deployment important?

| Aspect                        | Description                                                                                                                                                                 |
|-------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Importance of Deployment**     | Deployment is crucial for delivering applications, modules, updates, and patches from developers to users.                                                                 |
| **Impact of Development Methods** | Development methods directly affect a product's responsiveness to customer preferences and the quality of changes.                                                          |
| **Benefits of Streamlined Process** | - Respond quickly to customer demand. - Deliver updates promptly. - Introduce new features frequently to drive customer satisfaction and meet user needs.             |
| **Innovation in Software Deliver**y | Over the last two decades, software development teams have heavily innovated, creating new paradigms and methodologies for software delivery.                        |
| **Creation of Efficient Workflows** | Developers have devised workflows that enable faster and more frequent deployment of software updates to the production environment.                                           |

***

## Rolling Deployments

<img width="360" length="100" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/d10b9f88-01a9-4789-a93d-d2cf5244fa8a">

A rolling deployment is a deployment strategy that slowly replaces previous versions of an application with new versions of an application by completely replacing the infrastructure on which the application is running. For example, in a rolling deployment in Amazon ECS, containers running previous versions of the application will be replaced one-by-one with containers running new versions of the application.

A rolling deployment is generally faster than a blue/green deployment; however, unlike a blue/green deployment, in a rolling deployment there is no environment isolation between the old and new application versions. This allows rolling deployments to complete more quickly, but also increases risks and complicates the process of rollback if a deployment fails.

***

## Flow Diagram

The process involves sequentially updating or replacing instances of the application while ensuring continuous operation. Initially, traffic is stopped to one instance, allowing for the update or replacement with another instance running the desired version. After verifying the health of the newly configured instance with a simple test, it is reintegrated into the pool of instances serving traffic. This cycle repeats for each instance until all are running the updated version. This method ensures uninterrupted service as there are always functioning instances, either current or newly updated, serving traffic at any given time.

![Rolling GIF](https://www.encora.com/hs-fs/hubfs/rolling-update.gif?width=576&name=rolling-update.gif)

***
## Advantages of Rolling Deployments

| Advantages            | Description                                                                                                                                                                                    |
|-----------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Reduced Downtime**      | Rolling deployments allow for updates to be deployed incrementally, reducing overall downtime as the application remains available to users during the deployment process.                     |
| **Better Risk Management** | Updates are gradually applied to a subset of servers, enabling early detection and mitigation of issues, thus improving risk management.                                                      |
| **Improved Reliability**  | Rolling deployments reduce the risk of widespread failures by updating a subset of servers at a time, allowing for the detection and resolution of issues before affecting the entire system. |
| **Simplified Rollback**   | Rolling deployments facilitate easier rollback by deploying updates incrementally, requiring only the rollback of the subset of servers that have been updated if issues arise.           |

***

## Disadvantages of Rolling Deployments

| Complexity                                             | Description                                                                                                                                                                                                                                      |
|--------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Complexity of Setup and Management**                     | Rolling deployments can be complex to set up and manage, particularly for large applications with many servers. Careful planning and coordination are required to ensure updates are rolled out correctly and all servers are updated in a timely manner.    |
| **Longer Deployment Times**                                | Rolling deployments may take longer to complete compared to other deployment strategies, as updates are rolled out gradually. This can lead to longer deployment times, which may not be suitable for applications with strict uptime requirements. |
| **Increased Resource Usage**                               | Rolling deployments can require more resources since updates are deployed to a subset of servers before being rolled out to all servers. This can result in increased resource usage and higher costs.                                              |
| **Risk of Compatibility Issues**                          | Rolling deployments may increase the risk of compatibility issues between different versions of the application running on different servers. Thorough testing of the application before rolling out updates can help mitigate this risk.               |

***


## Conclusion

Rolling deployments provide a swift and efficient method for updating software systems with minimal downtime. While they offer advantages such as reduced downtime and simplified rollback, they also pose challenges like complexity and longer deployment times. Despite these drawbacks, rolling deployments remain a valuable strategy for maintaining service availability and meeting user needs effectively.

***

 ## Contact Information

 | **Name** | **Email Address** |
 | -------- | ----------------- |
 | **Vishal Kumar Kesharwani** | vishal.kumar.kesharwani.snaatak@mygurukulam.co |

 ***
 
 ## References

 | **Source** | **Description** |
 | ---------- | --------------- |
 | [Link](https://www.encora.com/insights/zero-downtime-deployment-techniques-rolling-update) | Rolling deployments |
 | [Link](https://blog.devops.dev/microsevices-deployment-patterns-rolling-vs-blue-green-vs-canary-e35440e794ed) | Advantages and Disadvantages of rolling deployments |
 | [Link](https://www.sumologic.com/glossary/software-deployment/) | Software deployment |

 



