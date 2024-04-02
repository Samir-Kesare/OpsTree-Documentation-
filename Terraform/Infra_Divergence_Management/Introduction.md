# Terraform Infra Divergence Management Understanding 

<p align="center">
  <img src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/072662dd-f2ef-4010-b2e8-385fe9b393b7" height="200" width="380">
</p>

***

| **Author** | **Created On** | **Last Updated** | **Document version** |
| ---------- | -------------- | ---------------- | -------------------- |
| **Vishal Kumar Kesharwani** | **01 April 2024** | **01 April 2024** | **v1** |

***

## Table of Contents

* [Introduction](#Introduction)
* [What is Drift?](#What-is-Drift)
* [Reasons for Terraform Drift](#Reasons-for-Terraform-Drift)
* [Risk of Being A-Drift](#Risk-of-Being-A-Drift)
* [How to Detect Terraform Drifts](#How-to-Detect-Terraform-Drifts)
* [Conclusion](#Conclusion) 
* [Contact Information](#Contact-Information) 
* [References](#References)

 ***

 ## Introduction

The concept of “Drift in Infrastructure as Code (IaC)” refers to the phenomenon that occurs when the intended state of the infrastructure diverges from the actual state of the infrastructure. This divergence can be brought about by various factors, including manual alterations made to the infrastructure by a human operator, changes made to the IaC configuration itself, or applications that make the changes. As a result, drift can have significant implications for the availability, security, and performance of the infrastructure.

***

## What is Drift?

Drift occurs when the actual state of the infrastructure diverges from what’s defined in the Terraform configurations. This divergence can occur due to manual changes, external processes, or resource modifications. Since the possible implications of drift are potentially catastrophic, drift detection in IaC collaboration tools such as Digger is sometimes a hard compliance requirement for companies.

***
## Reasons for Terraform Drift
* ### Lack of Automation

  Drift can arise when there’s an absence of systematic processes. When there’s no automation in place, infrastructure changes often happen         manually, leading to potential errors and inconsistencies. Implementing a CI/CD (Continuous Integration/Continuous Deployment) system ensures   changes are made consistently, tested, and deployed automatically. This minimizes drift by streamlining the creation, testing, and deployment of code. Furthermore, without a clear strategy for updating AWS infrastructure, ad hoc changes might go undocumented, laying the groundwork for drift.

* ### Urgency of Hotfixes

  When urgent issues arise, hotfixes can be a quick solution. However, when these fixes are applied manually, especially directly through the AWS interface, they might bypass regular procedures. Such changes can introduce drift as they aren’t reflected in the Terraform state file. For example, this may occur if an on-call team member fixes a resource configuration directly from the AWS console to address a production bug reported at 2 am in the morning. 

* ### Insufficient Team Training

  A well-informed team is crucial for maintaining consistent infrastructure. If team members, unfamiliar with Terraform, opt to make updates directly through the AWS console, it creates a blind spot for Terraform. Since Terraform doesn’t recognize these console-based changes, drift can unintentionally be introduced.

* ### Third-party Automation

  Not all automation tools are created equal, and using third-party automation software can be a Terraform drift culprit. For instance,  imagine a third-party security system that uses AWS CLI or AWS SDK to modify a rule in one of your AWS security groups. 
These tools don’t have access to the Terraform configuration file and can’t really change the Terraform code, so the change is not updated in it. 
In this situation, the Terraform state file won’t reflect the current condition of your infrastructure, thus causing a drift.

***

## Risk of Being A-Drift

| Categories             | Description                                                                                                                                                                                                                                                                                                    |
|------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Security Vulnerabilities**| Drift can lead to vulnerabilities like misconfigured firewalls or open ports, potentially enabling unauthorized access to sensitive data or systems, culminating in data breaches or other security incidents.                                                                                                                                                        |
| **Compliance Issues**       | Drift can also result in compliance challenges, such as failing to meet regulatory requisites or industry standards, which might lead to fines, penalties, or reputational damage.                                                                                                                                 |
| **Performance Issues**      | Drift in cloud infrastructure can trigger performance issues, such as increased latency or decreased throughput, adversely affecting user experience, inflating costs, or even leading to service outages.                                                                                                      |
| **Increased Costs**         | Drift can also lead to unnecessary expenses, such as wasted or over-allocated resources, which in turn can result in higher-than-anticipated bills or inefficiencies.                                                                                                                                           |
| **Operational Complexity**  | Drift in cloud infrastructure can escalate the complexity of managing, troubleshooting, and maintaining the infrastructure, leading to heightened operational complexity and costs.                                                                                                                            |
| **Misaligned Resources**    | Drift can cause resources to deviate from the actual application requirements, leading to wasted resources or under-allocated resources.                                                                                                                                                                        |


***

## How to Detect Terraform Drifts

Stay one step ahead of infrastructure drifts using the terraform plan command.
Think of it as a health check-up for your setup. It assesses how your current infrastructure measures up against the blueprint laid out in your Terraform configurations.
Spot a mismatch? This command will point out the changes needed to bridge that gap.
Regular checks, a few times a day or at least once a day, are a good habit. It’s like routine maintenance; catch the small issues before they snowball into bigger ones.

***


## Conclusion

Drift in Infrastructure as Code (IaC) occurs when the actual state of infrastructure diverges from its intended state, leading to risks like security vulnerabilities, compliance issues, performance problems, increased costs, operational complexity, and resource misalignment. Detecting and addressing drift using tools like Terraform's terraform plan command is crucial for maintaining a secure and efficient infrastructure.
 
***

 ## Contact Information

 | **Name** | **Email Address** |
 | -------- | ----------------- |
 | **Vishal Kumar Kesharwani** | vishal.kumar.kesharwani.snaatak@mygurukulam.co |

 ***
 
## References

| **Source** | **Description** |
| ---------- | --------------- |
| [**Link**](https://controlmonkey.io/blog/the-definitive-guide-for-terraform-drift-detection/) | Introduction of Drift |
| [**Link**](https://github.com/CodeOps-Hub/Documentation/blob/main/Terraform/Infra_Divergence_Management/POC.md) | POC |
| [**Link**](https://blog.brainboard.co/terraform-drift-detection-how-to-monitor-and-remediate-cloud-infrastructure-drift-3e365921420#:~:text=Whenever%20the%20terraform%20plan%20command,using%20the%20terraform%20apply%20command.) | Drift Tool |

