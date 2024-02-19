# Integrate Jenkins with Github (Private repo)
![image](https://github.com/avengers-p7/Documentation/assets/156056444/01d3b63b-1a88-489d-a5dd-7e331de0c695)

| Author                                                           | Created on  | Version    | Last Updated by | Last Updated on |
| ---------------------------------------------------------------- | ----------- | ---------- | --------------- | --------------- |
| **[Harshit Singh](https://github.com/Panu-S-Harshit-Ninja-07)**  | 08-02-2024  | 1.0        | Harshit Singh   | 11-02-2024      |

## Table  of Contents

1. [Introduction](#Introduction)
2. [Prerequisites](#Prerequisites)
3. [Flow Diagram](#Flow-Diagram)
4. [Generate Personal Access Token(PAT)](#generate-personal-access-tokenpat)
5. [Add Credentials in Jenkins](#Add-Credentials-in-Jenkins)
6. [Create Pipeline using Jenkinsfile](#Create-Pipeline-using-Jenkinsfile)
7. [Contact Information](#Contact-Information)
8. [References](#References)
***

## Introduction
In this document we will see how to integrate _**Jenkins**_  with _**Jenkinsfile**_ kept in _**Github Private Repo**_ using _**Personal Access Token**_.  
## Prerequisites
| Tool | Description |
| ---- | ----------- |
| Jenkins | For pipeline |
| GIT | To store Jenkinsfile in private repo |

> [!Important]
> I have installed the plugin bundle provided by Jenkins during setup. If you have not done the same, you may encounter plugin errors.

***
## Flow Diagram
![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/76bc9c27-79b5-459c-ad0a-7c1e5f32bd53)
***
## Generate Personal Access Token(PAT)
### Step 1 - Go to your Github profile
![image](https://github.com/avengers-p7/Documentation/assets/156056444/20666213-cad3-4c0b-a4fa-07fcd7902793)
### Step 2 - Go to Settings
![image](https://github.com/avengers-p7/Documentation/assets/156056444/cd831c21-3327-472c-b58a-12265322517c)

### Step 3 - Select Developer Setting
![image](https://github.com/avengers-p7/Documentation/assets/156056444/3279196e-b243-4af7-a3a0-61a7359be041)

### Step 4 - Select Tokens --> Generate new token --> Generate new token(classic)
![image](https://github.com/avengers-p7/Documentation/assets/156056444/0e05f52e-b375-44de-97ab-824234b6cbbf)

### Step 5 - Enter Token Name --> Select Scopes/Permission(according to your requirement)
![image](https://github.com/avengers-p7/Documentation/assets/156056444/8657f90a-4e3a-4023-88b6-bf84394092e7)

### Step 6 - Scroll Down --> Click on Generate Token
![image](https://github.com/avengers-p7/Documentation/assets/156056444/46a0abf3-1bd6-478b-b7e1-61910704ef7c)

### Step 7 - Copy your  token and save it  
![image](https://github.com/avengers-p7/Documentation/assets/156056444/38704809-d3d3-4363-a780-0c97567d5948)
***
## Add Credentials in Jenkins
### Step 1 - Check GIT plugin, Go to Dashboard --> Manage Jenkins --> PLugins --> Installed Plugins
The git plugin provides fundamental git operations for Jenkins projects. It can poll, fetch, checkout, branch, list, merge, tag, and push repositories.

![image](https://github.com/avengers-p7/Documentation/assets/156056444/dd5e89aa-66b7-4272-9afe-1e99b772ba94)

If not present, install it form  **Dashboard --> Manage Jenkins --> PLugins --> Available Plugins**
### Step 2 - Go to Dashboard --> Manage Jenkins --> Credentials
![image](https://github.com/avengers-p7/Documentation/assets/156056444/7ddbd779-4cce-4ab8-b074-6ead1451db36)

### Step 3 - List down global --> Add Credentials 
![image](https://github.com/avengers-p7/Documentation/assets/156056444/88663437-cf1f-4d20-b6d6-f853ca572735)

### Step 4 - Select username and password option and  add your github userename, PAT , ID(optional) and description(optional)
![image](https://github.com/avengers-p7/Documentation/assets/156056444/d0a4cac0-52e7-4883-a05a-e24a166f3388)

### Step 5 - Here your credentials are added
![image](https://github.com/avengers-p7/Documentation/assets/156056444/094747b8-5a49-4ca6-a6cd-355f06b5ebea)
***
## Create Pipeline using Jenkinsfile 
### Step 1 - Go to Jenkins Dashboard --> New Item
![image](https://github.com/avengers-p7/Documentation/assets/156056444/95f92018-1a2e-4099-9e44-916a0419877a)

### Step 2 - Now, provide Git private repo url, credential, branchname and jenkinsfile path to  configure your pipeline 
![image](https://github.com/avengers-p7/Documentation/assets/156056444/25fe31e2-127d-45ef-bfd2-4a985a443f79)

![image](https://github.com/avengers-p7/Documentation/assets/156056444/a0172809-4206-4ebf-a050-4afd3bb24d44)

### Step 3 - You can build your pipeline now
![image](https://github.com/avengers-p7/Documentation/assets/156056444/ba41da3b-ec43-4493-bd89-245a42172771)

### Step 4 - Result
![image](https://github.com/avengers-p7/Documentation/assets/156056444/8fcc37f0-1187-41c3-bccd-ca9d6c75bcef)

## Contact Information

|     Name         | Email  |
| -----------------| ------------------------------------ |
| Harshit Singh    | harshit.singh.snaatak@mygurukulam.co |
***

## References

| Description                                   | References  
| --------------------------------------------  | -------------------------------------------------|
| Integrate Jenkins with Github(Private repo)   | https://shreyakupadhyay.medium.com/integrate-jenkins-with-github-private-repo-8fb335494f7e |
| Pipeline Refrence Doc                         | https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Implementation/GenericDoc/jenkinsPipeline.md |
