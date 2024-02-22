# Declarative Pipeline for Python DAST
| Author | Created On | Last Updated | Document Version | Last Updated By |
| ------ | ---------- | ------------ | ---------------- | --------------- |
| Shantanu | 10-02-2024 | 19-02-2024   |         v1     |     Shantanu    |
***

# Table of Content
+ [Introduction](#Introduction)
+ [Why Declarative Pipeline?](#Why-Declarative-Pipeline)
+ [Flow Diagram](#Flow-Diagram)
+ [Pre-requisites](#Pre-requisites)
+ [Setup](#Setup)
+ [Jenkinsfile](#Jenkinsfile)
+ [Conclusion](#Conclusion)
+ [Contact Information](#Contact-Information)
+ [Resources and References](#Resources-and-References)
***

# Introduction
The Declarative Pipeline provides a simplified method for delineating Jenkins pipelines by utilizing a structured syntax enclosed within a pipeline {} block. It emphasizes simplicity, readability, and incorporates built-in directives for the definition of stages, steps, and additional elements. This approach seamlessly integrates with the Jenkins UI, facilitates pipeline visualization, and accommodates pipeline templates to promote code reusability. It is particularly suitable for teams seeking an uncomplicated approach to configuring CI/CD pipelines. Cilck [**here**](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/jenkinsPipeline.md) for detailed understanding on Jenkins pipeline.

***

# Why Declarative Pipeline?

| Feature                      | Description                                                                                       |
| ---------------------------- | ------------------------------------------------------------------------------------------------- |
| **Streamlined Syntax**       | Utilizes a structured syntax within a `pipeline {}` block, simplifying pipeline definition.       |
| **Readability**              | Emphasizes clarity and ease of understanding, making pipelines easier to comprehend.            |
| **Built-in Directives**      | Offers pre-defined directives for defining stages, steps, and other pipeline elements.           |
| **Integration with Jenkins UI** | Seamlessly integrates with the Jenkins user interface for intuitive pipeline management.      |
| **Pipeline Visualization**   | Provides visual representation of pipeline stages and steps for easier monitoring and debugging. |
| **Support for Pipeline Templates** | Facilitates code reuse by supporting the use of pipeline templates across multiple projects.   |
| **Simplified CI/CD Configuration** | Ideal for teams seeking a straightforward approach to configuring CI/CD pipelines.               |

***

# Flow Diagram

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056364/11f2441f-3b0d-4aa8-abff-e0e45ca75e1d)
***

# Pre-requisites
| Tool   | Description                          | 
|--------|--------------------------------------|
| OWASP ZAP | A tool for bug analysis in Python | 
| Jenkins | CICD Tool                          |  
***

# Setup

### Configure Pipeline Script:

* Upon saving the pipeline configuration, you have the option to manually initiate the build by selecting the "Build Now" button.

* Following the initiation of the build, you can monitor the ongoing progress and examine the console output by clicking on the corresponding build number on the Jenkins dashboard.
* The console output will showcase the executed steps of the pipeline script, encompassing tasks such as code checkout and compilation.

    ![Screenshot 2024-02-19 at 10 51 29 PM](https://github.com/CodeOps-Hub/Documentation/assets/156056364/62b2b6f0-aab4-43a4-aecc-401eaf91ff97)

### Build the Pipeline and View Build Console Output:
* Once the pipeline configuration is saved, you can manually trigger the build by clicking on Build Now.
* After triggering the build, you can view the progress and console output of the build by clicking on the build number in the Jenkins dashboard.
* The console output will display the steps executed by the pipeline script, including code checkout and compilation.

![Screenshot 2024-02-22 at 5 38 36 PM](https://github.com/CodeOps-Hub/Documentation/assets/156056364/9bcf3d1b-9fb3-4c33-93d3-464136dd2f86)

# Report
Click [here](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/Python%20CI/DAST/DeclarativePipeline/out2.html)
![Screenshot 2024-02-22 at 5 40 27 PM](https://github.com/CodeOps-Hub/Documentation/assets/156056364/807d9ba1-6630-4993-b95d-bf9f20e1c5a0)
***

# Jenkinsfile

```
pipeline {
    agent any
    
    environment {
        TARGET_URL = 'https://github.com/CodeOps-Hub/Attendance-API.git'
    }
    
    stages {
        stage('Checkout') {
            steps {
                // Checkout your code repository
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/CodeOps-Hub/Attendance-API.git']])
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
                    sh "/var/lib/jenkins/workspace/DAST_declarative/ZAP_2.14.0/zap.sh -cmd -port 8090 -quickurl http://54.179.71.71:8080/api/v1/attendance/health -quickprogress -quickout ~/out2.html"
                }
            }
        }
        
        stage('Publish ZAP Scan Report') {
            steps {
                // Publish HTML report
                publishHTML(target: [allowMissing: false, alwaysLinkToLastBuild: true, keepAll: true, reportDir: 'var/lib/jenkins/workspace/DAST_declarative/ZAP_2.14.0/', reportFiles: 'out2.html', reportName: 'ZAP Scan Report', reportTitles: ''])
            }
        }
    }
}
```

***


# Conclusion
Declarative Pipeline simplifies Jenkins pipeline configuration, offering clarity, readability, and integration with Markdown tables. It enhances collaboration, version control, and accessibility while enabling easy documentation and presentation of CI/CD processes.
***
# Contact Information
| Name | Email Address |
| ---- | ------------- |
| Shantanu  | shantanu.chauhan.snaatak@mygurukulam.co |
***
# References
| Source | Description  | 
| -------- | ------- |
| https://medium.com/globant/owasp-zap-integration-with-jenkins-795d65991404 | OWASP ZAP Integration with jenkins |
