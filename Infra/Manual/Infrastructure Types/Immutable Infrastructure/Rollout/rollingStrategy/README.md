# Rollout Immutable Infrastructure using Rolling Startegy
![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/1143df7b-945c-421e-9884-72f471636797)

|   Author        |  Created on   |  Version   | Last updated by  | Last edited on |
| --------------- | --------------| -----------|----------------- | -------------- |
| **[Harshit Singh](https://github.com/Panu-S-Harshit-Ninja-07)**    | 16 March 2024 |  Version 1 | Harshit Singh     | 17 March 2024  |
***

## Table of Contents 

+ [Introduction](#Introduction)
+ [Components of Alerting Rules](#Components-of-Alerting-Rules)
+ [Some Common Alert Rules for App](#Some-Common-Alert-Rules-for-App)
+ [Advantages](#Advantages)
+ [Disadvantages](#Disadvantages)
+ [Best Practices](#Best-Practices)
+ [Conclusion](#Conclusion)
+ [Contact Information](#contact-information)
+ [References](#References)
***

## Introduction
A rolling deployment strategy is a method used in software deployment where updates or changes are gradually applied to a subset of servers or instances in a systematic and controlled manner, while the remaining servers continue to handle production traffic. This approach ensures continuous availability of the application and reduces the risk associated with deploying changes.

In a rolling deployment:

1. **Gradual Updates**: Updates are applied incrementally to a small portion of the infrastructure, such as one server or a group of servers, at a time.

2. **Continuous Availability**: Throughout the deployment process, the application remains available to users as the updates are rolled out without causing downtime.

3. **Fault Isolation**: By updating only a subset of servers at any given time, the impact of any potential issues or bugs is limited to a small portion of the infrastructure.

4. **Easy Rollback**: If any problems occur during the deployment, it's relatively straightforward to roll back to the previous version since only a fraction of the infrastructure has been updated.

5. **Automated Orchestration**: Rolling deployments are often automated using deployment orchestration tools or continuous integration/continuous deployment (CI/CD) pipelines to manage the process efficiently.
***

## Steps to rollout

Rolling out immutable infrastructure using a rolling deployment strategy involves deploying updates or changes to your infrastructure in a phased manner while maintaining high availability and minimizing downtime. Here's a general outline of how you could approach it:

1. **Version Control**: Ensure that your infrastructure configurations are version controlled, preferably using a tool like Git. This allows you to track changes and roll back if necessary.

2. **Immutable Infrastructure Definition**: Define your infrastructure as code using tools like Terraform, AWS CloudFormation, or similar. This ensures that your infrastructure is consistent, repeatable, and versioned.

3. **Build and Test Immutable Images**: Create immutable images or machine images (AMIs, VM images, Docker containers, etc.) that represent your desired infrastructure state. Automate the build and testing of these images to ensure they are reliable and ready for deployment.

4. **Blue-Green Deployment Environment**: Set up a blue-green deployment environment where you have two identical production environments: one currently serving traffic (blue), and the other ready to receive updates (green).

5. **Gradual Rollout**: Start by deploying the new immutable images to the green environment. This could be done gradually, for example, by rolling out updates to a small subset of servers or instances first to ensure everything is working as expected.

6. **Health Checks and Monitoring**: Implement health checks and monitoring to ensure that the new green environment is functioning correctly. This could include automated tests, system health checks, and performance monitoring.

7. **Traffic Shifting**: Once you're confident that the green environment is stable and performing well, gradually shift traffic from the blue environment to the green environment. This could be done using load balancer settings or DNS changes.

8. **Rollback Plan**: Have a rollback plan in place in case any issues arise during the deployment. This could involve automatically shifting traffic back to the blue environment or rolling back to a previous version of the immutable images.

9. **Post-Deployment Verification**: After the deployment is complete, perform thorough post-deployment verification to ensure that everything is working as expected in the green environment.

10. **Cleanup**: Once the deployment is successful and you're confident in the new green environment, clean up any resources associated with the blue environment to avoid unnecessary costs and complexity.
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

| Disadvantages               | Description                                                                                                    |
|-----------------------------|----------------------------------------------------------------------------------------------------------------|
| Alert Fatigue               | Too many alerts or false positives can lead to alert fatigue, causing users to ignore or overlook important notifications.|
| Configuration Complexity    | Setting up and maintaining alert rules can be complex, requiring expertise in defining thresholds and conditions.  |
| Over-reliance on Automation | Over-reliance on automated alerting may lead to complacency, reducing the effectiveness of human monitoring and intervention.|
| Lack of Context             | Alerts triggered solely based on predefined rules may lack context, requiring additional investigation to understand the underlying cause.|
| Potential for False Positives | Alert rules may generate false positives, triggering unnecessary alerts and wasting resources on investigating non-issues.|
***

## Best Practices

| Best Practice                     | Description                                                                                       |
|----------------------------------|---------------------------------------------------------------------------------------------------|
| Start with Clear Objectives      | Clearly define the purpose of your alerting system and what you aim to achieve with it.          |
| Understand Your System           | Have a deep understanding of your application's architecture, dependencies, and normal behavior.  |
| Identify Key Metrics             | Determine the most critical metrics for monitoring your application's health and performance.     |
| Set Realistic Thresholds         | Establish thresholds for each metric that indicate abnormal behavior or potential issues.         |
| Prioritize Alerts                | Focus on critical alerts for issues that require immediate attention, based on impact and urgency.|
| Avoid Alert Fatigue              | Strike a balance by setting up alerts only for significant issues and avoiding unnecessary notifications.|
| Use Hysteresis                   | Incorporate hysteresis or "bounce" thresholds to prevent alert flapping caused by minor fluctuations.|
| Implement Escalation Policies    | Define escalation policies to ensure that alerts are handled promptly and effectively.            |
| Regularly Review and Refine      | Monitor the effectiveness of your alert rules regularly and refine them based on feedback and evolving requirements.|
| Document and Communicate         | Document alert rules comprehensively and communicate them effectively to all stakeholders.       |
***

## Conclusion

In conclusion, alerting rules are like watchdogs for your app, helping catch problems early and responding quickly. They're great for keeping your app reliable and using resources wisely, but too many alerts or false alarms can be annoying. By following some smart steps, like setting clear goals and checking alerts regularly, you can make sure they work well. It's important to talk about alerts with your team and write down how they should be handled so everyone knows what to do. This way, you can keep your app running smoothly and fix any issues fast.
***
## Contact Information

|     Name         | Email  |
| -----------------| ------------------------------------ |
| Harshit Singh    | harshit.singh.snaatak@mygurukulam.co |
***

## References

| Description                                   | References  
| --------------------------------------------  | -------------------------------------------------|
| Alerting Overview | https://prometheus.io/docs/alerting/latest/overview/ |
| Alert Rules | https://samber.github.io/awesome-prometheus-alerts/rules.html |
|| https://grafana.com/docs/grafana/latest/alerting/fundamentals/alert-rules/ |
