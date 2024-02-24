# Declarative Pipeline-Go Lang Static Code Analysis

|   Author        |  Created on   |  Version   | Last updated by  | Last edited on |
| --------------- | --------------| -----------|----------------- | -------------- |
| Khushi Malhotra |  07 Feb 2024  |  Version 1 | Khushi Malhotra  | 13 Feb 2024    |
***
#Table of Contents
-[Introduction](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GolangCI/StaticCodeAnalysis/DeclarativePipeline/README.md#introduction)
-[What is Declarative Pipeline](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GolangCI/StaticCodeAnalysis/DeclarativePipeline/README.md#what-is-declarative-pipeline)
-[Pre-requisites](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GolangCI/StaticCodeAnalysis/DeclarativePipeline/README.md#pre-requisites)
-[go plugin](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GolangCI/StaticCodeAnalysis/DeclarativePipeline/README.md#go-plugin)
-[Static-Code Analysis Setup](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GolangCI/StaticCodeAnalysis/DeclarativePipeline/README.md#static-code-analysis-setup)
-[Pipeline](
-[Contact Information](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GolangCI/StaticCodeAnalysis/DeclarativePipeline/README.md#contact-information)
-[References](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GolangCI/StaticCodeAnalysis/DeclarativePipeline/README.md#references)

## Introduction
Static analysis, also called static code analysis, is a method of computer program debugging that is done by examining the code without executing the program. The process provides an understanding of the code structure and can help ensure that the code adheres to industry standards. Static analysis is used in software engineering by software development and quality assurance teams. Automated tools can assist programmers and developers in carrying out static analysis. The software will scan all code in a project to check for vulnerabilities while validating the code.

**For more information visit the below document link:**

[\[ Reference Doc \]](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Design/08-%20Jenkins/static%20code%20Analysis.md)

***
## What is Declarative Pipeline

Declarative Pipeline in Jenkins offers a simplified and structured approach for defining CI/CD pipelines, using a human-readable syntax with predefined sections like pipeline, stages, and agent. It's designed to be easy to read and maintain, making it suitable for users without strong scripting skills.It enforces a stricter syntax and allows for less flexibility compared to the scripted pipeline, which can be seen as an advantage for ensuring consistency and readability.

**For more information visit the below document link:**

[\[ Reference Doc \]](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/jenkinsPipeline.md )

## Pre-requisites
| Item         | Version   |
|--------------|-----------|
| Jenkins      | 2.426.3 |
| go plugin    | v1.22.0 |

# go plugin
![WhatsApp Image 2024-02-13 at 13 33 44_886b7a78](https://github.com/avengers-p7/Documentation/assets/156056460/55c954ee-4937-496d-bff9-6ca2df8cca38)
![WhatsApp Image 2024-02-13 at 13 30 55_1bbd4add](https://github.com/avengers-p7/Documentation/assets/156056460/bb5dce1a-3952-4ebd-a40b-8a41a45375dd)

# Static-Code Analysis Setup 
**Step-1** Create a New Pipeline Job

- Navigate to the Jenkins dashboard and click on New Item.
- Enter a name for your job (e.g., "Declarative pipeline-Golang-Static-Code-Analysis").
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
- Verify Successful Compilation

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/6a6c23f4-ca5e-4a98-a078-bb5bab74a15a)

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/253cd688-9ee0-4dd9-ad97-5144dcb3d6b3)

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/40b763bb-c31a-4414-b1c4-a18768edfd96)

# Pipeline
```shell
pipeline {
    agent any
    tools {
        go 'go1.22.0'
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/CodeOps-Hub/Employee-API.git'
            }
        }
        stage('SonarQube Analysis') {
            steps {

                 withSonarQubeEnv('sq1') {
                        sh "/var/lib/jenkins/tools/hudson.plugins.sonar.MsBuildSQRunnerInstallation/SonarScanner/sonar-scanner-5.0.1.3006/bin/sonar-scanner -Dsonar.projectKey=gloang-static-01 -Dsonar.sources=. -Dsonar.host.url=http://10.188.0.3:9000  -Dsonar.login=sqp_baf01327c387b84a45b8796884f8bdcd2f3c7097"
                    }
                     
                    }
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
| Statis Code Analysis | https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Design/08-%20Jenkins/static%20code%20Analysis.md |
| Gosec | https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Design/05-%20GoLang%20CI%20Checks/Static_Code_Analysis_Go_Language.md |
| gosec Implementation | https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Design/05-%20GoLang%20CI%20Checks/Static-code-analysis-poc.md |
| Clean Workspace | https://www.jenkins.io/doc/pipeline/tour/running-multiple-steps/#finishing-up |
| Pipeline (Generic Doc) | https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/jenkinsPipeline.md |
| Create Pipeline (Generic Doc)| https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/pipelinePOC.md |
| Pipeine Syntax | https://www.jenkins.io/doc/book/pipeline/#pipeline-syntax-overview |
| Pipeline Concepts | https://www.jenkins.io/doc/book/pipeline/#pipeline-concepts |
