# Rollout Immutable Infrastructure using Rolling Startegy
![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/de21aea5-4b4c-4416-b18c-0a68788cfcce)

|   Author        |  Created on   |  Version   | Last updated by  | Last edited on |
| --------------- | --------------| -----------|----------------- | -------------- |
| **[Harshit Singh](https://github.com/Panu-S-Harshit-Ninja-07)**    | 16 March 2024 |  Version 1 | Harshit Singh     | 17 March 2024  |
***

## Table of Contents 

+ [Introduction](#Introduction)
+ [Steps to rollout](#Steps-to-rollout)
+ [Advantages](#Advantages)
+ [Disadvantages](#Disadvantages)
+ [Conclusion](#Conclusion)
+ [Contact Information](#contact-information)
+ [References](#References)
***

## Introduction
A rolling deployment strategy is a method used in software deployment where updates or changes are gradually applied to a subset of servers or instances in a systematic and controlled manner, while the remaining servers continue to handle production traffic. This approach ensures continuous availability of the application and reduces the risk associated with deploying changes.

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/ddf2dbea-9e4e-413c-83f1-2323ce5133e0)

In a rolling deployment:

1. **Gradual Updates**: Updates are applied incrementally to a small portion of the infrastructure, such as one server or a group of servers, at a time.

2. **Continuous Availability**: Throughout the deployment process, the application remains available to users as the updates are rolled out without causing downtime.

3. **Fault Isolation**: By updating only a subset of servers at any given time, the impact of any potential issues or bugs is limited to a small portion of the infrastructure.

4. **Easy Rollback**: If any problems occur during the deployment, it's relatively straightforward to roll back to the previous version since only a fraction of the infrastructure has been updated.

5. **Automated Orchestration**: Rolling deployments are often automated using deployment orchestration tools or continuous integration/continuous deployment (CI/CD) pipelines to manage the process efficiently.

To know more about Rolling Strategy, [**click here**](https://github.com/CodeOps-Hub/Documentation/tree/main/Deployment_strategies/Rolling)
***
## Steps to rollout
![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/8f9a29c6-0ef5-4b9c-b485-5ba6efc4a015)

Rolling out immutable infrastructure using a rolling deployment strategy involves deploying updates or changes to your infrastructure in a phased manner while maintaining high availability and minimizing downtime. Here's a general outline of how you could approach it:

**Step 1: Version Control**

Ensure that your infrastructure configurations are version controlled, preferably using a tool like Git. This allows you to track changes and roll back if necessary.

**Step 2: Immutable Infrastructure Definition**

Define your infrastructure as code using tools like Terraform, AWS CloudFormation, or similar. This ensures that your infrastructure is consistent, repeatable, and versioned.

**Step 3: Build and Test Immutable Images**

Create immutable images or machine images (AMIs, VM images, Docker containers, etc.) that represent your desired infrastructure state. Automate the build and testing of these images to ensure they are reliable and ready for deployment.

**Step 4: Blue-Green Deployment Environment**

Set up a blue-green deployment environment where you have two identical production environments: one currently serving traffic (blue), and the other ready to receive updates (green).

**Step 5: Gradual Rollout**

Start by deploying the new immutable images to the green environment. This could be done gradually, for example, by rolling out updates to a small subset of servers or instances first to ensure everything is working as expected.

**Step 6: Health Checks and Monitoring**

Implement health checks and monitoring to ensure that the new green environment is functioning correctly. This could include automated tests, system health checks, and performance monitoring.

**Step 7: Traffic Shifting**

Once you're confident that the green environment is stable and performing well, gradually shift traffic from the blue environment to the green environment. This could be done using load balancer settings or DNS changes.

**Step 8: Rollback Plan**

Have a rollback plan in place in case any issues arise during the deployment. This could involve automatically shifting traffic back to the blue environment or rolling back to a previous version of the immutable images.

**Step 9: Post-Deployment Verification**

After the deployment is complete, perform thorough post-deployment verification to ensure that everything is working as expected in the green environment.

**Step 10: Cleanup**

Once the deployment is successful and you're confident in the new green environment, clean up any resources associated with the blue environment to avoid unnecessary costs and complexity.
***

## Advantages

| Advantage                  | Description                                                                                                                                                      |
|----------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Continuous Availability    | Rolling deployments ensure that your application remains available throughout the deployment process, minimizing downtime and maintaining service continuity.   |
| Risk Mitigation            | Reduces the risk of deploying faulty updates by gradually updating a subset of instances, allowing for the detection and resolution of issues before affecting the entire infrastructure. |
| Incremental Updates        | Enables the deployment of updates incrementally, facilitating the management of large-scale deployments and reducing the impact on system resources.              |
| Easier Rollbacks           | Facilitates quick rollbacks to previous versions in case of issues, as changes are applied gradually, allowing for the identification and resolution of problems without disrupting the entire system. |
| Scalability                | Provides scalability by allowing the rate of updates to be adjusted based on demand, ensuring that the infrastructure can handle changes without sacrificing performance or stability. |
| Consistency                | Helps maintain consistency across the infrastructure by updating instances in a phased manner, ensuring that all instances run the same version of the application and reducing the risk of compatibility issues. |
***

## Disadvantages
Here's the information presented in a table format:

| Disadvantage              | Description |
|---------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Increased Complexity     | Implementing rolling deployments requires careful orchestration and coordination, adding complexity to the deployment process. |
| Resource Intensive        | Rolling deployments may require additional resources such as extra server capacity or automation tools, increasing operational costs and resource consumption. |
| Extended Deployment Time | Rolling deployments may take longer to complete compared to other deployment strategies due to incremental updates applied to a subset of servers. |
| Potential Service Degradation | There is a risk of service degradation if updated code introduces unexpected bugs or performance issues, impacting a subset of users or transactions. |
| Version Drift            | Managing version consistency across a large number of servers can be challenging, leading to version drift and potential compatibility issues. |
| Dependency Management    | Handling dependencies between different components of the application stack can be complex and may require additional testing and validation. |
***

## Conclusion
Rolling out immutable infrastructure using a rolling deployment strategy offers numerous advantages, including continuous availability, risk mitigation, and scalability. However, it comes with challenges such as increased complexity, resource intensity, and potential service degradation. Despite these drawbacks, proper orchestration and adherence to best practices can ensure successful deployment and maintenance of a robust and reliable infrastructure.
***

## Contact Information

|     Name         | Email  |
| -----------------| ------------------------------------ |
| Harshit Singh    | harshit.singh.snaatak@mygurukulam.co |
***

## References

| Description                                   | References  
| --------------------------------------------  | -------------------------------------------------|
| Deployment Strategies Reference doc | https://github.com/CodeOps-Hub/Documentation/tree/main/Deployment_strategies/Rolling |
| Immutable Infrastructure Reference doc | https://github.com/CodeOps-Hub/Documentation/blob/main/Infra/Manual/Infrastructure%20Types/Immutable%20Infrastructure/README.md |
| How to Rollout | https://medium.com/@maheshwar.ramkrushna/chap-22-rollout-strategies-in-kubernetes-rolling-update-with-nginx-7b539e03495a |
