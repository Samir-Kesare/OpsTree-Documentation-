# Dependency Scanning (Java)

|   Authors        |  Created on   |  Version   | Last updated by | Last edited on |
| -----------------| --------------| -----------|---------------- | -------------- |
| Vidhi Yadav      | 25 Jan 2024   |     v1     | Vidhi Yadav     | 29 Jan 2024    |

***
## Table of Contents 
+ [Introduction](#Introduction)
+ [Key Components](#key-points)
+ [Popular Tools](#popular-tools)
+ [Tool Comparison](#tool-comparison)
+ [Why Choose OWASP?](#why-choose-owasp)
+ [Guide to Installation](#Installing-OWASP-Dependency-Check)
+ [Best Practices](#best-practices)
+ [Security Compliance](#security-compliance)
+ [Contact Information](#contact-information)
+ [References](#references)

***
## Introduction

* Dependency scanning is a process used in software development to identify and analyze the external dependencies or third-party components that a project relies on. These dependencies can include libraries, frameworks, modules, packages, or other code modules that are utilized to build and run the software. 

* The scanning process is typically automated and integrated into the development workflow, often as part of continuous integration or continuous delivery (CI/CD) pipelines. It serves as a crucial pre-build process examines the project's dependencies to identify any known vulnerabilities, outdated versions, or security issues.

*** 
## Key Points

* **Automated Security Checks** - Dependency check facilitates the automated detection of vulnerabilities within project dependencies, seamlessly integrating this crucial security check into CI/CD pipelines.
  
* **Efficiency and Accuracy** - It reduces the need for manual effort, significantly improving accuracy and efficiency compared to traditional manual checks.
  
* **Awareness and Reporting** - Developers gain awareness of potential vulnerabilities through reports at an early stage, providing insights into the identified issues and their respective severity levels.

***
## Popular Tools

Explore a variety of widely used tools for scanning dependencies and enhancing the security of your projects. These tools can be integrated into Jenkins or used independently, providing diverse options for identifying and addressing vulnerabilities:

| Tool                  | Description                                                                                                    |
|---------------------------|----------------------------------------------------------------------------------------------------------------|
| [OWASP Dependency-Check](https://jeremylong.github.io/DependencyCheck/) | OWASP Dependency-Check is a mature and widely adopted tool that identifies project dependencies and checks if there are any known, publicly disclosed vulnerabilities.    |
| [Synk](https://snyk.io/)  | Synk is a comprehensive security platform that helps developers find and fix vulnerabilities in open-source libraries. It provides insights into dependencies, container images, and infrastructure as code. |
| [Retire.js](https://retirejs.github.io/retire.js/) | Retire.js is a tool for detecting vulnerable JavaScript libraries. It can be used as a command-line tool or integrated into various build tools. |

***
## Tool Comparison 
| Feature / Tool              | OWASP Dependency-Check | Synk                     | Retire.js                |
|-----------------------------|------------------------|--------------------------|--------------------------|
| **Supported Languages**     | Java, .NET, Node.js, Ruby, Python, and more | Java, JVM-based languages | JavaScript (Node.js)     |
| **Integration with CI/CD**  | Yes                    | Yes                      | Yes                      |
| **Build Tool Integration**   | Maven, Gradle, Ant, and more | Maven, Gradle, Jenkinsfile | Manual (Command-line)    |
| **Vulnerability Database**  | Combined public and private databases | Proprietary vulnerability database | Retire.js vulnerability database |
| **Reporting Formats**        | HTML, XML, JSON, CSV    | HTML, JSON, and more     | JSON, CSV, HTML          |
| **Active Community**        | Yes                    | Yes                      | Yes                      |
| **License Compliance**      | Yes                    | Yes                      | No                       |
| **Container Scanning**      | Yes                    | Yes                      | No                       |
| **False Positive Handling** | Suppression mechanism   | Manual confirmation     | Manual confirmation     |
| **Pricing Model**           | Open Source            | Freemium model with paid plans | Open Source              |

***
## Why Choose OWASP

OWASP Dependency-Check stands out as a robust and widely adopted tool for identifying vulnerabilities in project dependencies. Here are key reasons to consider using OWASP Dependency-Check in your CI/CD pipeline:

| #   | Key Feature                                        | Description                                                                                                                |
| --- | -------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------- |
| 1   | Identification of Vulnerabilities                 | OWASP Dependency-Check utilizes a combination of public and private vulnerability databases to identify known vulnerabilities in project dependencies, ensuring a thorough security assessment. |
| 2   | Integration with Build Tools                     | It seamlessly integrates into the project's build process, enabling developers to effortlessly incorporate regular vulnerability checks as part of their development workflow. It offers compatibility with popular build tools like Maven, Gradle, Ant, and others. |
| 3   | Versatile Language and Ecosystem Support         | With support for multiple programming languages and ecosystems including Java, .NET, Node.js, Ruby, Python, and more, OWASP Dependency-Check proves to be versatile and adaptable, catering to a diverse range of projects. |
| 4   | Flexible Report Generation                        | The tool provides flexibility in report generation, offering outputs in various formats such as HTML, XML, JSON, and CSV. These detailed reports empower developers and security teams with comprehensive information about identified vulnerabilities, facilitating prompt and informed decision-making. |
| 5   | Active and Collaborative Community               | OWASP thrives on an active and collaborative community. This community-driven approach ensures continuous updates, improvements, and the introduction of new features, enhancing the tool's effectiveness and relevance. |
| 6   | Integration with Security Tools                   | It can be seamlessly combined with other security tools to deliver a holistic security analysis of a project. This collaborative approach enhances the overall security posture and provides a more comprehensive understanding of potential risks. |

  
***
## Proof of Concept (POC) for Dependency-Check:

 * It is highly recommended to gain hands-on experience through our detailed Proof of Concept (POC) guide for [Dependency-Check](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Design/03-%20Java%20CI%20checks/Dependency%20Scanning%20POC/README.md). This comprehensive document walks you through a practical demonstration, providing step-by-step instructions on setting up Dependency-Check for a sample project. The POC guide delves into essential concepts into identifying vulnerabilities within project dependencies.


***
## Best Practices

1. **Regular Scanning Frequency** - Regular scanning of project dependencies is essential for maintaining a secure development environment. Conduct dependency scans at key points in the development lifecycle, such as during the build process, before major releases, and after significant changes.
   
2. **Integration with Other Security Tools** - Enhance the effectiveness of your security strategy by integrating OWASP Dependency-Check with other security tools. This synergistic approach provides a more comprehensive security analysis. (eg, DAST , Container security )
   
3. **Handling False Positives** - False positives in dependency scanning results can occasionally occur. Here's how to handle them effectively. Leverage Dependency-Check's suppression mechanism to manage false positives, ensuring accurate reporting and engage with the Dependency-Check community to share and verify findings, improving the accuracy of future scans.

***
## Security and Compliance

1. **Security Measures**  - Set appropriate vulnerability thresholds to trigger alerts or fail the build based on severity levels.
  
2. **Compliance Standards** - Identify and understand compliance standards relevant to your industry and project.
   
3. **Continuous Monitoring** - Implement tools and processes for automated monitoring of dependencies to ensure ongoing compliance. You may also conduct periodic audits to review and validate compliance measures, making adjustments as necessary.

***
## Contact Information

|Vidhi Yadav                     | vidhi.yadhav.snaatak@mygurukulam.co                                                                                      
|---------------------------------|------------------------------------------------------------|

***
## References

| Title                                      | URL                                           |
|--------------------------------------------|-----------------------------------------------|
| Dependency-Check User Guide           | https://jeremylong.github.io/DependencyCheck/    |
| OWASP Dependency-Check GitHub Repository    | https://github.com/jeremylong/DependencyCheck  |
| OWASP Dependency-Check benefits                 | https://medium.com/@sudheer.barakers/integrate-owasp-dependency-check-in-jenkins-pipeline-748d8aefc2b7 |
| Installation                                 | https://www.youtube.com/watch?v=bImOWD4b6o8 |




