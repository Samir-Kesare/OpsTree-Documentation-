# Declarative Pipeline Java DAST

![download](https://github.com/avengers-p7/Documentation/assets/156056570/a292f2dd-4795-4566-bfb6-014b634f76bf)



|   Author        |  Created on   |  Version   | Last updated by  | Last edited on |
| --------------- | --------------| -----------|----------------- | -------------- |
| Vidhi Yadav |  20th February 2024  |  Version 1 | Vidhi Yadav | 20th Feb 2024    |

***
## Table of Contents
+ [Introduction](#Introduction)
+ [Why Declarative Pipeline](#Why-Declarative-Pipeline)
+ [Flow Diagram](#Flow-Diagram)
+ [Pre-requisites](#Pre-requisites)
+ [Setup](#Setup)
+ [Jenkinsfile](#Jenkinsfile)
+ [Conclusion](#Conclusion)
+ [Contact Information](#Contact-Information)
+ [Resources and References](#Resources-and-References)
  
***
## Introduction

Declarative Pipeline is a streamlined way to define Jenkins pipelines using a structured syntax within a pipeline {} block. It offers simplicity, readability, and built-in directives for defining stages, steps, and more. It integrates well with the Jenkins UI, provides pipeline visualization, and supports pipeline templates for code reuse. It's ideal for teams looking for a straightforward approach to CI/CD pipeline configuration. Cilck [**here**](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/jenkinsPipeline.md)

***
## Why Declarative Pipeline
| Aspect          | Description                                                                                               |
|-----------------|-----------------------------------------------------------------------------------------------------------|
| **Organization**    | Markdown tables organize pipeline stages, descriptions, and commands into neat columns for easier readability and understanding. |
| **Readability**     | Condenses verbose Declarative Pipeline syntax, particularly beneficial for complex pipelines, enhancing readability and comprehension. |
| **Documentation**   | Integrates pipeline configuration seamlessly into project documentation using Markdown, providing a comprehensive overview of CI/CD processes. |
| **Version Control** | Markdown files are version-controlled with tools like Git, enabling tracking of pipeline changes, revision history, and collaboration. |
| **Accessibility**   | Markdown files are viewable and editable with basic text editors or online Markdown editors, facilitating review and contribution by team members, including non-technical stakeholders. |
| **Presentation**    | Markdown files can be rendered into multiple formats, including HTML, PDF, and slideshows, enabling formatted documents or presentations for sharing and presentation purposes. |

***
## Flow Diagram

![Screenshot 2024-02-13 230840](https://github.com/avengers-p7/Documentation/assets/156056570/ada5121d-79a9-4aa7-bafa-fc6c0ec0ddc9)

![image](https://github.com/avengers-p7/Documentation/assets/156056570/e7037d9f-dbbd-403d-90ff-cd870b1a3391)

***
## Pre-requisites

| Tool   | Description                          | 
|--------|--------------------------------------|
| OWASP ZAP | A tool for bug analysis in Python | 
| Jenkins | CICD Tool                          |  
| JAVA    |                                    |
***
## Setup

### Configure Pipeline Script:

* In the job configuration page, scroll down to the Pipeline section.
* Select Pipeline script from SCM.
* Give required repo url and enter your credentials.

![image](https://github.com/avengers-p7/Documentation/assets/156056570/2cf29533-0104-4cc1-bcfb-68228f9037fa)


### Build the Pipeline and View Build Console Output:

* Once the pipeline configuration is saved, you can manually trigger the build by clicking on Build Now.
* After triggering the build, you can view the progress and console output of the build by clicking on the build number in the Jenkins dashboard.
* The console output will display the steps executed by the pipeline script, including code checkout and compilation.

![Screenshot 2024-02-13 230752](https://github.com/avengers-p7/Documentation/assets/156056570/efcd108d-7143-4d78-a04f-0165fd3d8780)

![Screenshot 2024-02-13 230820](https://github.com/avengers-p7/Documentation/assets/156056570/894ad8f2-48df-4e2b-ad31-3e2b39777cd3)

![image](https://github.com/avengers-p7/Documentation/assets/156056570/c1c3c11f-bbb7-4b55-aef9-61a0ca071a72)




### HTML Report

* Click[**here**](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GolangCI/Declarative%20Pipeline%20GoLang%20DAST/Declarative%20Pipeline/HTML%20Report)

![Screenshot 2024-02-13 230445](https://github.com/avengers-p7/Documentation/assets/156056570/2414b727-8df0-454f-8bb6-eec702cf02c8)

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

