
# Python Scripted Pipeline Unit Testing 
| Author | Created On | Last Updated | Document Version | Last Updated By |
| ------ | ---------- | ------------ | ---------------- | --------------- |
| Shantanu | 07-02-2024 | 20-02-2024   |         v1     |     Shantanu    |
***


# Table of Content

[1. Introduction](#introduction)

[2. Pre-requisites](#pre-requisites)

[3. Jenkinsfile Configuration](#jenkinsfile-configuration)

[4. Output Evaluation](#output-evaluation)

[5. Conclusion](#conclusion)

[6. Contact Information](#contact-information)

[7. Refrenecs](#references)

***
# Introduction
Testing individual units or components of a software program is a vital part of the software development process, ensuring that each part performs as intended. In this context, we utilize the pytest framework to create [unit tests,](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Design/04-%20Python%20CI%20Checks/UnitTesting.md) validating the functionality of specific components. This practice contributes to verifying the overall correctness and reliability of a software application. For detailed understanding on Jenkins Pipeline click [here](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/jenkinsPipeline.md).

### What is a Scripted Pipeline?
A scripted pipeline typically refers to a set of automated processes or tasks that are executed in a sequential order according to a predefined script or set of instructions. In the context of software development, continuous integration, and deployment, a scripted pipeline is often used to automate the build, test, and deployment phases of a software project.


| **Advantages of Scripted Pipeline**                                | **Description**                                                                                                                                                                                                                                                                                                                            |
|------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Flexibility and Customization**                                | Allows high-level customization of each pipeline step to fit specific project requirements. Developers have control over build tools, testing frameworks, and deployment configurations.                                                                                                                                                 |
| **Advanced Logic and Conditional Execution**                     | Supports advanced scripting languages (e.g., Groovy) for incorporating complex logic and conditional statements in pipeline scripts. Enables dynamic decision-making during the pipeline execution, such as skipping steps based on conditions.                                                                                        |
| **Integration with External Tools**                              | Easily integrates with external tools and scripts, facilitating the inclusion of additional testing tools, static code analyzers, or third-party services in the CI/CD process.                                                                                                                                                              |
| **Parallel Execution**                                           | Supports parallel execution of tasks, optimizing build and test times by running independent tasks concurrently. This feature can significantly reduce the overall time required to complete the pipeline.                                                                                    |
| **Legacy System Compatibility**                                  | Well-suited for handling legacy systems or projects that may require custom configurations or scripts that are not easily accommodated by declarative pipelines. Allows developers to write custom scripts to address specific needs.                                                |
| **Dynamic Environments**                                         | Ideal for handling dynamic environments and deployment scenarios. Developers can use scripting to dynamically determine deployment targets, configure environments based on runtime conditions, or adapt to changes in the deployment infrastructure.                                  |
| **Migration from Existing Scripts**                              | Smooth transition for organizations with existing custom scripts or automation. Existing scripts can often be adapted and integrated into the scripted pipeline without significant modification.                                                                                    |

***

# Pre-requisites

|  Tool  | Description  |
| ------ | ---------- |
| Jenkins | Jenkins will orchestrate the CI/CD pipeline and execute the dependency analysis stage. |
| Python | Python is a versatile, high-level programming language. |
| Pytest | It is a widely used testing framework for Python, streamlining the task of creating and running tests. |
***
![image](https://github.com/CodeOps-Hub/Documentation/assets/156057205/5a6af77f-e467-46fa-94d6-215a4710293f)

***

# Jenkinsfile Configuration

**Agent Configuration:** This specifies that the pipeline can run on any available agent (slave node).

```
node {
    stage('Code Checkout') {
        git branch: 'main', credentialsId: 'snataak', url: 'https://github.com/OT-MICROSERVICES/attendance-api.git'
    }
```

**Stages:** This section defines multiple stages for the pipeline.

```
stage 
{
    // Stages go here
}
```

**Create Virtual Environment:** This stage creates a virtual environment named 'myenv' using Python's venv module and activates it.
stage('Create Virtual ENV') 

**NOTE:** _Here virtual environment is created to isolate project dependencies, ensuring a clean and controlled environment. It helps manage and specify the exact versions of Python and third-party libraries needed for a specific project, preventing conflicts with other projects or the global Python environment._
```
stage('Create Virtual ENV') {
        script {
            sh 'python3 -m venv myenv'
            sh '. myenv/bin/activate'
        }
    }
```

**Install Dependencies:** This stage installs the Python dependencies listed in the 'requirements.txt' file using the pip package manager.

```
stage('Install Dependencies') {
        script {
            sh 'pip install -r requirements.txt'
            sh 'pip install pytest pytest-html'
        }
    }
```

**Unit Testing:**

* This stage is dedicated to running unit tests for the project.

* It activates the virtual environment (. myenv/bin/activate) and then runs pytest on a specific test file (router/tests/test_cache.py).

* This assumes that your unit tests are written using the pytest framework, and that the specified test file is part of your project's test suite.
```
node {
    stage('Code Checkout') {
        git branch: 'main', credentialsId: 'snataak', url: 'https://github.com/OT-MICROSERVICES/attendance-api.git'
    }

    stage('Create Virtual ENV') {
        script {
            sh 'python3 -m venv myenv'
            sh '. myenv/bin/activate'
        }
    }

    stage('Install Dependencies') {
        script {
            sh 'pip install -r requirements.txt'
            sh 'pip install pytest pytest-html'
        }
    }

    stage('Unit Test') {
        script {
            sh '. myenv/bin/activate'
            sh 'pytest router/tests/test_cache.py'
        }
    }
}
```
***

> [!Note]
> There is a separate doc Generic Doc which includes common steps for pipeline, click this [Link](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GenericDoc/jenkinsPipeline.md)to see.

***

* Then execute your Pipeline by clicking on **“Build Now”**

![image](https://github.com/avengers-p7/Documentation/assets/156056364/e2e37e3c-c019-4be6-aade-2687f0e9f56c)

***

# Output Evaluation

In this screenshot, we execute a specific unit test case, which successfully passes 

![Screenshot 2024-02-15 at 7 23 43 PM](https://github.com/avengers-p7/Documentation/assets/156056364/96105b5d-e007-47f5-9e8d-6d22b086e756)

From console output, we can conclude that the unit test case report Python involves systematically validating the functionality of individual components to ensure the overall correctness and reliability of a software application. Adopting unit testing practices contributes to code quality, facilitates maintenance, and provides confidence in the robustness of the code base.

***

# Conclusion
Performing unit tests in Python entails methodically confirming the accuracy of individual components to guarantee the overall correctness and dependability of a software application. Embracing unit testing practices enhances code quality, simplifies maintenance, and instills confidence in the resilience of the codebase.

# Contact Information
| Name | Email Address |
| ---- | ------------- |
| Shantanu  | shantanu.chauhan.snaatak@mygurukulam.co |
***
# References
| Source | Description  | 
| -------- | ------- |
| https://realpython.com/pytest-python-testing/ | Pytest |
| https://skamalakannan.dev/posts/jenkins-pipeline-python/ | Jenkin pipeline with python |
| https://www.jenkins.io/doc/book/pipeline/ | Jenkins pipeline |

