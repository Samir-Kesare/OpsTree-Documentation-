# POC Of AMI Creation Using Shared Library

![image](https://github.com/avengers-p7/Documentation/assets/156057205/7ab97e86-1928-454d-8770-4b5e13487e95)

***

| **Author** | **Created On** | **Last Updated** | **Document Version** |
| ---------- | -------------- | ---------------- | -------------------- |
| **Shreya Jaiswal** | **16-02-2024** | **17-02-2024** | **v1** |

***

# Table Of Contents

1. [Introduction](#introduction)
2. [What is Shared Library?](#what-is-shared-library)
3. [Why Shared Library](#why-shared-library)
4. [Why use src folder structure in a Jenkins shared library](#Why-use-src-folder-structure-in-a-Jenkins-shared-library)
6. [AMI Setup](#AMI-setup)
7. [Pipeline](#Pipeline)
8. [Shared Library File](#shared-library-file)
9. [Template File](#Template-File)
10. [Conclusion](#conclusion)
11. [Contact Information](#contact-information)
12. [Reference](#reference)

***

# Introduction

This documentation will walk you through the steps involved in creating an AMI using a shared library.This guide is designed to assist users in creating a customized AMI on the Amazon Web Services (AWS) platform efficiently. AMIs are pre-configured templates that contain software configurations, launch permissions, and other settings required to launch an instance on AWS. By leveraging shared libraries, users can streamline the setup process, promote code reuse, and ensure consistency across multiple instances.

***

# What is Shared Library?

<img width="400" alt="image" src="https://github.com/avengers-p7/Documentation/assets/156057205/e55d86c5-ce1b-4a40-be43-6d59b4177419">

A shared library in Jenkins is a reusable collection of Groovy scripts that can be used by multiple Jenkins jobs.Shared libraries provide a way to efficiently share code and resources among multiple programs, promoting code reuse, efficient memory usage, and easier maintenance and updates.Each shared library requires users to define a name and a method of retrieving source code. These methods include local files, Git repositories, and Jenkins SCM plugins. Optionally, users can also set a default library version.

***

# Why Shared Library

| **Reason** | **Description** |
| ---------- | --------------- |
| **Reusability** | Shared libraries allow developers to write code once and reuse it in multiple programs, reducing duplication of effort and making maintenance easier. |
| **Dynamic Linking** |  When a program uses a shared library, the code from the library is not directly included in the program's executable file. Instead, references to the library are included, and the actual library code is loaded into memory at runtime when the program is executed. |
| **Efficient Memory Usage** | Since shared libraries are loaded into memory only once, even if multiple programs are using them simultaneously, they can help conserve system resources and reduce memory usage. |
| **Updates and Maintenance** |  If a shared library is updated or patched to fix bugs or add features, all programs that use that library can benefit from the changes without needing to be recompiled. |

***

# Why use `src` folder structure in a Jenkins shared library

| Benefit                    | Description                                                                                                                                                                    |
|----------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Organizational Structure**  | Placing source files in a `src` folder provides a clear and organized structure for the library, aiding developers in quickly locating files and understanding the layout.      |
| **Isolation of Source Code**  | Keeping source code separate from other files (e.g., documentation, configuration, tests) prevents clutter and confusion, making the codebase easier to manage.                 |
| **Easier Maintenance**        | With a clear structure, maintaining and updating the library becomes straightforward, as developers know where to find specific files and can make changes confidently.     |
| **Build and Packaging**       | Adhering to conventions like using a `src` folder facilitates integration with build tools and package managers, as they often expect a certain directory structure.           |
| **Compatibility with IDEs**   | Standard project structures, such as a `src` folder, improve compatibility with integrated development environments (IDEs), enabling features like code navigation and auto-completion. |
| **Readability and Maintainability** | A well-organized structure enhances readability and maintainability by making it easier for developers to understand the codebase's layout and locate relevant files efficiently. |

***

>[!Note]
>Click this [Link](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Design/02-%20Generic%20CI%20operation/AMI/AMI%20via%20Packer.) for AMI Setup Document.

***

>[!Note]
>Click this [Link](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/AMI/Scripted%20Pipeline/README.md) for AMI Setup using Jenkinsfile.

***

**Shared Library File Structure**

<img width="485" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/1a27b018-6294-4621-94e3-5295f428c6d9">

***

# AMI Setup

**Tool Installation**

<img width="407" alt="image" src="https://github.com/avengers-p7/Documentation/assets/156057205/5dee9dff-af57-4556-96bf-8a2c1b3012d4">

***

**Jenkinsfile Path in Configuration**

<img width="646" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/e3503ded-6235-4121-82da-cc22c26d49e7">

***

**Console Output**

<img width="950" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/a25f6ae6-f7e3-46ef-bb26-3630e30f0335">

***

<img width="680" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/a1046f45-7aa8-46ba-abd4-3d8c1dd73325">


***

**AMI Result**

<img width="700" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/eea68c85-88ca-4a01-87df-3367bea308f1">

***

# Pipeline

```shell
@Library("my-shared-library") _

def genericCiPackerAmi = new org.avengers.template.genericCi.GenericCiAmi()

node {
   genericCiPackerAmi.call() 
}
 
```
>[!Note]
>Click this [Link](https://github.com/CodeOps-Hub/Jenkinsfile/blob/main/SharedLibrary/AMI/Jenkinsfile) for the script file.

***

# Shared Library File

### src/org/avengers/genericCi/packerAmi/AwsCreds.groovy

This class, `AwsCreds`, encapsulates AWS credentials retrieval. It provides a static method, `awsCredentials()`, that returns a map containing details necessary for AWS credential retrieval. These details include the `credentialsId`, `accessKeyVariable`, and `secretKeyVariable`, which are essential for securely accessing AWS services and resources.

```shell
package org.avengers.genericCi.packerAmi

class AwsCreds {
    static def awsCredentials() {
        return [
            credentialsId: 'aws creds',
            accessKeyVariable: 'AWS_ACCESS_KEY_ID',
            secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
        ]
    }
}

```

>[!Note]
>Click this [Link](https://github.com/CodeOps-Hub/SharedLibrary/blob/main/src/org/avengers/genericCi/packerAmi/AwsCreds.groovy) for the script file.

***

### src/org/avengers/genericCi/packerAmi/PackerInit.groovy

This Groovy script is responsible for `initiating Packer` in a specified directory. It ensures that Packer is initialized correctly, preparing it for subsequent operations within the specified directory.

```shell
package org.avengers.genericCi.packerAmi

def call() {
    stage('Initialize Packer') {
            sh '/usr/bin/packer init .'
        }
    }

```

>[!Note]
>Click this [Link](https://github.com/CodeOps-Hub/SharedLibrary/blob/main/src/org/avengers/genericCi/packerAmi/PackerInit.groovy) for the script file.

***

### src/org/avengers/genericCi/packerAmi/PackerBuild.groovy

This Groovy script is a part of a Jenkins shared library used for building Amazon Machine Images (AMIs) with Packer. It defines a pipeline step `(call())` that switches to a directory containing Packer configuration files. Within this directory, it securely binds AWS credentials using the withCredentials block, ensuring that the access key and secret key are available as environment variables (`AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`, respectively). Finally, it executes the Packer build command `(packer build .)` within this context.

```shell
package org.avengers.genericCi.packerAmi

def call() {
    stage('Build AMI') {
        withCredentials([[
            $class: 'AmazonWebServicesCredentialsBinding',
            credentialsId: 'aws creds',
            accessKeyVariable: 'AWS_ACCESS_KEY_ID',
            secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
        ]]) {
            sh '/usr/bin/packer build .'
        }
    }
}

```

>[!Note]
>Click this [Link](https://github.com/CodeOps-Hub/SharedLibrary/blob/main/src/org/avengers/genericCi/packerAmi/PackerBuild.groovy) for the script file.

***

# Template File

### src/org/avengers/template/genericCi/GenericCiAmi.groovy

This Groovy script is a template for a generic continuous integration (CI) pipeline. It coordinates the execution of three main steps: obtaining AWS credentials, initializing Packer in a specific directory, and subsequently building an Amazon Machine Image (AMI) using Packer.

```shell
package org.avengers.template.genericCi

import org.avengers.common.*
import org.avengers.genericCi.packerAmi.*

def call(String url, String creds, String branch){
    gitCheckoutPrivate = new GitCheckoutPrivate()
    def awsCred = new AwsCreds()
    def packerInit = new PackerInit()
    def packerBuild = new PackerBuild()

    gitCheckoutPrivate.call(url, creds, branch)
    awsCred.awsCredentials()  // Call the correct method
    packerInit.call()
    packerBuild.call()
}

```

>[!Note]
>Click this [Link](https://github.com/CodeOps-Hub/SharedLibrary/blob/main/src/org/avengers/template/genericCi/GenericCiAmi.groovy) for the script file.
>
***

# Conclusion

In conclusion, this documentation has provided you with a comprehensive guide on setting up an Amazon Machine Image (AMI) using a shared library. By following the steps outlined in this guide, you can effectively leverage shared libraries to streamline the process of creating and managing AMIs on the Amazon Web Services (AWS) platform.Utilizing shared libraries offers numerous benefits, including code reuse, improved maintainability, and enhanced consistency across your infrastructure. 

***

# Contact Information

| **Name** | **Email Address** |
| -------- | ----------------- |
| **Shreya Jaiswal** | shreya.jaiswal.snaatak@mygurukulam.co |

***

# Reference
| **Source** | **Description** |
| ---------- | --------------- |
| [Link](https://keentolearn.medium.com/how-to-improve-your-jenkins-builds-with-shared-libraries-5e225b7435fb#:~:text=A%20shared%20library%20in%20Jenkins,efficient%20and%20easier%20to%20maintain.) | Link For Shared Library |
| [Link](https://phoenixnap.com/kb/jenkins-shared-library) | Reference Link For Understanding the concept of Shared Library |
| [Link](https://www.youtube.com/watch?v=pQUDhOMZiZQ) | Video Reference For Shared Library |
| [Link](https://youtu.be/Wj-weFEsTb0?feature=shared) | Video Reference For Shared Library |
| [Link](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/sharedLibrary/README.md) | Generic Doc Link |
| [Link](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/sharedLibrary/setup.md) | Generic Poc Doc Link |
| [Link](https://devopscube.com/packer-tutorial-for-beginners/) | Reference Link For AMI Creation |
| [Link](https://flugel-it.medium.com/building-and-running-custom-amis-on-aws-using-packer-and-terraform-3db28c968b30) | Reference Link |

