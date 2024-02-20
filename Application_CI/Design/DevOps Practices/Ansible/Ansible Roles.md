# Ansibe Roles 
![76 ansible-roles](https://github.com/avengers-p7/Documentation/assets/156056344/03abe0eb-9fca-40c7-b308-5474f3f67784)


|   Authors        |  Created on   |  Version   | Last updated by | Last edited on |
| -----------------| --------------| -----------|---------------- | -------------- |
| Aakash Tripathi      |  20 Feb 2024   |     v1     | Aakash Tripathi     | 20 Feb 2024    |

***
## Table of Contents
+ [Introduction](#Introduction)
+ [Why Ansible Roles](#why-ansible-roles)
+ [Creating A Role ](#creating-a-role)
+ [Role Directory Structure](#role-directory-structure)
+ [Storing And Finding Roles](#storing-and-finding-roles)
+ [Using Roles](#using-roles)
+ [Best Practices](#best-practices)
+ [Conclusion](#conclusion)
+ [Contact Information](#contact-information)
+ [References](#references)

***
## Introduction
In Ansible, roles are a way to organize and structure your playbooks to promote reusability and maintainability. A role is essentially a collection of tasks, variables, files, and templates organized in a specific directory structure. Roles make it easy to share and reuse configurations across different projects.

## Why Ansible Roles 

Ansible roles offer several advantages that contribute to better organization, reusability, and maintainability of your Ansible playbooks:

| **Feature** | **Description** |
| ----------- | --------------- |
| Modularity | Roles allow you to break down complex playbooks into smaller, more manageable components. Each role can represent a specific functionality or application component, making it easier to understand and maintain. |
| Reusability | Once you've defined a role, you can reuse it across multiple playbooks and projects. This promotes consistency and reduces duplication of code, ensuring that best practices are applied consistently. |
| Encapsulation | Roles encapsulate tasks, variables, and other resources related to a specific functionality. This encapsulation helps in isolating different parts of your infrastructure and promotes a cleaner, more maintainable codebase. |
| Parameterization | Roles allow you to define default variables in the defaults/main.yml file, providing a way to customize the behavior of the role without modifying its code. Users can override these variables in their playbooks to adapt the role to specific requirements. |
| Dependency Management | The meta/main.yml file in a role allows you to specify dependencies for the role. This ensures that the required roles are installed and executed before the current role, simplifying the management of complex infrastructures with multiple dependencies. |
| Separation of Concerns | Roles provide a clear separation of concerns by organizing tasks, variables, and other resources into distinct directories. This separation makes it easier for different team members to work on different aspects of the infrastructure without interfering with each other's code. |
| Testing and Validation | Roles make it easier to test and validate specific functionalities independently. You can run tests on individual roles before integrating them into a larger playbook, allowing for more efficient debugging and troubleshooting. |
| Community Contributions | Ansible Galaxy, a platform for sharing Ansible roles, encourages the creation of reusable roles by the community. This means you can leverage and contribute to a vast repository of roles that cover a wide range of applications and infrastructure components.|

***
## Creating A Role 
Creating an Ansible role involves creating a specific directory structure and organizing your tasks, variables, and other resources within that structure. Here is a step-by-step guide on how to create a basic Ansible role:

1. Navigate to your Ansible project directory:

 ```shell
 cd /path/to/your/ansible/project
 ```
   
3. Create the role directory structure:

```shell
ansible-galaxy init my_role
```
This command will create a directory named my_role with the basic structure of an Ansible role. More information on role directory structure [here](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Design/DevOps%20Practices/Ansible/Ansible%20Role.md#role-directory-structure)

3.Navigate into the role directory:
```shell
cd my_role
```
4. Edit the role files:

* Edit tasks/main.yml:
  Add the tasks that you want the role to perform. For example:

```yaml
---
- name: Install a package
  apt:
    name: my-package
    state: present
```
* Edit defaults/main.yml:
  Define default variables that can be overridden by the user. For example:

```yaml
---
my_variable: "default_value"
```

* Edit other files as needed:
  Depending on your requirements, you may also edit handlers/main.yml, meta/main.yml, vars/main.yml, and add files to files/ or templates/.

5. Create a playbook to use the role:
Create a playbook (e.g., my_playbook.yml) in your project directory or any subdirectory. Use the role in the playbook like this:

```yaml
---
- hosts: my_servers
  roles:
    - my_role
```

Ensure that my_servers is defined in your inventory file.

6.Run the playbook:

Execute the playbook using the following command:

```shell
ansible-playbook my_playbook.yml
```
This will apply the tasks defined in your role to the specified hosts.

That's it! You've created a basic Ansible role. You can now reuse this role in other playbooks, and if needed, share it with the community on Ansible Galaxy.
Remember that this is a simple example, and roles can be extended and customized based on the complexity of the tasks you need to perform. Consider adding documentation to your role in the form of a README.md file to explain its purpose, usage, and any specific requirements.

***
## Role Directory Structure 
An Ansible role has a defined directory structure with eight main standard directories. You must include at least one of these directories in each role. You can omit any directories the role does not use. For example:

```ini
  roles/
    common/               # this hierarchy represents a "role"
        tasks/            #
            main.yml      #  <-- tasks file can include smaller files if warranted
        handlers/         #
            main.yml      #  <-- handlers file
        templates/        #  <-- files for use with the template resource
            ntp.conf.j2   #  <------- templates end in .j2
        files/            #
            bar.txt       #  <-- files for use with the copy resource
            foo.sh        #  <-- script files for use with the script resource
        vars/             #
            main.yml      #  <-- variables associated with this role
        defaults/         #
            main.yml      #  <-- default lower priority variables for this role
        meta/             #
            main.yml      #  <-- role dependencies
        library/          # roles can also include custom modules
        module_utils/     # roles can also include custom module_utils
        lookup_plugins/   # or other types of plugins, like lookup in this case

    webtier/              # same kind of structure as "common" was above, done for the webtier role
    monitoring/           # ""
    fooapp/               # ""
```

![1_k_JStx2Xj0jssXrPtY6-vQ](https://github.com/avengers-p7/Documentation/assets/156056344/1abfb64d-2a97-4453-a414-e20190833a4b)

By default, Ansible will look in each directory within a role for a main.yml file for relevant content (also main.yaml and main):

| **Directory/File** | **Description** |
| ------------------ | --------------- |
| tasks/main.yml | The main list of tasks that the role executes. |
| handlers/main.yml |  Handlers, which may be used within or outside this role. |
| library/my_module.py | Modules, which may be used within this role |
| defaults/main.yml | Default variables for the role. These variables have the lowest priority of any variables available and can be easily overridden by any other variable, including inventory variables. |
| vars/main.yml | Other variables for the role (see Using Variables for more information). |
| files/main.yml | Files that the role deploys |
| templates/main.yml | Templates that the role deploys. |
| meta/main.yml | Metadata for the role, including role dependencies and optional Galaxy metadata such as platforms supported. |

You can add other YAML files in some directories. For example, you can place platform-specific tasks in separate files and refer to them in the tasks/main.yml file.

***
## Storing And Finding Roles

By default, Ansible looks for roles in the following locations:
+ In collections, if you are using them
+ In a directory called roles/, relative to the playbook file
+ In the configured roles_path. The default search path is `~/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles`.
+ In the directory where the playbook file is located

If you store your roles in a different location, set the roles_path configuration option so Ansible can find your roles. Checking shared roles into a single location makes them easier to use in multiple playbooks.

Alternatively, you can call a role with a fully qualified path:
```yaml
---
- hosts: webservers
  roles:
    - role: '/path/to/my/roles/common'
```
***

## Using Roles 

You can use roles in three ways:

+ At the play level with the roles option: This is the classic way of using roles in a play.
+ At the tasks level with `include_role`: You can reuse roles dynamically anywhere in the tasks section of a play using `include_role`.
+ At the tasks level with `import_role`: You can reuse roles statically anywhere in the tasks section of a play using `import_role`.

The classic and most obvious way is to reference a role at the play level with the roles option:

```yaml
---
- hosts: my_servers
  roles:
    - my_role
```
***

## Best Practices 
When creating Ansible roles, following best practices helps ensure your roles are modular, maintainable, and easy to use. Here are some best practices for creating Ansible roles:

| **Best Practice** | **Description** |
| ----------------- | --------------- |
| Use ansible-galaxy init | When creating a new role, use the ansible-galaxy init command to set up the basic directory structure. This provides a standardized layout for your roles and includes directories for tasks, defaults, handlers, meta, templates, vars, and files. |
| Document your role | Include a README.md file in your role directory with information about the role's purpose, variables, dependencies, and usage. Documentation is crucial for users who may want to leverage or contribute to your role. |
| Parameterize variables | Use the defaults/main.yml file to define default variables. Parameterizing your role makes it more flexible and allows users to customize the role's behavior by overriding these variables in their playbooks. |
| Separate sensitive data | Avoid hardcoding sensitive information such as passwords or API keys directly into your roles. Instead, use Ansible Vault to encrypt sensitive data or prompt users for input during playbook execution. |
| Test your role | Implement testing for your role using tools like Molecule. Testing ensures that your role works as expected and can be safely reused. Include test cases for different scenarios and platforms.|
| Version your roles | If you plan to share your roles with others, use version control (e.g., Git) and include version information in your role's meta/main.yml file. This helps users understand which version of the role they are using. |


By adhering to these best practices, you'll create Ansible roles that are more maintainable, shareable, and adaptable to various environments and use cases.

***
## Conclusion
In conclusion, Ansible roles serve as a powerful organizational and modularization tool within Ansible playbooks, enabling the creation of reusable, well-structured components. By adhering to best practices such as effective task organization, parameterizing variables, documenting thoroughly, handling dependencies, and implementing testing, roles become a key asset in the automation toolkit.

***
## Contact Information

|Aakash Tripathi                 | aakash.tripathi.snaatak@mygurukulam.co                                                                                      
|---------------------------------|------------------------------------------------------------|

***
## References

| Title                                      | URL                                           |
|--------------------------------------------|-----------------------------------------------|
| Ansible Role Docs         |  https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_reuse_roles.html   |
| Role POC          | https://spacelift.io/blog/ansible-roles |
| Ansible Roles                | [Jenkins]() , [SonarQube]() , [Redis](https://github.com/CodeOps-Hub/redis-ansiblerole/blob/main/README.md) , [ScyllaDB]() , [Postgres]() | 

