# Ansible Unit Test POC

<img width="300" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/bd24f25f-675e-4aef-8050-73dc273cbe95">

***

| **Author** | **Created On** | **Last Updated** | **Document Version** |
| ---------- | -------------- | ---------------- | -------------------- |
| **Shreya Jaiswal** | **08 April 2024** | **08 April 2024** | **v1** |

***

# Table of Contents

1. [Introduction](#Introduction)
2. [Why Ansible Molecule](#Why-Ansible-Molecule)
3. [Pre-requisites](#Pre-requisites)
4. [Directory Structure](#Directory-Structure)
5. [Flow of Ansible Unit Test](#Flow-of-Ansible-Unit-Test)
6. [Steps of Ansible Unit Testing](#Steps-of-Ansible-Unit-Testing)
7. [Advantages of Ansible Molecule](#Advantages-of-Ansible-Molecule)
8. [Disadvantages of Ansible Molecule](#Disadvantages-of-Ansible-Molecule)
9. [Best Practices](#Best-Practices)
10. [Conclusion](#Conclusion)
11. [Contact Information](#Contact-Information)
12. [References](#References)

***

# Introduction

Ansible Molecule is a powerful tool designed to streamline the development and testing of Ansible roles. It provides a framework for automating the process of spinning up infrastructure, applying roles to that infrastructure, and running tests to ensure the roles behave as expected. Molecule helps Ansible developers to iterate quickly, catch bugs early, and maintain the reliability of their roles across different environments.

***

# Why Ansible Molecule?

| **Reason**                                      | **Description**                                                                                                    |
|-------------------------------------------------|--------------------------------------------------------------------------------------------------------------------|
| **Automation**                                      | Molecule automates the setup of test environments, reducing manual effort and ensuring consistent testing results. |
| **Isolation**                                       | Molecule provides isolated testing environments for each scenario, preventing interference between tests.          |
| **Flexibility**                                     | Molecule supports multiple backends and testing frameworks, allowing users to choose their preferred setup.         |
| **Scalability**                                     | Molecule scales seamlessly from simple unit tests to complex integration tests, accommodating diverse use cases.    |
| **Community Support**                               | Molecule is backed by an active community, ensuring ongoing support, updates, and a wealth of resources.            |

***

# Pre-requisites

| **Pre-requisite** | **Description** |
| ----------------- | --------------- |
| **Ansible** | Ansible should be installed. |
| **Molecule** | Molecule must be installed and configured. |
| **Python3 & pip** | Python3 and pip are requirements for Ansible and Molecule. |
| **Docker** | Docker is a requirement as we are using `docker` as a `driver`. |

***

#  Directory Structure

<img width="300" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/e0046246-fc38-4d56-b848-fecd0f41f519">

***

# Flow of Ansible Unit Test

<img width="900" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/32ed5f12-0953-48be-970c-9549fbb95801">

***

| **Step**                            | **Description**                                                                                                |
|-------------------------------------|----------------------------------------------------------------------------------------------------------------|
| **Define Tests and Playbook**           | Write tests using Testinfra or Goss. Define the playbook for your Ansible role.                                |
| **Generate Molecule Structure**         | Use `molecule init scenario` to generate the necessary directory structure for Molecule testing.               |
| **Configure Molecule**                  | Define configuration settings in `molecule.yml`, including platforms, provisioner, and scenarios.             |
| **Create Test Instances**               | Use `molecule create` to create test instances or containers based on the defined configuration.              |
| **Apply Ansible Role**                  | Use `molecule converge` to apply the Ansible role to the test instances, ensuring correct configuration.       |
| **Run Tests**                           | Use `molecule verify` to execute tests against the provisioned infrastructure, checking for the desired state. |
| **Destroy Test Instances**             | Use `molecule destroy` to tear down the test instances, cleaning up resources.                                 |
| **Review Test Results**                 | Review test results to identify failures or issues, debug, and refine the Ansible role accordingly.             |

***

# Steps of Ansible Unit Testing

## Step-01: Installation of some pre-requisites

```shell
# install ansible
python3 -m pip install --user ansible
# Install the latest version of molecule from source
python3 -m pip install -U git+https://github.com/ansible-community/molecule
#install testinfra
python3 -m pip install --user pytest-testinfra
#install the molecule docker driver
python3 -m pip install -U "molecule[docker]"

```

***

# Advantages of Ansible Molecule

| **Advantage**                             | **Description**                                                                                                      |
|-------------------------------------------|----------------------------------------------------------------------------------------------------------------------|
| **Automation**                                | Molecule automates the setup and teardown of test environments, reducing manual effort and ensuring consistency.     |
| **Isolation**                                 | Molecule provides isolated testing environments, preventing interference between tests and ensuring reproducibility. |
| **Flexibility**                               | Supports various backends (Docker, Vagrant, etc.) and testing frameworks, offering flexibility in testing approaches.|
| **Scalability**                               | Scales seamlessly from simple unit tests to complex integration tests, accommodating projects of varying complexities.|
| **Community Support**                         | Backed by an active community, ensuring ongoing support, updates, and a wealth of resources for troubleshooting.      |


***

# Disadvantages of Ansible Molecule

| **Disadvantage**                          | **Description**                                                                                                      |
|-------------------------------------------|----------------------------------------------------------------------------------------------------------------------|
| **Learning Curve**                            | Requires learning curve, especially for beginners unfamiliar with testing frameworks and Molecule configuration.     |
| **Resource Intensive**                        | May require significant system resources, especially when testing complex scenarios or using resource-intensive backends.|
| **Integration with Existing Systems**         | Integration with existing CI/CD pipelines and infrastructure may require additional configuration and setup.         |
| **Overhead in Simple Projects**               | Adds overhead in simple projects or small teams where manual testing suffices, potentially slowing down development.  |

***

# Best Practices

| **Best Practice**                                 | **Description**                                                                                                    |
|---------------------------------------------------|--------------------------------------------------------------------------------------------------------------------|
| **Use Small and Focused Tests**                      | Write small, focused tests that validate specific aspects of your Ansible role's functionality.                    |
| **Leverage Idempotence**                             | Ensure that your Ansible role is idempotent to simplify testing and promote consistency.                           |
| **Automate Testing in CI/CD Pipelines**              | Integrate Molecule tests into CI/CD pipelines to automate testing and identify issues early in the development cycle.|
| **Regularly Update Dependencies**                    | Keep Molecule and its dependencies up to date to benefit from bug fixes, performance improvements, and new features.|

***

# Conclusion

In conclusion, following these best practices with Ansible Molecule helps ensure that testing your Ansible roles is smooth and reliable. By keeping tests small and focused, making sure your roles can be applied multiple times without messing things up (that's what "idempotence" means), and automating tests whenever possible, you can catch and fix issues early on. 

***

# Contact Information

| **Name** | **Email Address** |
| -------- | ----------------- |
| **Shreya Jaiswal** | shreya.jaiswal.snaatak@mygurukulam.co |

***

# References 

| **Source** | **Description** |
| --------- | --------------- |
| [Link](https://medium.com/contino-engineering/testing-ansible-automation-with-molecule-pt-1-66ab3ea7a58a) | Ansible Unit Test Reference Link |
| [Link](https://github.com/ansible-community/molecule) | Ansible Unit Test Reference Link |
| [Link](https://ansible.readthedocs.io/projects/molecule/) | Concept of Ansible Unit Test |

