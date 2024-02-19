# Commit Sign-off using Shared Library
|   Author        |  Created on   |  Version   | Last updated by  | Last edited on |
| --------------- | --------------| -----------|----------------- | -------------- |
| Khushi Malhotra |  13 Feb 2024  |  Version 1 | Khushi Malhotra  | 13 Feb 2024    |
***
# Introduction 
In the context of version control systems like Git, a commit sign-off is a line added to the end of a commit message that serves several purposes:
1. Attribution: It identifies the author of the commit, typically including their name and email address.
2. Licensing: It indicates that the author agrees to the project's licensing terms. This is especially important for open-source projects, where contributions need to comply with the defined license.
3. Verification: Depending on the project's setup, the sign-off might also involve cryptographic signing using GPG (GnuPG), which digitally verifies the author's identity and ensures the integrity of the commit message.

# What is Shared Library 
A shared library is a collection of reusable Groovy scripts that you can share across multiple Jenkins jobs. 
It's like building modular components for your CI/CD pipelines, promoting efficiency and maintainability.
**For more information click [here](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/sharedLibrary/README.md).
***

## Pre-requisites

| Tool | Description |
| ---- | ----------- |
| **Jenkins(2.426.3)** | To build our pipeline |

# Flow Diagram 
***

# Pipeline Setup
**Step-1** Create a New Pipeline Job

- Navigate to the Jenkins dashboard and click on New Item.
- Enter a name for your job (e.g., "Shared_Library_Code_Compilation").
- Select Pipeline and click OK.

**Step-2** Configure Pipeline Script

- In the job configuration page, scroll down to the Pipeline section.
- Select Pipeline script from SCM.
- Give required repo url and enter your credentials.

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/15895918-649d-49fd-9fd7-95148f060ac5)

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/b3933591-d583-4cee-a067-b8a6f2597a42)

**Step-3** Save the Configuration

- Click on Save to save the job configuration.

**Step-4** Build the Pipeline

- Once the pipeline configuration is saved, you can manually trigger the build by clicking on Build Now.

**Step-5** View Build Console Output

- After triggering the build, you can view the progress and console output of the build by clicking on the build number in the Jenkins dashboard.
- The console output will display the steps executed by the pipeline script, including code checkout and compilation.
- Verify Successful Compilation



# Contact Information
| Name            | Email Address                        |
|-----------------|--------------------------------------|
| Khushi Malhotra | khushi.malhotra.snaatak@mygurukulam.co |


# Resources and References
| Description                                   | References                                       |
| --------------------------------------------  | -------------------------------------------------|
| Commit Sign-off | https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Design/02-%20Generic%20CI%20operation/CommitSignOff.md |
| Shared Library (Generic Doc) | https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/jenkinsPipeline.md |
| Shared Library Setup (Generic Doc) | https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/sharedLibrary/setup.md |
| Create Pipeline (Generic Doc)| https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/pipelinePOC.md |
| Pipeine Syntax | https://www.jenkins.io/doc/book/pipeline/#pipeline-syntax-overview |
| Pipeline Concepts | https://www.jenkins.io/doc/book/pipeline/#pipeline-concepts |
| Shared Library | https://www.jenkins.io/doc/book/pipeline/shared-libraries/ |
| What is shared Library | https://keentolearn.medium.com/how-to-improve-your-jenkins-builds-with-shared-libraries-5e225b7435fb#:~:text=A%20shared%20library%20in%20Jenkins,efficient%20and%20easier%20to%20maintain. |
