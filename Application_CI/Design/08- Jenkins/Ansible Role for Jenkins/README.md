# Ansible Role to setup Jenkins (Ubuntu)


|   Authors        |  Created on   |  Version   | Last updated by | Last edited on |
| -----------------| --------------| -----------|---------------- | -------------- |
| Vidhi Yadav      |  31 Jan 2024   |     v1     | Vidhi Yadav     | 31 Jan 2024    |

***
## Table of Contents
+ [Introduction](#Introduction)
+ [Ansible and Jenkins](#Ansible-jenkins)
+ [Flow Diagram](#Flow-diagram)
+ [Pre-requisites](#pre-requisites)
+ [Setup Ansible Role](#steps)
+ [Output Verification](#output)
+ [Jenkins Setup](#post-installation-setup)
+ [Conclusion](#conclusion)
+ [Contact Information](#contact-information)
+ [References](#references)

***
# Introduction
This role is designed to automate the installation and configuration of Jenkins on target ubuntu servers. Whether you're setting up Jenkins for continuous integration, continuous delivery, or other purposes, this role aims to simplify the process.

Please refer to the following link to access the Jenkins playbook separately: [Jenkins Playbook](https://github.com/CodeOps-Hub/Jenkins-Playbook/tree/main)

***
## Ansible and Jenkins

Here, we harness the efficiency of Ansible, an open-source automation tool streamlining configuration management and application deployment. In parallel, Jenkins excels in facilitating continuous integration and delivery, ensuring a seamless and automated pipeline for software development processes.

***
## Flow Diagram

* This diagram should help you visualize the sequence of tasks in your Ansible playbook for installing Jenkins.

<img width="1457" alt="Screenshot 2024-02-19 at 11 41 38 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/b17b5300-0479-4ef2-83aa-72873b09ed0e">

***
## Pre-requisites

Before using this Ansible role to set up Jenkins, ensure that the following prerequisites are met:

1. **Ansible:**
   - Ansible must be installed on the control machine from which you plan to run the playbook. If Ansible is not installed, you can install it using this [link](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)

2. **SSH Access to Target Servers:**
   - Ensure that you have SSH access to the target servers where Jenkins will be installed.

***
# Steps 
* Before going further check the link for Ansible Role: https://github.com/vyadavP7/Jenkins-AnsibleRole

**Step 1: Dynamic Inventory Setup** 

```yaml
[defaults]

# some basic default values...


# Use AWS EC2 dynamic inventory for managing hosts
inventory      = aws_ec2.yml

# Disable SSH host key checking for convenience.
host_key_checking = False

# Specify the path to the private key file for SSH connections.
private_key_file = /path/to/private_key

Sets the remote user for SSH connections to 'ubuntu'
remote_user = ubuntu

[inventory]
# enable inventory plugins, default: 'host_list', 'script', 'auto', 'yaml', 'ini', 'toml'
enable_plugins = aws_ec2, host_list, virtualbox, yaml, constructed, script, auto, ini, toml
```

> [!NOTE]
>Ensure that for dynamic inventory you have the necessary AWS credentials configured in AWS CLI and attach an IAM role on the master node. 

**Step 2:  AWS EC2 Inventory**

```yaml
---
plugin: aws_ec2
regions:
  - your_aws_region

groups: 
  ubuntu: "'ubuntu' in tags.OS"
```

1. `plugin: aws_ec2`: Specifies the use of the aws_ec2 plugin as the dynamic inventory source. This plugin is designed to fetch information about EC2 instances in AWS.
2. `regions: - eu-north-1`: Indicates the AWS region(s) from which the dynamic inventory should fetch information.
3. `ubuntu: "'ubuntu' in tags.OS"`: Creates an Ansible group named ubuntu. This group includes EC2 instances where the tag named OS has a value of 'ubuntu'.

**Step 3: Create Ansible Role**
* Create a new Ansible role which should follow this directory structure:

<img width="842" alt="Screenshot 2024-02-03 at 5 28 58 PM" src="https://github.com/avengers-p7/Documentation/assets/156056349/9132ed3e-ddd3-42e4-ba6f-1aeff4b4430a">

**Step 4: playbook.yml**
* This file is defining a set of tasks to be executed on hosts belonging to the ubuntu group.

```yaml
---
- hosts: ubuntu
  become: yes
  gather_facts: yes 
  roles:
    - jenkins      #includes role
```
**Step 5: Tasks**
1. `main.yml`: This main.yml file is acting as an orchestrator, importing tasks from the `install_jenkins.yml` file. This separation of tasks into different files is a good practice for better organization, especially when dealing with complex configurations or roles.

```yaml
---
# importing task files
- name: Include file to install softwares
  import_tasks: install_jenkins.yml
```

2. `Default` variables: This role comes with default values for the Jenkins repository URL and key URL. You can find these defaults in the `defaults/main.yml` file within the role directory.

```yaml
---
# defaults file for jenkins
jenkins_repo_url:  deb https://pkg.jenkins.io/debian-stable binary/ 
jenkins_repo_key_url:  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key 
```

> [!NOTE]
> To customize the Jenkins version based on your specific requirements, you can override these default values in your playbook. This is particularly useful when you want to install a different version of Jenkins.


3. `install_jenkins.yml`: This file is included in the jenkins/tasks/main.yml file

```yaml
---
# Update APT cache
- name: Update APT cache
  apt:
    update_cache: yes

# Installs jdk if not installed already
- name: Ensure jdk is installed
  apt:
    name: default-jre
    state: present

# Adds the Jenkins repository's GPG key to the APT keyring
- name: Add Jenkins apt key in system.
  apt_key:
    url: "{{ jenkins_repo_key_url }}"
    state: present

# Add Jenkins apt repository
- name: Add Jenkins apt repository.
  apt_repository:
    repo: "{{ jenkins_repo_url }}"
    state: present
    update_cache: yes

# Install Jenkins
- name: Install jenkins 
  apt:
    name: jenkins
    state: present 

# Start Jenkins service
- name: Start service 
  service:
    name: jenkins 
    state: started 
    enabled: yes 

# Check Jenkins service status
- name: Check Jenkins service status
  systemd:
    name: jenkins
    state: started
  ignore_errors: yes
  register: jenkins_service_status

# Display Jenkins service status
- name: Display Jenkins service status
  debug:
    var: jenkins_service_status
```

**Step 6: Playbook Execution**

* To set up Jenkins on your target servers, you will execute the Ansible playbook using the following command:

```bash
ansible-playbook -i aws_ec2.yml playbook.yml
```

> Additional Options
> 
> --limit: You can use this option to specify a subset of hosts from the inventory on which the playbook should be executed.
> 
> -e or --extra-vars: You can pass extra variables to the playbook using this option.


<img width="925" alt="Screenshot 2024-02-01 at 2 07 56 AM" src="https://github.com/avengers-p7/Documentation/assets/156056349/38f31390-31ff-4591-a34d-8a23d96eaf49">

<img width="947" alt="Screenshot 2024-02-01 at 2 07 24 AM" src="https://github.com/avengers-p7/Documentation/assets/156056349/9e7fd3a7-5ac9-476c-8b55-35f969e0121b">

***
## Output
1.  **Host-level output**: Output for each host would indicate whether the playbook execution was successful or not.

<img width="1352" alt="Screenshot 2024-02-01 at 2 41 57 AM" src="https://github.com/avengers-p7/Documentation/assets/156056349/d69954c0-6182-4c73-883d-ea7e21fe323d">

2. **Colorized Output**: Ansible uses colorized output to make it easier to identify successful, changed, or failed tasks. Successful tasks are often displayed in green, changed tasks in yellow, and failed tasks in red.

<img width="947" alt="Screenshot 2024-02-01 at 2 07 24 AM" src="https://github.com/avengers-p7/Documentation/assets/156056349/17399616-2a58-406d-affd-ca529e5ed158">

3. **Verify Tags**: Verify that the Jenkins installation is on the instance with the mentioned tags.

<img width="764" alt="Screenshot 2024-02-01 at 9 26 33 AM" src="https://github.com/avengers-p7/Documentation/assets/156056349/aa56992e-6702-40f8-a80c-39c49f53856a">

***
## Post-Installation Setup
* Open your web browser and navigate to `http://your-jenkins-server:8080`.

<img width="1365" alt="Screenshot 2024-02-03 at 5 45 17 PM" src="https://github.com/avengers-p7/Documentation/assets/156056349/37be3eed-33ed-48fb-b2e3-d0a2977b0924">

> [!IMPORTANT]
>
>  Ensure that port `8080` is open on your Ansible host.

* Retrieve the initial administrator password from the Jenkins server.

<img width="1122" alt="Screenshot 2024-02-03 at 5 49 48 PM" src="https://github.com/avengers-p7/Documentation/assets/156056349/1c22aa91-343c-4761-9464-f9955ed7d1ad">

* Customize jenkins based on your requirements and you're all set!

<img width="809" alt="Screenshot 2024-02-03 at 5 53 08 PM" src="https://github.com/avengers-p7/Documentation/assets/156056349/e542a049-956c-4085-962c-93dde46440d8">


***
## Conclusion 

* This guide illustrates the process of deploying Jenkins in a development environment through Ansible. By adhering to these instructions, you can effectively provision and set up Jenkins within your AWS infrastructure.

***
## Contact Information

|Vidhi Yadav                     | vidhi.yadhav.snaatak@mygurukulam.co                                                                                      
|---------------------------------|------------------------------------------------------------|

***
## References

| Title                                      | URL                                           |
|--------------------------------------------|-----------------------------------------------|
| Ansible documentation           | https://docs.ansible.com/ansible/latest/index.html    |
| Jenkins Installation    | https://www.jenkins.io/doc/book/installing/linux/  |
| Dyanmic Inventory               | https://www.youtube.com/watch?v=junPdh2yvbU&t=454s | 







