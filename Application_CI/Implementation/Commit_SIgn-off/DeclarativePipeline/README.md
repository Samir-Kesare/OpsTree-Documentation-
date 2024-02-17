# Declarative Pipeline Commit Sign-off

|   Author        |  Created on   |  Version   | Last updated by  | Last edited on |
| --------------- | --------------| -----------|----------------- | -------------- |
| Khushi Malhotra |  13 Feb 2024  |  Version 1 | Khushi Malhotra  | 13 Feb 2024    |
***

# Table of Contents
- [Introduction](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/Commit_SIgn-off/DeclarativePipeline/README.md#introduction)
- [What is Commit Sign-Off](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/Commit_SIgn-off/DeclarativePipeline/README.md#what-is-commit-sign-off)
- [Why](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/Commit_SIgn-off/DeclarativePipeline/README.md#why)
- [Pre-requisites](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/Commit_SIgn-off/DeclarativePipeline/README.md#pre-requisites)
- [Commit Sign-off Setup](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/Commit_SIgn-off/DeclarativePipeline/README.md#commit-sign-off-setup)
- [Conclusion](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/Commit_SIgn-off/DeclarativePipeline/README.md#conclusion)
- [Contact Information](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/Commit_SIgn-off/DeclarativePipeline/README.md#contact-information)
- [Resources and References](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/Commit_SIgn-off/DeclarativePipeline/README.md#resources-and-references)

# Introduction
Declarative Pipelines refers to a way of defining automated workflows (pipelines) using code that describes the desired state of the system, rather than specific instructions on how to achieve it.
In software development, a commit represents a snapshot of changes made to code files in a version control system like Git. This usually refers to a process where a developer indicates they have reviewed and approved the changes in a commit.

# What is Commit Sign-Off
A commit sign-off is a line added to the end of a commit message in a version control system, like Git, to indicate that the contributor:

- Takes responsibility for the changes introduced in the commit. This means they confirm that they authored the code, have the necessary permissions to contribute it, and it adheres to the project's guidelines and coding style.
- Agrees to the project's licensing terms. By signing off, the contributor confirms that they have the right to license the code under the project's chosen license.

# Why 
The purpose of a Signed-off-by trailer in Git is:-
- Improved accountability: Sign-offs make it clear who is responsible for each change in the codebase, which can be helpful for debugging and tracking down issues.
- Encourages code ownership: By requiring sign-offs, projects can encourage contributors to take ownership of their code and ensure that it meets the project's standards.


# Pre-requisites
| Item         | Version   |
|--------------|-----------|
| Jenkins      | 2.426.3   |

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/d9febe6e-5c07-4a8c-85c3-ebc47c5803db)

# Commit Sign-off Setup

![image](https://github.com/avengers-p7/Documentation/assets/156056460/41bfd967-03e5-4379-a05c-be1439a1ce6e)

**Step-1** Create a New Pipeline Job

- Navigate to the Jenkins dashboard and click on New Item.
- Enter a name for your job (e.g., "Declarative Pipeline Commit Sign-off").
- Select Pipeline and click OK.

**Step-2** Configure Pipeline Script

- In the job configuration page, scroll down to the Pipeline section.
- Select Pipeline script from SCM.
- Give required repo url and enter your credentials.

![WhatsApp Image 2024-02-13 at 14 46 01_5dabb58d](https://github.com/avengers-p7/Documentation/assets/156056460/042d872f-31bb-4c0e-bb0f-27bb1929cf11)

**Step-3** Save the Configuration

- Click on Save to save the job configuration.

**Step-4** Build the Pipeline

- Once the pipeline configuration is saved, you can manually trigger the build by clicking on Build Now.

**Step-5** View Build Console Output

- After triggering the build, you can view the progress and console output of the build by clicking on the build number in the Jenkins dashboard.
- The console output will display the steps executed by the pipeline script, including code checkout and compilation.
- Verify Successful Compilation

![WhatsApp Image 2024-02-13 at 18 02 48_294d08e5](https://github.com/avengers-p7/Documentation/assets/156056460/79734075-b70b-4749-8429-a85045ca9086)
![WhatsApp Image 2024-02-13 at 14 47 44_f8ed731b](https://github.com/avengers-p7/Documentation/assets/156056460/28443aa1-2efc-4ed6-8326-61aa058b4560)
![image](https://github.com/avengers-p7/Documentation/assets/156056460/87119667-a076-453f-9675-6ea72c9b2ed4)
![WhatsApp Image 2024-02-13 at 18 01 14_744b2f9c](https://github.com/avengers-p7/Documentation/assets/156056460/1567b4a8-6942-480b-9884-5ff0d5e0f6e0)

[Jenkinsfile](https://github.com/avengers-p7/Jenkinsfile/blob/main/Declarative%20Pipeline/Commit%20Sign-off/Jenkinsfile)

```shell
pipeline {
    agent any
    
    stages {
        stage('Fetch Last Commit') {
            steps {
                script {
                    def gitCommit = sh(script: 'git log -1 --pretty=%an', returnStdout: true).trim()
                    def gitCommitMsg = sh(script: 'git log -1 --pretty=%B', returnStdout: true).trim()
                    
                    // Check if commit sign-off is present
                    if (gitCommitMsg.contains('Signed-off-by:')) {
                        echo "Last commit by ${gitCommit} has a sign-off."
                    } else {
                        // Iterate through usernames and find matching email and name
                        def usernameEmailMap = [
                            'vikram445': 'vikram.bisht@opstree.com',
                            'aakashtripathi-snaatak': 'aakash.tripathi.snaatak@mygurukulam.co',
                            'vyadavP7': 'vidhi.yadhav.snaatak@mygurukulam.co',
                            'code-shantanu': 'shantanu.chauhan.snaatak@mygurukulam.co',
                            'Vishalkk1998': 'vishal.kesarwani.snaatak@mygurukulam.co',
                            'Panu-S-Harshit-Ninja-07': 'harshit.singh.snaatak@mygurukulam.co',
                            'khushimalhoz': 'khushi.malhotra.snaatak@mygurukulam.co',
                            'Snatak-SamirKesare': 'samir.kesare.snaatak@mygurukulam.co',
                            'Parasharam-Desai': 'parasharam.desai.snaatak@mygurukulam.co',
                            'tripathishikha1': 'shikha.tripathi.snaatak@mygurukulam.co',
                            'shreya-snaatak': 'shikha.tripathi.snaatak@mygurukulam.co',
                            'Nidhi-bhardwaj123': 'nidhi.bhardwaj.snaatak@mygurukulam.co'
                        ]
                        
                        def email = usernameEmailMap[gitCommit]
                        
                        if (email) {
                            sh "git commit --amend --signoff --author='${gitCommit} <${email}>' -m '${gitCommitMsg} Signed-off-by: ${email}'"
                            echo "Commit message updated with sign-off by ${gitCommit}."
                        } else {
                            error "Unable to find email for ${gitCommit}."
                        }
                    }
                }
            }
        }
    }
}
```
# Conclusion
This pipeline script clones the Jenkinsfile from the Git repository, configures Git to sign commits, makes changes to the code, commits the changes with a sign-off line, and pushes the changes to the remote repository.

# Contact Information
| Name            | Email Address                        |
|-----------------|--------------------------------------|
| Khushi Malhotra | khushi.malhotra.snaatak@mygurukulam.co |

# Resources and References 
[JenkinsPipeline](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/jenkinsPipeline.md)

[Pipeline Creation](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/pipelinePOC.md)

[Commit Sign-off](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Design/02-%20Generic%20CI%20operation/CommitSignOff.md)

