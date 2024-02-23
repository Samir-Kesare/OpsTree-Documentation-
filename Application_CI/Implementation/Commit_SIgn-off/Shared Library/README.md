# Commit Sign-off using Shared Library
|   Author        |  Created on   |  Version   | Last updated by  | Last edited on |
| --------------- | --------------| -----------|----------------- | -------------- |
| Khushi Malhotra |  13 Feb 2024  |  Version 1 | Khushi Malhotra  | 13 Feb 2024    |
***

# Table of Contents
- [Introduction](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/Commit_SIgn-off/Shared%20Library/README.md#introduction)
- [What is Shared Library](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/Commit_SIgn-off/Shared%20Library/README.md#what-is-shared-library)
- [Pre-requisites](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/Commit_SIgn-off/Shared%20Library/README.md#pre-requisites)
- [Flow Diagram](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/Commit_SIgn-off/Shared%20Library/README.md#flow-diagram)
- [Pipeline Setup](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/Commit_SIgn-off/Shared%20Library/README.md#pipeline-setup)
- [Pipeline](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/Commit_SIgn-off/Shared%20Library/README.md#pipeline)
- [GitCommit.groovy](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/Commit_SIgn-off/Shared%20Library/README.md#gitcommitgroovy)
- [CommitSignOffPipeline.groovy](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/Commit_SIgn-off/Shared%20Library/README.md#commitsignoffpipelinegroovy)
- [Contact Information](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/Commit_SIgn-off/Shared%20Library/README.md#contact-information)
- [Resources and References](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/Commit_SIgn-off/Shared%20Library/README.md#resources-and-references)


# Introduction 
In the context of version control systems like Git, a commit sign-off is a line added to the end of a commit message that serves several purposes:
1. Attribution: It identifies the author of the commit, typically including their name and email address.
2. Licensing: It indicates that the author agrees to the project's licensing terms. This is especially important for open-source projects, where contributions need to comply with the defined license.
3. Verification: Depending on the project's setup, the sign-off might also involve cryptographic signing using GPG (GnuPG), which digitally verifies the author's identity and ensures the integrity of the commit message.

# What is Shared Library 
A shared library is a collection of reusable Groovy scripts that you can share across multiple Jenkins jobs. 
It's like building modular components for your CI/CD pipelines, promoting efficiency and maintainability.
**For more information click** [here](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/sharedLibrary/README.md).
***

## Pre-requisites

| Tool | Description |
| ---- | ----------- |
| **Jenkins(2.426.3)** | To build our pipeline |

# Flow Diagram 
![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/15464e56-677c-4bc4-95e8-41765d23d6e9)

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

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/15895918-649d-49fd-9fd7-95148f060ac5)

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/b3933591-d583-4cee-a067-b8a6f2597a42)

**Step-3** Save the Configuration

- Click on Save to save the job configuration.

**Step-4** Build the Pipeline

- Once the pipeline configuration is saved, you can manually trigger the build by clicking on Build Now.

**Step-5** View Build Console Output

- After triggering the build, you can view the progress and console output of the build by clicking on the build number in the Jenkins dashboard.
- The console output will display the steps executed by the pipeline script, including code checkout and compilation.
- Verify Successful Compilation
![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/0378ba12-b37a-4ac3-9e99-2bf3b8430dbd)

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/eb806524-0453-4fdb-bfdc-9b3ee497505f)

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/d9b860f7-1988-4ff5-9fe9-ecdd9a236c9c)

# [Pipeline](https://github.com/CodeOps-Hub/Jenkinsfile/blob/main/SharedLibrary/Commit%20Sign-off/Jenkinsfile)

```shell
@Library('shared-library') _
def commitSignOffPipeline = new org.avengers.template.CommitSignOff.CommitSignOffPipeline()

node {
   
    commitSignOffPipeline.call()  
    
}
```

# [GitCommit.groovy](https://github.com/CodeOps-Hub/SharedLibrary/blob/main/src/org/avengers/CommitSignOff/GitCommit.groovy)
## [src/org/avengers/CommitSignOff](https://github.com/CodeOps-Hub/SharedLibrary/tree/main/src/org/avengers/CommitSignOff)

```shell
package org.avengers.CommitSignOff

def call() {
    stage('Fetch Last Commit') {
           checkout scm // This line will check out the source code from the configured Git repository
            script {
                def gitCommit = sh(script: 'git log -1 --pretty=%an', returnStdout: true).trim()
                def gitCommitMsg = sh(script: 'git log -1 --pretty=%B', returnStdout: true).trim()
                
                // Check if commit sign-off is present
                if (gitCommitMsg.contains('Signed-off-by:')) {
                    echo "Last commit by ${gitCommit} has a sign-off."
                } else {
                    // Check if there are changes to commit
                    try {
                       // sh 'ls -al'
                        sh 'git diff --exit-code'
                        // No exception means there are no changes
                        echo "No changes to commit."
                        echo "${gitCommitMsg}"
                        echo "${gitCommit}"
                        // Exception indicates there are changes
                        // Add and commit changes
                       // sh 'git add .'
                        //sh "git commit -m 'Auto-commit before sign-off'"
                        
                        // Iterate through usernames and find matching email and name
                       // echo "hello if 1"
                        def usernameEmailMap = [
                            'vikram445': 'vikram.bisht@opstree.com',
                            'aakashtripathi-snaatak': 'aakash.tripathi.snaatak@mygurukulam.co',
                            'vyadavP7': 'vidhi.yadhav.snaatak@mygurukulam.co',
                            'code-shantanu': 'shantanu.chauhan.snaatak@mygurukulam.co',
                            'Vishalkk1998': 'vishal.kesarwani.snaatak@mygurukulam.co',
                            'Panu-S-Harshit-Ninja-07': 'harshit.singh.snaatak@mygurukulam.co',
                            'Khushi Malhotra': 'khushi.malhotra.snaatak@mygurukulam.co',
                            'Snatak-SamirKesare': 'samir.kesare.snaatak@mygurukulam.co',
                            'Parasharam-Desai': 'parasharam.desai.snaatak@mygurukulam.co',
                            'tripathishikha1': 'shikha.tripathi.snaatak@mygurukulam.co',
                            'shreya-snaatak': 'shreya.jaiswal.snaatak@mygurukulam.co',
                            'Nidhi-bhardwaj123': 'nidhi.bhardwaj.snaatak@mygurukulam.co'
                
                        ]   
                        def email = usernameEmailMap[gitCommit] 
                        //echo "hello if 2"
                        echo "${email}"
                        if (email) {
                            def newCommitMsg = "${gitCommitMsg}\nSigned-off-by: ${email}"
                            //echo "hello if 3"
                            sh "git commit --amend --signoff -m '${newCommitMsg}'"
                            echo "New commit message updated with sign-off by ${gitCommit}."
                        } else {
                            error "Unable to find email for ${gitCommit}."
                        }
                    }
                catch (Exception e) {
                    echo "ERROR"
                }
            }
        }
    }
}
```
# [CommitSignOffPipeline.groovy](https://github.com/CodeOps-Hub/SharedLibrary/blob/main/src/org/avengers/template/CommitSignOff/CommitSignOffPipeline.groovy)

## [src/org/avengers/template/CommitSignOff](https://github.com/CodeOps-Hub/SharedLibrary/tree/main/src/org/avengers/template/CommitSignOff)

```shell
package org.avengers.template.CommitSignOff

import org.avengers.CommitSignOff.*

def call(){
    gitCommit = new GitCommit()
   

    gitCommit.call()
   
}
```


# Contact Information
| Name            | Email Address                        |
|-----------------|--------------------------------------|
| Khushi Malhotra | khushi.malhotra.snaatak@mygurukulam.co |


# Resources and References
| Description                                   | References                                       |
| --------------------------------------------  | -------------------------------------------------|
| Commit Sign-off | https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Design/02-%20Generic%20CI%20operation/CommitSignOff.md |
| Shared Library (Generic Doc) | https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GenericDoc/jenkinsPipeline.md |
| Create Pipeline (Generic Doc)| https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GenericDoc/pipelinePOC.md |
| Pipeine Syntax | https://www.jenkins.io/doc/book/pipeline/#pipeline-syntax-overview |
| Pipeline Concepts | https://www.jenkins.io/doc/book/pipeline/#pipeline-concepts |
| Shared Library | https://www.jenkins.io/doc/book/pipeline/shared-libraries/ |
| What is shared Library | https://keentolearn.medium.com/how-to-improve-your-jenkins-builds-with-shared-libraries-5e225b7435fb#:~:text=A%20shared%20library%20in%20Jenkins,efficient%20and%20easier%20to%20maintain. |
