# Documentation of Scripted Pipeline for Slack Notification

![image](https://github.com/avengers-p7/Documentation/assets/156057205/e58d8c58-91d1-4fc2-b13f-af712095cf27)

***

| **Author** | **Created On** | **Last Updated** | **Document Version** |
| ---------- | -------------- | ---------------- | -------------------- |
| **Shreya Jaiswal** | **08-02-2024** | **08-02-2024** | **v1** |

***

# Table Of Contents

1. [Introduction](#introduction)
2. [What is Scripted Pipeline?](#what-is-scripted-pipeline)
3. [What is Jenkins Freestyle Job?](#what-is-jenkins-freestyle-job)
4. [Pre-requisites](#pre-requisites)
5. [Flow Diagram](#flow-diagram)
6. [Slack Notification Setup](#slack-notification-setup)
7. [Pipeline](#Pipeline)
8. [Conclusion](#conclusion)
9. [Contact Information](#contact-information)
10. [Reference](#reference)

***

# Introduction

In today's agile development environments, effective communication is key. With Jenkins scripted pipelines, teams can easily set up Slack notifications to keep everyone informed about build statuses. By writing simple scripts, teams can integrate Jenkins with Slack, ensuring everyone stays in the loop without complex configurations.

***

# What is Scripted Pipeline?

A Scripted Pipeline in Jenkins is a Groovy-based approach to defining continuous integration and continuous delivery (CI/CD) pipelines. It allows users to write pipeline scripts using Groovy syntax, providing full flexibility and customization for defining build, test, and deployment stages. Scripted Pipelines enable users to incorporate conditional logic, loops, and functions within the pipeline script to handle complex workflows and custom requirements. While offering extensive power and flexibility, Scripted Pipelines require users to have knowledge of Groovy programming and scripting concepts. They are well-suited for projects with intricate build processes or those requiring advanced automation and customization capabilities.

***

# What is Jenkins Freestyle Job?

In Jenkins, a Freestyle job is a type of project configuration that allows users to create flexible and customizable build processes without adhering to a strict structure or predefined steps. Freestyle jobs provide a straightforward interface where users can define build steps, configure source code management, specify triggers, and set up post-build actions using a graphical user interface (GUI). 

***

> [!Note]
> For more detail on Jenkins please go with this [Link](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/jenkinsPipeline.md)

***

# Pre-requisites

**1.Jenkins Installed**

**2.Slack Notification Plugin**

**3.Job DSL Plugin**

***

# Flow Diagram

<img width="641" alt="image" src="https://github.com/avengers-p7/Documentation/assets/156057205/6c61885a-53be-40f0-8e1e-bc6c693332c5">

***

> [!Note]
> For more detail on Jenkins Setup, please go with this [Link](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/pipelinePOC.md)

***

# Slack Notification Setup

Setting up Slack notifications in Jenkins involves integrating Jenkins with Slack using a Jenkins plugin and configuring the necessary settings in both Jenkins and Slack.

**Step-1 Workspace Creation**

Different projects or teams may have different Jenkins jobs with unique notification requirements. Using separate workspaces in Slack allows for the isolation and organization of notifications related to specific projects or teams.

Go to the Slack website.Click on "Get started for free" or "Create a new workspace."Follow the prompts to set up your Slack workspace, providing details such as your email address and password.

<img width="865" alt="image" src="https://github.com/avengers-p7/Documentation/assets/156057205/5abb2e1b-f5d1-47a0-ba8b-26a6c7bf7287">

***

**Step-2 Channel Creation**

Creating a dedicated channel for Jenkins notifications helps isolate and organize build-related messages.

Log in to your Slack workspace.In the left sidebar, click on the "+" button next to "Channels."Choose "Create a channel."

<img width="846" alt="Screenshot 2024-01-23 181612" src="https://github.com/avengers-p7/Documentation/assets/156057205/ce1ccb76-4a59-4a4c-89d9-4a0d418238d7">


***

**Step-3 Jenkins CI Setup**

This step includes the steps for "Password" or "Secret Text" creation,which is an important part for Slack Notification.With this,will get the "Team Subdomain" & "Password" which is needed for jenkins slack notification configuration.

<img width="945" alt="Screenshot 2024-01-23 181736" src="https://github.com/avengers-p7/Documentation/assets/156057205/ac515c7a-4501-48b6-b84d-2724d1084572">

***

<img width="940" alt="Screenshot 2024-01-23 181811" src="https://github.com/avengers-p7/Documentation/assets/156057205/a531d89d-8ee9-4c2c-b230-b3f66726201e">

***

**Step-4 Jenkins Configuration** 

Setting up Jenkins Global Configuration for Slack notifications allows you to centralize and manage Slack-related settings at a global level. This global configuration provides a convenient way to store and share common information, such as Slack team domain and integration tokens, across multiple Jenkins jobs.

Go to "Manage Jenkins" > "Configure System."Scroll down to the "Slack" section.In the "Team Domain" field, enter the Slack team domain.In the "Integration Token Credential" section, click on "Add" to add your Slack integration token as a Jenkins credential.Enter the necessary information, such as the token itself and an ID to identify the credential.In the "Test Connection" section, enter a Slack channel name and click on "Test Connection" to verify that Jenkins can communicate with Slack.

<img width="862" alt="Screenshot 2024-01-23 181534" src="https://github.com/avengers-p7/Documentation/assets/156057205/ff96bc8e-440e-4b72-946a-9f3757499eea">

***

**Slack Notification Plugin**

<img width="644" alt="image" src="https://github.com/avengers-p7/Documentation/assets/156057205/3b91bb9d-bb3c-4f5e-b600-08b11bf3f009">

***

**Job DSL Plugin**

<img width="596" alt="image" src="https://github.com/avengers-p7/Documentation/assets/156057205/f7374100-57c9-4334-9ca7-a7e5024fbdca">

***

**Jenkinsfile Path in Configuration**

<img width="650" alt="image" src="https://github.com/avengers-p7/Documentation/assets/156057205/530a0fab-6b26-4d94-a706-dcf6edb41f60">

***

**Console Output**

![image](https://github.com/avengers-p7/Documentation/assets/156057205/51079ecb-db54-4e52-89e0-365a700d7935)

![image](https://github.com/avengers-p7/Documentation/assets/156057205/78ef92ed-90ef-456d-947a-a5042eb211c3)

***

**Freestyle Job Created of name "Freestyle-Job"**

<img width="677" alt="image" src="https://github.com/avengers-p7/Documentation/assets/156057205/8fe62de8-ac54-4fad-80d2-2ad8222f62a6">

***

**Slack Notification Result**

![image](https://github.com/avengers-p7/Documentation/assets/156057205/ca5183a7-19a2-46bf-b707-ce050eeeed2f)

***

# Pipeline

```shell
node {
    stage('Build') {
        // Define the DSL for creating a Freestyle job
        def jobDSL = '''
            job('Freestyle-Job') {
                description('This is a sample Freestyle job created using a Scripted Pipeline')
                steps {
                    shell('echo "Hello, world!"')
                }
            }
        '''
        // Execute the job DSL to create the Freestyle job
        jobDsl scriptText: jobDSL
    }

    try {
        // Execute this block if the build succeeds
        stage('Notify Success') {
            // Send Slack notification for success
            slackSend(channel: '#jenkinss', message: 'Job Build successfully')
        }
    } catch (Exception e) {
        // Execute this block if the build fails
        stage('Notify Failure') {
            // Send Slack notification for failure
            slackSend(channel: '#jenkinss', message: 'Job Failed')
        }
    }
}
```

***

# Conclusion

In conclusion, Jenkins scripted pipelines provide a straightforward way to enable Slack notifications for build updates. With minimal effort, teams can ensure timely communication, fostering collaboration and facilitating swift responses to build outcomes. This streamlined approach enhances team coordination and accelerates decision-making, ultimately leading to smoother development workflows.

***

# Contact Information

| **Name** | **Email Address** |
| -------- | ----------------- |
| **Shreya Jaiswal** | shreya.jaiswal.snaatak@mygurukulam.co |

***

# Reference

| **Source** | **Description** |
| ---------- | --------------- |
| https://eavnitech.com/blog/send-notification-to-slack-from-the-Jenkins-CI-job-and-jenkinsfile/ |  Integration Jenkins with slack |
| https://naiveskill.com/jenkins-pipeline-slack-notification/ | Link for Jenkins CI |

