# Scripted Pipeline Commit Sign-off

|   Author        |  Created on   |  Version   | Last updated by  | Last edited on |
| --------------- | --------------| -----------|----------------- | -------------- |
| Khushi Malhotra |  13 Feb 2024  |  Version 1 | Khushi Malhotra  | 13 Feb 2024    |
***
# Table of Contents
- [Introduction](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/Commit_SIgn-off/ScriptedPipeline/README.md#introduction)
- [Pre-requisites](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/Commit_SIgn-off/ScriptedPipeline/README.md#pre-requisites)
- [Commit Sign-off Setup](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/Commit_SIgn-off/ScriptedPipeline/README.md#commit-sign-off-setup)
- [Contact Information](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/Commit_SIgn-off/ScriptedPipeline/README.md#contact-information)
- [Conclusion](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/Commit_SIgn-off/ScriptedPipeline/README.md#conclusion)
- [Resources and References](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/Commit_SIgn-off/ScriptedPipeline/README.md#resources-and-references)

# Introduction
A commit sign-off, often referred to as a "Developer's Certificate of Origin" or "DCO", is a declaration made by a developer to certify that they have the right to contribute the code they are submitting. 
In a Jenkins scripted pipeline, enforcing commit sign-off means that before allowing a build or deployment to proceed, the pipeline checks whether each commit in the repository has the appropriate sign-off. 

# Pre-requisites
| Item         | Version   |
|--------------|-----------|
| Jenkins      | 2.426.3   |


# Commit Sign-off Setup

![image](https://github.com/avengers-p7/Documentation/assets/156056460/82178e3b-9ce1-416e-8d66-dc22dca169c8)

**Step-1** Create a New Pipeline Job

- Navigate to the Jenkins dashboard and click on New Item.
- Enter a name for your job (e.g., "Declarative Pipeline-Commit SIgn-off").
- Select Pipeline and click OK.

**Step-2** Configure Pipeline Script

- In the job configuration page, scroll down to the Pipeline section.
- Select Pipeline script from SCM.
- Give required repo url and enter your credentials.
![WhatsApp Image 2024-02-18 at 10 29 26_e709c060](https://github.com/avengers-p7/Documentation/assets/156056460/575dbebd-9363-4622-ba00-c0ba7978891a)
![WhatsApp Image 2024-02-13 at 21 09 53_f8eb0af4](https://github.com/avengers-p7/Documentation/assets/156056460/1835787e-f7b9-4f4e-ada0-1a00fd10fad4)

**Step-3** Save the Configuration

- Click on Save to save the job configuration.

**Step-4** Build the Pipeline

- Once the pipeline configuration is saved, you can manually trigger the build by clicking on Build Now.

**Step-5** View Build Console Output

- After triggering the build, you can view the progress and console output of the build by clicking on the build number in the Jenkins dashboard.
- The console output will display the steps executed by the pipeline script, including code checkout and compilation.
- Verify Successful Compilation
![WhatsApp Image 2024-02-13 at 21 10 33_dc22d491](https://github.com/avengers-p7/Documentation/assets/156056460/952314d4-2cc5-4b0e-8d9f-a8ee762dfa1d)
![WhatsApp Image 2024-02-13 at 21 11 08_9f4b325c](https://github.com/avengers-p7/Documentation/assets/156056460/0400f3f5-2079-49b6-9fe1-fddd90c6eeb7)
![image](https://github.com/avengers-p7/Documentation/assets/156056460/95d36436-1b1f-483b-8693-e2af13568430)
![WhatsApp Image 2024-02-13 at 21 15 13_fb1e58ac](https://github.com/avengers-p7/Documentation/assets/156056460/9b34182e-f103-46b6-9aff-826f295c35a8)

[Jenkinsfile](https://github.com/avengers-p7/Jenkinsfile/blob/main/Scripted%20Pipeline/Commit%20sign-off/Jenkinsfile)
```shell
node {
    stage('Fetch Last Commit') {
        checkout scm
        
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
```
# Conclusion
In conclusion, implementing a scripted pipeline commit sign-off process can greatly enhance the reliability and security of software development projects. By requiring developers to sign off on their commits through a scripted pipeline, teams can ensure that each code change undergoes thorough review and validation before being merged into the main codebase. This not only helps in maintaining code quality and consistency but also reinforces accountability among team members.

# Contact Information
| Name            | Email Address                        |
|-----------------|--------------------------------------|
| Khushi Malhotra | khushi.malhotra.snaatak@mygurukulam.co |


# Resources and References 
[JenkinsPipeline](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/jenkinsPipeline.md)

[Pipeline Creation](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/pipelinePOC.md)

[Commit Sign-off](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Design/02-%20Generic%20CI%20operation/CommitSignOff.md)
