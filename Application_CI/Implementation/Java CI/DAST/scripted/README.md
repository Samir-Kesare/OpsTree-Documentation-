# Scripted Pipeline Java DAST

<img width="668" alt="Screenshot 2024-02-20 at 5 00 24 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/ca064fee-9fda-46b9-8073-9b3a4b87ad81">


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
## Scripted Pipeline

Scripted Pipeline uses a Groovy-based scripting syntax, where you write code directly using Groovy scripting language. It offers maximum flexibility and power to define complex pipelines using imperative programming constructs like loops, conditionals etc. This helps in providing fine-grained control over the flow of execution. 

**For more information visit the below document link:**

[\[ Reference Doc \]](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GenericDoc/jenkinsPipeline.md)

***
## Flow Diagram

![Screenshot 2024-02-20 at 6 22 49 PM](https://github.com/CodeOps-Hub/Documentation/assets/156056349/8a77d270-e5d3-4620-b48d-0268359b27d8)

<img width="692" alt="Screenshot 2024-02-20 at 5 11 50 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/910e9f0f-5be1-4eb1-972c-21d15a140df0">

***
## Pre-requisites

| Tool   | Description                          | 
|--------|--------------------------------------|
| OWASP ZAP (version: 2.14) | Tool required to perform DAST  | 
| Jenkins | CICD Tool                          |  
| JRE (Java runtime environment     | Zap is coded in Java, and its fundamental operations require a Java runtime environment for execution.    |

***
## Pipeline Setup

1. **Configure Jenkins Job**

<img width="916" alt="Screenshot 2024-02-20 at 5 02 54 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/99a6b362-6fb3-427b-9023-07992bd48d08">

2. **Build Pipeline**

<img width="1090" alt="Screenshot 2024-02-20 at 6 51 34 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/0d9eb3b2-a654-42ce-87cf-a8d04160697d">

***
## Console Output
* Resultant output for ZAP attack

<img width="967" alt="Screenshot 2024-02-20 at 9 42 39 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/87055c47-ccbb-4d3f-ada4-676509f0c48c">

* HTML file reports generated as `result.html`

<img width="838" alt="Screenshot 2024-02-20 at 9 41 14 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/e805e52f-95a6-4a8b-8fd0-99e25d816e00">

* HTML Report can be found [**here**](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/Java%20CI/DAST/declarative/ZAP%20Report.html)

<img width="1160" alt="Screenshot 2024-02-20 at 5 01 40 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/1948e7bc-46ad-4012-a4ce-4f003d111b67">

***
## [Jenkinsfile](https://github.com/CodeOps-Hub/Jenkinsfile/blob/main/Scripted%20Pipeline/Java/DAST/Jenkinsfile)
```shell
node {
    def CURRENT_WORKSPACE

    stage('Clone Repository') {
        git branch: 'main', url: 'https://github.com/CodeOps-Hub/Salary-API.git'
    }

    stage('Install ZAP') {
        sh 'wget https://github.com/zaproxy/zaproxy/releases/download/v2.14.0/ZAP_2.14.0_Linux.tar.gz'
        sh 'tar -xf ZAP_2.14.0_Linux.tar.gz'
    }

    stage('Run Zap Scan') {
        CURRENT_WORKSPACE = env.WORKSPACE
        sh "${CURRENT_WORKSPACE}/ZAP_2.14.0/zap.sh -cmd -port 8082 -quickurl http://174.129.170.198:8080/swagger-ui/index.html -quickout ${CURRENT_WORKSPACE}/results.html"
    }

    stage('Archive reports') {
        archiveArtifacts artifacts: '**/results.html'
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

| Name | Email address |
| ---- | ------------- |
| Vidhi Yadav | vidhi.yadhav.snaatak@mygurukulam.co |

***
## Resources and References

|  **Description** |   **Source** |
| ---------------- | ------------ |
| OWASP ZAP  | https://medium.com/globant/owasp-zap-integration-with-jenkins-795d65991404 |
| ZAP Official Documentation | https://www.zaproxy.org/ |
