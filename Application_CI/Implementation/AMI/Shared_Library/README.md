# POC Of AMI creation Using Shared Library

![image](https://github.com/avengers-p7/Documentation/assets/156057205/7ab97e86-1928-454d-8770-4b5e13487e95)

***

| **Author** | **Created On** | **Last Updated** | **Document Version** |
| ---------- | -------------- | ---------------- | -------------------- |
| **Shreya Jaiswal** | **16-02-2024** | **17-02-2024** | **v1** |

***

# Table Of Contents

1. [Introduction](#introduction)
2. [What is Shared Library?](#what-is-shared-library)
3. [Why Shared Library](#why-shared-library)
4. [Why use src folder structure in a Jenkins shared library](#Why-use-src-folder-structure-in-a-Jenkins-shared-library)
5. [Pre-requisites](#pre-requisites)
6. [Flow Diagram](#flow-diagram)
7. [AMI Setup](#slack-notification-setup)
8. [Pipeline](#Pipeline)
9. [Shared Library File](#shared-library-file)
10. [Template File](#Template-File)
11. [Conclusion](#conclusion)
12. [Contact Information](#contact-information)
13. [Reference](#reference)

***

# Introduction

This documentation presents the development and usage of a shared library for Slack notification. The shared library includes common functions for sending notifications to Slack channels. The purpose of this library is to streamline the process of integrating Slack notifications into various applications, reducing duplication of code and ensuring consistency in notification functionality across different projects.

***

# What is Shared Library?

<img width="400" alt="image" src="https://github.com/avengers-p7/Documentation/assets/156057205/e55d86c5-ce1b-4a40-be43-6d59b4177419">

A shared library in Jenkins is a reusable collection of Groovy scripts that can be used by multiple Jenkins jobs.Shared libraries provide a way to efficiently share code and resources among multiple programs, promoting code reuse, efficient memory usage, and easier maintenance and updates.Each shared library requires users to define a name and a method of retrieving source code. These methods include local files, Git repositories, and Jenkins SCM plugins. Optionally, users can also set a default library version.

***

# Why Shared Library

| **Reason** | **Description** |
| ---------- | --------------- |
| **Reusability** | Shared libraries allow developers to write code once and reuse it in multiple programs, reducing duplication of effort and making maintenance easier. |
| **Dynamic Linking** |  When a program uses a shared library, the code from the library is not directly included in the program's executable file. Instead, references to the library are included, and the actual library code is loaded into memory at runtime when the program is executed. |
| **Efficient Memory Usage** | Since shared libraries are loaded into memory only once, even if multiple programs are using them simultaneously, they can help conserve system resources and reduce memory usage. |
| **Updates and Maintenance** |  If a shared library is updated or patched to fix bugs or add features, all programs that use that library can benefit from the changes without needing to be recompiled. |

***

# Why use `src` folder structure in a Jenkins shared library

| Benefit                    | Description                                                                                                                                                                    |
|----------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Organizational Structure**  | Placing source files in a `src` folder provides a clear and organized structure for the library, aiding developers in quickly locating files and understanding the layout.      |
| **Isolation of Source Code**  | Keeping source code separate from other files (e.g., documentation, configuration, tests) prevents clutter and confusion, making the codebase easier to manage.                 |
| **Easier Maintenance**        | With a clear structure, maintaining and updating the library becomes straightforward, as developers know where to find specific files and can make changes confidently.     |
| **Build and Packaging**       | Adhering to conventions like using a `src` folder facilitates integration with build tools and package managers, as they often expect a certain directory structure.           |
| **Compatibility with IDEs**   | Standard project structures, such as a `src` folder, improve compatibility with integrated development environments (IDEs), enabling features like code navigation and auto-completion. |
| **Readability and Maintainability** | A well-organized structure enhances readability and maintainability by making it easier for developers to understand the codebase's layout and locate relevant files efficiently. |

***

# Pre-requisites

| **Pre-requisites** |
| ------------------ |
| **Jenkins** |
| **Slack Notification Plugin** |
| **Job Dsl Plugin** |
| **Global Pipeline Library Configured** |
| **Global Slack Notification Configuration** |

***

# Flow Diagram

**Flow of Work**

<img width="587" alt="image" src="https://github.com/avengers-p7/Documentation/assets/156057205/0d7db1d4-4331-429e-a088-e871ffbd7716">

***

**Shared Library File Structure**

<img width="600" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/ca8b6b9b-3b92-440e-8539-56dce86ce0f2">

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

<img width="700" alt="image" src="https://github.com/avengers-p7/Documentation/assets/156057205/d0c01488-0c49-4ada-8d78-cb736d6a653f">

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

<img width="700" alt="image" src="https://github.com/avengers-p7/Documentation/assets/156057205/2b373364-80e5-4559-8c63-d08279d38c9d">

***

**Slack Notification Plugin**

<img width="644" alt="image" src="https://github.com/avengers-p7/Documentation/assets/156057205/3b91bb9d-bb3c-4f5e-b600-08b11bf3f009">

***

**Job Dsl Plugin**

<img width="596" alt="image" src="https://github.com/avengers-p7/Documentation/assets/156057205/e5bc6f6f-5ddd-414a-81a9-1f1f6a1a69e7">

***

**Jenkinsfile Path in Configuration**

<img width="668" alt="image" src="https://github.com/avengers-p7/Documentation/assets/156057205/c9a7e00b-d4b3-4db8-a629-ead680753c89">

***

**Console Output**

<img width="700" alt="image" src="https://github.com/avengers-p7/Documentation/assets/156057205/d9835a9a-c48a-428a-976b-e32c32f8afbe">

<img width="689" alt="image" src="https://github.com/avengers-p7/Documentation/assets/156057205/4b915529-ab33-49d6-8e03-e31d13d43c31">

***

**Freestyle Job Created of name "My-Freestyle-Job"**

<img width="709" alt="image" src="https://github.com/avengers-p7/Documentation/assets/156057205/608ae964-707c-4839-a3ee-ac798a493148">

***

**Slack Notification Result**

<img width="683" alt="image" src="https://github.com/avengers-p7/Documentation/assets/156057205/190d9968-727b-48b0-be23-271b90b1e6c0">

***

# Pipeline

```shell
@Library("my-shared-library") _

def genericCiSlackNotification = new org.avengers.template.genericCi.GenericCiSlackNotification()

node {
   genericCiSlackNotification.call() 
}
 
```
>[!Note]
>Click this [Link](https://github.com/CodeOps-Hub/Jenkinsfile/blob/main/SharedLibrary/Slack_Notification/Jenkinsfile) for the script file.

***

# Shared Library File

### src/org/avengers/genericCi/slackNotification/DslJob.groovy

This DSL script creates a Freestyle job named **Freestyle-Job** in Jenkins. The job description includes a shell step that echoes **"Hello, world!"**. This script encapsulates the job configuration within a Groovy string (jobDSL) and then executes it using the jobDsl step provided by Jenkins Pipeline.


```shell
package org.avengers.genericCi.slackNotification

def call() {
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
    jobDsl(scriptText: jobDSL)
}
```

>[!Note]
>Click this [Link](https://github.com/CodeOps-Hub/SharedLibrary/blob/main/src/org/avengers/genericCi/slackNotification/DslJob.groovy) for the script file.

***

### src/org/avengers/genericCi/slackNotification/SendNotification.groovy

This DSL script sends Slack notifications based on the build status in Jenkins. It checks the **BUILD_STATUS** environment variable and defaults to **'SUCCESS'** if not set. If the build status is **'FAILURE'**, it sends a message indicating the job failure. Conversely, if the build status is **'SUCCESS'**, it sends a message indicating the successful build.

```shell
package org.avengers.genericCi.slackNotification

def call() {
    def status = env.BUILD_STATUS ?: 'SUCCESS' // Default to 'SUCCESS' if BUILD_STATUS is not set
    if (status == 'FAILURE') {
        slackSend channel: 'jenkinss', message: 'Job Failed'
    } else if (status == 'SUCCESS') {
        slackSend channel: 'jenkinss', message: 'Job Build successfully'
    }
}

```

>[!Note]
>Click this [Link](https://github.com/CodeOps-Hub/SharedLibrary/blob/main/src/org/avengers/genericCi/slackNotification/SendNotification.groovy) for the script file.

***

# Template File

### src/org/avengers/template/genericCi/GenericCiSlackNotification

This DSL script integrates two functionalities into a Jenkins pipeline. First, it initiates the creation of a job using the DslJob DSL from **org.avengers.genericCi.slackNotification**. Then, it triggers a Slack notification using the SendNotification DSL, also from the same package. This script encapsulates these actions into a single call, making it easier to use within Jenkins pipelines for Continuous Integration workflows.

```shell
package org.avengers.template.genericCi

import org.avengers.genericCi.slackNotification.*

def call(){
  dslJob = new DslJob()
  sendNotification = new SendNotification()

  dslJob .call()
  sendNotification.call()
}

```

>[!Note]
>Click this [Link](https://github.com/CodeOps-Hub/SharedLibrary/blob/main/src/org/avengers/template/genericCi/GenericCiSlackNotification.groovy) for the script file.
>
***

**Pipeline Syntax For Slacksend**

![Screenshot 2024-02-13 133308](https://github.com/avengers-p7/Documentation/assets/156057205/c5706782-2cb5-458f-ade0-6fee95cc6d6d)

***

# Conclusion

In conclusion, the shared library for Slack notification simplifies the process of integrating Slack notifications into applications by providing common functions for sending messages to Slack channels. By using this library, developers can save time and effort by avoiding the need to write notification code from scratch for each project. The library promotes code reuse, enhances consistency, and improves the overall development workflow when incorporating Slack notifications into various applications.

***

# Contact Information

| **Name** | **Email Address** |
| -------- | ----------------- |
| **Shreya Jaiswal** | shreya.jaiswal.snaatak@mygurukulam.co |

***

# Reference
| **Source** | **Description** |
| ---------- | --------------- |
| [Link](https://keentolearn.medium.com/how-to-improve-your-jenkins-builds-with-shared-libraries-5e225b7435fb#:~:text=A%20shared%20library%20in%20Jenkins,efficient%20and%20easier%20to%20maintain.) | Link For Shared Library |
| [Link](https://phoenixnap.com/kb/jenkins-shared-library) | Reference Link For Understanding the concept of Shared Library |
| [Link](https://www.youtube.com/redirect?event=video_description&redir_token=QUFFLUhqbHluUi1nZVZJcmRLai1COXZxMVRjcERlLXhXZ3xBQ3Jtc0trT05uZ3dWaG1sZmZHYXVQeWluVnl2ZHF6c3BYdGlyUE1OREh3NkRFb0dFMG5VQWxyMXhNRHRnWkxBY2hKTnB5UkJySW9BOVJkczJzRlZiZm92NVdWNHg1ZEJLeU5tRmFlS2sxWDZJUmE0YThuQ1JPQQ&q=https%3A%2F%2Fwww.jenkins.io%2Fdoc%2Fbook%2Fpipeline%2Fshared-libraries%2F&v=Wj-weFEsTb0) | Reference Link |
| [Link](https://www.youtube.com/watch?v=pQUDhOMZiZQ) | Video Reference For Shared Library |
| [Link](https://youtu.be/Wj-weFEsTb0?feature=shared) | Video Reference For Shared Library |
| [Link](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/sharedLibrary/README.md) | Generic Doc Link |
| [Link](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/sharedLibrary/setup.md) | Generic Poc Doc Link |

