# Scripted pipeline Go Lang Code Compilation

|   Author        |  Created on   |  Version   | Last updated by  | Last edited on |
| --------------- | --------------| -----------|----------------- | -------------- |
| Khushi Malhotra |  30 Jan 2024  |  Version 1 | Khushi Malhotra  | 13 Feb 2024    |
***
# Table of Content
- [Introduction](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GolangCI/CodeCompilation/Scripted%20Pipeline/README.md#introduction)
- [Pre-requisites](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GolangCI/CodeCompilation/Scripted%20Pipeline/README.md#pre-requisites)
- [go plugin](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GolangCI/CodeCompilation/Scripted%20Pipeline/README.md#go-plugin)
- [Contact Information](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GolangCI/CodeCompilation/Scripted%20Pipeline/README.md#contact-information)
- [Resources and References](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GolangCI/CodeCompilation/Scripted%20Pipeline/README.md#resources-and-references)

# Introduction
Scripted Pipelines are a powerful way to define and automate software delivery workflows in Jenkins. They offer more flexibility and customization compared to the simplified Declarative Pipelines. 

# Pre-requisites
| Item         | Version   |
|--------------|-----------|
| Jenkins      | 2.426.3 |
| go plugin    | v1.22.0 |

# go plugin
![WhatsApp Image 2024-02-13 at 13 33 44_886b7a78](https://github.com/avengers-p7/Documentation/assets/156056460/55c954ee-4937-496d-bff9-6ca2df8cca38)
![WhatsApp Image 2024-02-13 at 13 30 55_1bbd4add](https://github.com/avengers-p7/Documentation/assets/156056460/bb5dce1a-3952-4ebd-a40b-8a41a45375dd)


#Code Compilation Setup
**Step-1** Create a New Pipeline Job

- Navigate to the Jenkins dashboard and click on New Item.
- Enter a name for your job (e.g., "Declarative pipeline-Golang-Code Compilation").
- Select Pipeline and click OK.

**Step-2** Configure Pipeline Script

- In the job configuration page, scroll down to the Pipeline section.
- Select Pipeline script from SCM.
- Give required repo url and enter your credentials.

![image](https://github.com/avengers-p7/Documentation/assets/156056460/fd2ce394-cce7-44c0-bba0-5f27c6a45939)


**Step-3** Save the Configuration

- Click on Save to save the job configuration.

**Step-4** Build the Pipeline

- Once the pipeline configuration is saved, you can manually trigger the build by clicking on Build Now.

**Step-5** View Build Console Output

- After triggering the build, you can view the progress and console output of the build by clicking on the build number in the Jenkins dashboard.
- The console output will display the steps executed by the pipeline script, including code checkout and compilation.
- Verify Successful Compilation:

![image](https://github.com/avengers-p7/Documentation/assets/156056460/3a1f7144-5fcd-40d2-ad28-17e660d66ad0)
![image](https://github.com/avengers-p7/Documentation/assets/156056460/e8543a19-f042-46e3-ae78-a275de219f28)
![image](https://github.com/avengers-p7/Documentation/assets/156056460/9d506576-6151-4f79-9ee2-45b2034dac21)

[Jenkinsfile](https://github.com/avengers-p7/Jenkinsfile/blob/main/Scripted%20Pipeline/golang/code_compilation/Jenkinsfile)
```Shell
node {
    // Define the Go tool version
    def goHome = tool name: 'go1.22.0', type: 'go'

    stage('Checkout') {
        // Checkout the code from the Git repository
        git branch: 'main', credentialsId: 'khushi_cred', url: 'https://github.com/OT-MyGurukulam/employee-api.git'
    }
    
    stage('Code Compilation') {
        // Compile the Go code
        sh "${goHome}/bin/go build -o myapp main.go" // Replace 'main.go' with the main file of your Go API
    }
}
```

# Conclusion
In a scripted Jenkins pipeline, the code compilation process typically involves defining stages and steps within a Groovy script (Jenkinsfile) to compile your codebase. 

# Contact Information
| Name            | Email Address                        |
|-----------------|--------------------------------------|
| Khushi Malhotra | khushi.malhotra.snaatak@mygurukulam.co |

# Resources and References 
[JenkinsPipeline](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/jenkinsPipeline.md)

[Pipeline Creation](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/pipelinePOC.md)

[Compile](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Design/05-%20GoLang%20CI%20Checks/Code_compilationPOC-go.md)

[Jenkins pipeline](https://www.jenkins.io/doc/book/pipeline/#:~:text=Scripted%20Pipeline%20syntax.-,Declarative%20Pipeline%20fundamentals,done%20throughout%20your%20entire%20Pipeline.&text=Execute%20this%20Pipeline%20or%20any,stages%2C%20on%20any%20available%20agent.&text=Defines%20the%20%22Build%22%20stage.&text=Perform%20some%20steps%20related%20to%20the%20%22Build%22%20stage.)
