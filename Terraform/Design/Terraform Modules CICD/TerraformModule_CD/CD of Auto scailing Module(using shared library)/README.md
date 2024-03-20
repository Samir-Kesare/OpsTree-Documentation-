# create a DSL Jenkins pipeline for tf module CD of Auto scailing (using shared library)

![image](https://github.com/avengers-p7/Documentation/assets/156056460/44f80ab7-909e-48c2-8b1e-ea004054137e)

|   Author        |  Created on   |  Version   | Last updated by  | Last edited on |
| --------------- | --------------| -----------|----------------- | -------------- |
| Samir Kesare |  20-03-2024  |  Version 1 | Samir Kesare | 20-03-2024   |



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
Integrating Continuous Deployment (CD) practices into Continuous Integration/Continuous Deployment (CI/CD) pipelines for Terraform
modules involves automating the deployment of infrastructure configurations. Automated Deployment: CD in CI/CD pipelines automates the
deployment of Terraform modules, ensuring that changes are applied consistently and efficiently across different environments.
## Pre-requisites

| Tool |
|------|
| Terraform |
| tflint |
| checkov |

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

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056570/8fd72425-3882-433a-bafc-7771fe9dbdcc)

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056570/17f38b81-3756-4306-8dd9-9f0f1514cfd1)

**Step-3** Save the Configuration

- Click on Save to save the job configuration.

**Step-4** Build the Pipeline

- Once the pipeline configuration is saved, you can manually trigger the build by clicking on Build Now.

**Step-5** View Build Console Output

- After triggering the build, you can view the progress and console output of the build by clicking on the build number in the Jenkins dashboard.
- The console output will display the steps executed by the pipeline script, including code checkout and compilation.
- Verify Successful Compilation.

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056570/62196046-1732-43e7-82e3-eba18bf740db)


![image](https://github.com/CodeOps-Hub/Documentation/assets/156056570/fac074c6-f609-4d66-b385-6665ffee68a6)

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056570/4cb6dac3-3cfc-4546-85ce-f49667281e21)



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
