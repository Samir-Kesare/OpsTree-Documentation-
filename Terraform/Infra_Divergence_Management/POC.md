
# Terraform Infra Divergence Management POC

<p align="center">
  <img src="https://github.com/CodeOps-Hub/Documentation/assets/156056413/072662dd-f2ef-4010-b2e8-385fe9b393b7" height="200" width="380">
</p>

***

| **Author** | **Created On** | **Last Updated** | **Document version** |
| ---------- | -------------- | ---------------- | -------------------- |
| **Vishal Kumar Kesharwani** | **02 April 2024** | **03 April 2024** | **v1** |

***

## Table of Contents

* [Introduction](#Introduction)
* [What is Drift?](#What-is-Drift)
* [Flow Diagram](#Flow-Diagram)
* [Run Time Dependency](#Run-Time-Dependency)
* [Proof of Concept](#Proof-of-Concept)
* [Conclusion](#Conclusion) 
* [Contact Information](#Contact-Information) 
* [References](#References)

 ***

 ## Introduction

A Proof of Concept (POC) for drift detection is like a test drive for a drift detection tool. It's a small experiment where we create a simplified version of our cloud setup and intentionally make some changes to see if the tool can catch them. We use tools like Terraform plan to compare what we want our setup to be with what it actually is. This helps us decide if the drift detection tool works well enough to use it everywhere in our cloud system.

***

## What is Drift?

Drift occurs when the actual state of the infrastructure diverges from what’s defined in the Terraform configurations. This divergence can occur due to manual changes, external processes, or resource modifications. Since the possible implications of drift are potentially catastrophic, drift detection in IaC collaboration tools such as Digger is sometimes a hard compliance requirement for companies.

For More Information [**Click here**](https://github.com/CodeOps-Hub/Documentation/blob/main/Terraform/Infra_Divergence_Management/Introduction.md)
***
## Flow Diagram

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056413/feff3544-67e4-4c94-a5d2-8c4aa125d1b7)

***

## Run Time Dependency

* Configured Infra via Terraform.
* **v1.txt File** -  Once applied `terraform apply` command, then when we run the `terraform plan` again, it's output will be there in this `v1.txt` File.
   
***
## Proof of Concept

**Step-1**

Pushed all the configuration files in a repository in github.


 


## Conclusion


***

 ## Contact Information

 | **Name** | **Email Address** |
 | -------- | ----------------- |
 | **Vishal Kumar Kesharwani** | vishal.kumar.kesharwani.snaatak@mygurukulam.co |

 ***
 
## References

| **Source** | **Description** |
| ---------- | --------------- |
| [**Link**](https://github.com/CodeOps-Hub/Documentation/blob/main/Terraform/Infra_Divergence_Management/Introduction.md) | Introduction of Drift |
