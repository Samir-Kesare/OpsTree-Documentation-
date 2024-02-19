# Scripted pipeline Go Lang Static Code Analysis

|   Author        |  Created on   |  Version   | Last updated by  | Last edited on |
| --------------- | --------------| -----------|----------------- | -------------- |
| Khushi Malhotra |  07 Feb 2024  |  Version 1 | Khushi Malhotra  | 13 Feb 2024    |
***
# Introduction
Scripted Pipelines are a powerful way to define and automate software delivery workflows in Jenkins. They offer more flexibility and customization compared to the simplified Declarative Pipelines. 

**For more information visit the below document link:**

[\[ Reference Doc \]](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Design/08-%20Jenkins/static%20code%20Analysis.md)
[\[ Reference Doc \]](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/jenkinsPipeline.md )

# Pre-requisites
| Item         | Version   |
|--------------|-----------|
| Jenkins      | 2.426.3 |
| go plugin    | v1.22.0 |

# Flow Diagram
***

# go plugin
![WhatsApp Image 2024-02-13 at 13 33 44_886b7a78](https://github.com/avengers-p7/Documentation/assets/156056460/55c954ee-4937-496d-bff9-6ca2df8cca38)
![WhatsApp Image 2024-02-13 at 13 30 55_1bbd4add](https://github.com/avengers-p7/Documentation/assets/156056460/bb5dce1a-3952-4ebd-a40b-8a41a45375dd)


#Code Compilation Setup
**Step-1** Create a New Pipeline Job

- Navigate to the Jenkins dashboard and click on New Item.
- Enter a name for your job (e.g., "Declarative pipeline-Golang-Code Compilation").
- Select Pipeline and click OK.

**Step-2** Configure Pipeline Script

- In the job configuration page, scroll down to the Pipeline section.
- Select Pipeline script from SCM.
- Give required repo url and enter your credentials.

**Step-3** Save the Configuration

- Click on Save to save the job configuration.

**Step-4** Build the Pipeline

- Once the pipeline configuration is saved, you can manually trigger the build by clicking on Build Now.

**Step-5** View Build Console Output

- After triggering the build, you can view the progress and console output of the build by clicking on the build number in the Jenkins dashboard.
- The console output will display the steps executed by the pipeline script, including code checkout and compilation.
- Verify Successful Compilation:


# Contact Information
| Name            | Email Address                        |
|-----------------|--------------------------------------|
| Khushi Malhotra | khushi.malhotra.snaatak@mygurukulam.co |

## References

| Description                                   | References  
| --------------------------------------------  | -------------------------------------------------|
| Clean Workspace | https://www.jenkins.io/doc/pipeline/tour/running-multiple-steps/#finishing-up |
| Pipeline (Generic Doc) | https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/jenkinsPipeline.md |
| Create Pipeline (Generic Doc)| https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/pipelinePOC.md |
| Gosec | https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Design/05-%20GoLang%20CI%20Checks/Static-code-analysis-poc.md |

