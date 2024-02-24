# Go Lang Static Code Analysis using Shared Library

|   Author        |  Created on   |  Version   | Last updated by  | Last edited on |
| --------------- | --------------| -----------|----------------- | -------------- |
| Khushi Malhotra |  30 Jan 2024  |  Version 1 | Khushi Malhotra  | 13 Feb 2024    |
***
# Table of Contents
- [Introduction](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GolangCI/StaticCodeAnalysis/SharedLibrary/README.md#introduction)
- [What is Shared Library?](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GolangCI/StaticCodeAnalysis/SharedLibrary/README.md#what-is-shared-library)
- [Pre-requisites](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GolangCI/StaticCodeAnalysis/SharedLibrary/README.md#pre-requisites)
- [Flow Diagram](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GolangCI/StaticCodeAnalysis/SharedLibrary/README.md#flow-diagram)
- [go plugin](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GolangCI/StaticCodeAnalysis/SharedLibrary/README.md#go-plugin)
- [Static Code Analysis Setup](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GolangCI/StaticCodeAnalysis/SharedLibrary/README.md#static-code-analysis-setup)
- [Pipeline](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GolangCI/StaticCodeAnalysis/SharedLibrary/README.md#pipeline)
- [Contact Information](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GolangCI/StaticCodeAnalysis/SharedLibrary/README.md#contact-information)
- [Reference](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GolangCI/StaticCodeAnalysis/SharedLibrary/README.md#reference)
  
# Introduction 

Static analysis, also called static code analysis, is a method of computer program debugging that is done by examining the code without executing the program. The process provides an understanding of the code structure and can help ensure that the code adheres to industry standards. Static analysis is used in software engineering by software development and quality assurance teams. Automated tools can assist programmers and developers in carrying out static analysis. The software will scan all code in a project to check for vulnerabilities while validating the code.

**For more information visit the below document link:**

[\[ Reference Doc \]](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Design/08-%20Jenkins/static%20code%20Analysis.md)

# What is Shared Library?

A shared library in Jenkins is a reusable collection of Groovy scripts that can be used by multiple Jenkins jobs. This allows you to share code and functionality between different jobs, which can make your builds more efficient and easier to maintain.

**For more information visit the below document link:**

[\[ Reference Doc \]](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/sharedLibrary/README.md)

# Pre-requisites
| Item         | Version   |
|--------------|-----------|
| Jenkins      | 2.426.3 |
| go plugin    | v1.22.0 |

# Flow Diagram
**

# go plugin
![WhatsApp Image 2024-02-13 at 13 33 44_886b7a78](https://github.com/avengers-p7/Documentation/assets/156056460/55c954ee-4937-496d-bff9-6ca2df8cca38)
![WhatsApp Image 2024-02-13 at 13 30 55_1bbd4add](https://github.com/avengers-p7/Documentation/assets/156056460/bb5dce1a-3952-4ebd-a40b-8a41a45375dd)

# Static Code Analysis Setup 
**Step-1** Create a New Pipeline Job

- Navigate to the Jenkins dashboard and click on New Item.
- Enter a name for your job (e.g., "SharedLibrary-Golang-Static-Code-Analysis").
- Select Pipeline and click OK.

**Step-2** Configure Pipeline Script

- In the job configuration page, scroll down to the Pipeline section.
- Select Pipeline script from SCM.
- Give required repo url and enter your credentials.

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/7277047b-4b57-40d7-9562-58069ba4fc4a)

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/7d34c0f0-e1d1-41d4-b863-561aafbc1897)

**Step-3** Save the Configuration

- Click on Save to save the job configuration.

**Step-4** Build the Pipeline

- Once the pipeline configuration is saved, you can manually trigger the build by clicking on Build Now.

**Step-5** View Build Console Output

- After triggering the build, you can view the progress and console output of the build by clicking on the build number in the Jenkins dashboard.
- The console output will display the steps executed by the pipeline script, including code checkout and compilation.
- Verify Successful Compilation

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/d889dc2a-ffc6-43c1-b438-a8349857fd92)

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/46069300-e83c-4662-9940-05410c5b13f0)

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/40b763bb-c31a-4414-b1c4-a18768edfd96)

# [Pipeline](https://github.com/CodeOps-Hub/Jenkinsfile/blob/main/SharedLibrary/Golang/StaticCodeAnalysis/Jenkinsfile)

[Jenkinsfile](https://github.com/CodeOps-Hub/Jenkinsfile/tree/main/SharedLibrary/Golang/StaticCodeAnalysis)
```shell
@Library('my-shared-library') _
def staticanalysisgo = new org.avengers.template.golang.StaticAnalysisGo()

node {
    
    def url = 'https://github.com/OT-MICROSERVICES/employee-api.git'
    def creds = 'Harshit-Github-PAT'
    def branch = 'main'
    
    staticanalysisgo.call(url, creds, branch)
    
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

### [gostaticanalysis.groovy](https://github.com/CodeOps-Hub/SharedLibrary/blob/main/src/org/avengers/golang/StaticAnalysis/gostaticanalysis.groovy)

```shell
package org.avengers.golang.StaticAnalysis

def sonarQubeAnalysis() {
    stage('SonarQube Analysis') {
        withSonarQubeEnv('sq1') {
            sh "/var/lib/jenkins/tools/hudson.plugins.sonar.MsBuildSQRunnerInstallation/SonarScanner/sonar-scanner-5.0.1.3006/bin/sonar-scanner -Dsonar.projectKey=gloang-static-01 -Dsonar.sources=. -Dsonar.host.url=http://10.188.0.3:9000  -Dsonar.login=sqp_baf01327c387b84a45b8796884f8bdcd2f3c7097"
        }
    }
}
```

### [StaticAnalysisGo.groovy](https://github.com/CodeOps-Hub/SharedLibrary/blob/main/src/org/avengers/template/golang/StaticAnalysisGo.groovy)
```
shell
package org.avengers.template.golang


import org.avengers.common.*
import org.avengers.golang.StaticAnalysis.*
import org.avengers.golang.CodeCompilation.*

def call(String url, String creds, String branch){

  installationgo = new installationgo() 
  gitCheckoutPrivate = new GitCheckoutPrivate()
  gostaticanalysis = new gostaticanalysis()
   
  gitCheckoutPrivate.call(url, creds, branch)
  installationgo.call()
  gostaticanalysis.call()
}
```


# Contact Information
| Name            | Email Address                        |
|-----------------|--------------------------------------|
| Khushi Malhotra | khushi.malhotra.snaatak@mygurukulam.co |


# Reference
| Description                                   | References  
| --------------------------------------------  | -------------------------------------------------|
| gosec Implementation | https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Design/05-%20GoLang%20CI%20Checks/Static-code-analysis-poc.md |
| Statis Code Analysis | https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Design/08-%20Jenkins/static%20code%20Analysis.md |
| Clean Workspace | https://www.jenkins.io/doc/pipeline/tour/running-multiple-steps |

