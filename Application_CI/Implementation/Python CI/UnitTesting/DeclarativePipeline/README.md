# Python Declarative Pipeline Unit Testing 
| Author | Created On | Last Updated | Document Version | Last Updated By |
| ------ | ---------- | ------------ | ---------------- | --------------- |
| Shantanu | 07-02-2024 | 10-02-2024   |         v1     |     Shantanu    |
***

# Table of Content

[1. Introduction](#introduction)

[2. Pre-requisites](#pre-requisites)

[3. Jenkinsfile Configuration](#jenkinsfile-configuration)

[4. Output Evaluation](#output-evaluation)

[5. Conclusion](#conclusion)

[6. Contact Information](#contact-information)

[7. Refrenecs](#references)

# Introduction
Testing individual units or components of a software program is a vital part of the software development process, ensuring that each part performs as intended. In this context, we utilize the pytest framework to create [unit tests,](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Design/04-%20Python%20CI%20Checks/UnitTesting.md) validating the functionality of specific components. This practice contributes to verifying the overall correctness and reliability of a software application. For detailed understanding on Jenkins Pipeline click [here](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/jenkinsPipeline.md).

### What is a Declarative Pipeline?
A declarative pipeline is a feature in Jenkins, which is an open-source automation server. Jenkins pipelines allow you to define the entire build and deployment process as code, facilitating the automation of software delivery. Declarative pipelines provide a more structured and simplified way to define pipelines compared to the older scripted pipeline syntax.

| **Reasons for Using Declarative Pipelines**                | **Description**                                                                                                       |
| -------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------- |
| **Readability and Simplicity**                            | Declarative pipelines use a more human-readable syntax, making it easier for developers and non-developers to understand.|
| **Easy to Learn**                                        | Designed to be beginner-friendly, reducing the learning curve for users new to Jenkins or CI/CD concepts.                 |
| **Structured Approach**                                   | Follows a predefined structure for stages, steps, and elements, promoting consistency and simplifying pipeline management. |
| **Built-in Steps**                                       | Comes with built-in steps for common tasks, eliminating the need for custom scripts for routine operations.               |
| **Pipeline Visualization**                               | Provides visualization tools for easily tracking progress and status, aiding in troubleshooting and monitoring.           |
| **Promotes Best Practices**                               | Encourages the use of CI/CD best practices, such as clear stage definitions, version control for pipeline code, etc.      |
| **Integration with Blue Ocean**                           | Integrates well with Jenkins Blue Ocean, offering a modern and visual experience for creating and managing pipelines.       |


***

# Pre-requisites

|  Tool  | Description  |
| ------ | ---------- |
| Jenkins | Jenkins will orchestrate the CI/CD pipeline and execute the dependency analysis stage. |
| Python | Python is a versatile, high-level programming language. |
| Pytest | It is a widely used testing framework for Python, streamlining the task of creating and running tests. |
***

<img width="695" alt="image" src="https://github.com/avengers-p7/Documentation/assets/156057205/823c2e8d-4e48-4bd4-8cf3-2ccfa178ef4b">

***
# Jenkinsfile Configuration

**Agent Configuration:** This specifies that the pipeline can run on any available agent (slave node).

```
agent any
```

**Stages:** This section defines multiple stages for the pipeline.

```
stages 
{
    // Stages go here
}
```
**Code Checkout:** This stage checks out the code from the specified GitHub repository OT-Attendance using the 'main' branch and the specified credentials (Attendance-creds).

As it is a private repo so here we are using credentials which is already stored in the Jenkin server
pipeline {
    agent any
```
    stages {
        stage('Checkout') {
            steps {
                script {
                    // Checkout the code from the specified Git repository
                    git branch: 'main', credentialsId: 'snataak', url: 'https://github.com/OT-MICROSERVICES/attendance-api.git'
                }
            }
        }
```

**Create Virtual Environment:** This stage creates a virtual environment named 'myenv' using Python's venv module and activates it.
stage('Create Virtual ENV') 

**NOTE:** _Here virtual environment is created to isolate project dependencies, ensuring a clean and controlled environment. It helps manage and specify the exact versions of Python and third-party libraries needed for a specific project, preventing conflicts with other projects or the global Python environment._
```
{
    steps 
    {
        script 
        {
            sh 'python3 -m venv myenv'
            sh '. myenv/bin/activate'
        }
    }
}
```

**Install Dependencies:** This stage installs the Python dependencies listed in the 'requirements.txt' file using the pip package manager.

```
stage('Install Dependencies')
 {
    steps {
        script {
            sh 'python3 -m pip install -r requirements.txt'
        }
    }
}
```

**Unit Testing:**

* This stage is dedicated to running unit tests for the project.

* It activates the virtual environment (. myenv/bin/activate) and then runs pytest on a specific test file (router/tests/test_cache.py).

* This assumes that your unit tests are written using the pytest framework, and that the specified test file is part of your project's test suite.
```
pipeline {
    agent any

    stages 
    {
        stage('Code Checkout') 
        {
            steps 
            {
                git branch: 'main', credentialsId: 'snataak', url: 'https://github.com/OT-MICROSERVICES/attendance-api.git'
            }
        }
        
        stage('Creat Virtual ENV') 
        {
            steps 
            {
                script 
                {
                  sh 'python3 -m venv myenv'
                  sh '. myenv/bin/activate'
                }
            }
        }

        stage('Install Dependencies') 
        {
            steps 
            {
                script 
                {
                  sh 'pip install -r requirements.txt'
                  sh 'pip install pytest pytest-html'
                }
            }
        }

        stage('Unit Test') 
        {
            steps 
            {
                script 
                {
                    sh '. myenv/bin/activate'
                    //sh 'pytest router/tests/test_c
                    sh 'pytest router/tests/test_cache.py'
                    //sh 'pytest /var/lib/jenkins/workspace/unit_test '
                    
                    
                }
            }
        }
    }
}
```

# Pipeline Configuration

**Configure pipeline job for Jenkins and execute the pipeline.**

* Click on **"New Item"** or **"Create new jobs"** from the Jenkins dashboard.

* Enter a name for your job (e.g., "Python App Static_code_analysis") and select **"Pipeline"** as the job type.

* Click **"OK"** to create the new job.

![image](https://github.com/avengers-p7/Documentation/assets/156056364/29b29fe2-de41-4257-a8a5-c9dc6bcc2674)


* Then write your Pipeline Script under **“Script”** section and click “Save” Button.

  ![Screenshot 2024-02-15 at 7 22 20 PM](https://github.com/avengers-p7/Documentation/assets/156056364/3509bded-0bbf-47df-b4e0-8c21ac8a86cc)


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

