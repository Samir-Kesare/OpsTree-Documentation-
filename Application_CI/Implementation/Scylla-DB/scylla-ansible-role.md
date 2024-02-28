# Ansible Role to setup Scylla-DB (Ubuntu)

![logo-scylla-vertical-RGB](https://github.com/avengers-p7/Documentation/assets/156056709/e765857b-fd7e-4478-b59c-1545e0afd131)


| **Author** | **Created On** | **Last Updated** | **Document Version** |
| ---------- | -------------- | ---------------- | -------------------- |
| **Parasharam Desai** | 13-02-2024 | 13-02-2024 | V1 |

***

# Table of Contents

1. [Introduction](#introduction)
2. [Pre-requisites](#pre-requisites)
3. [Flow Diagram](#Flow-Diagram)
4. [Steps](#steps)
5. [Evaluate Output](#evaluate-output)
6. [Conclusion](#conclusion)
7. [Contact Information](#contact-information)
8. [Resources and References](#resources-and-references)

   
***
# Introduction 

This document aims to provide a guide for setting up ScyllaDB in a development environment using Ansible automation on AWS. We are
going to Setup a single Node server of Scylladb using dynamic inventory.

***
# Pre-requisites 

| Tool         | Description                                       |
| ------------ | ------------------------------------------------- |
| Ansible      | Version 2.15.5 or later. Used for Ansible roles. |
| AWS Account  | Access to an AWS account for deployment.         |
| Private key  | Required for SSH authentication.                 |

Please ensure you have access to an AWS account for deployment purposes in addition to Ansible and a private key for SSH authentication.

***
# Flow Diagram:
![image](https://github.com/avengers-p7/Documentation/assets/156056709/9e6a4ced-3182-40a9-b772-2ac7021a436c)


***
# Steps

Before going further check the link for Ansible Role  **[Repository-Link](https://github.com/Parasharam-Desai/scylla-ansible-role.git)** 

**Step 1: Dynamic Inventory Setup**(`ansible.cfg`)

Defines inventory settings, and SSH configurations.

```ini
[defaults]
inventory               =       /home/parsu/ansible/aws_ec2.yaml
private_key_file        =       /home/parsu/Downloads/ninja.pem
remote_user             =       ubuntu
host_key_checking       =       False

[inventory]
enable_plugins          =       aws_ec2
```
**Explanation:**

- `inventory`: Specifies the path to the AWS EC2 inventory file providing details about available hosts.
- `host_key_checking`: Turns off host key checking for simplicity.
- `remote_user`: Sets the remote user for SSH connections to 'ubuntu'.
- `private_key_file`: Specifies the location of the private key file for authentication.
  
> [!NOTE]
>Ensure that for dynamic inventory you have the necessary AWS credentials configured in AWS CLI and attach an IAM role on the master node.

**Step 2:  AWS EC2 Inventory** (`aws_ec2.yml`)


```yaml
---
plugin: aws_ec2
regions:
  - eu-west-3
  
filters:
  instance-state-code: 16

keyed_groups:
  - key: tags
    prefix: tag
```
## Usage

To use this configuration:

1. Make sure you have Ansible installed.
2. Copy the `aws_ec2.yml` configuration file into your Ansible project directory.
3. Configure dynamic inventory in your Ansible server to use the AWS EC2 plugin.
4. Use the configuration with the `ansible-playbook` command, specifying the path to the configuration file.

**Setting up Dynamic Inventory with Ansible and AWS**

To learn how to set up dynamic inventory for Ansible with AWS, please refer to the following documentation: [Blog-Link](https://devopscube.com/setup-ansible-aws-dynamic-inventory/)

**Step 3: Create Ansible Role**

To create an Ansible role, which should follow below directory structure, you can use the ansible-galaxy command-line tool. Here's the command to create a new Ansible role:

```bash
ansible-galaxy init <role_name>
```
![image](https://github.com/avengers-p7/Documentation/assets/156056709/80b46007-bed0-4eea-9d4e-994656258434)


![image](https://github.com/avengers-p7/Documentation/assets/156056709/fa26f123-6015-4b58-8def-cbe69d6dc673)


**Step 4: playbook.yml**

In the Ansible role, we manage playbooks in a directory structure.
* This file is defining a set of tasks to be executed on hosts belonging to the ubuntu group.
  
```yaml
---
- hosts: tag_Name_scylla
  remote_user: ubuntu
  become: yes
  roles:
    - scylla-ansible-role

```


**Step 5: Tasks**
* `main.yml`: This main.yml playbook is designed to handle tasks and variables differently based on the operating system family detected by Ansible, providing a way to manage configurations and installations across different types of systems efficiently.

   
### Main Tasks File (`tasks/main.yml`):

```yaml
---
- name: Install Dependencies
  import_tasks: scylla_dependencies_ubuntu.yml

- name: Install on Ubuntu
  import_tasks: install_scylla_ubuntu.yml

- name: Configure ScyllaDB
  import_tasks: change_config_ubuntu.yml
```

### Task Files:

#### `scylla_dependencies_ubuntu.yml`:

```yaml
---
- name: Update Apt Cache
  apt:
    update_cache: yes

- name: Create directory for cassandra and keyrings
  file:
    path: "{{ item }}"
    state: directory
    mode: "0777"
  loop:
    - "{{ keyring_path }}"
    - "{{ cassandra_directory }}"

- name: Install Java
  apt:
    name: "{{ java_apt_package }}"
    state: present
```

#### `install_scylla_ubuntu.yml`:

```yaml
---
# install scylla on ubuntu

- name: Import ScyllaDB GPG Key
  become: true
  raw: "{{ scylla_repo_key_url }}"

- name: Add ScyllaDB Repository
  get_url:
    url: "{{ scylla_repo_url }}"
    dest: "{{ scylla_repo_dest }}"

- name: Update Apt Cache
  apt:
    update_cache: yes

- name: Install Scylla
  apt:
    name: scylla
    state: present
  failed_when: false

- name: Run Scylla
  command: scylla_setup
  args:
    stdin: "YES\nYES\nYES\nYES\nYES\nYES\nYES\nYES\nyes\nYES\nyes\nYES\nyes\nYES\nyes\nYES\nYES\nYES\nYES\nYES\nYES\nYES\nyes"
  register: scylla_setup_output
  failed_when: false

- name: Debug Scylla setup output
  debug:
    var: scylla_setup_output

- name: Start and enable scylla service
  systemd:
    name: scylla-server
    state: started
    enabled: yes
```

#### `change_config_ubuntu.yml`:

```yaml
---
# Replace scylla yaml file into server

- name: Copy scylla configuration template into ubuntu
  template:
    src: scylla.yaml.j2
    dest: /etc/scylla/scylla.yaml
  notify: Restart scylla

- meta: flush_handlers

- name: Pause for 30 seconds
  pause:
    seconds: 30

- name: See Nodetool Status
  command: "nodetool status"
  register: status

- name: Debug Nodetool status
  debug:
    var: status
```

### Variables (`vars/main.yml`):

```yaml
---
# vars file for scylla-ansible-role
keyring_path : /etc/apt/keyrings
cassandra_directory : /etc/scylla/cassandra
java_apt_package: openjdk-17-jre
scylla_seed_nodes: "{{ groups['tag_Name_scylla'] | map('extract', hostvars, ['ansible_default_ipv4', 'address']) | join(',') }}"
scylla_endpoint_snitch: "SimpleSnitch"
scylla_repo_key_url: "gpg --homedir /tmp --no-default-keyring --keyring /etc/apt/keyrings/scylladb.gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys d0a112e067426ab2"
scylla_repo_url: http://downloads.scylladb.com/deb/debian/scylla-5.4.list
scylla_repo_dest: "/etc/apt/sources.list.d/scylla.list"
```

**Step 6: Jinja Template**(`scylla.yaml.j2`)

* The Jinja template is crucial for defining the behavior and characteristics of the ScyllaDB database cluster. It includes configuration parameters such as `cluster_name`, `num_tokens`, `commitlog_sync`, and more.

Configuration Parameters

- **cluster_name:**
  - *Purpose:* Provides a clear and identifiable label for the database cluster within the configuration.
  - *Impact:* Facilitates easy identification and management of the database cluster, aiding in monitoring, troubleshooting, and ensuring consistency in configuration across the system.

- **num_tokens:**
  - *Purpose:* Determines the number of tokens randomly assigned to each node on the ring.
  - *Impact:* Affects the amount of data each node will store.

- **commitlog_sync:**
  - *Purpose:* Specifies how the commit log is synced.
  - *Options:* "periodic" or "batch."

- **seed_provider:**
  - *Purpose:* Configures seed nodes, which are contact points for nodes to discover the cluster ring topology.

- **listen_address:**
  - *Purpose:* Defines the address to which Scylla should bind for other nodes to connect.

- **native_transport_port:**
  - *Purpose:* Specifies the port for the CQL native transport to listen for clients.

- **rpc_address and rpc_port:**
  - *Purpose:* Configures the Thrift RPC service address and port.

- **authenticator and authorizer:**
  - *Purpose:* Define authentication and authorization mechanisms.
  - *Configuration:* Uses PasswordAuthenticator and CassandraAuthorizer.

- **endpoint_snitch:**
  - *Purpose:* Defines how nodes are grouped into data centers and racks for efficient routing and replication.
  - *Configuration:* Set to SimpleSnitch.
 
    

**Step 7: Playbook Execution**

* To set up ScyllaDB on your target servers, you will execute the Ansible playbook using the following command:

```bash
ansible-playbook scylla-ansible-role/tests/test.yml
```
***
# Evaluate Output

* During the evaluation of output, we utilize the register and debug modules to verify whether our Ansible role is functioning correctly or not. In the image below, you will observe the output and status of the node.

![image](https://github.com/avengers-p7/Documentation/assets/156056709/e097d239-e38e-4973-b936-8658c16072cb)

![image](https://github.com/avengers-p7/Documentation/assets/156056709/459a0f88-2955-4d28-9467-69596386e5bc)

***
# Conclusion

* This guide demonstrates how to automate the setup of ScyllaDB in a development environment using Ansible. By following these steps, you can efficiently provision and configure ScyllaDB on your AWS infrastructure.

***
# Contact Information 

| Name | Email Address |
| ---- | -------------- |
| **[Parasharam Desai](https://github.com/Parasharam-Desai)** | parasharam.desai.snaatak@mygurukulam.co |

***
# Resources and References 

| Description | Source |
| ---- | -------------- |
|  Setting up Ansible AWS Dynamic Inventory | **[Link](https://devopscube.com/setup-ansible-aws-dynamic-inventory/)** |
|  ScyllaDB-Manual Setup | **[Link](https://github.com/avengers-p7/Documentation/tree/main/OT%20Micro%20Services/Software/ScyllaDB)** |
| [ScyllaDB Installation Guide](https://opensource.docs.scylladb.com/stable/getting-started/install-scylla/install-on-linux.html) | Comprehensive guide for installing ScyllaDB on Linux. |
| [ScyllaDB Configuration Guide](https://www.scylladb.com/download/?platform=ubuntu-22.04&version=scylla-5.2#open-source) | Step-by-step instructions for configuring ScyllaDB. |
| [Documentation Template](https://github.com/OT-MICROSERVICES/documentation-template/wiki/Software-Template) | Format inspiration for the document obtained from this repository. |
