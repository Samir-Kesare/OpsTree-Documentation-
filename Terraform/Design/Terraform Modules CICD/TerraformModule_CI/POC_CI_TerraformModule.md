# Implementation of CI Checks on Terraform Module 

|   Author        |  Created on   |  Version   | Last updated by  | Last edited on |
| --------------- | --------------| -----------|----------------- | -------------- |
| Khushi Malhotra |  07 Feb 2024  |  Version 1 | Khushi Malhotra  | 13 Feb 2024    |

![image](https://github.com/avengers-p7/Documentation/assets/156056460/44f80ab7-909e-48c2-8b1e-ea004054137e)

## Table Of Contents
- [Introduction](https://github.com/avengers-p7/Documentation/blob/main/Terraform/Terraform_CI/Terraform_CI_POC.md#introduction)
- [Pre-requisites](https://github.com/avengers-p7/Documentation/blob/main/Terraform/Terraform_CI/Terraform_CI_POC.md#pre-requisites)
- [Implementation of CI checks on Terraform Module](https://github.com/avengers-p7/Documentation/blob/main/Terraform/Terraform_CI/Terraform_CI_POC.md#implementation-of-ci-checks-on-terraform-module-1)
- [Terraform Module](https://github.com/avengers-p7/Documentation/blob/main/Terraform/Terraform_CI/Terraform_CI_POC.md#terraform-module)
- [Shared Library Jenkins File](https://github.com/avengers-p7/Documentation/blob/main/Terraform/Terraform_CI/Terraform_CI_POC.md#shared-library-jenkins-file)
- [Terraform groovy template file](https://github.com/avengers-p7/Documentation/blob/main/Terraform/Terraform_CI/Terraform_CI_POC.md#terraform-groovy-template-file)
- [Shared Library Src file](https://github.com/avengers-p7/Documentation/blob/main/Terraform/Terraform_CI/Terraform_CI_POC.md#shared-library-src-file)
- [Contact Information](https://github.com/avengers-p7/Documentation/blob/main/Terraform/Terraform_CI/Terraform_CI_POC.md#contact-information)
- [References](https://github.com/avengers-p7/Documentation/blob/main/Terraform/Terraform_CI/Terraform_CI_POC.md#references)

## Introduction
Terraform module CI, or continuous integration, refers to the practice of automating the testing and validation of Terraform modules within a CI/CD pipeline. This ensures that any changes made to the module code are automatically checked for errors and potential issues before they are potentially deployed to production environments.

## Pre-requisites

| Tool |
|------|
| Terraform |
| tflint |

## Implementation of CI checks on Terraform Module

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

![image](https://github.com/avengers-p7/Documentation/assets/156056460/453dd6fd-f767-454c-a27b-8aae6d4b4afb)

![image](https://github.com/avengers-p7/Documentation/assets/156056460/0dcc7a9d-1b47-4e13-afa5-e1ff25d0de5d)


**Step-3** Save the Configuration

- Click on Save to save the job configuration.

**Step-4** Build the Pipeline

- Once the pipeline configuration is saved, you can manually trigger the build by clicking on Build Now.

**Step-5** View Build Console Output

- After triggering the build, you can view the progress and console output of the build by clicking on the build number in the Jenkins dashboard.
- The console output will display the steps executed by the pipeline script, including code checkout and compilation.
- Verify Successful Compilation.

![image](https://github.com/avengers-p7/Documentation/assets/156056460/56b3c2b8-f643-4d65-855f-a4aa9d57b258)

![image](https://github.com/avengers-p7/Documentation/assets/156056460/f832fc2c-a7ab-4162-8c81-b61f2be37517)

![image](https://github.com/avengers-p7/Documentation/assets/156056460/50f16098-4521-4766-a61d-11ae43a99320)

<details>
  <summary> Click here to see the Console Output</summary>
<br>

  ```shell
  
Console Output
Started by user khushi
Obtained SharedLibrary/Terraform_CI_JF/Jenkinsfile from git https://github.com/CodeOps-Hub/Jenkinsfile.git
Loading library shared-library@main
Attempting to resolve main from remote references...
 > git --version # timeout=10
 > git --version # 'git version 2.34.1'
using GIT_ASKPASS to set credentials khushi_pass_secret
 > git ls-remote -h -- https://github.com/CodeOps-Hub/SharedLibrary.git # timeout=10
Found match: refs/heads/main revision b2fbf43f4fe44c5701093be51f7563dad0cf117c
The recommended git tool is: NONE
using credential khushi_pass_secret
 > git rev-parse --resolve-git-dir /var/lib/jenkins/workspace/terraform.CICD@libs/9b45fc695856553d98bb823001a46a17146f4d25f13f1d010b47c5ae1c9c87b1/.git # timeout=10
Fetching changes from the remote Git repository
 > git config remote.origin.url https://github.com/CodeOps-Hub/SharedLibrary.git # timeout=10
Fetching without tags
Fetching upstream changes from https://github.com/CodeOps-Hub/SharedLibrary.git
 > git --version # timeout=10
 > git --version # 'git version 2.34.1'
using GIT_ASKPASS to set credentials khushi_pass_secret
 > git fetch --no-tags --force --progress -- https://github.com/CodeOps-Hub/SharedLibrary.git +refs/heads/*:refs/remotes/origin/* # timeout=10
Checking out Revision b2fbf43f4fe44c5701093be51f7563dad0cf117c (main)
 > git config core.sparsecheckout # timeout=10
 > git checkout -f b2fbf43f4fe44c5701093be51f7563dad0cf117c # timeout=10
Commit message: "Update terraform_CI.groovy"
 > git rev-list --no-walk 5a58e79675207c42472736ce8ea502cc037698f3 # timeout=10
[Pipeline] Start of Pipeline
[Pipeline] properties
[Pipeline] node
Running on Jenkins in /var/lib/jenkins/workspace/terraform.CICD
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Clean Workspace)
[Pipeline] cleanWs
[WS-CLEANUP] Deleting project workspace...
[WS-CLEANUP] Deferred wipeout is used...
[WS-CLEANUP] done
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Clone)
[Pipeline] script
[Pipeline] {
[Pipeline] git
The recommended git tool is: NONE
using credential khushi_pass
Cloning the remote Git repository
Cloning repository https://github.com/HarshitSingh-Codes/jenkins-final.git
 > git init /var/lib/jenkins/workspace/terraform.CICD # timeout=10
Fetching upstream changes from https://github.com/HarshitSingh-Codes/jenkins-final.git
 > git --version # timeout=10
 > git --version # 'git version 2.34.1'
using GIT_ASKPASS to set credentials khushi_pass
 > git fetch --tags --force --progress -- https://github.com/HarshitSingh-Codes/jenkins-final.git +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git config remote.origin.url https://github.com/HarshitSingh-Codes/jenkins-final.git # timeout=10
 > git config --add remote.origin.fetch +refs/heads/*:refs/remotes/origin/* # timeout=10
Avoid second fetch
 > git rev-parse refs/remotes/origin/main^{commit} # timeout=10
Checking out Revision 10f7018d067d3dd60d882d4bd9efc5f142469f8f (refs/remotes/origin/main)
 > git config core.sparsecheckout # timeout=10
 > git checkout -f 10f7018d067d3dd60d882d4bd9efc5f142469f8f # timeout=10
 > git branch -a -v --no-abbrev # timeout=10
 > git checkout -b main 10f7018d067d3dd60d882d4bd9efc5f142469f8f # timeout=10
Commit message: "vcjc"
 > git rev-list --no-walk 10f7018d067d3dd60d882d4bd9efc5f142469f8f # timeout=10
[Pipeline] }
[Pipeline] // script
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Terraform action)
[Pipeline] script
[Pipeline] {
[Pipeline] sh
+ cd modules/network
[Pipeline] }
[Pipeline] // script
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Terraform init)
[Pipeline] script
[Pipeline] {
[Pipeline] sh
+ cd modules/network
+ terraform init

[0m[1mInitializing the backend...[0m

[0m[1mInitializing provider plugins...[0m
- Finding latest version of hashicorp/aws...
- Installing hashicorp/aws v5.39.1...
- Installed hashicorp/aws v5.39.1 (signed by HashiCorp)

Terraform has created a lock file [1m.terraform.lock.hcl[0m to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.[0m

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
+ cd modules/network
+ terraform fmt
main.tf
[Pipeline] }
[Pipeline] // script
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Terraform Validate)
[Pipeline] script
[Pipeline] {
[Pipeline] sh
+ cd modules/network
+ terraform validate
[32m[1mSuccess![0m The configuration is valid.
[0m
[Pipeline] }
[Pipeline] // script
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (checkov)
[Pipeline] script
[Pipeline] {
[Pipeline] sh
+ cd modules/network
+ /var/lib/jenkins/.local/bin/checkov -d . -s --output-file-path . --skip-path ./tflint_report.jsonֿ


       _               _              
   ___| |__   ___  ___| | _______   __
  / __| '_ \ / _ \/ __| |/ / _ \ \ / /
 | (__| | | |  __/ (__|   < (_) \ V / 
  \___|_| |_|\___|\___|_|\_\___/ \_/  
                                      
By Prisma Cloud | version: 3.2.31 
Update available 3.2.31 -> 3.2.32
Run pip3 install -U checkov to update 


terraform scan results:

Passed checks: 6, Failed checks: 7, Skipped checks: 0

Check: CKV_AWS_130: "Ensure VPC subnets do not assign public IP by default"
	PASSED for resource: aws_subnet.private_subnets[0]
	File: /main.tf:25-31
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-vpc-subnets-do-not-assign-public-ip-by-default
Check: CKV_AWS_130: "Ensure VPC subnets do not assign public IP by default"
	PASSED for resource: aws_subnet.private_subnets[1]
	File: /main.tf:25-31
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-vpc-subnets-do-not-assign-public-ip-by-default
Check: CKV2_AWS_35: "AWS NAT Gateways should be utilized for the default route"
	PASSED for resource: aws_route.existing_rtb
	File: /main.tf:71-76
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-aws-nat-gateways-are-utilized-for-the-default-route
Check: CKV2_AWS_35: "AWS NAT Gateways should be utilized for the default route"
	PASSED for resource: aws_route_table.public_rtb
	File: /main.tf:80-100
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-aws-nat-gateways-are-utilized-for-the-default-route
Check: CKV2_AWS_35: "AWS NAT Gateways should be utilized for the default route"
	PASSED for resource: aws_route_table.private_rtb
	File: /main.tf:111-130
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-aws-nat-gateways-are-utilized-for-the-default-route
Check: CKV2_AWS_19: "Ensure that all EIP addresses allocated to a VPC are attached to EC2 instances"
	PASSED for resource: aws_eip.elastic_ip
	File: /main.tf:44-47
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-that-all-eip-addresses-allocated-to-a-vpc-are-attached-to-ec2-instances
Check: CKV_AWS_130: "Ensure VPC subnets do not assign public IP by default"
	FAILED for resource: aws_subnet.public_subnets[0]
	File: /main.tf:14-21
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-vpc-subnets-do-not-assign-public-ip-by-default

		14 | resource "aws_subnet" "public_subnets" {
		15 |   count                   = length(var.public_subnets_cidr)
		16 |   vpc_id                  = aws_vpc.vpc-01.id
		17 |   cidr_block              = var.public_subnets_cidr[count.index]
		18 |   availability_zone       = var.public_subnets_az[count.index]
		19 |   map_public_ip_on_launch = var.enable_map_public_ip_on_launch
		20 |   tags                    = var.public_subnets_tags[count.index]
		21 | }

Check: CKV_AWS_130: "Ensure VPC subnets do not assign public IP by default"
	FAILED for resource: aws_subnet.public_subnets[1]
	File: /main.tf:14-21
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-vpc-subnets-do-not-assign-public-ip-by-default

		14 | resource "aws_subnet" "public_subnets" {
		15 |   count                   = length(var.public_subnets_cidr)
		16 |   vpc_id                  = aws_vpc.vpc-01.id
		17 |   cidr_block              = var.public_subnets_cidr[count.index]
		18 |   availability_zone       = var.public_subnets_az[count.index]
		19 |   map_public_ip_on_launch = var.enable_map_public_ip_on_launch
		20 |   tags                    = var.public_subnets_tags[count.index]
		21 | }

Check: CKV2_AWS_12: "Ensure the default security group of every VPC restricts all traffic"
	FAILED for resource: aws_vpc.vpc-01
	File: /main.tf:3-10
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/networking-4

		3  | resource "aws_vpc" "vpc-01" {
		4  |   cidr_block           = var.vpc_cidr
		5  |   enable_dns_support   = var.vpc_enable_dns_support
		6  |   enable_dns_hostnames = var.vpc_enable_dns_hostnames
		7  |   tags = {
		8  |     Name = var.vpc_name
		9  |   }
		10 | }

Check: CKV2_AWS_11: "Ensure VPC flow logging is enabled in all VPCs"
	FAILED for resource: aws_vpc.vpc-01
	File: /main.tf:3-10
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-logging-policies/logging-9-enable-vpc-flow-logging

		3  | resource "aws_vpc" "vpc-01" {
		4  |   cidr_block           = var.vpc_cidr
		5  |   enable_dns_support   = var.vpc_enable_dns_support
		6  |   enable_dns_hostnames = var.vpc_enable_dns_hostnames
		7  |   tags = {
		8  |     Name = var.vpc_name
		9  |   }
		10 | }

Check: CKV2_AWS_44: "Ensure AWS route table with VPC peering does not contain routes overly permissive to all traffic"
	FAILED for resource: aws_route.existing_rtb
	File: /main.tf:71-76
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-aws-route-table-with-vpc-peering-does-not-contain-routes-overly-permissive-to-all-traffic

		71 | resource "aws_route" "existing_rtb" {
		72 |   route_table_id            = var.existing_rtb
		73 |   destination_cidr_block    = var.vpc_cidr
		74 |   vpc_peering_connection_id = aws_vpc_peering_connection.peer_01.id
		75 |   depends_on                = [aws_vpc_peering_connection.peer_01]
		76 | }

Check: CKV2_AWS_44: "Ensure AWS route table with VPC peering does not contain routes overly permissive to all traffic"
	FAILED for resource: aws_route_table.public_rtb
	File: /main.tf:80-100
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-aws-route-table-with-vpc-peering-does-not-contain-routes-overly-permissive-to-all-traffic

		80  | resource "aws_route_table" "public_rtb" {
		81  |   vpc_id = aws_vpc.vpc-01.id
		82  |   route {
		83  |     cidr_block = "10.0.0.0/16"
		84  |     gateway_id = "local"
		85  |   }
		86  |   route {
		87  |     cidr_block = "0.0.0.0/0"
		88  |     gateway_id = aws_internet_gateway.igw.id
		89  |   }
		90  |   route {
		91  |     cidr_block                = var.existing_vpc_cidr
		92  |     vpc_peering_connection_id = aws_vpc_peering_connection.peer_01.id
		93  |   }
		94  | 
		95  |   tags = {
		96  |     Name = var.pub_route_table_name
		97  |   }
		98  | 
		99  |   depends_on = [aws_vpc_peering_connection.peer_01, aws_internet_gateway.igw]
		100 | }

Check: CKV2_AWS_44: "Ensure AWS route table with VPC peering does not contain routes overly permissive to all traffic"
	FAILED for resource: aws_route_table.private_rtb
	File: /main.tf:111-130
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-aws-route-table-with-vpc-peering-does-not-contain-routes-overly-permissive-to-all-traffic

		111 | resource "aws_route_table" "private_rtb" {
		112 |   vpc_id = aws_vpc.vpc-01.id
		113 |   route {
		114 |     cidr_block = "10.0.0.0/16"
		115 |     gateway_id = "local"
		116 |   }
		117 |   route {
		118 |     cidr_block     = "0.0.0.0/0"
		119 |     nat_gateway_id = aws_nat_gateway.ninja_nat.id
		120 |   }
		121 |   route {
		122 |     cidr_block                = var.existing_vpc_cidr
		123 |     vpc_peering_connection_id = aws_vpc_peering_connection.peer_01.id
		124 |   }
		125 | 
		126 |   tags = {
		127 |     Name = var.pri_route_table_name
		128 |   }
		129 |   depends_on = [aws_nat_gateway.ninja_nat, aws_vpc_peering_connection.peer_01]
		130 | }


[Pipeline] }
[Pipeline] // script
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Static Code Analysis)
[Pipeline] script
[Pipeline] {
[Pipeline] sh
+ sudo bash
+ curl -s https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh
arch=amd64
os=linux_amd64


====================================================
Looking up the latest version ...
Downloading TFLint v0.50.3
Downloaded successfully


====================================================
Unpacking /tmp/tflint.avcjOqLFIz/tflint.zip ...
Archive:  /tmp/tflint.avcjOqLFIz/tflint.zip
  inflating: /tmp/tflint.avcjOqLFIz/tflint  
Installing /tmp/tflint.avcjOqLFIz/tflint to /usr/local/bin/ ...
removed '/usr/local/bin/tflint'
'/tmp/tflint.avcjOqLFIz/tflint' -> '/usr/local/bin/tflint'
Cleaning temporary downloaded files directory /tmp/tflint.avcjOqLFIz ...


====================================================
Current tflint version
TFLint version 0.50.3
+ ruleset.terraform (0.5.0-bundled)
[Pipeline] sh
+ cd modules/network
+ tee tflint_report.json
+ tflint --format default
6 issue(s) found:

Warning: terraform "required_version" attribute is required (terraform_required_version)

  on  line 0:
   (source code not available)

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.5.0/docs/rules/terraform_required_version.md

Warning: [Fixable] List items should be accessed using square brackets (terraform_deprecated_index)

  on main.tf line 105:
 105:   count          = length(aws_subnet.public_subnets.*.id)

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.5.0/docs/rules/terraform_deprecated_index.md

Warning: Missing version constraint for provider "aws" in `required_providers` (terraform_required_providers)

  on main.tf line 134:
 134: resource "aws_route_table_association" "private_route_association01" {

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.5.0/docs/rules/terraform_required_providers.md

Warning: [Fixable] List items should be accessed using square brackets (terraform_deprecated_index)

  on main.tf line 136:
 136:   count          = length(aws_subnet.private_subnets.*.id)

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.5.0/docs/rules/terraform_deprecated_index.md

Warning: [Fixable] List items should be accessed using square brackets (terraform_deprecated_index)

  on output.tf line 6:
   6:   value = aws_subnet.public_subnets.*.id

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.5.0/docs/rules/terraform_deprecated_index.md

Warning: [Fixable] List items should be accessed using square brackets (terraform_deprecated_index)

  on output.tf line 11:
  11:   value = aws_subnet.private_subnets.*.id

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.5.0/docs/rules/terraform_deprecated_index.md

[Pipeline] }
[Pipeline] // script
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Archive)
[Pipeline] script
[Pipeline] {
[Pipeline] archiveArtifacts
Archiving artifacts
[Pipeline] }
[Pipeline] // script
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Archive)
[Pipeline] script
[Pipeline] {
[Pipeline] archiveArtifacts
Archiving artifacts
[Pipeline] }
[Pipeline] // script
[Pipeline] }
[Pipeline] // stage
[Pipeline] }
[Pipeline] // node
[Pipeline] End of Pipeline
Finished: SUCCESS

```
</details>

<details>
	<summary> Click here to see checkov output</summary>
<br>
	
```shell
	
 terraform scan results:

Passed checks: 6, Failed checks: 7, Skipped checks: 0

Check: CKV_AWS_130: "Ensure VPC subnets do not assign public IP by default"
	PASSED for resource: aws_subnet.private_subnets[0]
	File: /main.tf:25-31
	Guide: [1mhttps://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-vpc-subnets-do-not-assign-public-ip-by-default
Check: CKV_AWS_130: "Ensure VPC subnets do not assign public IP by default"
	PASSED for resource: aws_subnet.private_subnets[1]
	File: /main.tf:25-31
	Guide: [1mhttps://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-vpc-subnets-do-not-assign-public-ip-by-default
Check: CKV2_AWS_35: "AWS NAT Gateways should be utilized for the default route"
	PASSED for resource: aws_route.existing_rtb
	File: /main.tf:71-76
	Guide: [1mhttps://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-aws-nat-gateways-are-utilized-for-the-default-route
Check: CKV2_AWS_35: "AWS NAT Gateways should be utilized for the default route"
	PASSED for resource: aws_route_table.public_rtb
	File: /main.tf:80-100
	Guide: [1mhttps://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-aws-nat-gateways-are-utilized-for-the-default-route
Check: CKV2_AWS_35: "AWS NAT Gateways should be utilized for the default route"
	PASSED for resource: aws_route_table.private_rtb
	File: /main.tf:111-130
	Guide: [1mhttps://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-aws-nat-gateways-are-utilized-for-the-default-route
Check: CKV2_AWS_19: "Ensure that all EIP addresses allocated to a VPC are attached to EC2 instances"
	PASSED for resource: aws_eip.elastic_ip
	File: /main.tf:44-47
	Guide: [1mhttps://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-that-all-eip-addresses-allocated-to-a-vpc-are-attached-to-ec2-instances
Check: CKV_AWS_130: "Ensure VPC subnets do not assign public IP by default"
	FAILED for resource: aws_subnet.public_subnets[0]
	File: /main.tf:14-21
	Guide: [1mhttps://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-vpc-subnets-do-not-assign-public-ip-by-default

		[37m14 | [33mresource "aws_subnet" "public_subnets" {
		[37m15 | [33m  count                   = length(var.public_subnets_cidr)
		[37m16 | [33m  vpc_id                  = aws_vpc.vpc-01.id
		[37m17 | [33m  cidr_block              = var.public_subnets_cidr[count.index]
		[37m18 | [33m  availability_zone       = var.public_subnets_az[count.index]
		[37m19 | [33m  map_public_ip_on_launch = var.enable_map_public_ip_on_launch
		[37m20 | [33m  tags                    = var.public_subnets_tags[count.index]
		[37m21 | [33m}

Check: CKV_AWS_130: "Ensure VPC subnets do not assign public IP by default"
	FAILED for resource: aws_subnet.public_subnets[1]
	File: /main.tf:14-21
	Guide: [1mhttps://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-vpc-subnets-do-not-assign-public-ip-by-default

		[37m14 | [33mresource "aws_subnet" "public_subnets" {
		[37m15 | [33m  count                   = length(var.public_subnets_cidr)
		[37m16 | [33m  vpc_id                  = aws_vpc.vpc-01.id
		[37m17 | [33m  cidr_block              = var.public_subnets_cidr[count.index]
		[37m18 | [33m  availability_zone       = var.public_subnets_az[count.index]
		[37m19 | [33m  map_public_ip_on_launch = var.enable_map_public_ip_on_launch
		[37m20 | [33m  tags                    = var.public_subnets_tags[count.index]
		[37m21 | [33m}

Check: CKV2_AWS_12: "Ensure the default security group of every VPC restricts all traffic"
	FAILED for resource: aws_vpc.vpc-01
	File: /main.tf:3-10
	Guide: [1mhttps://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/networking-4

		[37m3  | [33mresource "aws_vpc" "vpc-01" {
		[37m4  | [33m  cidr_block           = var.vpc_cidr
		[37m5  | [33m  enable_dns_support   = var.vpc_enable_dns_support
		[37m6  | [33m  enable_dns_hostnames = var.vpc_enable_dns_hostnames
		[37m7  | [33m  tags = {
		[37m8  | [33m    Name = var.vpc_name
		[37m9  | [33m  }
		[37m10 | [33m}

Check: CKV2_AWS_11: "Ensure VPC flow logging is enabled in all VPCs"
	FAILED for resource: aws_vpc.vpc-01
	File: /main.tf:3-10
	Guide: [1mhttps://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-logging-policies/logging-9-enable-vpc-flow-logging

		[37m3  | [33mresource "aws_vpc" "vpc-01" {
		[37m4  | [33m  cidr_block           = var.vpc_cidr
		[37m5  | [33m  enable_dns_support   = var.vpc_enable_dns_support
		[37m6  | [33m  enable_dns_hostnames = var.vpc_enable_dns_hostnames
		[37m7  | [33m  tags = {
		[37m8  | [33m    Name = var.vpc_name
		[37m9  | [33m  }
		[37m10 | [33m}

Check: CKV2_AWS_44: "Ensure AWS route table with VPC peering does not contain routes overly permissive to all traffic"
	FAILED for resource: aws_route.existing_rtb
	File: /main.tf:71-76
	Guide: [1mhttps://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-aws-route-table-with-vpc-peering-does-not-contain-routes-overly-permissive-to-all-traffic

		[37m71 | [33mresource "aws_route" "existing_rtb" {
		[37m72 | [33m  route_table_id            = var.existing_rtb
		[37m73 | [33m  destination_cidr_block    = var.vpc_cidr
		[37m74 | [33m  vpc_peering_connection_id = aws_vpc_peering_connection.peer_01.id
		[37m75 | [33m  depends_on                = [aws_vpc_peering_connection.peer_01]
		[37m76 | [33m}

Check: CKV2_AWS_44: "Ensure AWS route table with VPC peering does not contain routes overly permissive to all traffic"
	FAILED for resource: aws_route_table.public_rtb
	File: /main.tf:80-100
	Guide: [1mhttps://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-aws-route-table-with-vpc-peering-does-not-contain-routes-overly-permissive-to-all-traffic

		[37m80  | [33mresource "aws_route_table" "public_rtb" {
		[37m81  | [33m  vpc_id = aws_vpc.vpc-01.id
		[37m82  | [33m  route {
		[37m83  | [33m    cidr_block = "10.0.0.0/16"
		[37m84  | [33m    gateway_id = "local"
		[37m85  | [33m  }
		[37m86  | [33m  route {
		[37m87  | [33m    cidr_block = "0.0.0.0/0"
		[37m88  | [33m    gateway_id = aws_internet_gateway.igw.id
		[37m89  | [33m  }
		[37m90  | [33m  route {
		[37m91  | [33m    cidr_block                = var.existing_vpc_cidr
		[37m92  | [33m    vpc_peering_connection_id = aws_vpc_peering_connection.peer_01.id
		[37m93  | [33m  }
		[37m94  | [33m
		[37m95  | [33m  tags = {
		[37m96  | [33m    Name = var.pub_route_table_name
		[37m97  | [33m  }
		[37m98  | [33m
		[37m99  | [33m  depends_on = [aws_vpc_peering_connection.peer_01, aws_internet_gateway.igw]
		[37m100 | [33m}

Check: CKV2_AWS_44: "Ensure AWS route table with VPC peering does not contain routes overly permissive to all traffic"
	FAILED for resource: aws_route_table.private_rtb
	File: /main.tf:111-130
	Guide: [1mhttps://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-aws-route-table-with-vpc-peering-does-not-contain-routes-overly-permissive-to-all-traffic

		[37m111 | [33mresource "aws_route_table" "private_rtb" {
		[37m112 | [33m  vpc_id = aws_vpc.vpc-01.id
		[37m113 | [33m  route {
		[37m114 | [33m    cidr_block = "10.0.0.0/16"
		[37m115 | [33m    gateway_id = "local"
		[37m116 | [33m  }
		[37m117 | [33m  route {
		[37m118 | [33m    cidr_block     = "0.0.0.0/0"
		[37m119 | [33m    nat_gateway_id = aws_nat_gateway.ninja_nat.id
		[37m120 | [33m  }
		[37m121 | [33m  route {
		[37m122 | [33m    cidr_block                = var.existing_vpc_cidr
		[37m123 | [33m    vpc_peering_connection_id = aws_vpc_peering_connection.peer_01.id
		[37m124 | [33m  }
		[37m125 | [33m
		[37m126 | [33m  tags = {
		[37m127 | [33m    Name = var.pri_route_table_name
		[37m128 | [33m  }
		[37m129 | [33m  depends_on = [aws_nat_gateway.ninja_nat, aws_vpc_peering_connection.peer_01]
		[37m130 | [33m}

```

</details>

<details>
	<summary> Click here to see tflint output </summary>
	<br>

 ```shell
6 issue(s) found:

Warning: terraform "required_version" attribute is required (terraform_required_version)

  on  line 0:
   (source code not available)

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.5.0/docs/rules/terraform_required_version.md

Warning: [Fixable] List items should be accessed using square brackets (terraform_deprecated_index)

  on main.tf line 105:
 105:   count          = length(aws_subnet.public_subnets.*.id)

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.5.0/docs/rules/terraform_deprecated_index.md

Warning: Missing version constraint for provider "aws" in `required_providers` (terraform_required_providers)

  on main.tf line 134:
 134: resource "aws_route_table_association" "private_route_association01" {

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.5.0/docs/rules/terraform_required_providers.md

Warning: [Fixable] List items should be accessed using square brackets (terraform_deprecated_index)

  on main.tf line 136:
 136:   count          = length(aws_subnet.private_subnets.*.id)

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.5.0/docs/rules/terraform_deprecated_index.md

Warning: [Fixable] List items should be accessed using square brackets (terraform_deprecated_index)

  on output.tf line 6:
   6:   value = aws_subnet.public_subnets.*.id

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.5.0/docs/rules/terraform_deprecated_index.md

Warning: [Fixable] List items should be accessed using square brackets (terraform_deprecated_index)

  on output.tf line 11:
  11:   value = aws_subnet.private_subnets.*.id

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.5.0/docs/rules/terraform_deprecated_index.md
```
</details>

## [Terraform Module](https://github.com/HarshitSingh-Codes/jenkins-final.git)

## [Shared Library Jenkins File](https://github.com/CodeOps-Hub/Jenkinsfile/blob/main/SharedLibrary/Terraform_CI_JF/Jenkinsfile)

```shell
@Library('shared-library') _

//import org.avengers.template.terraform.*
def terraformCI = new org.avengers.template.terraformCI.terraform_CI()
properties([
    parameters([
        choice(name: 'branch', choices: ['main'], description: 'Select the branch'),
        choice(name: 'rootPath', choices: ['modules'], description: 'Select the root directory'),
        choice(name: 'childPath',choices: ['network'], description: 'Select the child directory'),
    ])
])
node {
    def url = 'https://github.com/HarshitSingh-Codes/jenkins-final.git'
    def creds = 'khushi_pass'
    def reportName1 = 'results_cli.txt'
    def reportName2 = 'tflint_report.json'
  //  def terraformCI = new org.avengers.template.terraform.terraformCI()
    terraformCI.call(url, creds, params.branch, params.rootPath, params.childPath, reportName1, reportName2)
     
}
```
## [Terraform groovy template file](https://github.com/CodeOps-Hub/SharedLibrary/blob/main/src/org/avengers/template/terraformCI/terraform_CI.groovy)
<details>
<summary> terraform_CI.groovy </summary>
<br>

```shell
package org.avengers.template.terraformCI

import org.avengers.common.*
import org.avengers.terraform_CICD.*

def call(String url, String creds, String branch, String rootPath, String childPath, String reportName1, String reportName2){

    variablization = new action()
    gitCheckoutPrivate = new GitCheckoutPrivate()
    initialization = new init()
    formating = new fmt()
    validation = new validate()
    linting = new linting()
    securitychecks = new checkov()
    cleanWorkspace = new cleanWorkspace()
    archiving = new ArchivewithoutClean()

    cleanWorkspace.call()
    gitCheckoutPrivate.call(url, creds, branch)
    variablization.call(rootPath, childPath)
    initialization.call(rootPath, childPath)
    formating.call(rootPath, childPath)
    validation.call(rootPath, childPath)
    securitychecks.call(rootPath, childPath)
    linting.call(rootPath, childPath)
    archiving.call(reportName1)
    archiving.call(reportName2)
    // securitychecks.call(rootPath, childPath)

}

```
</details>

## [Shared Library Src file](https://github.com/CodeOps-Hub/SharedLibrary/tree/main/src/org/avengers/terraform_CICD)

<details>
<summary>scr files</summary>
<br>
action.grovvy

```shell
package org.avengers.terraform_CICD

def call(String rootPath, String childPath) {
    stage("Terraform action") {
        script {
            sh "cd ${rootPath}/${childPath}"
        }
    }
}
```
init.groovy

```shell
package org.avengers.terraform_CICD

def call(String rootPath, String childPath) {
    stage('Terraform init') {
        script {
            sh "cd ${rootPath}/${childPath} && terraform init"
        }
    }
}

```

validate.groovy

```shell

package org.avengers.terraform_CICD

def call(String rootPath, String childPath) {
    stage('Terraform Validate') {
        script {
            sh "cd ${rootPath}/${childPath} && terraform validate"
        }
    }
}

```

fmt.groovy

```shell
package org.avengers.terraform_CICD

def call(String rootPath, String childPath) {
    stage('Terraform fmt') {
        script {
            sh "cd ${rootPath}/${childPath} && terraform fmt"
        }
    }
}
```

linting.groovy

```shell
package org.avengers.terraform_CICD

def call(String rootPath, String childPath) {
    stage('Static Code Analysis') {
        script {
            sh "curl -s https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | sudo bash"
            sh "cd ${rootPath}/${childPath} && tflint --format default | tee tflint_report.json"
        }
    }
}
```
checkov.groovy

```shell
package org.avengers.terraform_CICD

def call(String rootPath, String childPath) {
    stage('checkov') {
        script {
            //sh "pip install checkov"
        //    sh "python3 -m pip install checkov"
          //  sh 'echo "export PATH=\"`python3 -m site --user-base`/bin:\$PATH\"" >> ~/.bashrc'
           // sh "source ~/.bashrc"
          //  sh 'export PATH="$HOME/.local/bin:$PATH"'
           // sh "sudo apt install pipenv -y"
           // sh "pip install checkov"
        //    sh "/var/lib/jenkins/.local/bin/checkov -d . -s"
            sh "cd ${rootPath}/${childPath} && /var/lib/jenkins/.local/bin/checkov -d . -s --output-file-path . --skip-path ./tflint_report.jsonֿ"
        }
    }
}
```

</details>

## Contact Information
| Name            | Email Address                        |
|-----------------|--------------------------------------|
| Khushi Malhotra | khushi.malhotra.snaatak@mygurukulam.co |

## References

| Description                                   | References  
| --------------------------------------------  | -------------------------------------------------|
| Terraform Module | https://spacelift.io/blog/what-are-terraform-modules-and-how-do-they-work |
| What is CI | https://www.atlassian.com/continuous-delivery/continuous-integration |
| Terraform Module CI/CD | https://www.reddit.com/r/Terraform/comments/17ldr9i/cicd_for_creating_terraform_modules/ |
