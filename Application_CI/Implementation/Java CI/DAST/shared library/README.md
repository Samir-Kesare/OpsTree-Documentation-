# DAST Java CI (Shared Library)

| Author                                                           | Created on  | Version    | Last Updated by | Last Updated on |
| ---------------------------------------------------------------- | ----------- | ---------- | --------------- | --------------- |
| Vidhi Yadav  | 18th Feb 2024  | 1.0        | Vidhi Yadav   | 18th Feb 2024      |


## Table  of Contents

1. [Introduction](#Introduction)
2. [What is Shared Library](#What-is-Shared-Library)
3. [Pre-requisites](#Pre-requisites)
4. [Runtime Prerequisites](#Runtime-Prerequisites)
5. [Flow Diagram](#Flow-Diagram)
6. [Pipeline Setup](#Pipeline-Setup)
7. [Best Practices](#best-practices)
8. [Contact Information](#Contact-Information)
9. [References](#References)
***

## Introduction 

Dynamic Application Security Testing (DAST) is an approach in the field of cybersecurity, dedicated to evaluating and enhancing the security posture of web applications. DAST operates dynamically during runtime, actively examining web applications in their functional state by simulating real-world attacks. Unlike static analysis, DAST assesses applications in their deployed environment, providing a comprehensive view of potential vulnerabilities and security weaknesses.

Visit this [link](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GenericDoc/jenkinsPipeline.md) to get comprehensive understanding of DAST

***
## What is Shared Library?

A shared library in Jenkins is a reusable collection of Groovy scripts that can be used by multiple Jenkins jobs. This allows you to share code and functionality between different jobs, which can make your builds more efficient and easier to maintain. 

A shared library is typically organized as a Git repository containing code that you want to share across pipelines. This repository would have a specific structure with directories like src, vars, resources, etc., where you place your Groovy scripts, classes, and other resources.

![SL](https://github.com/CodeOps-Hub/Documentation/assets/156056349/4d4fac2f-75d1-4faf-9eda-2e61288d0262)


**For more information visit the below document link:**

[\[ Reference Doc \]]()

***
## Pre-requisites

| Tool   | Description                          | 
|--------|--------------------------------------|
| OWASP ZAP (version: 2.14) | Tool required to perform DAST  | 
| Jenkins | CICD Tool                          |  
| JRE (Java runtime environment     | Zap is coded in Java, and its fundamental operations require a Java runtime environment for execution.    |

***
## Flow Diagram

<img width="890" alt="Screenshot 2024-02-20 at 9 55 58 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/bb1e65cb-c705-4e5e-b565-1c400b348e4a">


***
## Pipeline Setup

1. **Configure Shared library in Jenkins**
	
* Follow below document

[Reference Document](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GenericDoc/sharedLibrary/README.md)

<img width="921" alt="Screenshot 2024-02-20 at 9 09 24 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/069fac7d-e622-4012-821d-c9b1dafea609">


2. **Create and Configure your Jenkins Pipeline job**

* Follow below document

	[Reference Document](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GenericDoc/pipelinePOC.md)

<img width="899" alt="Screenshot 2024-02-20 at 9 10 44 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/678f85b5-faf0-45c2-8359-58fb66220179">


3. **Build Pipeline**

<img width="1022" alt="Screenshot 2024-02-20 at 10 02 52 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/f258fabd-9543-4d63-8521-c5a7d9a1513d">

***
## Output
* OWASP ZAP console log

<img width="1006" alt="Screenshot 2024-02-20 at 9 13 18 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/89083752-f859-4657-83a3-ffcd8b1978ad">

* Archived HTML ZAP reports

<img width="833" alt="Screenshot 2024-02-20 at 9 39 04 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/ee550ed2-276c-45b9-a8d0-2d1d3537bde8">

* HTML Report can be found [**here**](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/Java%20CI/DAST/declarative/ZAP%20Report.html)

<img width="1160" alt="Screenshot 2024-02-20 at 5 01 40 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/1948e7bc-46ad-4012-a4ce-4f003d111b67">

***
## [Jenkinsfile](https://github.com/CodeOps-Hub/Jenkinsfile/blob/main/SharedLibrary/Java/DAST/Jenkinsfile)

```shell
@Library('dast_sharedLib') _
def dast = new org.avengers.template.java.javaDast()

node {
    
    def url = 'https://github.com/CodeOps-Hub/Salary-API.git'
    def creds = 'vyadavP7'
    def branch = 'main'
    def zapVersion = '2.14.0'
    def currentWorkspace = env.WORKSPACE 
        
    dast.call(url, creds, branch, zapVersion, currentWorkspace)
    
}
```

## [Shared Library](https://github.com/CodeOps-Hub/SharedLibrary/blob/main/src/org/avengers/template/java/javaDast.groovy)

```shell
package org.avengers.template.java

import org.avengers.common.*
import org.avengers.java.dast.*

def call(String url, String creds, String branch, String zapVersion, String currentWorkspace){
  gitCheckoutPrivate = new GitCheckoutPrivate()
  owaspZapInstallation = new OwaspZapInstallation()
  runZap = new RunZap()

  gitCheckoutPrivate.call(url, creds, branch)
  owaspZapInstallation.call(zapVersion)
  runZap.call(zapVersion, currentWorkspace)

  // Archive ZAP scan results
  archiveArtifacts artifacts: '**/results.html', allowEmptyArchive: true
}
```

### [OwaspZapInstallation.groovy](https://github.com/CodeOps-Hub/SharedLibrary/blob/main/src/org/avengers/java/dast/OwaspZapInstallation.groovy)
```
package org.avengers.java.dast

def call(String zapVersion) {
  stage('Install ZAP') {
    script {
         // Download and install OWASP ZAP
          sh "wget https://github.com/zaproxy/zaproxy/releases/download/v${zapVersion}/ZAP_${zapVersion}_Linux.tar.gz"
          sh "tar -xvf ZAP_${zapVersion}_Linux.tar.gz"
                    
                }
            }
        }
```

### [RunZap.groovy](https://github.com/CodeOps-Hub/SharedLibrary/blob/main/src/org/avengers/java/dast/RunZap.groovy)

```
package org.avengers.java.dast

def call(String zapVersion, String currentWorkspace) {
stage('Run ZAP Scan') {
            script {
                 // Start ZAP and perform the scan
                  sh "${currentWorkspace}/ZAP_${zapVersion}/zap.sh -cmd -port 8082 -quickurl http://174.129.170.198:8080/swagger-ui/index.html -quickout ${currentWorkspace}/results.html"
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

### [cleanWorkspace.groovy](https://github.com/CodeOps-Hub/SharedLibrary/blob/main/src/org/avengers/common/cleanWorkspace.groovy)
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



* For more comprehensive understanding of each step in the pipeline and detailed information, you can visit the following link: [Link to Documentation](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Design/03-%20Java%20CI%20checks/DAST%20POC/README.md)

***
## Best Practices

1. **Collaboration and Reporting:** Share scan results with relevant stakeholders, including developers, security teams, and management. Use OWASP ZAP's reporting features to generate detailed reports that highlight identified vulnerabilities, their impact, and recommended remediation steps.
   
2. **Stay Updated:** Regularly update OWASP ZAP to the latest version to ensure you have the most up-to-date features and security checks.
 
3. **Authentication Configuration:** If your application requires authentication, configure OWASP ZAP to handle it properly. Provide credentials or session tokens to ensure comprehensive testing of authenticated parts of the application.

***

## Contact Information

|     Name         | Email  |
| -----------------| ------------------------------------ |
| Vidhi Yadav    | vidhi.yadhav.snaatak@mygurukulam.co |
***

## References

| Description                                   | References  
| --------------------------------------------  | -------------------------------------------------|
| Shared Library (Generic Doc) |  |	https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GenericDoc/sharedLibrary/README.md
| Shared Library Setup (Generic Doc) | https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GenericDoc/sharedLibrary/setup.md |
