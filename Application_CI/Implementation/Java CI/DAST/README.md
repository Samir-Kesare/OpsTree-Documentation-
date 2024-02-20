# Declarative Pipeline Java DAST

![download](https://github.com/avengers-p7/Documentation/assets/156056570/a292f2dd-4795-4566-bfb6-014b634f76bf)



|   Author        |  Created on   |  Version   | Last updated by  | Last edited on |
| --------------- | --------------| -----------|----------------- | -------------- |
| Vidhi Yadav |  20th February 2024  |  Version 1 | Vidhi Yadav | 20th Feb 2024    |

***
## Table of Contents
+ [Introduction](#Introduction)
+ [Declarative Pipeline](#Declarative-Pipeline)
+ [Flow Diagram](#Flow-Diagram)
+ [Pre-requisites](#Pre-requisites)
+ [Setup](#pipeline-setup)
+ [Conclusion](#Conclusion)
+ [Contact Information](#Contact-Information)
+ [Resources and References](#Resources-and-References)
  
***
## Introduction

[Dynamic Application Security Testing (DAST)](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GenericDoc/jenkinsPipeline.md) is an approach in the field of cybersecurity, dedicated to evaluating and enhancing the security posture of web applications. DAST operates dynamically during runtime, actively examining web applications in their functional state by simulating real-world attacks. Unlike static analysis, DAST assesses applications in their deployed environment, providing a comprehensive view of potential vulnerabilities and security weaknesses.

***
## Declarative Pipeline

Declarative Pipeline in Jenkins offers a simplified and structured approach for defining CI/CD pipelines, using a human-readable syntax with predefined sections like pipeline, stages, and agent. It's designed to be easy to read and maintain, making it suitable for users without strong scripting skills. While it may be less flexible in terms of allowing complex scripting logic, it is a newer and more concise way to define Jenkins pipeline.

**For more information visit the below document link:**

[\[ Reference Doc \]](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/jenkinsPipeline.md )

***
## Flow Diagram


***
## Pre-requisites

| Tool   | Description                          | 
|--------|--------------------------------------|
| OWASP ZAP (version: 2.14) | Tool required to perform DAST  | 
| Jenkins | CICD Tool                          |  
| JRE (Java runtime environment     | Zap is coded in Java, and its fundamental operations require a Java runtime environment for execution.    |

***
## Pipeline Setup

1. **Fork the Github Repo**
```shell
https://github.com/avengers-p7/Salary-API/tree/main
```
[**Repo Link**](https://github.com/OT-MICROSERVICES/salary-api)

2. **Build Pipeline**


<img width="1243" alt="Screenshot 2024-02-20 at 2 33 23 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/548c6ae8-bf02-4b68-8e4e-1061c094513c">


### HTML Report

* Click[**here**](file:///Users/vidhiyadav/Desktop/ZAP%20Report.html)

***
## Jenkinsfile
```shell
pipeline {
    agent any
    
    environment {
        TARGET_URL = 'https://github.com/OT-MICROSERVICES/employee-api.git'
    }
    
    stages {
        stage('Checkout') {
            steps {
                // Checkout your code repository
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/OT-MICROSERVICES/employee-api.git']])
            }
        }
        
        stage('Install ZAP') {
            steps {
                script {
                    // Download and install OWASP ZAP
                    sh 'wget https://github.com/zaproxy/zaproxy/releases/download/v2.14.0/ZAP_2.14.0_Linux.tar.gz'
                    sh 'tar -xvf ZAP_2.14.0_Linux.tar.gz'
                    
                }
            }
        }
        
        stage('Run ZAP Scan') {
            steps {
                script {
                    // Start ZAP and perform the scan
                    sh "/var/lib/jenkins/workspace/'Declarative Pipeline GoLang DAST'/ZAP_2.14.0/zap.sh -cmd -port 8090 -quickurl http://18.183.109.200:8080/api/v1/employee/health -quickprogress -quickout ~/out2.html"
                }
            }
        }
        
        stage('Publish ZAP Scan Report') {
            steps {
                // Publish HTML report
                publishHTML(target: [allowMissing: false, alwaysLinkToLastBuild: true, keepAll: true, reportDir: '/var/lib/jenkins/workspace/Declarative Pipeline GoLang DAST/ZAP_2.14.0/', reportFiles: 'out2.html', reportName: 'ZAP Scan Report', reportTitles: ''])
            }
        }
    }
    
    post {
        always {
            // Clean workspace
            cleanWs()
        }
    }
}

```

***
## Conclusion

Declarative Pipeline simplifies Jenkins pipeline configuration, offering clarity, readability, and integration with Markdown tables. It enhances collaboration, version control, and accessibility while enabling easy documentation and presentation of CI/CD processes.

***
## Contact Information

| Name | Email address |
| ---- | ------------- |
| Samir Kesare | samir.kesare.snaatak@mygurukulam.co |

***
## Resources and References

|  **Description** |   **Source** |
| ---------------- | ------------ |
| OWASP ZAP Integration | https://medium.com/globant/owasp-zap-integration-with-jenkins-795d65991404 |

