# Deployment strategies ( Canary Deployment )

<img width="360" length="100" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/24ad8e64-67e6-4c50-80ae-4fd802f806fb">

***

| **Author** | **Created On** | **Last Updated** | **Document version** |
| ---------- | -------------- | ---------------- | -------------------- |
| **Vishal Kumar Kesharwani** | **12 March 2024** | **12 March 2024** | **v1** |

***

## Table of Contents

* [Introduction](#Introduction)
* [What is software deployment](#What-is-software-deployment)
* [Why is software deployment important](#Why-is-software-deployment-important)
* [Canary Deployments](#Canary-Deployments)
* [Flow Diagram](#Flow-Diagram)
* [Advantages of Canary Deployments](#Advantages-of-Canary-Deployments)
* [Disadvantages of Canary Deployments](#Disadvantages-of-Canary-Deployments)
* [Best Practices](#Best-Practices)
* [Conclusion](#Conclusion) 
* [Contact Information](#Contact-Information) 
* [References](#References)

 ***
## Introduction

Software deployment is the process of delivering updates and new applications to users. It's crucial for keeping software up-to-date and meeting user needs. Streamlining deployment processes helps teams respond quickly to user demands. Canary deployments are one such method that aims to make this process smoother. Understanding software deployment is essential for teams to deliver quality products efficiently.

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

## Canary Deployments

<img width="360" length="100" src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/7d9b407e-4c14-4e82-8bb9-84d1b2a96546">

The canary deployment method sends out application updates in an incremental fashion. It starts with a small badge of users and continues the rollout until you reach 100% deployment. This is the least risky deployment strategy as it allows teams to test live updates on small groups of users before pushing them out in larger badges. 

It’s also more effective because you conduct tests on the live version instead of staged environments. Rollbacks are fast, and there’s no downtime in this case.

***

## Flow Diagram

Canary deployment involves deploying a new version of an application to a separate environment while directing only a small portion of traffic to it initially. This allows for gradual testing and monitoring of the new version's performance. Various strategies, such as distributing requests evenly or selecting beta testers, can determine which traffic accesses the new version first. Continuous monitoring of metrics helps decide whether to increase traffic or rollback. Once validated, all traffic is routed to the new version, and the old environment can be terminated gracefully. This approach reduces the impact of potential failures and promotes confidence in adopting Continuous Deployment practices.

![Canary](https://www.encora.com/hs-fs/hubfs/GIF-canary-deployment.gif?width=720&name=GIF-canary-deployment.gif)

***

## Advantages of Canary Deployments

| Benefit              | Description                                                                                                   |
|----------------------|---------------------------------------------------------------------------------------------------------------|
| **Risk Reduction**      | Canary deployment allows for rolling out the new version to a small subset of users or servers, reducing the risk of widespread issues.                                    |
| **Early Feedback**      | Provides early feedback on the new version from a limited user base, facilitating identification and resolution of potential issues.                                           |
| **Improved Reliability** | Helps enhance application reliability by detecting and addressing issues early in the deployment process.                                                                |
| **Controlled Rollout**  | Enables a controlled release of the new version, ensuring a smooth rollout and minimizing the impact of any unexpected issues on the wider audience.                       |


***

## Disadvantages of Canary Deployments

| Disadvantage                   | Description                                                                                                                                                                    |
|--------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Increased complexity**          | Canary deployment can be complex to set up and manage, especially for large applications with many components. It requires careful planning and coordination for a seamless rollout. |
| **Increased resource usage**      | Running two versions of the application can require more resources, leading to increased costs.                                                                                |
| **Longer deployment times**       | Canary deployment can take longer to deploy because the new version of the application needs testing and monitoring before being rolled out to the wider audience.             |
| **Risk of overloading the canary** | If the canary subset is too small or not representative of the wider audience, it can be overloaded with traffic or usage, affecting the overall performance of the application.|

***

## Best Practices

| Best Practice              | Description                                                                                                                                                                                                                                   |
|----------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Start Small**                | Begin with a small subset of servers or instances to minimize the impact of any potential issues. This allows for easier troubleshooting and rollback if necessary.                                                                         |
| **Monitor Health**             | Continuously monitor the health and performance of deployed instances during the rollout process. Automated monitoring tools can help detect any anomalies or failures early on.                                                            |
| **Automate Testing**           | Implement automated testing procedures to ensure that each instance meets performance and functionality requirements before it is fully deployed.                                                                                             |
| **Incremental Updates**        | Deploy updates incrementally, gradually replacing older versions with newer ones. This helps minimize risks and ensures a smoother transition.                                                                                               |
| **Rollback Plan**              | Have a well-defined rollback plan in place in case of any issues or failures during the deployment process. This should include procedures for reverting to the previous version quickly and efficiently.                                       |
| **Version Control**            | Maintain strict version control to track changes and updates accurately. This enables easier identification of issues and facilitates rollback if necessary.                                                                                  |
| **Communication**              | Maintain clear communication channels among team members and stakeholders throughout the deployment process. This ensures everyone is aware of progress, potential issues, and any necessary actions.                                        |
| **Post-Deployment Verification** | Perform thorough post-deployment verification to ensure that all instances are functioning correctly and meeting performance expectations.                                                                                                   |
| **Documentation**              | Document all steps, configurations, and changes made during the deployment process. This documentation serves as a valuable reference for future deployments and troubleshooting.                                                              |
| **Continuous Improvement**     | Continuously review and improve the deployment process based on feedback, lessons learned, and evolving best practices. This iterative approach helps optimize efficiency and reliability over time.                                        |
***

## Conclusion

Canary deployments offer a controlled and incremental approach to updating applications, reducing risks by testing updates on a small subset of users or servers before full deployment. Despite potential complexities and resource usage, the method provides early feedback, improves reliability, and enables a smoother rollout. By following best practices such as starting small, automating testing, and maintaining clear communication, teams can effectively manage Canary deployments, ensuring successful updates with minimal disruption.

***

 ## Contact Information

 | **Name** | **Email Address** |
 | -------- | ----------------- |
 | **Vishal Kumar Kesharwani** | vishal.kumar.kesharwani.snaatak@mygurukulam.co |

 ***
 
 ## References

 | **Source** | **Description** |
 | ---------- | --------------- |
 | [**Link**](https://www.encora.com/insights/zero-downtime-deployment-techniques-canary-deployments) | About Canary deployments |
 | [**Link**](https://blog.devops.dev/microsevices-deployment-patterns-rolling-vs-Canary-vs-canary-e35440e794ed) | Advantages and Disadvantages of Canary deployments |
 | [**Link**](https://www.sumologic.com/glossary/software-deployment/) | Software deployment |
 | [**Link**](https://github.com/CodeOps-Hub/Documentation/blob/main/Deployment_strategies/Rolling/README.md) | Rolling Deployment_strategies |
 | [**Link**](https://github.com/CodeOps-Hub/Documentation/blob/main/Deployment_strategies/Blue_Green/README.md) | Blue-Green Deployment_strategies |
 
