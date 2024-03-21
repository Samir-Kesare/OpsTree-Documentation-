# DSL Jenkins Pipeline for tf module CD of Standalone (Using Shared Library)

![image](https://github.com/avengers-p7/Documentation/assets/156056460/44f80ab7-909e-48c2-8b1e-ea004054137e)

|   Author        |  Created on   |  Version   | Last updated by  | Last edited on |
| --------------- | --------------| -----------|----------------- | -------------- |
| Shantanu |  20-03-2024  |  Version 1 | Shantanu | 21-03-2024   |
***

# Table Of Contents
- [Introduction](#introduction)
- [Pre-requisites](#pre-requisites)
- [Implementation of CI checks on Terraform Module](#implementation-of-ci-checks-on-terraform-module)
- [Shared Library Jenkins File](#shared-library-jenkins-file)
- [Terraform groovy template file](#terraform-groovy-template-file)
- [Shared Library Src file](#shared-library-src-file)
- [Contact Information](#contact-information)
- [References](#references)
***

# Introduction
Continuous Deployment (CD) is an integral part of the Continuous Integration/Continuous Deployment (CI/CD) pipeline, playing a crucial role in automating the delivery of software updates to production environments. Unlike Continuous Integration, which focuses on code integration and testing, Continuous Deployment extends the automation process to include the release and deployment of code changes. With CD, every successful build that passes through the CI phase is automatically deployed to production environments, eliminating manual intervention and reducing the time between code changes and their availability to end-users. This approach not only enhances the speed of software delivery but also increases the reliability and consistency of deployments, as automated processes minimize the risk of human error. By enabling teams to release updates quickly and frequently while maintaining stability and quality, Continuous Deployment empowers organizations to deliver value to customers more efficiently and stay ahead in today's fast-paced digital landscape.

***

# Pre-requisites

| Tool |
|------|
| Terraform |
| tflint |
| checkov |
***

# Implementation of CI checks on Terraform Module

![image](https://github.com/avengers-p7/Documentation/assets/156056460/923eea03-8c36-4c93-ae51-554ac3e05cc8)


| Tool             | Purpose                                                                                                                                                                  |
|------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Terraform fmt    | Automatically formats Terraform configuration files (.tf files) to ensure consistent styling and layout.                                                                   |
| Terraform validate | Verifies whether the configuration files are syntactically correct and internally consistent. It checks for errors in attribute names, argument types, and required inputs. |
| Terraform lint   | Performs static analysis of Terraform code to identify potential issues, such as deprecated syntax, unused variables, or non-idiomatic patterns.                           |
| Checkov          | A static code analysis tool for Infrastructure as Code (IaC), including Terraform. It scans Terraform configuration files for security and best practice issues.        |


**Step-1** Create a New Pipeline Job

- Navigate to the Jenkins dashboard and click on New Item.
- Enter a name for your job (e.g., "Terraform.CI").
- Select Pipeline and click OK.

**Step-2** Configure Pipeline Script

- In the job configuration page, scroll down to the Pipeline section.
- Select Pipeline script from SCM.
- Give required repo url and enter your credentials.

![Screenshot 2024-03-21 at 5 22 08 PM](https://github.com/CodeOps-Hub/Documentation/assets/156056364/f05cd205-0465-4f01-99a8-a5a763e25e01)
***
![Screenshot 2024-03-21 at 5 22 41 PM](https://github.com/CodeOps-Hub/Documentation/assets/156056364/25cf111b-4493-4e2c-81be-dc7f95c271a6)

**Step-3** Save the Configuration

- Click on Save to save the job configuration.

**Step-4** Build the Pipeline

- Once the pipeline configuration is saved, you can manually trigger the build by clicking on Build Now.

**Step-5** View Build Console Output

- After triggering the build, you can view the progress and console output of the build by clicking on the build number in the Jenkins dashboard.
- The console output will display the steps executed by the pipeline script, including code checkout and compilation.
- Verify Successful Compilation.

![Screenshot 2024-03-21 at 4 39 56 PM](https://github.com/CodeOps-Hub/Documentation/assets/156056364/3795481b-a7fd-42ee-b343-20efa2ecd241)


***


<details>
  <summary> Click here to see the Console Output</summary>
<br>

  ```shell
  
Started by user Shantanu
Obtained SharedLibrary/Module_CI_CD/Standalone/Jenkinsfile from git https://github.com/CodeOps-Hub/Jenkinsfile.git
Loading library my-shared-library@main
Attempting to resolve main from remote references...
 > git --version # timeout=10
 > git --version # 'git version 2.25.1'
using GIT_ASKPASS to set credentials shantanu-pat
 > git ls-remote -h -- https://github.com/CodeOps-Hub/SharedLibrary.git # timeout=10
Found match: refs/heads/main revision c1b12ac0eacd115b5c7842ee9dbda32cb871eaf9
The recommended git tool is: NONE
using credential shantanu-pat
 > git rev-parse --resolve-git-dir /var/lib/jenkins/workspace/DSL_CI-CD_Standalone_Module@libs/fa825161180b48026f3f72bd86b5280b41948ba0e7505a66c83f19dbed0a5928/.git # timeout=10
Fetching changes from the remote Git repository
 > git config remote.origin.url https://github.com/CodeOps-Hub/SharedLibrary.git # timeout=10
Fetching without tags
Fetching upstream changes from https://github.com/CodeOps-Hub/SharedLibrary.git
 > git --version # timeout=10
 > git --version # 'git version 2.25.1'
using GIT_ASKPASS to set credentials shantanu-pat
 > git fetch --no-tags --force --progress -- https://github.com/CodeOps-Hub/SharedLibrary.git +refs/heads/*:refs/remotes/origin/* # timeout=10
Checking out Revision c1b12ac0eacd115b5c7842ee9dbda32cb871eaf9 (main)
 > git config core.sparsecheckout # timeout=10
 > git checkout -f c1b12ac0eacd115b5c7842ee9dbda32cb871eaf9 # timeout=10
Commit message: "Update ci.groovy"
 > git rev-list --no-walk c1b12ac0eacd115b5c7842ee9dbda32cb871eaf9 # timeout=10
[Pipeline] Start of Pipeline
[Pipeline] node
Running on Jenkins in /var/lib/jenkins/workspace/DSL_CI-CD_Standalone_Module
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Declarative: Checkout SCM)
[Pipeline] checkout
Selected Git installation does not exist. Using Default
The recommended git tool is: NONE
using credential shantanu-pat
 > git rev-parse --resolve-git-dir /var/lib/jenkins/workspace/DSL_CI-CD_Standalone_Module/.git # timeout=10
Fetching changes from the remote Git repository
 > git config remote.origin.url https://github.com/CodeOps-Hub/Jenkinsfile.git # timeout=10
Fetching upstream changes from https://github.com/CodeOps-Hub/Jenkinsfile.git
 > git --version # timeout=10
 > git --version # 'git version 2.25.1'
using GIT_ASKPASS to set credentials shantanu-pat
 > git fetch --tags --force --progress -- https://github.com/CodeOps-Hub/Jenkinsfile.git +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git rev-parse refs/remotes/origin/Shantanu/DSL_Standalone^{commit} # timeout=10
Checking out Revision 5513e07b1cdbcd53934ec77c8f455f02ce1e63ec (refs/remotes/origin/Shantanu/DSL_Standalone)
 > git config core.sparsecheckout # timeout=10
 > git checkout -f 5513e07b1cdbcd53934ec77c8f455f02ce1e63ec # timeout=10
Commit message: "Update Jenkinsfile"
 > git rev-list --no-walk 5513e07b1cdbcd53934ec77c8f455f02ce1e63ec # timeout=10
[Pipeline] }
[Pipeline] // stage
[Pipeline] withEnv
[Pipeline] {
[Pipeline] withCredentials
Masking supported pattern matches of $AWS_ACCESS_KEY_ID or $AWS_SECRET_ACCESS_KEY
[Pipeline] {
[Pipeline] withEnv
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Terraform)
[Pipeline] script
[Pipeline] {
[Pipeline] properties
[Pipeline] stage
[Pipeline] { (Clone)
[Pipeline] script
[Pipeline] {
[Pipeline] git
The recommended git tool is: NONE
using credential shantanu-pat
 > git rev-parse --resolve-git-dir /var/lib/jenkins/workspace/DSL_CI-CD_Standalone_Module/.git # timeout=10
Fetching changes from the remote Git repository
 > git config remote.origin.url https://github.com/CodeOps-Hub/Terraform-modules.git # timeout=10
Fetching upstream changes from https://github.com/CodeOps-Hub/Terraform-modules.git
 > git --version # timeout=10
 > git --version # 'git version 2.25.1'
using GIT_ASKPASS to set credentials shantanu-pat
 > git fetch --tags --force --progress -- https://github.com/CodeOps-Hub/Terraform-modules.git +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git rev-parse refs/remotes/origin/main^{commit} # timeout=10
Checking out Revision 5c569e3c1f0485be68051ce76e16529800a1c290 (refs/remotes/origin/main)
 > git config core.sparsecheckout # timeout=10
 > git checkout -f 5c569e3c1f0485be68051ce76e16529800a1c290 # timeout=10
 > git branch -a -v --no-abbrev # timeout=10
 > git branch -D main # timeout=10
 > git checkout -b main 5c569e3c1f0485be68051ce76e16529800a1c290 # timeout=10
Commit message: "Merge pull request #17 from CodeOps-Hub/Shikha/Salary/Salary-app"
 > git rev-list --no-walk 5c569e3c1f0485be68051ce76e16529800a1c290 # timeout=10
[Pipeline] }
[Pipeline] // script
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Terraform action)
[Pipeline] script
[Pipeline] {
[Pipeline] sh
+ cd Modules/VM-Module
[Pipeline] }
[Pipeline] // script
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Terraform init)
[Pipeline] script
[Pipeline] {
[Pipeline] sh
+ cd Modules/VM-Module
+ terraform init

[0m[1mInitializing the backend...[0m

[0m[1mInitializing provider plugins...[0m
- Reusing previous version of hashicorp/tls from the dependency lock file
- Reusing previous version of hashicorp/aws from the dependency lock file
- Reusing previous version of hashicorp/local from the dependency lock file
- Using previously-installed hashicorp/tls v4.0.5
- Using previously-installed hashicorp/aws v5.41.0
- Using previously-installed hashicorp/local v2.5.1

[0m[1m[32mTerraform has been successfully initialized![0m[32m[0m
[0m[32m
You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.[0m
[Pipeline] }
[Pipeline] // script
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Terraform fmt)
[Pipeline] script
[Pipeline] {
[Pipeline] sh
+ cd Modules/VM-Module
+ sudo terraform fmt
main.tf
variables.tf
[Pipeline] }
[Pipeline] // script
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Terraform Validate)
[Pipeline] script
[Pipeline] {
[Pipeline] sh
+ cd Modules/VM-Module
+ sudo terraform validate
[32m[1mSuccess![0m The configuration is valid.
[0m
[Pipeline] }
[Pipeline] // script
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Static Code Analysis)
[Pipeline] script
[Pipeline] {
[Pipeline] sh
+ curl -s https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh
+ sudo bash
arch=amd64
os=linux_amd64


====================================================
Looking up the latest version ...
Downloading TFLint v0.50.3
Downloaded successfully


====================================================
Unpacking /tmp/tflint.5jC9clYnMp/tflint.zip ...
Archive:  /tmp/tflint.5jC9clYnMp/tflint.zip
  inflating: /tmp/tflint.5jC9clYnMp/tflint  
Installing /tmp/tflint.5jC9clYnMp/tflint to /usr/local/bin/ ...
removed '/usr/local/bin/tflint'
'/tmp/tflint.5jC9clYnMp/tflint' -> '/usr/local/bin/tflint'
Cleaning temporary downloaded files directory /tmp/tflint.5jC9clYnMp ...


====================================================
Current tflint version
TFLint version 0.50.3
+ ruleset.terraform (0.5.0-bundled)
[Pipeline] sh
+ cd Modules/VM-Module
+ tflint --format default
+ tee tflint_report.json
4 issue(s) found:

Warning: terraform "required_version" attribute is required (terraform_required_version)

  on  line 0:
   (source code not available)

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.5.0/docs/rules/terraform_required_version.md

Warning: Missing version constraint for provider "tls" in `required_providers` (terraform_required_providers)

  on main.tf line 37:
  37: resource "tls_private_key" "rsa_4096" {

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.5.0/docs/rules/terraform_required_providers.md

Warning: Missing version constraint for provider "local" in `required_providers` (terraform_required_providers)

  on main.tf line 49:
  49: resource "local_file" "private_key" {

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.5.0/docs/rules/terraform_required_providers.md

Warning: Missing version constraint for provider "aws" in `required_providers` (terraform_required_providers)

  on main.tf line 56:
  56: resource "aws_instance" "standalone_server" {

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.5.0/docs/rules/terraform_required_providers.md

[Pipeline] }
[Pipeline] // script
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (checkov)
[Pipeline] script
[Pipeline] {
[Pipeline] sh
+ test -x /var/lib/jenkins/.local/bin/checkov
+ echo Installed
Installed
[Pipeline] echo
Checkov is already installed.
[Pipeline] sh
+ cd Modules/VM-Module
+ /var/lib/jenkins/.local/bin/checkov -d . -s --output-file-path . --skip-path ./tflint_report.jsonֿ

       _               _              
   ___| |__   ___  ___| | _______   __
  / __| '_ \ / _ \/ __| |/ / _ \ \ / /
 | (__| | | |  __/ (__|   < (_) \ V / 
  \___|_| |_|\___|\___|_|\_\___/ \_/  
                                      
By Prisma Cloud | version: 3.2.43 

terraform scan results:

Passed checks: 7, Failed checks: 6, Skipped checks: 0

Check: CKV_AWS_260: "Ensure no security groups allow ingress from 0.0.0.0:0 to port 80"
	PASSED for resource: aws_security_group.sec_grp
	File: /main.tf:7-34
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-aws-security-groups-do-not-allow-ingress-from-00000-to-port-80
Check: CKV_AWS_25: "Ensure no security groups allow ingress from 0.0.0.0:0 to port 3389"
	PASSED for resource: aws_security_group.sec_grp
	File: /main.tf:7-34
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/networking-2
Check: CKV_AWS_277: "Ensure no security groups allow ingress from 0.0.0.0:0 to port -1"
	PASSED for resource: aws_security_group.sec_grp
	File: /main.tf:7-34
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-aws-security-group-does-not-allow-all-traffic-on-all-ports
Check: CKV_AWS_24: "Ensure no security groups allow ingress from 0.0.0.0:0 to port 22"
	PASSED for resource: aws_security_group.sec_grp
	File: /main.tf:7-34
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/networking-1-port-security
Check: CKV_AWS_46: "Ensure no hard-coded secrets exist in EC2 user data"
	PASSED for resource: aws_instance.standalone_server
	File: /main.tf:56-68
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/secrets-policies/bc-aws-secrets-1
Check: CKV_AWS_88: "EC2 instance should not have public IP."
	PASSED for resource: aws_instance.standalone_server
	File: /main.tf:56-68
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/public-policies/public-12
Check: CKV2_AWS_5: "Ensure that Security Groups are attached to another resource"
	PASSED for resource: aws_security_group.sec_grp
	File: /main.tf:7-34
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-that-security-groups-are-attached-to-ec2-instances-or-elastic-network-interfaces-enis
Check: CKV_AWS_23: "Ensure every security groups rule has a description"
	FAILED for resource: aws_security_group.sec_grp
	File: /main.tf:7-34
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/networking-31

		7  | resource "aws_security_group" "sec_grp" {
		8  |   name        = var.sec_grp_name
		9  |   description = var.Sec_grp_description
		10 |   vpc_id      = var.vpc_id
		11 | 
		12 |   dynamic "ingress" {
		13 |     for_each = local.inbound_ports
		14 |     content {
		15 |       from_port       = ingress.value.port
		16 |       to_port         = ingress.value.port
		17 |       protocol        = ingress.value.protocol
		18 |       cidr_blocks     = contains(keys(ingress.value), "cidr_blocks") ? [ingress.value.cidr_blocks] : null
		19 |       security_groups = contains(keys(ingress.value), "security_group_ids") ? [ingress.value.security_group_ids] : null
		20 |     }
		21 |   }
		22 | 
		23 |   dynamic "egress" {
		24 |     for_each = local.outbound_ports
		25 |     content {
		26 |       from_port   = egress.value.port
		27 |       to_port     = egress.value.port
		28 |       protocol    = egress.value.protocol
		29 |       cidr_blocks = [egress.value.cidr_blocks]
		30 |     }
		31 |   }
		32 | 
		33 |   tags = var.Sec_grp_tags
		34 | }

Check: CKV_AWS_126: "Ensure that detailed monitoring is enabled for EC2 instances"
	FAILED for resource: aws_instance.standalone_server
	File: /main.tf:56-68
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-logging-policies/ensure-that-detailed-monitoring-is-enabled-for-ec2-instances

		56 | resource "aws_instance" "standalone_server" {
		57 |   ami                         = data.aws_ami.ubuntu.id
		58 |   instance_type               = var.server_type
		59 |   key_name                    = aws_key_pair.key_pair.key_name
		60 |   subnet_id                   = var.subnet_id
		61 |   associate_public_ip_address = false
		62 |   vpc_security_group_ids      = [aws_security_group.sec_grp.id]
		63 |   tags = {
		64 |     Name = var.server_name
		65 |     Type = "dev"
		66 |   }
		67 | 
		68 | }

Check: CKV_AWS_79: "Ensure Instance Metadata Service Version 1 is not enabled"
	FAILED for resource: aws_instance.standalone_server
	File: /main.tf:56-68
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-general-policies/bc-aws-general-31

		56 | resource "aws_instance" "standalone_server" {
		57 |   ami                         = data.aws_ami.ubuntu.id
		58 |   instance_type               = var.server_type
		59 |   key_name                    = aws_key_pair.key_pair.key_name
		60 |   subnet_id                   = var.subnet_id
		61 |   associate_public_ip_address = false
		62 |   vpc_security_group_ids      = [aws_security_group.sec_grp.id]
		63 |   tags = {
		64 |     Name = var.server_name
		65 |     Type = "dev"
		66 |   }
		67 | 
		68 | }

Check: CKV_AWS_135: "Ensure that EC2 is EBS optimized"
	FAILED for resource: aws_instance.standalone_server
	File: /main.tf:56-68
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-general-policies/ensure-that-ec2-is-ebs-optimized

		56 | resource "aws_instance" "standalone_server" {
		57 |   ami                         = data.aws_ami.ubuntu.id
		58 |   instance_type               = var.server_type
		59 |   key_name                    = aws_key_pair.key_pair.key_name
		60 |   subnet_id                   = var.subnet_id
		61 |   associate_public_ip_address = false
		62 |   vpc_security_group_ids      = [aws_security_group.sec_grp.id]
		63 |   tags = {
		64 |     Name = var.server_name
		65 |     Type = "dev"
		66 |   }
		67 | 
		68 | }

Check: CKV_AWS_8: "Ensure all data stored in the Launch configuration or instance Elastic Blocks Store is securely encrypted"
	FAILED for resource: aws_instance.standalone_server
	File: /main.tf:56-68
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-general-policies/general-13

		56 | resource "aws_instance" "standalone_server" {
		57 |   ami                         = data.aws_ami.ubuntu.id
		58 |   instance_type               = var.server_type
		59 |   key_name                    = aws_key_pair.key_pair.key_name
		60 |   subnet_id                   = var.subnet_id
		61 |   associate_public_ip_address = false
		62 |   vpc_security_group_ids      = [aws_security_group.sec_grp.id]
		63 |   tags = {
		64 |     Name = var.server_name
		65 |     Type = "dev"
		66 |   }
		67 | 
		68 | }

Check: CKV2_AWS_41: "Ensure an IAM role is attached to EC2 instance"
	FAILED for resource: aws_instance.standalone_server
	File: /main.tf:56-68
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-iam-policies/ensure-an-iam-role-is-attached-to-ec2-instance

		56 | resource "aws_instance" "standalone_server" {
		57 |   ami                         = data.aws_ami.ubuntu.id
		58 |   instance_type               = var.server_type
		59 |   key_name                    = aws_key_pair.key_pair.key_name
		60 |   subnet_id                   = var.subnet_id
		61 |   associate_public_ip_address = false
		62 |   vpc_security_group_ids      = [aws_security_group.sec_grp.id]
		63 |   tags = {
		64 |     Name = var.server_name
		65 |     Type = "dev"
		66 |   }
		67 | 
		68 | }

terraform_plan scan results:

Passed checks: 0, Failed checks: 0, Skipped checks: 0, Parsing errors: 1

Error parsing file ./tflint_report.jsonֿ

[Pipeline] }
[Pipeline] // script
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Git Tag Stage)
[Pipeline] script
[Pipeline] {
[Pipeline] sh
+ git tag -a v1.1 -m Version 1.1
[Pipeline] }
[Pipeline] // script
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Git Push Version Stage)
[Pipeline] script
[Pipeline] {
[Pipeline] withCredentials
Masking supported pattern matches of $PASSWORD
[Pipeline] {
[Pipeline] sh
Warning: A secret was passed to "sh" using Groovy String interpolation, which is insecure.
		 Affected argument(s) used the following variable(s): [PASSWORD]
		 See https://jenkins.io/redirect/groovy-string-interpolation for details.
+ git push https://username:****@github.com/CodeOps-Hub/Terraform-modules.git v1.1
To https://github.com/CodeOps-Hub/Terraform-modules.git
 * [new tag]         v1.1 -> v1.1
[Pipeline] }
[Pipeline] // withCredentials
[Pipeline] }
[Pipeline] // script
[Pipeline] }
[Pipeline] // stage
[Pipeline] }
[Pipeline] // script
[Pipeline] }
[Pipeline] // stage
[Pipeline] }
[Pipeline] // withEnv
[Pipeline] }
[Pipeline] // withCredentials
[Pipeline] }
[Pipeline] // withEnv
[Pipeline] }
[Pipeline] // node
[Pipeline] End of Pipeline
Finished: SUCCESS


```
</details>

***

<details>
	<summary> Click here to see checkov output</summary>
<br>
	
```shell
	
 terraform scan results:
terraform scan results:

Passed checks: 11, Failed checks: 2, Skipped checks: 0

Check: CKV_AWS_260: "Ensure no security groups allow ingress from 0.0.0.0:0 to port 80"
	PASSED for resource: aws_security_group.security_group
	File: /main.tf:7-33
	Guide: [1mhttps://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-aws-security-groups-do-not-allow-ingress-from-00000-to-port-80
Check: CKV_AWS_24: "Ensure no security groups allow ingress from 0.0.0.0:0 to port 22"
	PASSED for resource: aws_security_group.security_group
	File: /main.tf:7-33
	Guide: [1mhttps://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/networking-1-port-security
Check: CKV_AWS_25: "Ensure no security groups allow ingress from 0.0.0.0:0 to port 3389"
	PASSED for resource: aws_security_group.security_group
	File: /main.tf:7-33
	Guide: [1mhttps://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/networking-2
Check: CKV_AWS_277: "Ensure no security groups allow ingress from 0.0.0.0:0 to port -1"
	PASSED for resource: aws_security_group.security_group
	File: /main.tf:7-33
	Guide: [1mhttps://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-aws-security-group-does-not-allow-all-traffic-on-all-ports
Check: CKV_AWS_341: "Ensure Launch template should not have a metadata response hop limit greater than 1"
	PASSED for resource: aws_launch_template.Template
	File: /main.tf:55-70
	Guide: [1mhttps://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-general-policies/bc-aws-341
Check: CKV_AWS_46: "Ensure no hard-coded secrets exist in EC2 user data"
	PASSED for resource: aws_launch_template.Template
	File: /main.tf:55-70
	Guide: [1mhttps://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/secrets-policies/bc-aws-secrets-1
Check: CKV_AWS_88: "EC2 instance should not have public IP."
	PASSED for resource: aws_launch_template.Template
	File: /main.tf:55-70
	Guide: [1mhttps://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/public-policies/public-12
Check: CKV_AWS_261: "Ensure HTTP HTTPS Target group defines Healthcheck"
	PASSED for resource: aws_lb_target_group.Target_group
	File: /main.tf:75-94
	Guide: [1mhttps://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-general-policies/ensure-aws-kendra-index-server-side-encryption-uses-customer-managed-keys-cmks
Check: CKV_AWS_315: "Ensure EC2 Auto Scaling groups use EC2 launch templates"
	PASSED for resource: aws_autoscaling_group.ASG
	File: /main.tf:118-136
	Guide: [1mhttps://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-general-policies/bc-aws-315
Check: CKV_AWS_153: "Autoscaling groups should supply tags to launch configurations"
	PASSED for resource: aws_autoscaling_group.ASG
	File: /main.tf:118-136
	Guide: [1mhttps://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-general-policies/autoscaling-groups-should-supply-tags-to-launch-configurations
Check: CKV2_AWS_5: "Ensure that Security Groups are attached to another resource"
	PASSED for resource: aws_security_group.security_group
	File: /main.tf:7-33
	Guide: [1mhttps://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-that-security-groups-are-attached-to-ec2-instances-or-elastic-network-interfaces-enis
Check: CKV_AWS_23: "Ensure every security groups rule has a description"
	FAILED for resource: aws_security_group.security_group
	File: /main.tf:7-33
	Guide: [1mhttps://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/networking-31

		[37m7  | [33mresource "aws_security_group" "security_group" {
		[37m8  | [33m  name        = var.security_name
		[37m9  | [33m  description = var.Security_description
		[37m10 | [33m  vpc_id      = var.SG_vpc_id
		[37m11 | [33m
		[37m12 | [33m  dynamic "ingress" {
		[37m13 | [33m    for_each = local.inbound_ports
		[37m14 | [33m    content {
		[37m15 | [33m      from_port = ingress.value.port
		[37m16 | [33m      to_port   = ingress.value.port
		[37m17 | [33m      protocol  = ingress.value.protocol
		[37m18 |       # Conditionally apply CIDR block or security group rule based on type
		[37m19 | [33m      cidr_blocks     = contains(keys(ingress.value), "cidr_blocks") ? [ingress.value.cidr_blocks] : null
		[37m20 | [33m      security_groups = contains(keys(ingress.value), "security_group_ids") ? [ingress.value.security_group_ids] : null
		[37m21 | [33m    }
		[37m22 | [33m  }
		[37m23 | [33m  dynamic "egress" {
		[37m24 | [33m    for_each = local.outbound_ports
		[37m25 | [33m    content {
		[37m26 | [33m      from_port   = egress.value.port
		[37m27 | [33m      to_port     = egress.value.port
		[37m28 | [33m      protocol    = egress.value.protocol
		[37m29 | [33m      cidr_blocks = [egress.value.cidr_blocks]
		[37m30 | [33m    }
		[37m31 | [33m  }
		[37m32 | [33m  tags = var.Sg_tags
		[37m33 | [33m}

Check: CKV_AWS_79: "Ensure Instance Metadata Service Version 1 is not enabled"
	FAILED for resource: aws_launch_template.Template
	File: /main.tf:55-70
	Guide: [1mhttps://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-general-policies/bc-aws-general-31

		[37m55 | [33mresource "aws_launch_template" "Template" {
		[37m56 | [33m  name          = var.template_name
		[37m57 | [33m  description   = var.template_description
		[37m58 | [33m  image_id      = var.AMI_ID
		[37m59 | [33m  instance_type = var.instance_type
		[37m60 | [33m  key_name      = aws_key_pair.key_pair.key_name
		[37m61 | [33m  network_interfaces {
		[37m62 | [33m    security_groups = [aws_security_group.security_group.id]
		[37m63 | [33m    subnet_id       = var.subnet_ID
		[37m64 | [33m  }
		[37m65 |   # user_data = base64encode(templatefile(var.user_data_script_path, { varibale_name = Value (Fatch in Resources) })) if you need any variable pass in User data
		[37m66 | [33m  user_data = filebase64(var.user_data_script_path)
		[37m67 | [33m  tags = {
		[37m68 | [33m    Name = var.template_name
		[37m69 | [33m  }
		[37m70 | [33m}

terraform_plan scan results:

Passed checks: 0, Failed checks: 0, Skipped checks: 0, Parsing errors: 1

Error parsing file ./tflint_report.jsonÖ¿

```

</details>

***

<details>
	<summary> Click here to see tflint output </summary>
	<br>

 ```shell
4 issue(s) found:

Warning: terraform "required_version" attribute is required (terraform_required_version)

  on  line 0:
   (source code not available)

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.5.0/docs/rules/terraform_required_version.md

Warning: Missing version constraint for provider "tls" in `required_providers` (terraform_required_providers)

  on main.tf line 38:
  38: resource "tls_private_key" "private_key" {

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.5.0/docs/rules/terraform_required_providers.md

Warning: Missing version constraint for provider "local" in `required_providers` (terraform_required_providers)

  on main.tf line 50:
  50: resource "local_file" "private_key" {

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.5.0/docs/rules/terraform_required_providers.md

Warning: Missing version constraint for provider "aws" in `required_providers` (terraform_required_providers)

  on main.tf line 141:
 141: resource "aws_autoscaling_policy" "ASG_Policy" {

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.5.0/docs/rules/terraform_required_providers.md

```
</details>

***

# Shared Library Jenkins File

<details>
	<summary> Click here to see Jenkinsfile </summary>
	<br>
	
```shell

@Library('my-shared-library') _

def standalone = new org.avengers.template.Module_CI_CD.cicd()

pipeline {
    agent any
    
    environment {
        AWS_ACCESS_KEY_ID = credentials('aws-access-key	')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-key	')
        TF_CLI_ARGS = '-input=false'
    }
    
    stages {
        stage('Terraform') {
            steps {
                script {
                    properties([
                        parameters([
                            
                            string(name: 'branch', defaultValue: 'main', description: 'Enter the branch name'),
                            string(name: 'rootPath', defaultValue: 'Modules', description: 'Enter the root directory path'),
                            string(name: 'childPath', defaultValue: 'VM-Module', description: 'Enter the child directory path'),
                            string(name: 'tagVersion', defaultValue: 'null', description: 'Enter the correct version'),
                            string(name: 'gitpath', defaultValue: 'CodeOps-Hub/Terraform-modules.git', description: 'Enter the correct GitHub repository path')
                              
                           
                        ])
                    ])

                    def url = 'https://github.com/CodeOps-Hub/Terraform-modules.git'
                    def creds = 'shantanu-pat'
                    
                    
                    standalone.call(url, creds, params.branch, params.rootPath, params.childPath, params.tagVersion, params.gitpath)
                }
            }
        }
    }
}

```

</details>

***

# **Terraform groovy template file**

<details>
<summary> cd.groovy </summary>
<br>

```shell
package org.avengers.Module_CI_CD

def call(String gitpath, String creds, String tagVersion) {
  stage('Git Push Version Stage') {
            script {
                // Push the tagged version to the remote repository
                withCredentials([usernamePassword(credentialsId: "${creds}", usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh "git push https://username:${PASSWORD}@github.com/${gitpath} v${tagVersion}"
                }
            }
        }
}
```
</details>

***

# Shared Library Src file

<details>
<summary>src files</summary>
<br>
	
cd.grovvy

```shell
package org.avengers.Module_CI_CD

def call(String gitpath, String creds, String tagVersion) {
  stage('Git Push Version Stage') {
            script {
                // Push the tagged version to the remote repository
                withCredentials([usernamePassword(credentialsId: "${creds}", usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh "git push https://username:${PASSWORD}@github.com/${gitpath} v${tagVersion}"
                }
            }
        }
}
```

</details>

***

# Contact Information
| Name            | Email Address                        |
|-----------------|--------------------------------------|
| Shantanu | shantanu.chauhan.snaatak@mygurukulam.co |

***

# References

| Description                                   | References  
| --------------------------------------------  | -------------------------------------------------|
| Terraform Module | https://spacelift.io/blog/what-are-terraform-modules-and-how-do-they-work |
| Terraform Module CI/CD | https://www.reddit.com/r/Terraform/comments/17ldr9i/cicd_for_creating_terraform_modules/ |


