# Ansible Unit Test POC

<img width="300" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/bd24f25f-675e-4aef-8050-73dc273cbe95">

***

| **Author** | **Created On** | **Last Updated** | **Document Version** |
| ---------- | -------------- | ---------------- | -------------------- |
| **Shreya Jaiswal** | **12 April 2024** | **12 April 2024** | **v1** |

***

# Table of Contents

1. [Introduction](#Introduction)
2. [Why Ansible Molecule](#Why-Ansible-Molecule)
3. [Pre-requisites](#Pre-requisites)
4. [Directory Structure](#Directory-Structure)
5. [Flow of Ansible Unit Test](#Flow-of-Ansible-Unit-Test)
6. [Steps of Ansible Unit Testing](#Steps-of-Ansible-Unit-Testing)
7. [Advantages of Ansible Molecule](#Advantages-of-Ansible-Molecule)
8. [Disadvantages of Ansible Molecule](#Disadvantages-of-Ansible-Molecule)
9. [Best Practices](#Best-Practices)
10. [Conclusion](#Conclusion)
11. [Contact Information](#Contact-Information)
12. [References](#References)

***

# Introduction

Ansible Molecule is a powerful tool designed to streamline the development and testing of Ansible roles. It provides a framework for automating the process of spinning up infrastructure, applying roles to that infrastructure, and running tests to ensure the roles behave as expected. Molecule helps Ansible developers to iterate quickly, catch bugs early, and maintain the reliability of their roles across different environments.

***

# Why Ansible Molecule?

| **Reason**                                      | **Description**                                                                                                    |
|-------------------------------------------------|--------------------------------------------------------------------------------------------------------------------|
| **Automation**                                      | Molecule automates the setup of test environments, reducing manual effort and ensuring consistent testing results. |
| **Isolation**                                       | Molecule provides isolated testing environments for each scenario, preventing interference between tests.          |
| **Flexibility**                                     | Molecule supports multiple backends and testing frameworks, allowing users to choose their preferred setup.         |
| **Scalability**                                     | Molecule scales seamlessly from simple unit tests to complex integration tests, accommodating diverse use cases.    |
| **Community Support**                               | Molecule is backed by an active community, ensuring ongoing support, updates, and a wealth of resources.            |

***

# Pre-requisites

| **Pre-requisite** | **Description** |
| ----------------- | --------------- |
| **Ansible** | Ansible should be installed. |
| **Molecule** | Molecule must be installed and configured. |
| **Python3 & pip** | Python3 and pip are requirements for Ansible and Molecule. |
| **Docker** | Docker is a requirement as we are using `docker` as a `driver`.Also ensure that `docker` is running. |
| **Pytest** | To install pytest globally, you can use the following command `sudo -H python3 -m pip install pytest`. |

***

#  Directory Structure

<img width="300" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/e0046246-fc38-4d56-b848-fecd0f41f519">

***

# Flow of Ansible Unit Test

<img width="900" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/32ed5f12-0953-48be-970c-9549fbb95801">

***

| **Step**                            | **Description**                                                                                                |
|-------------------------------------|----------------------------------------------------------------------------------------------------------------|
| **Define Tests and Playbook**           | Write tests using Testinfra or Goss. Define the playbook for your Ansible role.                                |
| **Generate Molecule Structure**         | Use `molecule init scenario` to generate the necessary directory structure for Molecule testing.               |
| **Configure Molecule**                  | Define configuration settings in `molecule.yml`, including platforms, provisioner, and scenarios.             |
| **Create Test Instances**               | Use `molecule create` to create test instances or containers based on the defined configuration.              |
| **Apply Ansible Role**                  | Use `molecule converge` to apply the Ansible role to the test instances, ensuring correct configuration.       |
| **Run Tests**                           | Use `molecule verify` to execute tests against the provisioned infrastructure, checking for the desired state. |
| **Destroy Test Instances**             | Use `molecule destroy` to tear down the test instances, cleaning up resources.                                 |
| **Review Test Results**                 | Review test results to identify failures or issues, debug, and refine the Ansible role accordingly.             |

***

# Steps of Ansible Unit Testing

## Step-01: Installation of some pre-requisites.

<details>
<summary> Click here to see commands</summary>
<br>
  
```shell

# install ansible
python3 -m pip install --user ansible
# Install the latest version of molecule from source
python3 -m pip install -U git+https://github.com/ansible-community/molecule
#install testinfra
python3 -m pip install --user pytest-testinfra
#install the molecule docker driver
python3 -m pip install -U "molecule[docker]"

```
</details>

## Step-02: Creation of role(demo_role) through `ansible galaxy`.

<details>
<summary> Click here to see command</summary>
<br>
  
```shell
ansible-galaxy init demo_role

```
</details>

## Step-03: Role Initialization

Initializing the role with Molecule, this will create a directory named `molecule` withing `demo_role` directory and it contains some default files `molecule.yml`, `create.yml`, `destroy.yml`, `converge.yml`.Note that, we can create files and folders withing molecule/default/ according to our requirement except the defaults. I have created a folder named `test` under molecule/default/ and under that, I have created `test_default.py` file.

<details>
<summary> Click here to see command</summary>
<br>
  
```shell
molecule init scenerio
or
molecule init scenerio default

```
</details>

<img width="300" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/ad6799b2-0273-418d-acb8-531c94e8e7a0">

***
## Step-04: After that, will configure the molecule's files:-

### First, we will configure `molecule.yml` file

This is the core file for Molecule. Used to define your testing steps, scenarios, dependencies, and other configuration options.

<details>
<summary> Click here to see molecule.yml file</summary>
<br>
  
```shell
---
dependency:
  name: galaxy
driver:
  name: docker
platforms:
  - name: instance
    image: quay.io/centos/centos:stream8
    pre_build_image: true
provisioner:
  name: ansible
verifier:
  name: testinfra

```
</details>

***

### Second, we will configure `converge.yml` file

This is the playbook that Molecule will run to provision the targets for testing. Below is the file that Molecule creates.

<details>
<summary> Click here to see molecule.yml file</summary>
<br>
  
```shell
---
- name: Converge
  hosts: all
  tasks:
    - name: "Include sample.demo_role"
      include_role:
        name: "demo_role"

```
</details>

***


### Then, we will configure `test_default.py` file

This is the initial test file generated for testinfra. This is where we will be putting our tests.

<details>
<summary> Click here to see molecule.yml file</summary>
<br>
  
```shell
"""Role testing files using testinfra."""
def test_hosts_file(host):
    """Validate etc/hosts file"""
    f = host.file("/etc/hosts")
    assert f.exists
    assert f.user == "root"
    assert f.group == "root"

```
</details>

***

## Step-05: Configuring the files for `demo_role`

We have a role that currently doesn’t do anything, let’s fix that by adding some tasks to ./tasks/main.yml. For this post, we’ll stick to the basics, only adding a few things we can write tests for. In this case, some yum packages, a user, and a config file. Provided in the code below.

### demo_role/tasks/main.yml file

<details>
<summary> Click here to see tasks/main.yml file</summary>
<br>
  
```shell

---
# tasks file for demo_role
- name: install some packages
  yum:
    name: "{{ item.name }}-{{item.version}}.{{ item.arch }}"
    state: installed
  with_items:
    - { name: 'epel-release', version: '8-11.el8', arch: 'noarch' }
    - { name: 'nginx', version: '1.14.1-9.module_el8.0.0+1060+3ab382d3', arch: 'x86_64' }
    - { name: 'git', version: '2.31.1-2.el8', arch: 'x86_64' }
- name: add webapp user
  ansible.builtin.user:
    name: webapp
    system: true
- name: create an app directory owned by webapp
  ansible.builtin.file:
    path: /opt/webapp
    state: directory
    owner: webapp
    group: webapp
- name: create app.conf owned by webapp
  ansible.builtin.file:
    path: /opt/webapp/app.conf
    state: touch
    owner: webapp
    group: webapp
    mode: '0755'
    access_time: preserve
    modification_time: preserve

```
</details>

***

### demo_role/meta/main.yml file

<details>
<summary> Click here to see meta/main.yml file</summary>
<br>
  
```shell

galaxy_info:
  author: shreya
  description: snaatak
  company: opstree
  role_name: demo_role

  # If the issue tracker for your role is not on github, uncomment the
  # next line and provide a value
  # issue_tracker_url: http://example.com/issue/tracker

  # Choose a valid license ID from https://spdx.org - some suggested licenses:
  # - BSD-3-Clause (default)
  # - MIT
  # - GPL-2.0-or-later
  # - GPL-3.0-only
  # - Apache-2.0
  # - CC-BY-4.0
  license: license (GPL-2.0-or-later, MIT, etc)

  min_ansible_version: 2.1

  # If this a Container Enabled role, provide the minimum Ansible Container version.
  # min_ansible_container_version:

  #
  # Provide a list of supported platforms, and for each platform a list of versions.
  # If you don't wish to enumerate all versions for a particular platform, use 'all'.
  # To view available platforms and versions (or releases), visit:
  # https://galaxy.ansible.com/api/v1/platforms/
  #
  # platforms:
  # - name: Fedora
  #   versions:
  #   - all
  #   - 25
  # - name: SomePlatform
  #   versions:
  #   - all
  #   - 1.0
  #   - 7
  #   - 99.99

  galaxy_tags: []
    # List tags for your role here, one per line. A tag is a keyword that describes
    # and categorizes the role. Users find roles by searching for tags. Be sure to
    # remove the '[]' above, if you add tags to this list.
    #
    # NOTE: A tag is limited to a single word comprised of alphanumeric characters.
    #       Maximum 20 tags per role.

dependencies: []
  # List your role dependencies here, one per line. Be sure to remove the '[]' above,
  # if you add dependencies to this list.

```
</details>

***

### demo_role/tests/test.yml

<details>
<summary> Click here to see tests/test.yml file</summary>
<br>
  
```shell

---
- hosts: localhost
  remote_user: root
  roles:
    - demo_role

```
</details>

***

## Step-06: Running `molecule commands`

### `molecule create`

We have a role that will process some tasks, first, we can run the command `molecule create` in the ./demo_role directory. Create uses the settings defined in the molecule.yml config to determine the driver and the platform. For this example, Molecule will use the following lines in the molecule.yml.It will use Ansible to launch a Docker container based on the quay.io/centos/centos:stream8 image, pulling it from the container registry if needed.

> [!NOTE]
> You can configure sudo to preserve the user's environment variables, including the PATH, by using the -E option.

```shell

sudo -E /home/shreya/.local/bin/molecule create

```

<img width="856" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/12f81b46-671b-456d-82bb-74731ee21012">

***

### `molecule converge`

Now that we have a target and a role, let’s bring them together with molecule converge . The converge command runs the converge.yml playbook against the target platform.

```shell

sudo -E /home/shreya/.local/bin/molecule converge

```

<img width="856" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/68483f42-e848-4fdd-86d3-99234e4d1a04">

***

### `molecule verify`

Now that we have run converge and deployed the containers, let’s run some tests. Use the command molecule verify to run the default test in test_default.py.

```shell

sudo -E /home/shreya/.local/bin/molecule converge

```

<img width="856" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/8b184e9b-9bde-4f00-b2f6-faf07918317d">

***

### Now let’s write some tests to confirm our role is doing what it should. We’ll start by testing that the proper packages and versions are installed. Add the following to ./molecule/default/tests/test_default.py, then run `molecule verify`.

```shell

import pytest
# Confirm that specific packages and versions are installed
@pytest.mark.parametrize("name,version", [
    ("epel-release", "8"),
    ("nginx", "1.14"),
    ("git", "2.31"),
])
def test_packages(host, name, version):
    pkg = host.package(name)
    assert pkg.is_installed
    assert pkg.version.startswith(version)

```

<img width="856" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/7ac339a9-efde-4845-b781-462c312b8f85">

***

### Next, we can test for the user webapp and the file app.conf. Add the following to `test_default.py` and run the command `molecule verify`.

```shell

import pytest

# Test that the webapp user is available.
@pytest.mark.parametrize("user,group", [
    ("webapp", "webapp"),
])
def test_users(host, user, group):
    usr = host.user(user)
    assert usr.exists
    assert usr.group == group

# Test that app.conf is present and has expected permissions
@pytest.mark.parametrize("filename,owner,group,mode", [
    ("/opt/webapp/app.conf", "webapp", "webapp", 0o755),
])
def test_file(host, filename, owner, group, mode):
    target = host.file(filename)
    assert target.exists
    assert target.user == owner
    assert target.group == group
    assert target.mode == mode

```

<img width="856" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/18b5c647-ed22-4754-bf34-33c0c803cd84">

***

### Finally, to clean up, we can run molecule destroy. This removes the containers that we deployed and provisioned with create or converge.

<img width="856" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/ca793892-b411-475c-a3ee-6b602f507d26">

***

## Step-07 One command to rule them all `molecule test`.

One last Molecule command to look at is molecule test. The test command will run the entire scenario; creating, converging, verifying, and more.

<img width="856" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/43fcadd0-e149-4721-a7eb-3fe74ae91ffa">

***

# Advantages of Ansible Molecule

| **Advantage**                             | **Description**                                                                                                      |
|-------------------------------------------|----------------------------------------------------------------------------------------------------------------------|
| **Automation**                                | Molecule automates the setup and teardown of test environments, reducing manual effort and ensuring consistency.     |
| **Isolation**                                 | Molecule provides isolated testing environments, preventing interference between tests and ensuring reproducibility. |
| **Flexibility**                               | Supports various backends (Docker, Vagrant, etc.) and testing frameworks, offering flexibility in testing approaches.|
| **Scalability**                               | Scales seamlessly from simple unit tests to complex integration tests, accommodating projects of varying complexities.|
| **Community Support**                         | Backed by an active community, ensuring ongoing support, updates, and a wealth of resources for troubleshooting.      |


***

# Disadvantages of Ansible Molecule

| **Disadvantage**                          | **Description**                                                                                                      |
|-------------------------------------------|----------------------------------------------------------------------------------------------------------------------|
| **Learning Curve**                            | Requires learning curve, especially for beginners unfamiliar with testing frameworks and Molecule configuration.     |
| **Resource Intensive**                        | May require significant system resources, especially when testing complex scenarios or using resource-intensive backends.|
| **Integration with Existing Systems**         | Integration with existing CI/CD pipelines and infrastructure may require additional configuration and setup.         |
| **Overhead in Simple Projects**               | Adds overhead in simple projects or small teams where manual testing suffices, potentially slowing down development.  |

***

# Best Practices

| **Best Practice**                                 | **Description**                                                                                                    |
|---------------------------------------------------|--------------------------------------------------------------------------------------------------------------------|
| **Use Small and Focused Tests**                      | Write small, focused tests that validate specific aspects of your Ansible role's functionality.                    |
| **Leverage Idempotence**                             | Ensure that your Ansible role is idempotent to simplify testing and promote consistency.                           |
| **Automate Testing in CI/CD Pipelines**              | Integrate Molecule tests into CI/CD pipelines to automate testing and identify issues early in the development cycle.|
| **Regularly Update Dependencies**                    | Keep Molecule and its dependencies up to date to benefit from bug fixes, performance improvements, and new features.|

***

# Conclusion

In conclusion, following these best practices with Ansible Molecule helps ensure that testing your Ansible roles is smooth and reliable. By keeping tests small and focused, making sure your roles can be applied multiple times without messing things up (that's what "idempotence" means), and automating tests whenever possible, you can catch and fix issues early on. 

***

# Contact Information

| **Name** | **Email Address** |
| -------- | ----------------- |
| **Shreya Jaiswal** | shreya.jaiswal.snaatak@mygurukulam.co |

***

# References 

| **Source** | **Description** |
| --------- | --------------- |
| [Link](https://medium.com/contino-engineering/testing-ansible-automation-with-molecule-pt-1-66ab3ea7a58a) | Ansible Unit Test Reference Link |
| [Link](https://github.com/ansible-community/molecule) | Ansible Unit Test Reference Link |
| [Link](https://ansible.readthedocs.io/projects/molecule/) | Concept of Ansible Unit Test |

