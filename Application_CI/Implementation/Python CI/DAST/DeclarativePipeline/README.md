# Declarative Pipeline for Python DAST
| Author | Created On | Last Updated | Document Version | Last Updated By |
| ------ | ---------- | ------------ | ---------------- | --------------- |
| Shantanu | 10-02-2024 | 19-02-2024   |         v1     |     Shantanu    |
***

# Table of Content
+ [Introduction](#Introduction)
+ [Why Declarative Pipeline?](#Why-Declarative-Pipeline)
+ [Flow Diagram](#Flow-Diagram)
+ [Pre-requisites](#Pre-requisites)
+ [Setup](#Setup)
+ [Jenkinsfile](#Jenkinsfile)
+ [Conclusion](#Conclusion)
+ [Contact Information](#Contact-Information)
+ [Resources and References](#Resources-and-References)
***

# Introduction
The Declarative Pipeline provides a simplified method for delineating Jenkins pipelines by utilizing a structured syntax enclosed within a pipeline {} block. It emphasizes simplicity, readability, and incorporates built-in directives for the definition of stages, steps, and additional elements. This approach seamlessly integrates with the Jenkins UI, facilitates pipeline visualization, and accommodates pipeline templates to promote code reusability. It is particularly suitable for teams seeking an uncomplicated approach to configuring CI/CD pipelines. Cilck [**here**](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/jenkinsPipeline.md) for detailed understanding on Jenkins pipeline.

***

# Why Declarative Pipeline?

| Feature                      | Description                                                                                       |
| ---------------------------- | ------------------------------------------------------------------------------------------------- |
| **Streamlined Syntax**       | Utilizes a structured syntax within a `pipeline {}` block, simplifying pipeline definition.       |
| **Readability**              | Emphasizes clarity and ease of understanding, making pipelines easier to comprehend.            |
| **Built-in Directives**      | Offers pre-defined directives for defining stages, steps, and other pipeline elements.           |
| **Integration with Jenkins UI** | Seamlessly integrates with the Jenkins user interface for intuitive pipeline management.      |
| **Pipeline Visualization**   | Provides visual representation of pipeline stages and steps for easier monitoring and debugging. |
| **Support for Pipeline Templates** | Facilitates code reuse by supporting the use of pipeline templates across multiple projects.   |
| **Simplified CI/CD Configuration** | Ideal for teams seeking a straightforward approach to configuring CI/CD pipelines.               |

***

# Flow Diagram

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056364/11f2441f-3b0d-4aa8-abff-e0e45ca75e1d)
***

# Pre-requisites
| Tool   | Description                          | 
|--------|--------------------------------------|
| OWASP ZAP | A tool for bug analysis in Python | 
| Jenkins | CICD Tool                          |  
***

# Setup

### Configure Pipeline Script:

* Upon saving the pipeline configuration, you have the option to manually initiate the build by selecting the "Build Now" button.

* Following the initiation of the build, you can monitor the ongoing progress and examine the console output by clicking on the corresponding build number on the Jenkins dashboard.
* The console output will showcase the executed steps of the pipeline script, encompassing tasks such as code checkout and compilation.

    ![Screenshot 2024-02-19 at 10 51 29 PM](https://github.com/CodeOps-Hub/Documentation/assets/156056364/62b2b6f0-aab4-43a4-aecc-401eaf91ff97)

***

# 
