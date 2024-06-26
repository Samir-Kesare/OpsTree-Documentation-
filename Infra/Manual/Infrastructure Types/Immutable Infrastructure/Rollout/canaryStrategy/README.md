# Rollout Immutable Infrastructure using Canary Strategy
![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/3e0c84bd-1113-491e-ad0a-92f30a599e95)

|   Author        |  Created on   |  Version   | Last updated by  | Last edited on |
| --------------- | --------------| -----------|----------------- | -------------- |
| **[Harshit Singh](https://github.com/Panu-S-Harshit-Ninja-07)**    | 18 March 2024 |  Version 1 | Harshit Singh     | 18 March 2024  |
***

## Table of Contents 

+ [Introduction](#Introduction)
+ [Steps to rollout](#Steps-to-rollout-Canary-Strategy)
+ [Advantages](#Advantages)
+ [Disadvantages](#Disadvantages)
+ [Conclusion](#Conclusion)
+ [Contact Information](#contact-information)
+ [References](#References)
***

## Introduction
[**Immutable infrastructure**](https://github.com/CodeOps-Hub/Documentation/blob/main/Infra/Manual/Infrastructure%20Types/Immutable%20Infrastructure/README.md) is a modern approach to managing IT environments that emphasizes the use of immutable components, where server instances, containers, or virtual machines are treated as disposable, immutable artifacts that are never modified after they are created.

In immutable infrastructure, updates and changes are applied by replacing entire server instances or components with new ones that incorporate the desired changes, rather than modifying existing instances in place.

The Canary deployment strategy is a method of releasing software updates gradually to a small subset of users or servers before rolling them out to the entire user base. This approach allows for early detection of issues and smoother transitions to new versions by monitoring performance metrics and gradually expanding the update's reach. It helps mitigate risks associated with deployments and enables faster feedback and iteration on software releases.

![Canary](https://www.encora.com/hs-fs/hubfs/GIF-canary-deployment.gif?width=720&name=GIF-canary-deployment.gif)

To know more about Canary Deployment Strategy, [**click here**](https://github.com/CodeOps-Hub/Documentation/blob/main/Deployment_strategies/Canary/README.md)
***
## Steps to rollout (Canary Strategy)
![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/ffc2d72a-3a60-496c-8506-cbf6aec79ae8)

Rolling out the Canary deployment strategy in an immutable infrastructure involves implementing the same gradual update process, but within the context of immutable infrastructure principles. Here's how it can be done:

1. **Immutable Infrastructure Setup**:
   - Provision immutable infrastructure components such as virtual machines, containers, or serverless resources using automation tools like Terraform, AWS CloudFormation, or Kubernetes.

2. **Deploy Initial Version (Baseline)**:
   - Deploy the initial version of your application to the immutable infrastructure. This serves as the baseline version against which subsequent updates will be compared.

3. **Create Canary Instances**:
   - Create a subset of immutable instances, representing the canary group, where the new version of the application will be deployed. These instances should be identical to the baseline but configured to receive the new version.

4. **Gradual Update Rollout**:
   - Deploy the updated version of the application to the canary instances, while keeping the baseline instances unchanged. This allows for a controlled rollout of the update to a small subset of infrastructure.

5. **Monitor and Validate**:
   - Monitor the performance, metrics, and user feedback from the canary instances to assess the impact of the update. Use tools like Prometheus, Grafana, or AWS CloudWatch to track key metrics and identify any anomalies.

6. **Incremental Expansion**:
   - If the canary deployment performs well without significant issues, gradually expand the rollout to additional instances or clusters, following the same monitoring and validation process.

7. **Full Rollout or Rollback**:
   - Once the updated version has been validated and proven stable across the canary instances, proceed with rolling it out to the remaining infrastructure. Alternatively, if issues are detected, rollback the update to the baseline version to maintain system stability.

8. **Post-Deployment Tasks**:
   - Perform any necessary post-deployment tasks, such as updating documentation, notifying stakeholders, and conducting post-mortem analysis to learn from the deployment process.

By applying the Canary deployment strategy within an immutable infrastructure setup, organizations can ensure a controlled and iterative approach to deploying updates while maintaining the reliability and consistency of their infrastructure.
***

## Advantages

| Advantages                               | Description                                                                                                       |
|------------------------------------------|-------------------------------------------------------------------------------------------------------------------|
| Early Issue Detection                    | Canary deployments allow for early detection of issues by exposing a small subset of users to new updates first.     |
| Reduced Risk of Widespread Impact        | By initially deploying updates to a limited audience, the risk of widespread negative impact is significantly reduced. |
| Faster Feedback Loop                     | Canary deployments enable faster feedback loops, allowing teams to gather user feedback and iterate on updates quickly. |
| Smoother Rollouts                        | Gradual rollout to a subset of users ensures smoother transitions to new versions, minimizing disruption for the entire user base. |
| Improved User Experience                 | Users in the canary group may experience improved performance or new features earlier, enhancing their overall experience. |
| Incremental Deployment                   | Updates are incrementally deployed, enabling teams to validate changes in real-world scenarios before full rollout. |
***

## Disadvantages

| Disadvantages                            | Description                                                                                                       |
|------------------------------------------|-------------------------------------------------------------------------------------------------------------------|
| Complexity of Implementation             | Implementing a Canary deployment strategy can be complex, requiring careful planning and coordination across teams. |
| Increased Overhead for Monitoring        | Monitoring the performance and behavior of canary deployments requires additional overhead and resource allocation. |
| Potential for Canary Bias                | There's a risk of biased results if the canary group differs significantly from the broader user base or environment. |
| Requires Granular Control                | Canary deployments require granular control over deployment processes and infrastructure, which may not be feasible for all setups. |
| Dependency on Automated Testing          | Successful implementation of Canary deployments relies heavily on automated testing and monitoring tools for validation. |
***

## Conclusion
In conclusion, the Canary deployment strategy offers several advantages, including early issue detection, reduced risk of widespread impact, faster feedback loops, smoother rollouts, improved user experience, and incremental deployment capabilities. However, it also comes with its own set of challenges, such as complexity of implementation, increased monitoring overhead, potential for bias, requirement for granular control, and dependency on automated testing. By carefully considering these factors and implementing best practices, organizations can leverage Canary deployments effectively to enhance their release management processes and deliver software updates with greater confidence and reliability.
***

## Contact Information

|     Name         | Email  |
| -----------------| ------------------------------------ |
| Harshit Singh    | harshit.singh.snaatak@mygurukulam.co |
***

## References

| Description                                   | References  
| --------------------------------------------  | -------------------------------------------------|
| Deployment Strategies Reference doc | https://github.com/CodeOps-Hub/Documentation/blob/main/Deployment_strategies/Canary/README.md |
| Immutable Infrastructure Reference doc | https://github.com/CodeOps-Hub/Documentation/blob/main/Infra/Manual/Infrastructure%20Types/Immutable%20Infrastructure/README.md |
| Canary Deployment | https://wa.aws.amazon.com/wellarchitected/2020-07-02T19-33-23/wat.concept.canary-deployment.en.html |
|| https://martinfowler.com/bliki/CanaryRelease.html?ref=wellarchitected |
