# Scripted pipeline Go Lang Static Code Analysis

|   Author        |  Created on   |  Version   | Last updated by  | Last edited on |
| --------------- | --------------| -----------|----------------- | -------------- |
| Khushi Malhotra |  07 Feb 2024  |  Version 1 | Khushi Malhotra  | 13 Feb 2024    |
***
![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/f30e7c1f-307b-4a80-b617-9a20949db8b5)

# Table of Contents
- [Introduction](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GolangCI/StaticCodeAnalysis/ScriptedPipeline/README.md#introduction)
- [Pre-requisites](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GolangCI/StaticCodeAnalysis/ScriptedPipeline/README.md#pre-requisites)
- [Flow Diagram](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GolangCI/StaticCodeAnalysis/ScriptedPipeline/README.md#flow-diagram)
- [go plugin](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GolangCI/StaticCodeAnalysis/ScriptedPipeline/README.md#go-plugin)
- [Static Code Analysis Setup](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GolangCI/StaticCodeAnalysis/ScriptedPipeline/README.md#static-code-analysis-setup)
- [Pipeline](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GolangCI/StaticCodeAnalysis/ScriptedPipeline/README.md#pipeline)
- [Contact Information](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GolangCI/StaticCodeAnalysis/ScriptedPipeline/README.md#contact-information)
- [References](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GolangCI/StaticCodeAnalysis/ScriptedPipeline/README.md#references)

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
![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/0448c461-e7f0-4c85-9c19-68a2706959d1)

***

# go plugin
![WhatsApp Image 2024-02-13 at 13 33 44_886b7a78](https://github.com/avengers-p7/Documentation/assets/156056460/55c954ee-4937-496d-bff9-6ca2df8cca38)
![WhatsApp Image 2024-02-13 at 13 30 55_1bbd4add](https://github.com/avengers-p7/Documentation/assets/156056460/bb5dce1a-3952-4ebd-a40b-8a41a45375dd)


# Static Code Analysis Setup
**Step-1** Create a New Pipeline Job

- Navigate to the Jenkins dashboard and click on New Item.
- Enter a name for your job (e.g., "Declarative pipeline-Golang-Code Compilation").
- Select Pipeline and click OK.

**Step-2** Configure Pipeline Script

- In the job configuration page, scroll down to the Pipeline section.
- Select Pipeline script from SCM.
- Give required repo url and enter your credentials.
![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/e07007c2-da74-434b-b53f-0b2f4002bbbf)

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/3c3596fb-bf41-4144-a31f-0de617379e8d)

**Step-3** Save the Configuration

- Click on Save to save the job configuration.

**Step-4** Build the Pipeline

- Once the pipeline configuration is saved, you can manually trigger the build by clicking on Build Now.

**Step-5** View Build Console Output

- After triggering the build, you can view the progress and console output of the build by clicking on the build number in the Jenkins dashboard.
- The console output will display the steps executed by the pipeline script, including code checkout and compilation.
- Verify Successful Compilation:

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/399f3e93-9aab-4dd5-bec5-d53117aa9fb8)

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/d8d0d5f4-f85c-4a6b-9e93-2149a6410efa)

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/40b763bb-c31a-4414-b1c4-a18768edfd96)

# Pipeline
```shell
node {
    def goHome = tool name: 'go1.22.0', type: 'go'
    
    stage('Checkout') {
        git branch: 'main', url: 'https://github.com/CodeOps-Hub/Employee-API.git'
    }
    
    stage('SonarQube Analysis') {
        withSonarQubeEnv('sq1') {
            sh "/var/lib/jenkins/tools/hudson.plugins.sonar.MsBuildSQRunnerInstallation/SonarScanner/sonar-scanner-5.0.1.3006/bin/sonar-scanner -Dsonar.projectKey=gloang-static-01 -Dsonar.sources=. -Dsonar.host.url=http://10.188.0.3:9000  -Dsonar.login=sqp_baf01327c387b84a45b8796884f8bdcd2f3c7097"
                    
        }
    }
}
```

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

