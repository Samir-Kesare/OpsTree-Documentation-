# GoLang Code Compilation using Shared Library
|   Author        |  Created on   |  Version   | Last updated by  | Last edited on |
| --------------- | --------------| -----------|----------------- | -------------- |
| Khushi Malhotra |  13 Feb 2024  |  Version 1 | Khushi Malhotra  | 13 Feb 2024    |
***
# Table of Contents
- [Introduction](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GolangCI/CodeCompilation/Shared%20Library/README.md#introduction)
- [What is Shared Library](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GolangCI/CodeCompilation/Shared%20Library/README.md#what-is-shared-library)
- [Prerequisites](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GolangCI/CodeCompilation/Shared%20Library/README.md#prerequisites)
- [Flow Diagram](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GolangCI/CodeCompilation/Shared%20Library/README.md#flow-diagram)
- [Pipeline Setup](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GolangCI/CodeCompilation/Shared%20Library/README.md#pipeline-setup)
- [Pipeline](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GolangCI/CodeCompilation/Shared%20Library/README.md#pipeline)
- [Shared Library](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GolangCI/CodeCompilation/Shared%20Library/README.md#shared-library)
- [Contact Information](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GolangCI/CodeCompilation/Shared%20Library/README.md#contact-information)
- [Resources and References](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GolangCI/CodeCompilation/Shared%20Library/README.md#resources-and-references)
***

# Introduction 
The process of code compilation involves converting high-level programming code, such as Java, C++, or Python, into machine-readable instructions or bytecode. 
This transformation is carried out by a compiler, which is a specialized tool designed to translate human-readable source code into an executable format. Here we are using "go Build" to compile the code.
**For more information visit the below document link:**
[[Reference Doc]](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Design/05-%20GoLang%20CI%20Checks/Code_Compilation_GoLang.md)
In this task, we are using Shared Library.
***

# What is Shared Library 
A shared library is a collection of reusable Groovy scripts that you can share across multiple Jenkins jobs. 
It's like building modular components for your CI/CD pipelines, promoting efficiency and maintainability.
**For more information click [here](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/sharedLibrary/README.md).
***

## Prerequisites

| Tool | Description |
| ---- | ----------- |
| **Jenkins(2.426.3)** | To build our pipeline |
| **Go plugin** | Go 1.22.0 |

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

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/72f17d8f-060b-40b0-b8b3-10d09fe1f27a)

**Step-3** Save the Configuration

- Click on Save to save the job configuration.

**Step-4** Build the Pipeline

- Once the pipeline configuration is saved, you can manually trigger the build by clicking on Build Now.

**Step-5** View Build Console Output

- After triggering the build, you can view the progress and console output of the build by clicking on the build number in the Jenkins dashboard.
- The console output will display the steps executed by the pipeline script, including code checkout and compilation.
- Verify Successful Compilation

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/1d5e5d8a-b222-4aea-85b2-802569d155c5)
![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/efa1100e-7711-4523-8d70-a6af364eda59)
![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/12c20379-d75b-4fc9-aa4b-ee852dc754bf)

***

# [Pipeline](https://github.com/CodeOps-Hub/Jenkinsfile/blob/main/SharedLibrary/Golang/CodeCompilation/Jenkinsfile)
```shell
@Library('shared-library') _
def golangcodecompilation = new org.avengers.template.golang.GolangCodeCompilation()

node {
    
    def url = 'https://github.com/OT-MICROSERVICES/employee-api.git'
    def creds = 'khushi09'
    def branch = 'main'
    
    golangcodecompilation.call(url, creds, branch)
    
}
```
# [Shared Library](https://github.com/CodeOps-Hub/SharedLibrary)

## [src/org/avengers/golang/CodeCompilation](https://github.com/CodeOps-Hub/SharedLibrary/tree/main/src/org/avengers/golang/CodeCompilation)

### [codecompilation.groovy](https://github.com/CodeOps-Hub/SharedLibrary/blob/main/src/org/avengers/golang/CodeCompilation/codecompilation.groovy)
```shell
package org.avengers.golang.CodeCompilation

def call() {
  echo "Golang code compilation"
   sh 'go install'
   sh "go list -f '{{.Target}}'"
}
return this
```
### [installationgo.groovy](https://github.com/CodeOps-Hub/SharedLibrary/blob/main/src/org/avengers/golang/CodeCompilation/installationgo.groovy)
```shell
package org.avengers.golang.CodeCompilation

def call() {
    stage('Installation Pre-Requisites') {
        script {
            // Ensure Go is available in the environment
            def goHome = tool 'go1.22.0'
            env.PATH = "${goHome}/bin:${env.PATH}"
        }
    }
}
```
## [src/org/avengers/common](https://github.com/CodeOps-Hub/SharedLibrary/tree/main/src/org/avengers/common)

### [CleanWorkSpace.groovy](https://github.com/CodeOps-Hub/SharedLibrary/blob/main/src/org/avengers/common/CleanWorkSpace.groovy)
```shell
package org.avengers.common
// Always Clean 
def call(){
  stage('Clean Workspace') {
        script {
           cleanWs()
        }
    }
  
}
```
### [GitCheckoutPrivate.groovy](https://github.com/CodeOps-Hub/SharedLibrary/blob/main/src/org/avengers/common/GitCheckoutPrivate.groovy)
```shell
package org.avengers.common

def call(String url, String creds, String branch) {
    stage('Clone') {
        script {
            git branch: "${branch}", credentialsId: "${creds}", url: "${url}"
        }
    }
}
```

## [src/org/avengers/template/golang](https://github.com/CodeOps-Hub/SharedLibrary/tree/main/src/org/avengers/template/golang)

### [GolangCodeCompilation.groovy](https://github.com/CodeOps-Hub/SharedLibrary/blob/main/src/org/avengers/template/golang/GolangCodeCompilation.groovy)
```shell
package org.avengers.template.golang


import org.avengers.common.*
import org.avengers.golang.CodeCompilation.*

def call(String url, String creds, String branch){
  cleanWorkspace = new cleanWorkspace()
  gitCheckoutPrivate = new GitCheckoutPrivate()
  installationgo = new installationgo()
  codecompilation = new codecompilation()

  cleanWorkspace.call()
  gitCheckoutPrivate.call(url, creds, branch)
  installationgo.call()
  codecompilation.call()
}
```

# Contact Information
| Name            | Email Address                        |
|-----------------|--------------------------------------|
| Khushi Malhotra | khushi.malhotra.snaatak@mygurukulam.co |

# Resources and References
| Description                                   | References  
| --------------------------------------------  | -------------------------------------------------|
| Code Compilation | https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Design/05-%20GoLang%20CI%20Checks/Code_Compilation_GoLang.md |
| Code Compilation | https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Design/05-%20GoLang%20CI%20Checks/Code_compilationPOC-go.md |
| Clean Workspace | https://www.jenkins.io/doc/pipeline/tour/running-multiple-steps/#finishing-up |
| Shared Library (Generic Doc) | https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/jenkinsPipeline.md |
| Shared Library Setup (Generic Doc) | https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/sharedLibrary/setup.md |
| Create Pipeline (Generic Doc)| https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/pipelinePOC.md |
| Pipeine Syntax | https://www.jenkins.io/doc/book/pipeline/#pipeline-syntax-overview |
| Pipeline Concepts | https://www.jenkins.io/doc/book/pipeline/#pipeline-concepts |
| Shared Library | https://www.jenkins.io/doc/book/pipeline/shared-libraries/ |
| What is shared Library | https://keentolearn.medium.com/how-to-improve-your-jenkins-builds-with-shared-libraries-5e225b7435fb#:~:text=A%20shared%20library%20in%20Jenkins,efficient%20and%20easier%20to%20maintain. |
