# Declarative Pipeline-Go Lang Code Compilation

|   Author        |  Created on   |  Version   | Last updated by  | Last edited on |
| --------------- | --------------| -----------|----------------- | -------------- |
| Khushi Malhotra |  07 Feb 2024  |  Version 1 | Khushi Malhotra  | 13 Feb 2024    |
***

# Table of Contents
- [Introduction](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GolangCI/CodeCompilation/DeclarativePipeline/README.md#introduction)
- [Pre-requisites](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GolangCI/CodeCompilation/DeclarativePipeline/README.md#pre-requisites)
- [Code-Compilation Setup](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GolangCI/CodeCompilation/DeclarativePipeline/README.md#code-compilation-setup)
- [Conclusion](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GolangCI/CodeCompilation/DeclarativePipeline/README.md#conclusion)
- [Contact Information](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GolangCI/CodeCompilation/DeclarativePipeline/README.md#contact-information)
- [Resources and References](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GolangCI/CodeCompilation/DeclarativePipeline/README.md#resources-and-references)

# Introduction
Building and deploying Go APIs can be streamlined through continuous integration and continuous delivery (CI/CD) pipelines. Declarative pipelines in Jenkins offer a robust and readable approach to automate Go code compilation. 
Declarative pipelines use Jenkins DSL, a Groovy-based domain-specific language, to define pipeline stages and steps in a more structured and human-readable format. This promotes maintainability and easier understanding of the build process.

# Pre-requisites
| Item         | Version   |
|--------------|-----------|
| Jenkins      | 2.426.3 |
| go plugin    | v1.22.0 |

# go plugin
![WhatsApp Image 2024-02-13 at 13 33 44_886b7a78](https://github.com/avengers-p7/Documentation/assets/156056460/55c954ee-4937-496d-bff9-6ca2df8cca38)
![WhatsApp Image 2024-02-13 at 13 30 55_1bbd4add](https://github.com/avengers-p7/Documentation/assets/156056460/bb5dce1a-3952-4ebd-a40b-8a41a45375dd)


# Code-Compilation Setup 
**Step-1** Create a New Pipeline Job

- Navigate to the Jenkins dashboard and click on New Item.
- Enter a name for your job (e.g., "Declarative pipeline-Golang-Code Compilation").
- Select Pipeline and click OK.

**Step-2** Configure Pipeline Script

- In the job configuration page, scroll down to the Pipeline section.
- Select Pipeline script from SCM.
- Give required repo url and enter your credentials.

![WhatsApp Image 2024-02-13 at 13 02 53_eb3d939c](https://github.com/avengers-p7/Documentation/assets/156056460/66906402-2f8d-46b3-a9e4-aabacfc84a2d)

**Step-3** Save the Configuration

- Click on Save to save the job configuration.

**Step-4** Build the Pipeline

- Once the pipeline configuration is saved, you can manually trigger the build by clicking on Build Now.

**Step-5** View Build Console Output

- After triggering the build, you can view the progress and console output of the build by clicking on the build number in the Jenkins dashboard.
- The console output will display the steps executed by the pipeline script, including code checkout and compilation.
- Verify Successful Compilation
![WhatsApp Image 2024-02-18 at 03 14 13_c846d813](https://github.com/avengers-p7/Documentation/assets/156056460/775da429-6535-4ac2-a6a2-d38a9ee75bc5)
![WhatsApp Image 2024-02-13 at 13 05 34_8cb5346a](https://github.com/avengers-p7/Documentation/assets/156056460/2e051239-c92f-4ef7-bd60-263a49263f94)
![image](https://github.com/avengers-p7/Documentation/assets/156056460/479f10ed-1800-4b0e-8189-c568d76e71a6)

[JenkinsFile](https://github.com/avengers-p7/Jenkinsfile/blob/main/Declarative%20Pipeline/golang_code-compilation/Jenkinsfile)

``` shell
pipeline {
    agent any

    tools {
        go 'go1.22.0'
    }

    stages {
         stage('Clean Workspace') {
            steps {
                cleanWs()
            }
        }
        stage('Checkout') {
            steps {
                git branch: 'main', credentialsId: 'khushi_cred', url: 'https://github.com/OT-MyGurukulam/employee-api.git'
            }
        }
        stage('Code Compilation') {
            steps {
                script {
                    sh 'go install'
                    sh "go list -f '{{.Target}}'"
                }
            }
        }
    }
}
```

# Conclusion
Declarative pipeline offers a simpler, more structured approach to defining Jenkins pipelines, making it ideal for teams looking to streamline their CI/CD processes and improve pipeline readability, maintainability, and scalability.

# Contact Information
| Name            | Email Address                        |
|-----------------|--------------------------------------|
| Khushi Malhotra | khushi.malhotra.snaatak@mygurukulam.co |

# Resources and References 
[JenkinsPipeline](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/jenkinsPipeline.md)

[Pipeline Creation](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/pipelinePOC.md)

[POC](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Design/05-%20GoLang%20CI%20Checks/Code_compilationPOC-go.md)

[Compile Code](https://go.dev/doc/tutorial/compile-install)

[Jenkins pipeline](https://www.jenkins.io/doc/book/pipeline/#:~:text=Scripted%20Pipeline%20syntax.-,Declarative%20Pipeline%20fundamentals,done%20throughout%20your%20entire%20Pipeline.&text=Execute%20this%20Pipeline%20or%20any,stages%2C%20on%20any%20available%20agent.&text=Defines%20the%20%22Build%22%20stage.&text=Perform%20some%20steps%20related%20to%20the%20%22Build%22%20stage.)
