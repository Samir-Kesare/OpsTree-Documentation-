# DSL Jenkins Pipeline for tf module CI of Network Skeleton (Using Shared Library)

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
![Screenshot 2024-03-21 at 6 08 39 PM](https://github.com/CodeOps-Hub/Documentation/assets/156056364/d2c6efb2-a04d-4039-a090-37f9d9954ac1)

**Step-3** Save the Configuration

- Click on Save to save the job configuration.

**Step-4** Build the Pipeline

- Once the pipeline configuration is saved, you can manually trigger the build by clicking on Build Now.

**Step-5** View Build Console Output

- After triggering the build, you can view the progress and console output of the build by clicking on the build number in the Jenkins dashboard.
- The console output will display the steps executed by the pipeline script, including code checkout and compilation.
- Verify Successful Compilation.

![Screenshot 2024-03-21 at 6 06 19 PM](https://github.com/CodeOps-Hub/Documentation/assets/156056364/fb5dce5b-63c5-40c8-95d5-53c298b5d255)


***


<details>
  <summary> Click here to see the Console Output</summary>
<br>

  ```shell
Started by user Shantanu
Obtained SharedLibrary/Module_CI_CD/Network_Skeleton/Jenkinsfile from git https://github.com/CodeOps-Hub/Jenkinsfile.git
Loading library my-shared-library@main
Attempting to resolve main from remote references...
 > git --version # timeout=10
 > git --version # 'git version 2.25.1'
using GIT_ASKPASS to set credentials shantanu-pat
 > git ls-remote -h -- https://github.com/CodeOps-Hub/SharedLibrary.git # timeout=10
Found match: refs/heads/main revision c1b12ac0eacd115b5c7842ee9dbda32cb871eaf9
The recommended git tool is: NONE
using credential shantanu-pat
 > git rev-parse --resolve-git-dir /var/lib/jenkins/workspace/DSL_CI-CD_Network_Skeleton_Module@libs/fa825161180b48026f3f72bd86b5280b41948ba0e7505a66c83f19dbed0a5928/.git # timeout=10
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
 > git rev-list --no-walk 64abfefc099d54cd9cc804dc29b96c0283000645 # timeout=10
[Pipeline] Start of Pipeline
[Pipeline] node
Running on Jenkins in /var/lib/jenkins/workspace/DSL_CI-CD_Network_Skeleton_Module
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Declarative: Checkout SCM)
[Pipeline] checkout
Selected Git installation does not exist. Using Default
The recommended git tool is: NONE
using credential shantanu-pat
 > git rev-parse --resolve-git-dir /var/lib/jenkins/workspace/DSL_CI-CD_Network_Skeleton_Module/.git # timeout=10
Fetching changes from the remote Git repository
 > git config remote.origin.url https://github.com/CodeOps-Hub/Jenkinsfile.git # timeout=10
Fetching upstream changes from https://github.com/CodeOps-Hub/Jenkinsfile.git
 > git --version # timeout=10
 > git --version # 'git version 2.25.1'
using GIT_ASKPASS to set credentials shantanu-pat
 > git fetch --tags --force --progress -- https://github.com/CodeOps-Hub/Jenkinsfile.git +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git rev-parse refs/remotes/origin/Shantanu/DSL_Network_Skeleton^{commit} # timeout=10
Checking out Revision c90a7798749c8b1c1c60033c4ee22dacf92843e1 (refs/remotes/origin/Shantanu/DSL_Network_Skeleton)
 > git config core.sparsecheckout # timeout=10
 > git checkout -f c90a7798749c8b1c1c60033c4ee22dacf92843e1 # timeout=10
Commit message: "Create Jenkinsfile"
 > git rev-list --no-walk c90a7798749c8b1c1c60033c4ee22dacf92843e1 # timeout=10
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
 > git rev-parse --resolve-git-dir /var/lib/jenkins/workspace/DSL_CI-CD_Network_Skeleton_Module/.git # timeout=10
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
+ cd Modules/Network_Skeleton_Module
[Pipeline] }
[Pipeline] // script
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Terraform init)
[Pipeline] script
[Pipeline] {
[Pipeline] sh
+ cd Modules/Network_Skeleton_Module
+ terraform init

[0m[1mInitializing the backend...[0m

[0m[1mInitializing provider plugins...[0m
- Reusing previous version of hashicorp/aws from the dependency lock file
- Using previously-installed hashicorp/aws v5.41.0

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
+ cd Modules/Network_Skeleton_Module
+ sudo terraform fmt
main.tf
output.tf
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
+ cd Modules/Network_Skeleton_Module
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
Unpacking /tmp/tflint.JQRUAULUth/tflint.zip ...
Archive:  /tmp/tflint.JQRUAULUth/tflint.zip
  inflating: /tmp/tflint.JQRUAULUth/tflint  
Installing /tmp/tflint.JQRUAULUth/tflint to /usr/local/bin/ ...
removed '/usr/local/bin/tflint'
'/tmp/tflint.JQRUAULUth/tflint' -> '/usr/local/bin/tflint'
Cleaning temporary downloaded files directory /tmp/tflint.JQRUAULUth ...


====================================================
Current tflint version
TFLint version 0.50.3
+ ruleset.terraform (0.5.0-bundled)
[Pipeline] sh
+ cd Modules/Network_Skeleton_Module
+ tflint --format default
+ tee tflint_report.json
6 issue(s) found:

Warning: terraform "required_version" attribute is required (terraform_required_version)

  on  line 0:
   (source code not available)

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.5.0/docs/rules/terraform_required_version.md

Warning: [Fixable] List items should be accessed using square brackets (terraform_deprecated_index)

  on main.tf line 71:
  71:   count          = length(aws_subnet.dev_public_subnets.*.id)

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.5.0/docs/rules/terraform_deprecated_index.md

Warning: [Fixable] List items should be accessed using square brackets (terraform_deprecated_index)

  on main.tf line 95:
  95:   count          = length(aws_subnet.dev_private_subnets.*.id)

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.5.0/docs/rules/terraform_deprecated_index.md

Warning: Missing version constraint for provider "aws" in `required_providers` (terraform_required_providers)

  on main.tf line 264:
 264: resource "aws_route53_record" "dev_route53_record" {

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.5.0/docs/rules/terraform_required_providers.md

Warning: [Fixable] List items should be accessed using square brackets (terraform_deprecated_index)

  on output.tf line 6:
   6:   value = aws_subnet.dev_public_subnets.*.id

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.5.0/docs/rules/terraform_deprecated_index.md

Warning: [Fixable] List items should be accessed using square brackets (terraform_deprecated_index)

  on output.tf line 11:
  11:   value = aws_subnet.dev_private_subnets.*.id

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.5.0/docs/rules/terraform_deprecated_index.md

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
+ cd Modules/Network_Skeleton_Module
+ /var/lib/jenkins/.local/bin/checkov -d . -s --output-file-path . --skip-path ./tflint_report.jsonֿ

       _               _              
   ___| |__   ___  ___| | _______   __
  / __| '_ \ / _ \/ __| |/ / _ \ \ / /
 | (__| | | |  __/ (__|   < (_) \ V / 
  \___|_| |_|\___|\___|_|\_\___/ \_/  
                                      
By Prisma Cloud | version: 3.2.43 

terraform scan results:

Passed checks: 29, Failed checks: 13, Skipped checks: 0

Check: CKV_AWS_130: "Ensure VPC subnets do not assign public IP by default"
	PASSED for resource: aws_subnet.dev_private_subnets[0]
	File: /main.tf:23-29
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-vpc-subnets-do-not-assign-public-ip-by-default
Check: CKV_AWS_229: "Ensure no NACL allow ingress from 0.0.0.0:0 to port 21"
	PASSED for resource: aws_network_acl.dev_frontend_nacl
	File: /main.tf:103-129
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-aws-nacl-does-not-allow-ingress-from-00000-to-port-21
Check: CKV_AWS_230: "Ensure no NACL allow ingress from 0.0.0.0:0 to port 20"
	PASSED for resource: aws_network_acl.dev_frontend_nacl
	File: /main.tf:103-129
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-aws-nacl-does-not-allow-ingress-from-00000-to-port-20
Check: CKV_AWS_231: "Ensure no NACL allow ingress from 0.0.0.0:0 to port 3389"
	PASSED for resource: aws_network_acl.dev_frontend_nacl
	File: /main.tf:103-129
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-aws-nacl-does-not-allow-ingress-from-00000-to-port-3389
Check: CKV_AWS_232: "Ensure no NACL allow ingress from 0.0.0.0:0 to port 22"
	PASSED for resource: aws_network_acl.dev_frontend_nacl
	File: /main.tf:103-129
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-aws-nacl-does-not-allow-ingress-from-00000-to-port-22
Check: CKV_AWS_229: "Ensure no NACL allow ingress from 0.0.0.0:0 to port 21"
	PASSED for resource: aws_network_acl.dev_backend_nacl
	File: /main.tf:139-165
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-aws-nacl-does-not-allow-ingress-from-00000-to-port-21
Check: CKV_AWS_230: "Ensure no NACL allow ingress from 0.0.0.0:0 to port 20"
	PASSED for resource: aws_network_acl.dev_backend_nacl
	File: /main.tf:139-165
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-aws-nacl-does-not-allow-ingress-from-00000-to-port-20
Check: CKV_AWS_231: "Ensure no NACL allow ingress from 0.0.0.0:0 to port 3389"
	PASSED for resource: aws_network_acl.dev_backend_nacl
	File: /main.tf:139-165
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-aws-nacl-does-not-allow-ingress-from-00000-to-port-3389
Check: CKV_AWS_232: "Ensure no NACL allow ingress from 0.0.0.0:0 to port 22"
	PASSED for resource: aws_network_acl.dev_backend_nacl
	File: /main.tf:139-165
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-aws-nacl-does-not-allow-ingress-from-00000-to-port-22
Check: CKV_AWS_229: "Ensure no NACL allow ingress from 0.0.0.0:0 to port 21"
	PASSED for resource: aws_network_acl.dev_db_nacl
	File: /main.tf:175-201
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-aws-nacl-does-not-allow-ingress-from-00000-to-port-21
Check: CKV_AWS_230: "Ensure no NACL allow ingress from 0.0.0.0:0 to port 20"
	PASSED for resource: aws_network_acl.dev_db_nacl
	File: /main.tf:175-201
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-aws-nacl-does-not-allow-ingress-from-00000-to-port-20
Check: CKV_AWS_231: "Ensure no NACL allow ingress from 0.0.0.0:0 to port 3389"
	PASSED for resource: aws_network_acl.dev_db_nacl
	File: /main.tf:175-201
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-aws-nacl-does-not-allow-ingress-from-00000-to-port-3389
Check: CKV_AWS_232: "Ensure no NACL allow ingress from 0.0.0.0:0 to port 22"
	PASSED for resource: aws_network_acl.dev_db_nacl
	File: /main.tf:175-201
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-aws-nacl-does-not-allow-ingress-from-00000-to-port-22
Check: CKV_AWS_260: "Ensure no security groups allow ingress from 0.0.0.0:0 to port 80"
	PASSED for resource: aws_security_group.dev_alb_sg
	File: /main.tf:212-237
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-aws-security-groups-do-not-allow-ingress-from-00000-to-port-80
Check: CKV_AWS_25: "Ensure no security groups allow ingress from 0.0.0.0:0 to port 3389"
	PASSED for resource: aws_security_group.dev_alb_sg
	File: /main.tf:212-237
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/networking-2
Check: CKV_AWS_277: "Ensure no security groups allow ingress from 0.0.0.0:0 to port -1"
	PASSED for resource: aws_security_group.dev_alb_sg
	File: /main.tf:212-237
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-aws-security-group-does-not-allow-all-traffic-on-all-ports
Check: CKV_AWS_24: "Ensure no security groups allow ingress from 0.0.0.0:0 to port 22"
	PASSED for resource: aws_security_group.dev_alb_sg
	File: /main.tf:212-237
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/networking-1-port-security
Check: CKV_AWS_150: "Ensure that Load Balancer has deletion protection enabled"
	PASSED for resource: aws_lb.dev_alb
	File: /main.tf:241-251
	Guide: https://docs.bridgecrew.io/docs/bc_aws_networking_62
Check: CKV_AWS_328: "Ensure that ALB is configured with defensive or strictest desync mitigation mode"
	PASSED for resource: aws_lb.dev_alb
	File: /main.tf:241-251
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/bc-aws-328
Check: CKV_AWS_130: "Ensure VPC subnets do not assign public IP by default"
	PASSED for resource: aws_subnet.dev_private_subnets[1]
	File: /main.tf:23-29
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-vpc-subnets-do-not-assign-public-ip-by-default
Check: CKV_AWS_130: "Ensure VPC subnets do not assign public IP by default"
	PASSED for resource: aws_subnet.dev_private_subnets[2]
	File: /main.tf:23-29
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-vpc-subnets-do-not-assign-public-ip-by-default
Check: CKV2_AWS_5: "Ensure that Security Groups are attached to another resource"
	PASSED for resource: aws_security_group.dev_alb_sg
	File: /main.tf:212-237
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-that-security-groups-are-attached-to-ec2-instances-or-elastic-network-interfaces-enis
Check: CKV2_AWS_20: "Ensure that ALB redirects HTTP requests into HTTPS ones"
	PASSED for resource: aws_lb.dev_alb
	File: /main.tf:241-251
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-that-alb-redirects-http-requests-into-https-ones
Check: CKV2_AWS_35: "AWS NAT Gateways should be utilized for the default route"
	PASSED for resource: aws_route_table.dev_public_rtb
	File: /main.tf:55-66
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-aws-nat-gateways-are-utilized-for-the-default-route
Check: CKV2_AWS_35: "AWS NAT Gateways should be utilized for the default route"
	PASSED for resource: aws_route_table.dev_private_rtb
	File: /main.tf:77-89
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-aws-nat-gateways-are-utilized-for-the-default-route
Check: CKV2_AWS_44: "Ensure AWS route table with VPC peering does not contain routes overly permissive to all traffic"
	PASSED for resource: aws_route_table.dev_public_rtb
	File: /main.tf:55-66
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-aws-route-table-with-vpc-peering-does-not-contain-routes-overly-permissive-to-all-traffic
Check: CKV2_AWS_44: "Ensure AWS route table with VPC peering does not contain routes overly permissive to all traffic"
	PASSED for resource: aws_route_table.dev_private_rtb
	File: /main.tf:77-89
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-aws-route-table-with-vpc-peering-does-not-contain-routes-overly-permissive-to-all-traffic
Check: CKV2_AWS_23: "Route53 A Record has Attached Resource"
	PASSED for resource: aws_route53_record.dev_route53_record
	File: /main.tf:264-274
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-general-policies/ensure-route53-a-record-has-an-attached-resource
Check: CKV2_AWS_19: "Ensure that all EIP addresses allocated to a VPC are attached to EC2 instances"
	PASSED for resource: aws_eip.dev_elastic_ip
	File: /main.tf:40-42
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-that-all-eip-addresses-allocated-to-a-vpc-are-attached-to-ec2-instances
Check: CKV_AWS_130: "Ensure VPC subnets do not assign public IP by default"
	FAILED for resource: aws_subnet.dev_public_subnets[0]
	File: /main.tf:12-19
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-vpc-subnets-do-not-assign-public-ip-by-default

		12 | resource "aws_subnet" "dev_public_subnets" {
		13 |   count                   = length(var.public_subnets_cidr)
		14 |   vpc_id                  = aws_vpc.dev_vpc.id
		15 |   cidr_block              = var.public_subnets_cidr[count.index]
		16 |   availability_zone       = var.public_subnets_az[count.index]
		17 |   map_public_ip_on_launch = var.enable_map_public_ip_on_launch
		18 |   tags                    = var.public_subnets_tags[count.index]
		19 | }

Check: CKV_AWS_23: "Ensure every security groups rule has a description"
	FAILED for resource: aws_security_group.dev_alb_sg
	File: /main.tf:212-237
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/networking-31

		212 | resource "aws_security_group" "dev_alb_sg" {
		213 |   name        = var.alb_sg_name
		214 |   description = var.alb_sg_description
		215 |   vpc_id      = aws_vpc.dev_vpc.id
		216 | 
		217 |   dynamic "ingress" {
		218 |     for_each = var.alb_sg_inbound_rules
		219 |     content {
		220 |       from_port   = ingress.value.port
		221 |       to_port     = ingress.value.port
		222 |       protocol    = ingress.value.protocol
		223 |       cidr_blocks = [ingress.value.source]
		224 |     }
		225 |   }
		226 | 
		227 |   dynamic "egress" {
		228 |     for_each = var.alb_sg_outbound_rules
		229 |     content {
		230 |       from_port   = egress.value.port
		231 |       to_port     = egress.value.port
		232 |       protocol    = egress.value.protocol
		233 |       cidr_blocks = [egress.value.source]
		234 |     }
		235 |   }
		236 |   tags = var.alb_sg_tags
		237 | }

Check: CKV_AWS_91: "Ensure the ELBv2 (Application/Network) has access logging enabled"
	FAILED for resource: aws_lb.dev_alb
	File: /main.tf:241-251
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-logging-policies/bc-aws-logging-22

		241 | resource "aws_lb" "dev_alb" {
		242 |   name               = var.alb_name
		243 |   internal           = var.alb_internal
		244 |   load_balancer_type = var.alb_type
		245 |   security_groups    = [aws_security_group.dev_alb_sg.id]
		246 |   subnets            = [for subnet in aws_subnet.dev_public_subnets : subnet.id]
		247 | 
		248 |   enable_deletion_protection = var.alb_deletion_protection
		249 | 
		250 |   tags = var.alb_tags
		251 | }

Check: CKV_AWS_131: "Ensure that ALB drops HTTP headers"
	FAILED for resource: aws_lb.dev_alb
	File: /main.tf:241-251
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-that-alb-drops-http-headers

		241 | resource "aws_lb" "dev_alb" {
		242 |   name               = var.alb_name
		243 |   internal           = var.alb_internal
		244 |   load_balancer_type = var.alb_type
		245 |   security_groups    = [aws_security_group.dev_alb_sg.id]
		246 |   subnets            = [for subnet in aws_subnet.dev_public_subnets : subnet.id]
		247 | 
		248 |   enable_deletion_protection = var.alb_deletion_protection
		249 | 
		250 |   tags = var.alb_tags
		251 | }

Check: CKV_AWS_130: "Ensure VPC subnets do not assign public IP by default"
	FAILED for resource: aws_subnet.dev_public_subnets[1]
	File: /main.tf:12-19
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-vpc-subnets-do-not-assign-public-ip-by-default

		12 | resource "aws_subnet" "dev_public_subnets" {
		13 |   count                   = length(var.public_subnets_cidr)
		14 |   vpc_id                  = aws_vpc.dev_vpc.id
		15 |   cidr_block              = var.public_subnets_cidr[count.index]
		16 |   availability_zone       = var.public_subnets_az[count.index]
		17 |   map_public_ip_on_launch = var.enable_map_public_ip_on_launch
		18 |   tags                    = var.public_subnets_tags[count.index]
		19 | }

Check: CKV2_AWS_11: "Ensure VPC flow logging is enabled in all VPCs"
	FAILED for resource: aws_vpc.dev_vpc
	File: /main.tf:3-8
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-logging-policies/logging-9-enable-vpc-flow-logging

		3 | resource "aws_vpc" "dev_vpc" {
		4 |   cidr_block           = var.vpc_cidr
		5 |   enable_dns_support   = var.vpc_enable_dns_support
		6 |   enable_dns_hostnames = var.vpc_enable_dns_hostnames
		7 |   tags                 = var.vpc_tags
		8 | }

Check: CKV2_AWS_39: "Ensure Domain Name System (DNS) query logging is enabled for Amazon Route 53 hosted zones"
	FAILED for resource: aws_route53_zone.dev_route53_zone
	File: /main.tf:255-262
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-logging-policies/bc-aws-2-39

		255 | resource "aws_route53_zone" "dev_route53_zone" {
		256 |   name = var.route53_zone_name
		257 |   vpc {
		258 |     vpc_id     = aws_vpc.dev_vpc.id
		259 |     vpc_region = var.region
		260 |   }
		261 |   tags = var.route53_zone_tags
		262 | }

Check: CKV2_AWS_38: "Ensure Domain Name System Security Extensions (DNSSEC) signing is enabled for Amazon Route 53 public hosted zones"
	FAILED for resource: aws_route53_zone.dev_route53_zone
	File: /main.tf:255-262
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/bc-aws-2-38

		255 | resource "aws_route53_zone" "dev_route53_zone" {
		256 |   name = var.route53_zone_name
		257 |   vpc {
		258 |     vpc_id     = aws_vpc.dev_vpc.id
		259 |     vpc_region = var.region
		260 |   }
		261 |   tags = var.route53_zone_tags
		262 | }

Check: CKV2_AWS_12: "Ensure the default security group of every VPC restricts all traffic"
	FAILED for resource: aws_vpc.dev_vpc
	File: /main.tf:3-8
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/networking-4

		3 | resource "aws_vpc" "dev_vpc" {
		4 |   cidr_block           = var.vpc_cidr
		5 |   enable_dns_support   = var.vpc_enable_dns_support
		6 |   enable_dns_hostnames = var.vpc_enable_dns_hostnames
		7 |   tags                 = var.vpc_tags
		8 | }

Check: CKV2_AWS_1: "Ensure that all NACL are attached to subnets"
	FAILED for resource: aws_network_acl.dev_frontend_nacl
	File: /main.tf:103-129
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-that-all-nacl-are-attached-to-subnets

		103 | resource "aws_network_acl" "dev_frontend_nacl" {
		104 |   vpc_id = aws_vpc.dev_vpc.id
		105 | 
		106 |   dynamic "ingress" {
		107 |     for_each = var.frontend_nacl_ingress
		108 |     content {
		109 |       protocol   = ingress.value.protocol
		110 |       rule_no    = ingress.value.rule_no
		111 |       action     = ingress.value.action
		112 |       cidr_block = ingress.value.cidr_block
		113 |       from_port  = ingress.value.from_port
		114 |       to_port    = ingress.value.to_port
		115 |     }
		116 |   }
		117 |   dynamic "egress" {
		118 |     for_each = var.frontend_nacl_egress
		119 |     content {
		120 |       protocol   = egress.value.protocol
		121 |       rule_no    = egress.value.rule_no
		122 |       action     = egress.value.action
		123 |       cidr_block = egress.value.cidr_block
		124 |       from_port  = egress.value.from_port
		125 |       to_port    = egress.value.to_port
		126 |     }
		127 |   }
		128 |   tags = var.frontend_nacl_tags
		129 | }

Check: CKV2_AWS_1: "Ensure that all NACL are attached to subnets"
	FAILED for resource: aws_network_acl.dev_backend_nacl
	File: /main.tf:139-165
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-that-all-nacl-are-attached-to-subnets

		139 | resource "aws_network_acl" "dev_backend_nacl" {
		140 |   vpc_id = aws_vpc.dev_vpc.id
		141 | 
		142 |   dynamic "ingress" {
		143 |     for_each = var.backend_nacl_ingress
		144 |     content {
		145 |       protocol   = ingress.value.protocol
		146 |       rule_no    = ingress.value.rule_no
		147 |       action     = ingress.value.action
		148 |       cidr_block = ingress.value.cidr_block
		149 |       from_port  = ingress.value.from_port
		150 |       to_port    = ingress.value.to_port
		151 |     }
		152 |   }
		153 |   dynamic "egress" {
		154 |     for_each = var.backend_nacl_egress
		155 |     content {
		156 |       protocol   = egress.value.protocol
		157 |       rule_no    = egress.value.rule_no
		158 |       action     = egress.value.action
		159 |       cidr_block = egress.value.cidr_block
		160 |       from_port  = egress.value.from_port
		161 |       to_port    = egress.value.to_port
		162 |     }
		163 |   }
		164 |   tags = var.backend_nacl_tags
		165 | }

Check: CKV2_AWS_1: "Ensure that all NACL are attached to subnets"
	FAILED for resource: aws_network_acl.dev_db_nacl
	File: /main.tf:175-201
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-that-all-nacl-are-attached-to-subnets

		175 | resource "aws_network_acl" "dev_db_nacl" {
		176 |   vpc_id = aws_vpc.dev_vpc.id
		177 | 
		178 |   dynamic "ingress" {
		179 |     for_each = var.db_nacl_ingress
		180 |     content {
		181 |       protocol   = ingress.value.protocol
		182 |       rule_no    = ingress.value.rule_no
		183 |       action     = ingress.value.action
		184 |       cidr_block = ingress.value.cidr_block
		185 |       from_port  = ingress.value.from_port
		186 |       to_port    = ingress.value.to_port
		187 |     }
		188 |   }
		189 |   dynamic "egress" {
		190 |     for_each = var.db_nacl_egress
		191 |     content {
		192 |       protocol   = egress.value.protocol
		193 |       rule_no    = egress.value.rule_no
		194 |       action     = egress.value.action
		195 |       cidr_block = egress.value.cidr_block
		196 |       from_port  = egress.value.from_port
		197 |       to_port    = egress.value.to_port
		198 |     }
		199 |   }
		200 |   tags = var.db_nacl_tags
		201 | }

Check: CKV2_AWS_28: "Ensure public facing ALB are protected by WAF"
	FAILED for resource: aws_lb.dev_alb
	File: /main.tf:241-251
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-public-facing-alb-are-protected-by-waf

		241 | resource "aws_lb" "dev_alb" {
		242 |   name               = var.alb_name
		243 |   internal           = var.alb_internal
		244 |   load_balancer_type = var.alb_type
		245 |   security_groups    = [aws_security_group.dev_alb_sg.id]
		246 |   subnets            = [for subnet in aws_subnet.dev_public_subnets : subnet.id]
		247 | 
		248 |   enable_deletion_protection = var.alb_deletion_protection
		249 | 
		250 |   tags = var.alb_tags
		251 | }

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
+ git tag -a v1.0 -m Version 1.0
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
+ git push https://username:****@github.com/CodeOps-Hub/Terraform-modules.git v1.0
To https://github.com/CodeOps-Hub/Terraform-modules.git
 * [new tag]         v1.0 -> v1.0
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

def network = new org.avengers.template.Module_CI_CD.cicd()

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
                            string(name: 'childPath', defaultValue: 'Network_Skeleton_Module', description: 'Enter the child directory path'),
                            string(name: 'tagVersion', defaultValue: 'null', description: 'Enter the correct version'),
                            string(name: 'gitpath', defaultValue: 'CodeOps-Hub/Terraform-modules.git', description: 'Enter the correct GitHub repository path')
                              
                           
                        ])
                    ])

                    def url = 'https://github.com/CodeOps-Hub/Terraform-modules.git'
                    def creds = 'shantanu-pat'
                    
                    
                    network.call(url, creds, params.branch, params.rootPath, params.childPath, params.tagVersion, params.gitpath)
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
<summary> cicd.groovy </summary>
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
	
ci.grovvy

```shell
package org.avengers.Module_CI_CD

def call(String rootPath, String childPath, String tagVersion) {
    stage("Terraform action") {
        script {
            sh "cd ${rootPath}/${childPath}"
        }
    }
    stage('Terraform init') {
        script {
            // Initialize Terraform working directory
            sh "cd ${rootPath}/${childPath} && terraform init"
        }
    }
    stage('Terraform fmt') {
        script {
            // Stage to format Terraform files
            sh "cd ${rootPath}/${childPath} && sudo terraform fmt"
        }
    }
    stage('Terraform Validate') {
        script {
            // Validate Terraform configurations
            sh "cd ${rootPath}/${childPath} && sudo terraform validate"
        }
    }
      stage('Static Code Analysis') {
        script {
            // Install TFLint and run static code analysis
            sh "curl -s https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | sudo bash"
            sh "cd ${rootPath}/${childPath} && tflint --format default | tee tflint_report.json"
        }
    }

    stage('checkov') {
        script {

            // Check if Checkov is installed
           def checkovInstalled = sh(script: 'test -x /var/lib/jenkins/.local/bin/checkov && echo "Installed"', returnStatus: true)
            if (checkovInstalled == 0) {
               echo "Checkov is already installed."
           } else {
                echo "Checkov is not installed. Installing..."
                sh "pip install checkov"
                sh "python3 -m pip install checkov"
                sh 'echo "export PATH=\"`python3 -m site --user-base`/bin:\$PATH\"" >> ~/.bashrc'
                sh "sudo apt install pipenv -y"
                sh "pip install checkov"
                
            }
            // Stage to run Checkov for Terraform
            sh "cd ${rootPath}/${childPath} && /var/lib/jenkins/.local/bin/checkov -d . -s --output-file-path . --skip-path ./tflint_report.jsonֿ"
        }
    }
    // stage("Terraform Plan") {
    //     script {
    //         sh "cd ${rootPath}/${childPath} && terraform plan"
    //     }
    // }
    
   stage('Git Tag Stage') {
        script {
            // Tag the version
            sh "git tag -a v${tagVersion} -m 'Version ${tagVersion}'"
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
