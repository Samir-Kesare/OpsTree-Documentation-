# DSL Jenkins pipeline for Network Skeleton setup in QA env 

<img width="360" length="100" alt="Terraform" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/556e50dc-0c8b-4262-be16-2c384d2cfa8a">

***
|   Author        |  Created on   |  Version   | Last updated by  | Last edited on |
| --------------- | --------------| -----------|----------------- | -------------- |
| Khushi Malhotra |  18 March 2024  |  Version 1 | Khushi Malhotra  | 18 March 2024    |

## Table of contents

* [Introduction](#Introduction)
* [What is DSL Pipeline](#What-is-DSL-Pipeline)
* [Why DSL Pipeline](#Why-DSP-Pipeline)
* [Flow Diagram](#Flow-Diagram)
* [Pre-requisites](#Pre-requisites)
* [Implementation of DSL Pipeline](#Implementation-of-DSL-Pipeline)
* [Terraform Module](#Terraform-Module)
* [Jenkinsfile](#Jenkinsfile)
* [Output](#Output)
* [Conclusion](#Conclusion)
* [Contact Information](#Contact-Information)
* [References](#References)

***
## Introduction

With the increasing complexity of modern networks and the need for agility in infrastructure management, Terraform has emerged as a powerful tool for automating the provisioning and configuration of network resources.This module is designed to provide a foundational framework for managing network infrastructure as code using Terraform. The OpenVPN wrapper code simplifies the deployment and management of OpenVPN servers by automating configuration tasks and providing a user-friendly interface for users to connect securely to the VPN.

***

## What is DSL Pipeline?

A Domain-Specific Language (DSL) is a programming language or specification language dedicated to a particular problem domain, a particular problem representation technique, and/or a particular solution technique.DSL Pipeline is a robust framework designed to facilitate the creation, deployment, and management of domain-specific languages within your software development projects. By employing DSLs, developers can express solutions in a concise, domain-specific syntax tailored to the problem at hand, thereby enhancing productivity and reducing the gap between domain experts and software implementation.

There are two main types of DSLs: external DSLs and internal DSLs. External DSLs have their own syntax and are typically parsed by a separate compiler or interpreter. Internal DSLs, on the other hand, are embedded within a host programming language, leveraging its syntax and features to create a domain-specific syntax.

***

## Why DSL Pipeline

| Key Features  | Description                                                                                                              |
|---------------|--------------------------------------------------------------------------------------------------------------------------|
| **Modularity**    | The DSL Pipeline offers a modular architecture, allowing developers to define and integrate custom DSL components seamlessly. |
| **Extensibility** | Extend the capabilities of the DSL Pipeline by incorporating new DSL constructs, transformations, and integrations with existing tools and libraries. |
| **Automation**    | Automate repetitive tasks in the development lifecycle through pipeline automation, including parsing, validation, transformation, and code generation. |
| **Flexibility**   | Accommodate diverse DSL requirements with flexible configuration options, support for various syntax styles, and compatibility with multiple target platforms. |

***

## Flow Diagram

<img width="950" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/9b5ae612-95d9-4cf4-9612-d9874fcfd843">

***

## Pre-requisites

| **Pre-requisites** | **Description** |
| ------------------ | ---------------- |
| **AWS Account**    | Access to the AWS Management Console with credentials configured. |
| **Jenkins**        | To integrate infra through DSL Pipeline. |
| **Terraform**      | Terraform HCL (v1.7.4) |

***

## Implementation of DSL Pipeline 

**Step-1** Create a New Pipeline Job

- Navigate to the Jenkins dashboard and click on New Item.
- Enter a name for your job (e.g., "Terraform.CD").
- Select Pipeline and click OK.

**Step-2** Configure Pipeline Script

- In the job configuration page, scroll down to the Pipeline section.
- Select Pipeline script from SCM.
- Give required repo url and enter your credentials.

**Step-3** Save the Configuration

- Click on Save to save the job configuration.

**Step-4** Build the Pipeline

- Once the pipeline configuration is saved, you can manually trigger the build by clicking on Build Now.

**Step-5** View Build Console Output

- After triggering the build, you can view the progress and console output of the build by clicking on the build number in the Jenkins dashboard.
- The console output will display the steps executed by the pipeline script, including code checkout and compilation.
- Verify Successful Compilation.

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/2fb508a3-dfae-42c3-a453-54cd62377fbd)

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/02922b8b-c2c5-40c1-9209-e9258ce4e6ec)

<details>
<summary> <b> Click here for Console Output </b> </summary>
<br>

  ```shell
Started by user Shikha Tripathi
Lightweight checkout support not available, falling back to full checkout.
Checking out git https://github.com/CodeOps-Hub/Jenkinsfile.git into /var/lib/jenkins/jobs/QA_NS_DSL_Pipeline/workspace@script/2c624e68d9ac93966b0a6ecea74a8a9f93dbab47b6fffa7f2ebbef857f80f0b1 to read Wrapper-Code/QA_Env/networkskeleton_QA/Jenkinsfile
Selected Git installation does not exist. Using Default
The recommended git tool is: NONE
using credential Khushi_PAT
 > git rev-parse --resolve-git-dir /var/lib/jenkins/jobs/QA_NS_DSL_Pipeline/workspace@script/2c624e68d9ac93966b0a6ecea74a8a9f93dbab47b6fffa7f2ebbef857f80f0b1/.git # timeout=10
Fetching changes from the remote Git repository
 > git config remote.origin.url https://github.com/CodeOps-Hub/Jenkinsfile.git # timeout=10
Fetching upstream changes from https://github.com/CodeOps-Hub/Jenkinsfile.git
 > git --version # timeout=10
 > git --version # 'git version 2.34.1'
using GIT_ASKPASS to set credentials Khushi_PAT
 > git fetch --tags --force --progress -- https://github.com/CodeOps-Hub/Jenkinsfile.git +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git rev-parse refs/remotes/origin/khushi/networkSkeleton_QA^{commit} # timeout=10
 > git rev-parse khushi/networkSkeleton_QA^{commit} # timeout=10
Checking out Revision 33bec14482cf60973148febd3fe55ca9080add67 (refs/remotes/origin/khushi/networkSkeleton_QA)
 > git config core.sparsecheckout # timeout=10
 > git checkout -f 33bec14482cf60973148febd3fe55ca9080add67 # timeout=10
Commit message: "Update Jenkinsfile"
 > git rev-list --no-walk 33bec14482cf60973148febd3fe55ca9080add67 # timeout=10
[Pipeline] Start of Pipeline
[Pipeline] node
Running on Jenkins in /var/lib/jenkins/jobs/QA_NS_DSL_Pipeline/workspace
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Declarative: Checkout SCM)
[Pipeline] checkout
Selected Git installation does not exist. Using Default
The recommended git tool is: NONE
using credential Khushi_PAT
 > git rev-parse --resolve-git-dir /var/lib/jenkins/jobs/QA_NS_DSL_Pipeline/workspace/.git # timeout=10
Fetching changes from the remote Git repository
 > git config remote.origin.url https://github.com/CodeOps-Hub/Jenkinsfile.git # timeout=10
Fetching upstream changes from https://github.com/CodeOps-Hub/Jenkinsfile.git
 > git --version # timeout=10
 > git --version # 'git version 2.34.1'
using GIT_ASKPASS to set credentials Khushi_PAT
 > git fetch --tags --force --progress -- https://github.com/CodeOps-Hub/Jenkinsfile.git +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git rev-parse refs/remotes/origin/khushi/networkSkeleton_QA^{commit} # timeout=10
 > git rev-parse khushi/networkSkeleton_QA^{commit} # timeout=10
Checking out Revision 33bec14482cf60973148febd3fe55ca9080add67 (refs/remotes/origin/khushi/networkSkeleton_QA)
 > git config core.sparsecheckout # timeout=10
 > git checkout -f 33bec14482cf60973148febd3fe55ca9080add67 # timeout=10
Commit message: "Update Jenkinsfile"
[Pipeline] }
[Pipeline] // stage
[Pipeline] withEnv
[Pipeline] {
[Pipeline] withCredentials
WARNING: Unknown parameter(s) found for class type 'com.cloudbees.jenkins.plugins.awscredentials.AmazonWebServicesCredentialsBinding': keyIdVariable,secretVariable
WARNING: Unknown parameter(s) found for class type 'com.cloudbees.jenkins.plugins.awscredentials.AmazonWebServicesCredentialsBinding': keyIdVariable,secretVariable
Masking supported pattern matches of $AWS_ACCESS_KEY_ID or $AWS_SECRET_ACCESS_KEY
[Pipeline] {
[Pipeline] withEnv
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Checkout)
[Pipeline] git
The recommended git tool is: NONE
using credential Khushi_PAT
 > git rev-parse --resolve-git-dir /var/lib/jenkins/jobs/QA_NS_DSL_Pipeline/workspace/.git # timeout=10
Fetching changes from the remote Git repository
 > git config remote.origin.url https://github.com/CodeOps-Hub/Terraform-modules.git # timeout=10
Fetching upstream changes from https://github.com/CodeOps-Hub/Terraform-modules.git
 > git --version # timeout=10
 > git --version # 'git version 2.34.1'
using GIT_ASKPASS to set credentials Khushi_PAT
 > git fetch --tags --force --progress -- https://github.com/CodeOps-Hub/Terraform-modules.git +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git rev-parse refs/remotes/origin/main^{commit} # timeout=10
Checking out Revision 0cb5bbf1af0778791c4c1c54bd62f0564a6d0041 (refs/remotes/origin/main)
 > git config core.sparsecheckout # timeout=10
 > git checkout -f 0cb5bbf1af0778791c4c1c54bd62f0564a6d0041 # timeout=10
 > git branch -a -v --no-abbrev # timeout=10
 > git branch -D main # timeout=10
 > git checkout -b main 0cb5bbf1af0778791c4c1c54bd62f0564a6d0041 # timeout=10
Commit message: "Update output.tf"
 > git rev-list --no-walk 0cb5bbf1af0778791c4c1c54bd62f0564a6d0041 # timeout=10
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Copy Terraform Files)
[Pipeline] sh
+ cp wrapperCode/Network-Skeleton-Wrapper-Code/QA-Network-Skeleton-Wrapper-Code/main.tf wrapperCode/Network-Skeleton-Wrapper-Code/QA-Network-Skeleton-Wrapper-Code/output.tf wrapperCode/Network-Skeleton-Wrapper-Code/QA-Network-Skeleton-Wrapper-Code/providers.tf wrapperCode/Network-Skeleton-Wrapper-Code/QA-Network-Skeleton-Wrapper-Code/terraform.tfvars wrapperCode/Network-Skeleton-Wrapper-Code/QA-Network-Skeleton-Wrapper-Code/variables.tf .
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Terraform Init)
[Pipeline] script
[Pipeline] {
[Pipeline] sh
+ terraform init

[0m[1mInitializing the backend...[0m
[0m[1mInitializing modules...[0m

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
[Pipeline] { (Terraform Plan)
[Pipeline] script
[Pipeline] {
[Pipeline] sh
+ terraform plan
[0m[1mmodule.network.aws_eip.dev_elastic_ip: Refreshing state... [id=eipalloc-06ed2d588543a8977][0m
[0m[1mmodule.network.aws_vpc.dev_vpc: Refreshing state... [id=vpc-0a917fb8214d4ce27][0m
[0m[1mmodule.network.aws_security_group.dev_alb_sg: Refreshing state... [id=sg-0cb0d9b0b204a76b0][0m
[0m[1mmodule.network.aws_subnet.dev_private_subnets[2]: Refreshing state... [id=subnet-0833f5adf745ed36e][0m
[0m[1mmodule.network.aws_network_acl.dev_db_nacl: Refreshing state... [id=acl-0dc3bb1249fefdc2a][0m
[0m[1mmodule.network.aws_subnet.dev_public_subnets[1]: Refreshing state... [id=subnet-019b3e37356b9a8fc][0m
[0m[1mmodule.network.aws_network_acl.dev_frontend_nacl: Refreshing state... [id=acl-0e1fdcd7a4e2d28f4][0m
[0m[1mmodule.network.aws_subnet.dev_public_subnets[0]: Refreshing state... [id=subnet-029ec349c99f32b78][0m
[0m[1mmodule.network.aws_subnet.dev_private_subnets[0]: Refreshing state... [id=subnet-0d2692e3f50413cb0][0m
[0m[1mmodule.network.aws_subnet.dev_private_subnets[1]: Refreshing state... [id=subnet-0729f2e42a973a23d][0m
[0m[1mmodule.network.aws_route53_zone.dev_route53_zone: Refreshing state... [id=Z02676911RHIWQ84M65B8][0m
[0m[1mmodule.network.aws_network_acl.dev_backend_nacl: Refreshing state... [id=acl-05193e105cbafa972][0m
[0m[1mmodule.network.aws_internet_gateway.dev_igw: Refreshing state... [id=igw-029d331ad13cf3181][0m
[0m[1mmodule.network.aws_lb.dev_alb: Refreshing state... [id=arn:aws:elasticloadbalancing:us-east-2:133673781875:loadbalancer/app/QA-alb/ad64e23f0761861a][0m
[0m[1mmodule.network.aws_route_table.dev_public_rtb: Refreshing state... [id=rtb-0ebe9542ba1b8b63c][0m
[0m[1mmodule.network.aws_nat_gateway.dev_nat: Refreshing state... [id=nat-07d8818303623fb59][0m
[0m[1mmodule.network.aws_network_acl_association.dev_frontend_nacl: Refreshing state... [id=aclassoc-025a02d3403117f89][0m
[0m[1mmodule.network.aws_network_acl_association.dev_db_nacl_assc: Refreshing state... [id=aclassoc-02c4ceb5646dc3f58][0m
[0m[1mmodule.network.aws_network_acl_association.dev_backend_nacl_assc: Refreshing state... [id=aclassoc-0dfdc2502459a5ce5][0m
[0m[1mmodule.network.aws_route_table_association.dev_public_route_association01[0]: Refreshing state... [id=rtbassoc-023c9ddeb3106b4a3][0m
[0m[1mmodule.network.aws_route_table_association.dev_public_route_association01[1]: Refreshing state... [id=rtbassoc-07e0a3f81eb238476][0m
[0m[1mmodule.network.aws_route_table.dev_private_rtb: Refreshing state... [id=rtb-051d119075e393d2a][0m
[0m[1mmodule.network.aws_route_table_association.dev_private_route_association01[2]: Refreshing state... [id=rtbassoc-06a303cad50a27114][0m
[0m[1mmodule.network.aws_route_table_association.dev_private_route_association01[0]: Refreshing state... [id=rtbassoc-0aed0aad698470afb][0m
[0m[1mmodule.network.aws_route_table_association.dev_private_route_association01[1]: Refreshing state... [id=rtbassoc-0dc813f2dde9d7efb][0m
[0m[1mmodule.network.aws_route53_record.dev_route53_record: Refreshing state... [id=Z02676911RHIWQ84M65B8_example.com_A][0m

[0m[1m[32mNo changes.[0m[1m Your infrastructure matches the configuration.[0m

[0mTerraform has compared your real infrastructure against your configuration
and found no differences, so no changes are needed.
[Pipeline] }
[Pipeline] // script
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Review and Approve Apply)
Stage "Review and Approve Apply" skipped due to when conditional
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Review and Approve Destroy)
[Pipeline] input
Do you want to destroy Terraform resources?
Proceed or Abort
Approved by Shikha Tripathi
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Apply or Destroy)
[Pipeline] script
[Pipeline] {
[Pipeline] sh
+ terraform destroy -auto-approve
[0m[1mmodule.network.aws_vpc.dev_vpc: Refreshing state... [id=vpc-0a917fb8214d4ce27][0m
[0m[1mmodule.network.aws_eip.dev_elastic_ip: Refreshing state... [id=eipalloc-06ed2d588543a8977][0m
[0m[1mmodule.network.aws_route53_zone.dev_route53_zone: Refreshing state... [id=Z02676911RHIWQ84M65B8][0m
[0m[1mmodule.network.aws_network_acl.dev_frontend_nacl: Refreshing state... [id=acl-0e1fdcd7a4e2d28f4][0m
[0m[1mmodule.network.aws_network_acl.dev_db_nacl: Refreshing state... [id=acl-0dc3bb1249fefdc2a][0m
[0m[1mmodule.network.aws_subnet.dev_private_subnets[0]: Refreshing state... [id=subnet-0d2692e3f50413cb0][0m
[0m[1mmodule.network.aws_subnet.dev_private_subnets[1]: Refreshing state... [id=subnet-0729f2e42a973a23d][0m
[0m[1mmodule.network.aws_subnet.dev_public_subnets[0]: Refreshing state... [id=subnet-029ec349c99f32b78][0m
[0m[1mmodule.network.aws_security_group.dev_alb_sg: Refreshing state... [id=sg-0cb0d9b0b204a76b0][0m
[0m[1mmodule.network.aws_internet_gateway.dev_igw: Refreshing state... [id=igw-029d331ad13cf3181][0m
[0m[1mmodule.network.aws_subnet.dev_public_subnets[1]: Refreshing state... [id=subnet-019b3e37356b9a8fc][0m
[0m[1mmodule.network.aws_network_acl.dev_backend_nacl: Refreshing state... [id=acl-05193e105cbafa972][0m
[0m[1mmodule.network.aws_subnet.dev_private_subnets[2]: Refreshing state... [id=subnet-0833f5adf745ed36e][0m
[0m[1mmodule.network.aws_route_table.dev_public_rtb: Refreshing state... [id=rtb-0ebe9542ba1b8b63c][0m
[0m[1mmodule.network.aws_nat_gateway.dev_nat: Refreshing state... [id=nat-07d8818303623fb59][0m
[0m[1mmodule.network.aws_network_acl_association.dev_db_nacl_assc: Refreshing state... [id=aclassoc-02c4ceb5646dc3f58][0m
[0m[1mmodule.network.aws_network_acl_association.dev_frontend_nacl: Refreshing state... [id=aclassoc-025a02d3403117f89][0m
[0m[1mmodule.network.aws_lb.dev_alb: Refreshing state... [id=arn:aws:elasticloadbalancing:us-east-2:133673781875:loadbalancer/app/QA-alb/ad64e23f0761861a][0m
[0m[1mmodule.network.aws_route_table_association.dev_public_route_association01[0]: Refreshing state... [id=rtbassoc-023c9ddeb3106b4a3][0m
[0m[1mmodule.network.aws_route_table_association.dev_public_route_association01[1]: Refreshing state... [id=rtbassoc-07e0a3f81eb238476][0m
[0m[1mmodule.network.aws_network_acl_association.dev_backend_nacl_assc: Refreshing state... [id=aclassoc-0dfdc2502459a5ce5][0m
[0m[1mmodule.network.aws_route_table.dev_private_rtb: Refreshing state... [id=rtb-051d119075e393d2a][0m
[0m[1mmodule.network.aws_route_table_association.dev_private_route_association01[0]: Refreshing state... [id=rtbassoc-0aed0aad698470afb][0m
[0m[1mmodule.network.aws_route_table_association.dev_private_route_association01[1]: Refreshing state... [id=rtbassoc-0dc813f2dde9d7efb][0m
[0m[1mmodule.network.aws_route_table_association.dev_private_route_association01[2]: Refreshing state... [id=rtbassoc-06a303cad50a27114][0m
[0m[1mmodule.network.aws_route53_record.dev_route53_record: Refreshing state... [id=Z02676911RHIWQ84M65B8_example.com_A][0m

Terraform used the selected providers to generate the following execution
plan. Resource actions are indicated with the following symbols:
  [31m-[0m destroy[0m

Terraform will perform the following actions:

[1m  # module.network.aws_eip.dev_elastic_ip[0m will be [1m[31mdestroyed[0m
[0m  [31m-[0m[0m resource "aws_eip" "dev_elastic_ip" {
      [31m-[0m[0m allocation_id        = "eipalloc-06ed2d588543a8977" [90m-> null[0m[0m
      [31m-[0m[0m association_id       = "eipassoc-0dd61a5b7d00c9971" [90m-> null[0m[0m
      [31m-[0m[0m domain               = "vpc" [90m-> null[0m[0m
      [31m-[0m[0m id                   = "eipalloc-06ed2d588543a8977" [90m-> null[0m[0m
      [31m-[0m[0m network_border_group = "us-east-2" [90m-> null[0m[0m
      [31m-[0m[0m network_interface    = "eni-04bb3a616425bcb4f" [90m-> null[0m[0m
      [31m-[0m[0m private_dns          = "ip-10-0-1-134.us-east-2.compute.internal" [90m-> null[0m[0m
      [31m-[0m[0m private_ip           = "10.0.1.134" [90m-> null[0m[0m
      [31m-[0m[0m public_dns           = "ec2-3-13-41-144.us-east-2.compute.amazonaws.com" [90m-> null[0m[0m
      [31m-[0m[0m public_ip            = "3.13.41.144" [90m-> null[0m[0m
      [31m-[0m[0m public_ipv4_pool     = "amazon" [90m-> null[0m[0m
      [31m-[0m[0m tags                 = {} [90m-> null[0m[0m
      [31m-[0m[0m tags_all             = {} [90m-> null[0m[0m
      [31m-[0m[0m vpc                  = true [90m-> null[0m[0m
    }

[1m  # module.network.aws_internet_gateway.dev_igw[0m will be [1m[31mdestroyed[0m
[0m  [31m-[0m[0m resource "aws_internet_gateway" "dev_igw" {
      [31m-[0m[0m arn      = "arn:aws:ec2:us-east-2:133673781875:internet-gateway/igw-029d331ad13cf3181" [90m-> null[0m[0m
      [31m-[0m[0m id       = "igw-029d331ad13cf3181" [90m-> null[0m[0m
      [31m-[0m[0m owner_id = "133673781875" [90m-> null[0m[0m
      [31m-[0m[0m tags     = {
          [31m-[0m[0m "Enviroment" = "QA"
          [31m-[0m[0m "Name"       = "QA-igw-01"
          [31m-[0m[0m "Owner"      = "shreya"
        } [90m-> null[0m[0m
      [31m-[0m[0m tags_all = {
          [31m-[0m[0m "Enviroment" = "QA"
          [31m-[0m[0m "Name"       = "QA-igw-01"
          [31m-[0m[0m "Owner"      = "shreya"
        } [90m-> null[0m[0m
      [31m-[0m[0m vpc_id   = "vpc-0a917fb8214d4ce27" [90m-> null[0m[0m
    }

[1m  # module.network.aws_lb.dev_alb[0m will be [1m[31mdestroyed[0m
[0m  [31m-[0m[0m resource "aws_lb" "dev_alb" {
      [31m-[0m[0m arn                                         = "arn:aws:elasticloadbalancing:us-east-2:133673781875:loadbalancer/app/QA-alb/ad64e23f0761861a" [90m-> null[0m[0m
      [31m-[0m[0m arn_suffix                                  = "app/QA-alb/ad64e23f0761861a" [90m-> null[0m[0m
      [31m-[0m[0m desync_mitigation_mode                      = "defensive" [90m-> null[0m[0m
      [31m-[0m[0m dns_name                                    = "QA-alb-1420650551.us-east-2.elb.amazonaws.com" [90m-> null[0m[0m
      [31m-[0m[0m drop_invalid_header_fields                  = false [90m-> null[0m[0m
      [31m-[0m[0m enable_cross_zone_load_balancing            = true [90m-> null[0m[0m
      [31m-[0m[0m enable_deletion_protection                  = false [90m-> null[0m[0m
      [31m-[0m[0m enable_http2                                = true [90m-> null[0m[0m
      [31m-[0m[0m enable_tls_version_and_cipher_suite_headers = false [90m-> null[0m[0m
      [31m-[0m[0m enable_waf_fail_open                        = false [90m-> null[0m[0m
      [31m-[0m[0m enable_xff_client_port                      = false [90m-> null[0m[0m
      [31m-[0m[0m id                                          = "arn:aws:elasticloadbalancing:us-east-2:133673781875:loadbalancer/app/QA-alb/ad64e23f0761861a" [90m-> null[0m[0m
      [31m-[0m[0m idle_timeout                                = 60 [90m-> null[0m[0m
      [31m-[0m[0m internal                                    = false [90m-> null[0m[0m
      [31m-[0m[0m ip_address_type                             = "ipv4" [90m-> null[0m[0m
      [31m-[0m[0m load_balancer_type                          = "application" [90m-> null[0m[0m
      [31m-[0m[0m name                                        = "QA-alb" [90m-> null[0m[0m
      [31m-[0m[0m preserve_host_header                        = false [90m-> null[0m[0m
      [31m-[0m[0m security_groups                             = [
          [31m-[0m[0m "sg-0cb0d9b0b204a76b0",
        ] [90m-> null[0m[0m
      [31m-[0m[0m subnets                                     = [
          [31m-[0m[0m "subnet-019b3e37356b9a8fc",
          [31m-[0m[0m "subnet-029ec349c99f32b78",
        ] [90m-> null[0m[0m
      [31m-[0m[0m tags                                        = {
          [31m-[0m[0m "Enviroment" = "QA"
          [31m-[0m[0m "Owner"      = "shreya"
        } [90m-> null[0m[0m
      [31m-[0m[0m tags_all                                    = {
          [31m-[0m[0m "Enviroment" = "QA"
          [31m-[0m[0m "Owner"      = "shreya"
        } [90m-> null[0m[0m
      [31m-[0m[0m vpc_id                                      = "vpc-0a917fb8214d4ce27" [90m-> null[0m[0m
      [31m-[0m[0m xff_header_processing_mode                  = "append" [90m-> null[0m[0m
      [31m-[0m[0m zone_id                                     = "Z3AADJGX6KTTL2" [90m-> null[0m[0m

      [31m-[0m[0m access_logs {
          [31m-[0m[0m enabled = false [90m-> null[0m[0m
        }

      [31m-[0m[0m connection_logs {
          [31m-[0m[0m enabled = false [90m-> null[0m[0m
        }

      [31m-[0m[0m subnet_mapping {
          [31m-[0m[0m subnet_id = "subnet-019b3e37356b9a8fc" [90m-> null[0m[0m
        }
      [31m-[0m[0m subnet_mapping {
          [31m-[0m[0m subnet_id = "subnet-029ec349c99f32b78" [90m-> null[0m[0m
        }
    }

[1m  # module.network.aws_nat_gateway.dev_nat[0m will be [1m[31mdestroyed[0m
[0m  [31m-[0m[0m resource "aws_nat_gateway" "dev_nat" {
      [31m-[0m[0m allocation_id                      = "eipalloc-06ed2d588543a8977" [90m-> null[0m[0m
      [31m-[0m[0m association_id                     = "eipassoc-0dd61a5b7d00c9971" [90m-> null[0m[0m
      [31m-[0m[0m connectivity_type                  = "public" [90m-> null[0m[0m
      [31m-[0m[0m id                                 = "nat-07d8818303623fb59" [90m-> null[0m[0m
      [31m-[0m[0m network_interface_id               = "eni-04bb3a616425bcb4f" [90m-> null[0m[0m
      [31m-[0m[0m private_ip                         = "10.0.1.134" [90m-> null[0m[0m
      [31m-[0m[0m public_ip                          = "3.13.41.144" [90m-> null[0m[0m
      [31m-[0m[0m secondary_allocation_ids           = [] [90m-> null[0m[0m
      [31m-[0m[0m secondary_private_ip_address_count = 0 [90m-> null[0m[0m
      [31m-[0m[0m secondary_private_ip_addresses     = [] [90m-> null[0m[0m
      [31m-[0m[0m subnet_id                          = "subnet-029ec349c99f32b78" [90m-> null[0m[0m
      [31m-[0m[0m tags                               = {
          [31m-[0m[0m "Enviroment" = "QA"
          [31m-[0m[0m "Name"       = "QA-nat-01"
          [31m-[0m[0m "Owner"      = "shreya"
        } [90m-> null[0m[0m
      [31m-[0m[0m tags_all                           = {
          [31m-[0m[0m "Enviroment" = "QA"
          [31m-[0m[0m "Name"       = "QA-nat-01"
          [31m-[0m[0m "Owner"      = "shreya"
        } [90m-> null[0m[0m
    }

[1m  # module.network.aws_network_acl.dev_backend_nacl[0m will be [1m[31mdestroyed[0m
[0m  [31m-[0m[0m resource "aws_network_acl" "dev_backend_nacl" {
      [31m-[0m[0m arn        = "arn:aws:ec2:us-east-2:133673781875:network-acl/acl-05193e105cbafa972" [90m-> null[0m[0m
      [31m-[0m[0m egress     = [
          [31m-[0m[0m {
              [31m-[0m[0m action          = "allow"
              [31m-[0m[0m cidr_block      = "10.0.1.128/28"
              [31m-[0m[0m from_port       = 1024
              [31m-[0m[0m icmp_code       = 0
              [31m-[0m[0m icmp_type       = 0
              [31m-[0m[0m ipv6_cidr_block = ""
              [31m-[0m[0m protocol        = "6"
              [31m-[0m[0m rule_no         = 140
              [31m-[0m[0m to_port         = 65535
            },
          [31m-[0m[0m {
              [31m-[0m[0m action          = "allow"
              [31m-[0m[0m cidr_block      = "10.0.1.144/28"
              [31m-[0m[0m from_port       = 1024
              [31m-[0m[0m icmp_code       = 0
              [31m-[0m[0m icmp_type       = 0
              [31m-[0m[0m ipv6_cidr_block = ""
              [31m-[0m[0m protocol        = "6"
              [31m-[0m[0m rule_no         = 130
              [31m-[0m[0m to_port         = 65535
            },
          [31m-[0m[0m {
              [31m-[0m[0m action          = "allow"
              [31m-[0m[0m cidr_block      = "10.0.1.192/28"
              [31m-[0m[0m from_port       = 1024
              [31m-[0m[0m icmp_code       = 0
              [31m-[0m[0m icmp_type       = 0
              [31m-[0m[0m ipv6_cidr_block = ""
              [31m-[0m[0m protocol        = "6"
              [31m-[0m[0m rule_no         = 110
              [31m-[0m[0m to_port         = 65535
            },
          [31m-[0m[0m {
              [31m-[0m[0m action          = "allow"
              [31m-[0m[0m cidr_block      = "20.0.0.0/28"
              [31m-[0m[0m from_port       = 1024
              [31m-[0m[0m icmp_code       = 0
              [31m-[0m[0m icmp_type       = 0
              [31m-[0m[0m ipv6_cidr_block = ""
              [31m-[0m[0m protocol        = "6"
              [31m-[0m[0m rule_no         = 120
              [31m-[0m[0m to_port         = 65535
            },
          [31m-[0m[0m {
              [31m-[0m[0m action          = "allow"
              [31m-[0m[0m cidr_block      = "20.0.0.0/28"
              [31m-[0m[0m from_port       = 22
              [31m-[0m[0m icmp_code       = 0
              [31m-[0m[0m icmp_type       = 0
              [31m-[0m[0m ipv6_cidr_block = ""
              [31m-[0m[0m protocol        = "6"
              [31m-[0m[0m rule_no         = 100
              [31m-[0m[0m to_port         = 22
            },
        ] [90m-> null[0m[0m
      [31m-[0m[0m id         = "acl-05193e105cbafa972" [90m-> null[0m[0m
      [31m-[0m[0m ingress    = [
          [31m-[0m[0m {
              [31m-[0m[0m action          = "allow"
              [31m-[0m[0m cidr_block      = "10.0.1.128/28"
              [31m-[0m[0m from_port       = 1024
              [31m-[0m[0m icmp_code       = 0
              [31m-[0m[0m icmp_type       = 0
              [31m-[0m[0m ipv6_cidr_block = ""
              [31m-[0m[0m protocol        = "6"
              [31m-[0m[0m rule_no         = 150
              [31m-[0m[0m to_port         = 65535
            },
          [31m-[0m[0m {
              [31m-[0m[0m action          = "allow"
              [31m-[0m[0m cidr_block      = "10.0.1.128/28"
              [31m-[0m[0m from_port       = 22
              [31m-[0m[0m icmp_code       = 0
              [31m-[0m[0m icmp_type       = 0
              [31m-[0m[0m ipv6_cidr_block = ""
              [31m-[0m[0m protocol        = "6"
              [31m-[0m[0m rule_no         = 140
              [31m-[0m[0m to_port         = 22
            },
          [31m-[0m[0m {
              [31m-[0m[0m action          = "allow"
              [31m-[0m[0m cidr_block      = "10.0.1.128/28"
              [31m-[0m[0m from_port       = 8080
              [31m-[0m[0m icmp_code       = 0
              [31m-[0m[0m icmp_type       = 0
              [31m-[0m[0m ipv6_cidr_block = ""
              [31m-[0m[0m protocol        = "6"
              [31m-[0m[0m rule_no         = 110
              [31m-[0m[0m to_port         = 8080
            },
          [31m-[0m[0m {
              [31m-[0m[0m action          = "allow"
              [31m-[0m[0m cidr_block      = "10.0.1.144/28"
              [31m-[0m[0m from_port       = 1024
              [31m-[0m[0m icmp_code       = 0
              [31m-[0m[0m icmp_type       = 0
              [31m-[0m[0m ipv6_cidr_block = ""
              [31m-[0m[0m protocol        = "6"
              [31m-[0m[0m rule_no         = 130
              [31m-[0m[0m to_port         = 65535
            },
          [31m-[0m[0m {
              [31m-[0m[0m action          = "allow"
              [31m-[0m[0m cidr_block      = "10.0.1.144/28"
              [31m-[0m[0m from_port       = 8080
              [31m-[0m[0m icmp_code       = 0
              [31m-[0m[0m icmp_type       = 0
              [31m-[0m[0m ipv6_cidr_block = ""
              [31m-[0m[0m protocol        = "6"
              [31m-[0m[0m rule_no         = 160
              [31m-[0m[0m to_port         = 8080
            },
          [31m-[0m[0m {
              [31m-[0m[0m action          = "allow"
              [31m-[0m[0m cidr_block      = "10.0.1.192/28"
              [31m-[0m[0m from_port       = 1024
              [31m-[0m[0m icmp_code       = 0
              [31m-[0m[0m icmp_type       = 0
              [31m-[0m[0m ipv6_cidr_block = ""
              [31m-[0m[0m protocol        = "6"
              [31m-[0m[0m rule_no         = 120
              [31m-[0m[0m to_port         = 65535
            },
          [31m-[0m[0m {
              [31m-[0m[0m action          = "allow"
              [31m-[0m[0m cidr_block      = "20.0.0.0/28"
              [31m-[0m[0m from_port       = 22
              [31m-[0m[0m icmp_code       = 0
              [31m-[0m[0m icmp_type       = 0
              [31m-[0m[0m ipv6_cidr_block = ""
              [31m-[0m[0m protocol        = "6"
              [31m-[0m[0m rule_no         = 100
              [31m-[0m[0m to_port         = 22
            },
        ] [90m-> null[0m[0m
      [31m-[0m[0m owner_id   = "133673781875" [90m-> null[0m[0m
      [31m-[0m[0m subnet_ids = [
          [31m-[0m[0m "subnet-0729f2e42a973a23d",
        ] [90m-> null[0m[0m
      [31m-[0m[0m tags       = {
          [31m-[0m[0m "Enviroment" = "QA"
          [31m-[0m[0m "Name"       = "QA-backend-nacl-01"
          [31m-[0m[0m "Owner"      = "shreya"
        } [90m-> null[0m[0m
      [31m-[0m[0m tags_all   = {
          [31m-[0m[0m "Enviroment" = "QA"
          [31m-[0m[0m "Name"       = "QA-backend-nacl-01"
          [31m-[0m[0m "Owner"      = "shreya"
        } [90m-> null[0m[0m
      [31m-[0m[0m vpc_id     = "vpc-0a917fb8214d4ce27" [90m-> null[0m[0m
    }

[1m  # module.network.aws_network_acl.dev_db_nacl[0m will be [1m[31mdestroyed[0m
[0m  [31m-[0m[0m resource "aws_network_acl" "dev_db_nacl" {
      [31m-[0m[0m arn        = "arn:aws:ec2:us-east-2:133673781875:network-acl/acl-0dc3bb1249fefdc2a" [90m-> null[0m[0m
      [31m-[0m[0m egress     = [
          [31m-[0m[0m {
              [31m-[0m[0m action          = "allow"
              [31m-[0m[0m cidr_block      = "10.0.1.128/28"
              [31m-[0m[0m from_port       = 1024
              [31m-[0m[0m icmp_code       = 0
              [31m-[0m[0m icmp_type       = 0
              [31m-[0m[0m ipv6_cidr_block = ""
              [31m-[0m[0m protocol        = "6"
              [31m-[0m[0m rule_no         = 120
              [31m-[0m[0m to_port         = 65535
            },
          [31m-[0m[0m {
              [31m-[0m[0m action          = "allow"
              [31m-[0m[0m cidr_block      = "10.0.1.176/28"
              [31m-[0m[0m from_port       = 1024
              [31m-[0m[0m icmp_code       = 0
              [31m-[0m[0m icmp_type       = 0
              [31m-[0m[0m ipv6_cidr_block = ""
              [31m-[0m[0m protocol        = "6"
              [31m-[0m[0m rule_no         = 110
              [31m-[0m[0m to_port         = 65535
            },
          [31m-[0m[0m {
              [31m-[0m[0m action          = "allow"
              [31m-[0m[0m cidr_block      = "20.0.0.0/28"
              [31m-[0m[0m from_port       = 1024
              [31m-[0m[0m icmp_code       = 0
              [31m-[0m[0m icmp_type       = 0
              [31m-[0m[0m ipv6_cidr_block = ""
              [31m-[0m[0m protocol        = "6"
              [31m-[0m[0m rule_no         = 100
              [31m-[0m[0m to_port         = 65535
            },
        ] [90m-> null[0m[0m
      [31m-[0m[0m id         = "acl-0dc3bb1249fefdc2a" [90m-> null[0m[0m
      [31m-[0m[0m ingress    = [
          [31m-[0m[0m {
              [31m-[0m[0m action          = "allow"
              [31m-[0m[0m cidr_block      = "10.0.1.128/28"
              [31m-[0m[0m from_port       = 22
              [31m-[0m[0m icmp_code       = 0
              [31m-[0m[0m icmp_type       = 0
              [31m-[0m[0m ipv6_cidr_block = ""
              [31m-[0m[0m protocol        = "6"
              [31m-[0m[0m rule_no         = 110
              [31m-[0m[0m to_port         = 22
            },
          [31m-[0m[0m {
              [31m-[0m[0m action          = "allow"
              [31m-[0m[0m cidr_block      = "10.0.1.176/28"
              [31m-[0m[0m from_port       = 5432
              [31m-[0m[0m icmp_code       = 0
              [31m-[0m[0m icmp_type       = 0
              [31m-[0m[0m ipv6_cidr_block = ""
              [31m-[0m[0m protocol        = "6"
              [31m-[0m[0m rule_no         = 140
              [31m-[0m[0m to_port         = 5432
            },
          [31m-[0m[0m {
              [31m-[0m[0m action          = "allow"
              [31m-[0m[0m cidr_block      = "10.0.1.176/28"
              [31m-[0m[0m from_port       = 6379
              [31m-[0m[0m icmp_code       = 0
              [31m-[0m[0m icmp_type       = 0
              [31m-[0m[0m ipv6_cidr_block = ""
              [31m-[0m[0m protocol        = "6"
              [31m-[0m[0m rule_no         = 120
              [31m-[0m[0m to_port         = 6379
            },
          [31m-[0m[0m {
              [31m-[0m[0m action          = "allow"
              [31m-[0m[0m cidr_block      = "10.0.1.176/28"
              [31m-[0m[0m from_port       = 9042
              [31m-[0m[0m icmp_code       = 0
              [31m-[0m[0m icmp_type       = 0
              [31m-[0m[0m ipv6_cidr_block = ""
              [31m-[0m[0m protocol        = "6"
              [31m-[0m[0m rule_no         = 130
              [31m-[0m[0m to_port         = 9042
            },
          [31m-[0m[0m {
              [31m-[0m[0m action          = "allow"
              [31m-[0m[0m cidr_block      = "20.0.0.0/28"
              [31m-[0m[0m from_port       = 22
              [31m-[0m[0m icmp_code       = 0
              [31m-[0m[0m icmp_type       = 0
              [31m-[0m[0m ipv6_cidr_block = ""
              [31m-[0m[0m protocol        = "6"
              [31m-[0m[0m rule_no         = 100
              [31m-[0m[0m to_port         = 22
            },
        ] [90m-> null[0m[0m
      [31m-[0m[0m owner_id   = "133673781875" [90m-> null[0m[0m
      [31m-[0m[0m subnet_ids = [
          [31m-[0m[0m "subnet-0833f5adf745ed36e",
        ] [90m-> null[0m[0m
      [31m-[0m[0m tags       = {
          [31m-[0m[0m "Enviroment" = "QA"
          [31m-[0m[0m "Name"       = "QA-db-nacl-01"
          [31m-[0m[0m "Owner"      = "shreya"
        } [90m-> null[0m[0m
      [31m-[0m[0m tags_all   = {
          [31m-[0m[0m "Enviroment" = "QA"
          [31m-[0m[0m "Name"       = "QA-db-nacl-01"
          [31m-[0m[0m "Owner"      = "shreya"
        } [90m-> null[0m[0m
      [31m-[0m[0m vpc_id     = "vpc-0a917fb8214d4ce27" [90m-> null[0m[0m
    }

[1m  # module.network.aws_network_acl.dev_frontend_nacl[0m will be [1m[31mdestroyed[0m
[0m  [31m-[0m[0m resource "aws_network_acl" "dev_frontend_nacl" {
      [31m-[0m[0m arn        = "arn:aws:ec2:us-east-2:133673781875:network-acl/acl-0e1fdcd7a4e2d28f4" [90m-> null[0m[0m
      [31m-[0m[0m egress     = [
          [31m-[0m[0m {
              [31m-[0m[0m action          = "allow"
              [31m-[0m[0m cidr_block      = "10.0.1.128/28"
              [31m-[0m[0m from_port       = 1024
              [31m-[0m[0m icmp_code       = 0
              [31m-[0m[0m icmp_type       = 0
              [31m-[0m[0m ipv6_cidr_block = ""
              [31m-[0m[0m protocol        = "6"
              [31m-[0m[0m rule_no         = 110
              [31m-[0m[0m to_port         = 65535
            },
          [31m-[0m[0m {
              [31m-[0m[0m action          = "allow"
              [31m-[0m[0m cidr_block      = "10.0.1.144/28"
              [31m-[0m[0m from_port       = 1024
              [31m-[0m[0m icmp_code       = 0
              [31m-[0m[0m icmp_type       = 0
              [31m-[0m[0m ipv6_cidr_block = ""
              [31m-[0m[0m protocol        = "6"
              [31m-[0m[0m rule_no         = 120
              [31m-[0m[0m to_port         = 65535
            },
          [31m-[0m[0m {
              [31m-[0m[0m action          = "allow"
              [31m-[0m[0m cidr_block      = "20.0.0.0/28"
              [31m-[0m[0m from_port       = 1024
              [31m-[0m[0m icmp_code       = 0
              [31m-[0m[0m icmp_type       = 0
              [31m-[0m[0m ipv6_cidr_block = ""
              [31m-[0m[0m protocol        = "6"
              [31m-[0m[0m rule_no         = 100
              [31m-[0m[0m to_port         = 65535
            },
        ] [90m-> null[0m[0m
      [31m-[0m[0m id         = "acl-0e1fdcd7a4e2d28f4" [90m-> null[0m[0m
      [31m-[0m[0m ingress    = [
          [31m-[0m[0m {
              [31m-[0m[0m action          = "allow"
              [31m-[0m[0m cidr_block      = "10.0.1.128/28"
              [31m-[0m[0m from_port       = 22
              [31m-[0m[0m icmp_code       = 0
              [31m-[0m[0m icmp_type       = 0
              [31m-[0m[0m ipv6_cidr_block = ""
              [31m-[0m[0m protocol        = "6"
              [31m-[0m[0m rule_no         = 120
              [31m-[0m[0m to_port         = 22
            },
          [31m-[0m[0m {
              [31m-[0m[0m action          = "allow"
              [31m-[0m[0m cidr_block      = "10.0.1.128/28"
              [31m-[0m[0m from_port       = 3000
              [31m-[0m[0m icmp_code       = 0
              [31m-[0m[0m icmp_type       = 0
              [31m-[0m[0m ipv6_cidr_block = ""
              [31m-[0m[0m protocol        = "6"
              [31m-[0m[0m rule_no         = 110
              [31m-[0m[0m to_port         = 3000
            },
          [31m-[0m[0m {
              [31m-[0m[0m action          = "allow"
              [31m-[0m[0m cidr_block      = "10.0.1.144/28"
              [31m-[0m[0m from_port       = 3000
              [31m-[0m[0m icmp_code       = 0
              [31m-[0m[0m icmp_type       = 0
              [31m-[0m[0m ipv6_cidr_block = ""
              [31m-[0m[0m protocol        = "6"
              [31m-[0m[0m rule_no         = 130
              [31m-[0m[0m to_port         = 3000
            },
          [31m-[0m[0m {
              [31m-[0m[0m action          = "allow"
              [31m-[0m[0m cidr_block      = "20.0.0.0/28"
              [31m-[0m[0m from_port       = 22
              [31m-[0m[0m icmp_code       = 0
              [31m-[0m[0m icmp_type       = 0
              [31m-[0m[0m ipv6_cidr_block = ""
              [31m-[0m[0m protocol        = "6"
              [31m-[0m[0m rule_no         = 100
              [31m-[0m[0m to_port         = 22
            },
        ] [90m-> null[0m[0m
      [31m-[0m[0m owner_id   = "133673781875" [90m-> null[0m[0m
      [31m-[0m[0m subnet_ids = [
          [31m-[0m[0m "subnet-0d2692e3f50413cb0",
        ] [90m-> null[0m[0m
      [31m-[0m[0m tags       = {
          [31m-[0m[0m "Enviroment" = "QA"
          [31m-[0m[0m "Name"       = "QA-frontend-nacl-01"
          [31m-[0m[0m "Owner"      = "shreya"
        } [90m-> null[0m[0m
      [31m-[0m[0m tags_all   = {
          [31m-[0m[0m "Enviroment" = "QA"
          [31m-[0m[0m "Name"       = "QA-frontend-nacl-01"
          [31m-[0m[0m "Owner"      = "shreya"
        } [90m-> null[0m[0m
      [31m-[0m[0m vpc_id     = "vpc-0a917fb8214d4ce27" [90m-> null[0m[0m
    }

[1m  # module.network.aws_network_acl_association.dev_backend_nacl_assc[0m will be [1m[31mdestroyed[0m
[0m  [31m-[0m[0m resource "aws_network_acl_association" "dev_backend_nacl_assc" {
      [31m-[0m[0m id             = "aclassoc-0dfdc2502459a5ce5" [90m-> null[0m[0m
      [31m-[0m[0m network_acl_id = "acl-05193e105cbafa972" [90m-> null[0m[0m
      [31m-[0m[0m subnet_id      = "subnet-0729f2e42a973a23d" [90m-> null[0m[0m
    }

[1m  # module.network.aws_network_acl_association.dev_db_nacl_assc[0m will be [1m[31mdestroyed[0m
[0m  [31m-[0m[0m resource "aws_network_acl_association" "dev_db_nacl_assc" {
      [31m-[0m[0m id             = "aclassoc-02c4ceb5646dc3f58" [90m-> null[0m[0m
      [31m-[0m[0m network_acl_id = "acl-0dc3bb1249fefdc2a" [90m-> null[0m[0m
      [31m-[0m[0m subnet_id      = "subnet-0833f5adf745ed36e" [90m-> null[0m[0m
    }

[1m  # module.network.aws_network_acl_association.dev_frontend_nacl[0m will be [1m[31mdestroyed[0m
[0m  [31m-[0m[0m resource "aws_network_acl_association" "dev_frontend_nacl" {
      [31m-[0m[0m id             = "aclassoc-025a02d3403117f89" [90m-> null[0m[0m
      [31m-[0m[0m network_acl_id = "acl-0e1fdcd7a4e2d28f4" [90m-> null[0m[0m
      [31m-[0m[0m subnet_id      = "subnet-0d2692e3f50413cb0" [90m-> null[0m[0m
    }

[1m  # module.network.aws_route53_record.dev_route53_record[0m will be [1m[31mdestroyed[0m
[0m  [31m-[0m[0m resource "aws_route53_record" "dev_route53_record" {
      [31m-[0m[0m fqdn                             = "example.com" [90m-> null[0m[0m
      [31m-[0m[0m id                               = "Z02676911RHIWQ84M65B8_example.com_A" [90m-> null[0m[0m
      [31m-[0m[0m multivalue_answer_routing_policy = false [90m-> null[0m[0m
      [31m-[0m[0m name                             = "example.com" [90m-> null[0m[0m
      [31m-[0m[0m records                          = [] [90m-> null[0m[0m
      [31m-[0m[0m ttl                              = 0 [90m-> null[0m[0m
      [31m-[0m[0m type                             = "A" [90m-> null[0m[0m
      [31m-[0m[0m zone_id                          = "Z02676911RHIWQ84M65B8" [90m-> null[0m[0m

      [31m-[0m[0m alias {
          [31m-[0m[0m evaluate_target_health = true [90m-> null[0m[0m
          [31m-[0m[0m name                   = "qa-alb-1420650551.us-east-2.elb.amazonaws.com" [90m-> null[0m[0m
          [31m-[0m[0m zone_id                = "Z3AADJGX6KTTL2" [90m-> null[0m[0m
        }
    }

[1m  # module.network.aws_route53_zone.dev_route53_zone[0m will be [1m[31mdestroyed[0m
[0m  [31m-[0m[0m resource "aws_route53_zone" "dev_route53_zone" {
      [31m-[0m[0m arn                 = "arn:aws:route53:::hostedzone/Z02676911RHIWQ84M65B8" [90m-> null[0m[0m
      [31m-[0m[0m comment             = "Managed by Terraform" [90m-> null[0m[0m
      [31m-[0m[0m force_destroy       = false [90m-> null[0m[0m
      [31m-[0m[0m id                  = "Z02676911RHIWQ84M65B8" [90m-> null[0m[0m
      [31m-[0m[0m name                = "example.com" [90m-> null[0m[0m
      [31m-[0m[0m name_servers        = [
          [31m-[0m[0m "ns-0.awsdns-00.com.",
          [31m-[0m[0m "ns-1024.awsdns-00.org.",
          [31m-[0m[0m "ns-1536.awsdns-00.co.uk.",
          [31m-[0m[0m "ns-512.awsdns-00.net.",
        ] [90m-> null[0m[0m
      [31m-[0m[0m primary_name_server = "ns-0.awsdns-00.com." [90m-> null[0m[0m
      [31m-[0m[0m tags                = {
          [31m-[0m[0m "Enviroment" = "QA"
          [31m-[0m[0m "Owner"      = "shreya"
        } [90m-> null[0m[0m
      [31m-[0m[0m tags_all            = {
          [31m-[0m[0m "Enviroment" = "QA"
          [31m-[0m[0m "Owner"      = "shreya"
        } [90m-> null[0m[0m
      [31m-[0m[0m zone_id             = "Z02676911RHIWQ84M65B8" [90m-> null[0m[0m

      [31m-[0m[0m vpc {
          [31m-[0m[0m vpc_id     = "vpc-0a917fb8214d4ce27" [90m-> null[0m[0m
          [31m-[0m[0m vpc_region = "us-east-2" [90m-> null[0m[0m
        }
    }

[1m  # module.network.aws_route_table.dev_private_rtb[0m will be [1m[31mdestroyed[0m
[0m  [31m-[0m[0m resource "aws_route_table" "dev_private_rtb" {
      [31m-[0m[0m arn              = "arn:aws:ec2:us-east-2:133673781875:route-table/rtb-051d119075e393d2a" [90m-> null[0m[0m
      [31m-[0m[0m id               = "rtb-051d119075e393d2a" [90m-> null[0m[0m
      [31m-[0m[0m owner_id         = "133673781875" [90m-> null[0m[0m
      [31m-[0m[0m propagating_vgws = [] [90m-> null[0m[0m
      [31m-[0m[0m route            = [
          [31m-[0m[0m {
              [31m-[0m[0m carrier_gateway_id         = ""
              [31m-[0m[0m cidr_block                 = "0.0.0.0/0"
              [31m-[0m[0m core_network_arn           = ""
              [31m-[0m[0m destination_prefix_list_id = ""
              [31m-[0m[0m egress_only_gateway_id     = ""
              [31m-[0m[0m gateway_id                 = ""
              [31m-[0m[0m ipv6_cidr_block            = ""
              [31m-[0m[0m local_gateway_id           = ""
              [31m-[0m[0m nat_gateway_id             = "nat-07d8818303623fb59"
              [31m-[0m[0m network_interface_id       = ""
              [31m-[0m[0m transit_gateway_id         = ""
              [31m-[0m[0m vpc_endpoint_id            = ""
              [31m-[0m[0m vpc_peering_connection_id  = ""
            },
          [31m-[0m[0m {
              [31m-[0m[0m carrier_gateway_id         = ""
              [31m-[0m[0m cidr_block                 = "10.0.1.128/25"
              [31m-[0m[0m core_network_arn           = ""
              [31m-[0m[0m destination_prefix_list_id = ""
              [31m-[0m[0m egress_only_gateway_id     = ""
              [31m-[0m[0m gateway_id                 = "local"
              [31m-[0m[0m ipv6_cidr_block            = ""
              [31m-[0m[0m local_gateway_id           = ""
              [31m-[0m[0m nat_gateway_id             = ""
              [31m-[0m[0m network_interface_id       = ""
              [31m-[0m[0m transit_gateway_id         = ""
              [31m-[0m[0m vpc_endpoint_id            = ""
              [31m-[0m[0m vpc_peering_connection_id  = ""
            },
        ] [90m-> null[0m[0m
      [31m-[0m[0m tags             = {
          [31m-[0m[0m "Enviroment" = "QA"
          [31m-[0m[0m "Name"       = "QA-private-RTB-01"
          [31m-[0m[0m "Owner"      = "shreya"
        } [90m-> null[0m[0m
      [31m-[0m[0m tags_all         = {
          [31m-[0m[0m "Enviroment" = "QA"
          [31m-[0m[0m "Name"       = "QA-private-RTB-01"
          [31m-[0m[0m "Owner"      = "shreya"
        } [90m-> null[0m[0m
      [31m-[0m[0m vpc_id           = "vpc-0a917fb8214d4ce27" [90m-> null[0m[0m
    }

[1m  # module.network.aws_route_table.dev_public_rtb[0m will be [1m[31mdestroyed[0m
[0m  [31m-[0m[0m resource "aws_route_table" "dev_public_rtb" {
      [31m-[0m[0m arn              = "arn:aws:ec2:us-east-2:133673781875:route-table/rtb-0ebe9542ba1b8b63c" [90m-> null[0m[0m
      [31m-[0m[0m id               = "rtb-0ebe9542ba1b8b63c" [90m-> null[0m[0m
      [31m-[0m[0m owner_id         = "133673781875" [90m-> null[0m[0m
      [31m-[0m[0m propagating_vgws = [] [90m-> null[0m[0m
      [31m-[0m[0m route            = [
          [31m-[0m[0m {
              [31m-[0m[0m carrier_gateway_id         = ""
              [31m-[0m[0m cidr_block                 = "0.0.0.0/0"
              [31m-[0m[0m core_network_arn           = ""
              [31m-[0m[0m destination_prefix_list_id = ""
              [31m-[0m[0m egress_only_gateway_id     = ""
              [31m-[0m[0m gateway_id                 = "igw-029d331ad13cf3181"
              [31m-[0m[0m ipv6_cidr_block            = ""
              [31m-[0m[0m local_gateway_id           = ""
              [31m-[0m[0m nat_gateway_id             = ""
              [31m-[0m[0m network_interface_id       = ""
              [31m-[0m[0m transit_gateway_id         = ""
              [31m-[0m[0m vpc_endpoint_id            = ""
              [31m-[0m[0m vpc_peering_connection_id  = ""
            },
          [31m-[0m[0m {
              [31m-[0m[0m carrier_gateway_id         = ""
              [31m-[0m[0m cidr_block                 = "10.0.1.128/25"
              [31m-[0m[0m core_network_arn           = ""
              [31m-[0m[0m destination_prefix_list_id = ""
              [31m-[0m[0m egress_only_gateway_id     = ""
              [31m-[0m[0m gateway_id                 = "local"
              [31m-[0m[0m ipv6_cidr_block            = ""
              [31m-[0m[0m local_gateway_id           = ""
              [31m-[0m[0m nat_gateway_id             = ""
              [31m-[0m[0m network_interface_id       = ""
              [31m-[0m[0m transit_gateway_id         = ""
              [31m-[0m[0m vpc_endpoint_id            = ""
              [31m-[0m[0m vpc_peering_connection_id  = ""
            },
        ] [90m-> null[0m[0m
      [31m-[0m[0m tags             = {
          [31m-[0m[0m "Enviroment" = "QA"
          [31m-[0m[0m "Name"       = "QA-public-RTB-01"
          [31m-[0m[0m "Owner"      = "shreya"
        } [90m-> null[0m[0m
      [31m-[0m[0m tags_all         = {
          [31m-[0m[0m "Enviroment" = "QA"
          [31m-[0m[0m "Name"       = "QA-public-RTB-01"
          [31m-[0m[0m "Owner"      = "shreya"
        } [90m-> null[0m[0m
      [31m-[0m[0m vpc_id           = "vpc-0a917fb8214d4ce27" [90m-> null[0m[0m
    }

[1m  # module.network.aws_route_table_association.dev_private_route_association01[0][0m will be [1m[31mdestroyed[0m
[0m  [31m-[0m[0m resource "aws_route_table_association" "dev_private_route_association01" {
      [31m-[0m[0m id             = "rtbassoc-0aed0aad698470afb" [90m-> null[0m[0m
      [31m-[0m[0m route_table_id = "rtb-051d119075e393d2a" [90m-> null[0m[0m
      [31m-[0m[0m subnet_id      = "subnet-0d2692e3f50413cb0" [90m-> null[0m[0m
    }

[1m  # module.network.aws_route_table_association.dev_private_route_association01[1][0m will be [1m[31mdestroyed[0m
[0m  [31m-[0m[0m resource "aws_route_table_association" "dev_private_route_association01" {
      [31m-[0m[0m id             = "rtbassoc-0dc813f2dde9d7efb" [90m-> null[0m[0m
      [31m-[0m[0m route_table_id = "rtb-051d119075e393d2a" [90m-> null[0m[0m
      [31m-[0m[0m subnet_id      = "subnet-0729f2e42a973a23d" [90m-> null[0m[0m
    }

[1m  # module.network.aws_route_table_association.dev_private_route_association01[2][0m will be [1m[31mdestroyed[0m
[0m  [31m-[0m[0m resource "aws_route_table_association" "dev_private_route_association01" {
      [31m-[0m[0m id             = "rtbassoc-06a303cad50a27114" [90m-> null[0m[0m
      [31m-[0m[0m route_table_id = "rtb-051d119075e393d2a" [90m-> null[0m[0m
      [31m-[0m[0m subnet_id      = "subnet-0833f5adf745ed36e" [90m-> null[0m[0m
    }

[1m  # module.network.aws_route_table_association.dev_public_route_association01[0][0m will be [1m[31mdestroyed[0m
[0m  [31m-[0m[0m resource "aws_route_table_association" "dev_public_route_association01" {
      [31m-[0m[0m id             = "rtbassoc-023c9ddeb3106b4a3" [90m-> null[0m[0m
      [31m-[0m[0m route_table_id = "rtb-0ebe9542ba1b8b63c" [90m-> null[0m[0m
      [31m-[0m[0m subnet_id      = "subnet-029ec349c99f32b78" [90m-> null[0m[0m
    }

[1m  # module.network.aws_route_table_association.dev_public_route_association01[1][0m will be [1m[31mdestroyed[0m
[0m  [31m-[0m[0m resource "aws_route_table_association" "dev_public_route_association01" {
      [31m-[0m[0m id             = "rtbassoc-07e0a3f81eb238476" [90m-> null[0m[0m
      [31m-[0m[0m route_table_id = "rtb-0ebe9542ba1b8b63c" [90m-> null[0m[0m
      [31m-[0m[0m subnet_id      = "subnet-019b3e37356b9a8fc" [90m-> null[0m[0m
    }

[1m  # module.network.aws_security_group.dev_alb_sg[0m will be [1m[31mdestroyed[0m
[0m  [31m-[0m[0m resource "aws_security_group" "dev_alb_sg" {
      [31m-[0m[0m arn                    = "arn:aws:ec2:us-east-2:133673781875:security-group/sg-0cb0d9b0b204a76b0" [90m-> null[0m[0m
      [31m-[0m[0m description            = "Security group for QA-ALB" [90m-> null[0m[0m
      [31m-[0m[0m egress                 = [
          [31m-[0m[0m {
              [31m-[0m[0m cidr_blocks      = [
                  [31m-[0m[0m "0.0.0.0/0",
                ]
              [31m-[0m[0m description      = ""
              [31m-[0m[0m from_port        = 0
              [31m-[0m[0m ipv6_cidr_blocks = []
              [31m-[0m[0m prefix_list_ids  = []
              [31m-[0m[0m protocol         = "-1"
              [31m-[0m[0m security_groups  = []
              [31m-[0m[0m self             = false
              [31m-[0m[0m to_port          = 0
            },
        ] [90m-> null[0m[0m
      [31m-[0m[0m id                     = "sg-0cb0d9b0b204a76b0" [90m-> null[0m[0m
      [31m-[0m[0m ingress                = [
          [31m-[0m[0m {
              [31m-[0m[0m cidr_blocks      = [
                  [31m-[0m[0m "0.0.0.0/0",
                ]
              [31m-[0m[0m description      = ""
              [31m-[0m[0m from_port        = 443
              [31m-[0m[0m ipv6_cidr_blocks = []
              [31m-[0m[0m prefix_list_ids  = []
              [31m-[0m[0m protocol         = "tcp"
              [31m-[0m[0m security_groups  = []
              [31m-[0m[0m self             = false
              [31m-[0m[0m to_port          = 443
            },
          [31m-[0m[0m {
              [31m-[0m[0m cidr_blocks      = [
                  [31m-[0m[0m "0.0.0.0/0",
                ]
              [31m-[0m[0m description      = ""
              [31m-[0m[0m from_port        = 80
              [31m-[0m[0m ipv6_cidr_blocks = []
              [31m-[0m[0m prefix_list_ids  = []
              [31m-[0m[0m protocol         = "tcp"
              [31m-[0m[0m security_groups  = []
              [31m-[0m[0m self             = false
              [31m-[0m[0m to_port          = 80
            },
        ] [90m-> null[0m[0m
      [31m-[0m[0m name                   = "QA-alb-sg" [90m-> null[0m[0m
      [31m-[0m[0m owner_id               = "133673781875" [90m-> null[0m[0m
      [31m-[0m[0m revoke_rules_on_delete = false [90m-> null[0m[0m
      [31m-[0m[0m tags                   = {
          [31m-[0m[0m "Enviroment" = "QA"
          [31m-[0m[0m "Owner"      = "shreya"
        } [90m-> null[0m[0m
      [31m-[0m[0m tags_all               = {
          [31m-[0m[0m "Enviroment" = "QA"
          [31m-[0m[0m "Owner"      = "shreya"
        } [90m-> null[0m[0m
      [31m-[0m[0m vpc_id                 = "vpc-0a917fb8214d4ce27" [90m-> null[0m[0m
    }

[1m  # module.network.aws_subnet.dev_private_subnets[0][0m will be [1m[31mdestroyed[0m
[0m  [31m-[0m[0m resource "aws_subnet" "dev_private_subnets" {
      [31m-[0m[0m arn                                            = "arn:aws:ec2:us-east-2:133673781875:subnet/subnet-0d2692e3f50413cb0" [90m-> null[0m[0m
      [31m-[0m[0m assign_ipv6_address_on_creation                = false [90m-> null[0m[0m
      [31m-[0m[0m availability_zone                              = "us-east-2a" [90m-> null[0m[0m
      [31m-[0m[0m availability_zone_id                           = "use2-az1" [90m-> null[0m[0m
      [31m-[0m[0m cidr_block                                     = "10.0.1.160/28" [90m-> null[0m[0m
      [31m-[0m[0m enable_dns64                                   = false [90m-> null[0m[0m
      [31m-[0m[0m enable_lni_at_device_index                     = 0 [90m-> null[0m[0m
      [31m-[0m[0m enable_resource_name_dns_a_record_on_launch    = false [90m-> null[0m[0m
      [31m-[0m[0m enable_resource_name_dns_aaaa_record_on_launch = false [90m-> null[0m[0m
      [31m-[0m[0m id                                             = "subnet-0d2692e3f50413cb0" [90m-> null[0m[0m
      [31m-[0m[0m ipv6_native                                    = false [90m-> null[0m[0m
      [31m-[0m[0m map_customer_owned_ip_on_launch                = false [90m-> null[0m[0m
      [31m-[0m[0m map_public_ip_on_launch                        = false [90m-> null[0m[0m
      [31m-[0m[0m owner_id                                       = "133673781875" [90m-> null[0m[0m
      [31m-[0m[0m private_dns_hostname_type_on_launch            = "ip-name" [90m-> null[0m[0m
      [31m-[0m[0m tags                                           = {
          [31m-[0m[0m "Enviroment" = "QA"
          [31m-[0m[0m "Name"       = "frontend-subnet"
          [31m-[0m[0m "Owner"      = "shreya"
        } [90m-> null[0m[0m
      [31m-[0m[0m tags_all                                       = {
          [31m-[0m[0m "Enviroment" = "QA"
          [31m-[0m[0m "Name"       = "frontend-subnet"
          [31m-[0m[0m "Owner"      = "shreya"
        } [90m-> null[0m[0m
      [31m-[0m[0m vpc_id                                         = "vpc-0a917fb8214d4ce27" [90m-> null[0m[0m
    }

[1m  # module.network.aws_subnet.dev_private_subnets[1][0m will be [1m[31mdestroyed[0m
[0m  [31m-[0m[0m resource "aws_subnet" "dev_private_subnets" {
      [31m-[0m[0m arn                                            = "arn:aws:ec2:us-east-2:133673781875:subnet/subnet-0729f2e42a973a23d" [90m-> null[0m[0m
      [31m-[0m[0m assign_ipv6_address_on_creation                = false [90m-> null[0m[0m
      [31m-[0m[0m availability_zone                              = "us-east-2a" [90m-> null[0m[0m
      [31m-[0m[0m availability_zone_id                           = "use2-az1" [90m-> null[0m[0m
      [31m-[0m[0m cidr_block                                     = "10.0.1.176/28" [90m-> null[0m[0m
      [31m-[0m[0m enable_dns64                                   = false [90m-> null[0m[0m
      [31m-[0m[0m enable_lni_at_device_index                     = 0 [90m-> null[0m[0m
      [31m-[0m[0m enable_resource_name_dns_a_record_on_launch    = false [90m-> null[0m[0m
      [31m-[0m[0m enable_resource_name_dns_aaaa_record_on_launch = false [90m-> null[0m[0m
      [31m-[0m[0m id                                             = "subnet-0729f2e42a973a23d" [90m-> null[0m[0m
      [31m-[0m[0m ipv6_native                                    = false [90m-> null[0m[0m
      [31m-[0m[0m map_customer_owned_ip_on_launch                = false [90m-> null[0m[0m
      [31m-[0m[0m map_public_ip_on_launch                        = false [90m-> null[0m[0m
      [31m-[0m[0m owner_id                                       = "133673781875" [90m-> null[0m[0m
      [31m-[0m[0m private_dns_hostname_type_on_launch            = "ip-name" [90m-> null[0m[0m
      [31m-[0m[0m tags                                           = {
          [31m-[0m[0m "Enviroment" = "QA"
          [31m-[0m[0m "Name"       = "backend-subnet"
          [31m-[0m[0m "Owner"      = "shreya"
        } [90m-> null[0m[0m
      [31m-[0m[0m tags_all                                       = {
          [31m-[0m[0m "Enviroment" = "QA"
          [31m-[0m[0m "Name"       = "backend-subnet"
          [31m-[0m[0m "Owner"      = "shreya"
        } [90m-> null[0m[0m
      [31m-[0m[0m vpc_id                                         = "vpc-0a917fb8214d4ce27" [90m-> null[0m[0m
    }

[1m  # module.network.aws_subnet.dev_private_subnets[2][0m will be [1m[31mdestroyed[0m
[0m  [31m-[0m[0m resource "aws_subnet" "dev_private_subnets" {
      [31m-[0m[0m arn                                            = "arn:aws:ec2:us-east-2:133673781875:subnet/subnet-0833f5adf745ed36e" [90m-> null[0m[0m
      [31m-[0m[0m assign_ipv6_address_on_creation                = false [90m-> null[0m[0m
      [31m-[0m[0m availability_zone                              = "us-east-2a" [90m-> null[0m[0m
      [31m-[0m[0m availability_zone_id                           = "use2-az1" [90m-> null[0m[0m
      [31m-[0m[0m cidr_block                                     = "10.0.1.192/28" [90m-> null[0m[0m
      [31m-[0m[0m enable_dns64                                   = false [90m-> null[0m[0m
      [31m-[0m[0m enable_lni_at_device_index                     = 0 [90m-> null[0m[0m
      [31m-[0m[0m enable_resource_name_dns_a_record_on_launch    = false [90m-> null[0m[0m
      [31m-[0m[0m enable_resource_name_dns_aaaa_record_on_launch = false [90m-> null[0m[0m
      [31m-[0m[0m id                                             = "subnet-0833f5adf745ed36e" [90m-> null[0m[0m
      [31m-[0m[0m ipv6_native                                    = false [90m-> null[0m[0m
      [31m-[0m[0m map_customer_owned_ip_on_launch                = false [90m-> null[0m[0m
      [31m-[0m[0m map_public_ip_on_launch                        = false [90m-> null[0m[0m
      [31m-[0m[0m owner_id                                       = "133673781875" [90m-> null[0m[0m
      [31m-[0m[0m private_dns_hostname_type_on_launch            = "ip-name" [90m-> null[0m[0m
      [31m-[0m[0m tags                                           = {
          [31m-[0m[0m "Enviroment" = "QA"
          [31m-[0m[0m "Name"       = "database-subnet"
          [31m-[0m[0m "Owner"      = "shreya"
        } [90m-> null[0m[0m
      [31m-[0m[0m tags_all                                       = {
          [31m-[0m[0m "Enviroment" = "QA"
          [31m-[0m[0m "Name"       = "database-subnet"
          [31m-[0m[0m "Owner"      = "shreya"
        } [90m-> null[0m[0m
      [31m-[0m[0m vpc_id                                         = "vpc-0a917fb8214d4ce27" [90m-> null[0m[0m
    }

[1m  # module.network.aws_subnet.dev_public_subnets[0][0m will be [1m[31mdestroyed[0m
[0m  [31m-[0m[0m resource "aws_subnet" "dev_public_subnets" {
      [31m-[0m[0m arn                                            = "arn:aws:ec2:us-east-2:133673781875:subnet/subnet-029ec349c99f32b78" [90m-> null[0m[0m
      [31m-[0m[0m assign_ipv6_address_on_creation                = false [90m-> null[0m[0m
      [31m-[0m[0m availability_zone                              = "us-east-2a" [90m-> null[0m[0m
      [31m-[0m[0m availability_zone_id                           = "use2-az1" [90m-> null[0m[0m
      [31m-[0m[0m cidr_block                                     = "10.0.1.128/28" [90m-> null[0m[0m
      [31m-[0m[0m enable_dns64                                   = false [90m-> null[0m[0m
      [31m-[0m[0m enable_lni_at_device_index                     = 0 [90m-> null[0m[0m
      [31m-[0m[0m enable_resource_name_dns_a_record_on_launch    = false [90m-> null[0m[0m
      [31m-[0m[0m enable_resource_name_dns_aaaa_record_on_launch = false [90m-> null[0m[0m
      [31m-[0m[0m id                                             = "subnet-029ec349c99f32b78" [90m-> null[0m[0m
      [31m-[0m[0m ipv6_native                                    = false [90m-> null[0m[0m
      [31m-[0m[0m map_customer_owned_ip_on_launch                = false [90m-> null[0m[0m
      [31m-[0m[0m map_public_ip_on_launch                        = true [90m-> null[0m[0m
      [31m-[0m[0m owner_id                                       = "133673781875" [90m-> null[0m[0m
      [31m-[0m[0m private_dns_hostname_type_on_launch            = "ip-name" [90m-> null[0m[0m
      [31m-[0m[0m tags                                           = {
          [31m-[0m[0m "Enviroment" = "QA"
          [31m-[0m[0m "Name"       = "public-subnet-01"
          [31m-[0m[0m "Owner"      = "shreya"
        } [90m-> null[0m[0m
      [31m-[0m[0m tags_all                                       = {
          [31m-[0m[0m "Enviroment" = "QA"
          [31m-[0m[0m "Name"       = "public-subnet-01"
          [31m-[0m[0m "Owner"      = "shreya"
        } [90m-> null[0m[0m
      [31m-[0m[0m vpc_id                                         = "vpc-0a917fb8214d4ce27" [90m-> null[0m[0m
    }

[1m  # module.network.aws_subnet.dev_public_subnets[1][0m will be [1m[31mdestroyed[0m
[0m  [31m-[0m[0m resource "aws_subnet" "dev_public_subnets" {
      [31m-[0m[0m arn                                            = "arn:aws:ec2:us-east-2:133673781875:subnet/subnet-019b3e37356b9a8fc" [90m-> null[0m[0m
      [31m-[0m[0m assign_ipv6_address_on_creation                = false [90m-> null[0m[0m
      [31m-[0m[0m availability_zone                              = "us-east-2b" [90m-> null[0m[0m
      [31m-[0m[0m availability_zone_id                           = "use2-az2" [90m-> null[0m[0m
      [31m-[0m[0m cidr_block                                     = "10.0.1.144/28" [90m-> null[0m[0m
      [31m-[0m[0m enable_dns64                                   = false [90m-> null[0m[0m
      [31m-[0m[0m enable_lni_at_device_index                     = 0 [90m-> null[0m[0m
      [31m-[0m[0m enable_resource_name_dns_a_record_on_launch    = false [90m-> null[0m[0m
      [31m-[0m[0m enable_resource_name_dns_aaaa_record_on_launch = false [90m-> null[0m[0m
      [31m-[0m[0m id                                             = "subnet-019b3e37356b9a8fc" [90m-> null[0m[0m
      [31m-[0m[0m ipv6_native                                    = false [90m-> null[0m[0m
      [31m-[0m[0m map_customer_owned_ip_on_launch                = false [90m-> null[0m[0m
      [31m-[0m[0m map_public_ip_on_launch                        = true [90m-> null[0m[0m
      [31m-[0m[0m owner_id                                       = "133673781875" [90m-> null[0m[0m
      [31m-[0m[0m private_dns_hostname_type_on_launch            = "ip-name" [90m-> null[0m[0m
      [31m-[0m[0m tags                                           = {
          [31m-[0m[0m "Enviroment" = "QA"
          [31m-[0m[0m "Name"       = "public-subnet-02"
          [31m-[0m[0m "Owner"      = "shreya"
        } [90m-> null[0m[0m
      [31m-[0m[0m tags_all                                       = {
          [31m-[0m[0m "Enviroment" = "QA"
          [31m-[0m[0m "Name"       = "public-subnet-02"
          [31m-[0m[0m "Owner"      = "shreya"
        } [90m-> null[0m[0m
      [31m-[0m[0m vpc_id                                         = "vpc-0a917fb8214d4ce27" [90m-> null[0m[0m
    }

[1m  # module.network.aws_vpc.dev_vpc[0m will be [1m[31mdestroyed[0m
[0m  [31m-[0m[0m resource "aws_vpc" "dev_vpc" {
      [31m-[0m[0m arn                                  = "arn:aws:ec2:us-east-2:133673781875:vpc/vpc-0a917fb8214d4ce27" [90m-> null[0m[0m
      [31m-[0m[0m assign_generated_ipv6_cidr_block     = false [90m-> null[0m[0m
      [31m-[0m[0m cidr_block                           = "10.0.1.128/25" [90m-> null[0m[0m
      [31m-[0m[0m default_network_acl_id               = "acl-090fd8fa8909aad49" [90m-> null[0m[0m
      [31m-[0m[0m default_route_table_id               = "rtb-0d1f142608dbe0c0f" [90m-> null[0m[0m
      [31m-[0m[0m default_security_group_id            = "sg-0feb83718eb3e4395" [90m-> null[0m[0m
      [31m-[0m[0m dhcp_options_id                      = "dopt-05eca57ecc30ce323" [90m-> null[0m[0m
      [31m-[0m[0m enable_dns_hostnames                 = false [90m-> null[0m[0m
      [31m-[0m[0m enable_dns_support                   = true [90m-> null[0m[0m
      [31m-[0m[0m enable_network_address_usage_metrics = false [90m-> null[0m[0m
      [31m-[0m[0m id                                   = "vpc-0a917fb8214d4ce27" [90m-> null[0m[0m
      [31m-[0m[0m instance_tenancy                     = "default" [90m-> null[0m[0m
      [31m-[0m[0m ipv6_netmask_length                  = 0 [90m-> null[0m[0m
      [31m-[0m[0m main_route_table_id                  = "rtb-0d1f142608dbe0c0f" [90m-> null[0m[0m
      [31m-[0m[0m owner_id                             = "133673781875" [90m-> null[0m[0m
      [31m-[0m[0m tags                                 = {
          [31m-[0m[0m "Enviroment" = "QA"
          [31m-[0m[0m "Name"       = "QA-vpc"
          [31m-[0m[0m "Owner"      = "shreya"
        } [90m-> null[0m[0m
      [31m-[0m[0m tags_all                             = {
          [31m-[0m[0m "Enviroment" = "QA"
          [31m-[0m[0m "Name"       = "QA-vpc"
          [31m-[0m[0m "Owner"      = "shreya"
        } [90m-> null[0m[0m
    }

[1mPlan:[0m 0 to add, 0 to change, 26 to destroy.
[0m
Changes to Outputs:
  [31m-[0m[0m alb-sg-id            = "sg-0cb0d9b0b204a76b0" [90m-> null[0m[0m
  [31m-[0m[0m dev-alb-dns          = "QA-alb-1420650551.us-east-2.elb.amazonaws.com" [90m-> null[0m[0m
  [31m-[0m[0m dev-backend-nacl-id  = "acl-05193e105cbafa972" [90m-> null[0m[0m
  [31m-[0m[0m dev-db-nacl-id       = "acl-0dc3bb1249fefdc2a" [90m-> null[0m[0m
  [31m-[0m[0m dev-frontend-nacl-id = "acl-0e1fdcd7a4e2d28f4" [90m-> null[0m[0m
  [31m-[0m[0m dev-igw-id           = "igw-029d331ad13cf3181" [90m-> null[0m[0m
  [31m-[0m[0m dev-nat-id           = "nat-07d8818303623fb59" [90m-> null[0m[0m
  [31m-[0m[0m dev-private-RTB-id   = "rtb-051d119075e393d2a" [90m-> null[0m[0m
  [31m-[0m[0m dev-public-RTB-id    = "rtb-0ebe9542ba1b8b63c" [90m-> null[0m[0m
  [31m-[0m[0m dev-route53-record   = "example.com" [90m-> null[0m[0m
  [31m-[0m[0m dev-route53-zone     = [
      [31m-[0m[0m "ns-0.awsdns-00.com.",
      [31m-[0m[0m "ns-1024.awsdns-00.org.",
      [31m-[0m[0m "ns-1536.awsdns-00.co.uk.",
      [31m-[0m[0m "ns-512.awsdns-00.net.",
    ] [90m-> null[0m[0m
  [31m-[0m[0m private-subnets-id   = [
      [31m-[0m[0m "subnet-0d2692e3f50413cb0",
      [31m-[0m[0m "subnet-0729f2e42a973a23d",
      [31m-[0m[0m "subnet-0833f5adf745ed36e",
    ] [90m-> null[0m[0m
  [31m-[0m[0m public-subnets-id    = [
      [31m-[0m[0m "subnet-029ec349c99f32b78",
      [31m-[0m[0m "subnet-019b3e37356b9a8fc",
    ] [90m-> null[0m[0m
  [31m-[0m[0m vpc-id               = "vpc-0a917fb8214d4ce27" [90m-> null[0m[0m
[0m[1mmodule.network.aws_network_acl_association.dev_backend_nacl_assc: Destroying... [id=aclassoc-0dfdc2502459a5ce5][0m[0m
[0m[1mmodule.network.aws_route_table_association.dev_private_route_association01[0]: Destroying... [id=rtbassoc-0aed0aad698470afb][0m[0m
[0m[1mmodule.network.aws_network_acl_association.dev_db_nacl_assc: Destroying... [id=aclassoc-02c4ceb5646dc3f58][0m[0m
[0m[1mmodule.network.aws_network_acl_association.dev_frontend_nacl: Destroying... [id=aclassoc-025a02d3403117f89][0m[0m
[0m[1mmodule.network.aws_route_table_association.dev_public_route_association01[0]: Destroying... [id=rtbassoc-023c9ddeb3106b4a3][0m[0m
[0m[1mmodule.network.aws_route_table_association.dev_private_route_association01[1]: Destroying... [id=rtbassoc-0dc813f2dde9d7efb][0m[0m
[0m[1mmodule.network.aws_route_table_association.dev_public_route_association01[1]: Destroying... [id=rtbassoc-07e0a3f81eb238476][0m[0m
[0m[1mmodule.network.aws_route_table_association.dev_private_route_association01[2]: Destroying... [id=rtbassoc-06a303cad50a27114][0m[0m
[0m[1mmodule.network.aws_route53_record.dev_route53_record: Destroying... [id=Z02676911RHIWQ84M65B8_example.com_A][0m[0m
[0m[1mmodule.network.aws_route_table_association.dev_public_route_association01[0]: Destruction complete after 0s[0m
[0m[1mmodule.network.aws_network_acl_association.dev_backend_nacl_assc: Destruction complete after 0s[0m
[0m[1mmodule.network.aws_network_acl_association.dev_frontend_nacl: Destruction complete after 0s[0m
[0m[1mmodule.network.aws_network_acl.dev_backend_nacl: Destroying... [id=acl-05193e105cbafa972][0m[0m
[0m[1mmodule.network.aws_route_table_association.dev_private_route_association01[0]: Destruction complete after 0s[0m
[0m[1mmodule.network.aws_network_acl_association.dev_db_nacl_assc: Destruction complete after 0s[0m
[0m[1mmodule.network.aws_network_acl.dev_frontend_nacl: Destroying... [id=acl-0e1fdcd7a4e2d28f4][0m[0m
[0m[1mmodule.network.aws_network_acl.dev_db_nacl: Destroying... [id=acl-0dc3bb1249fefdc2a][0m[0m
[0m[1mmodule.network.aws_route_table_association.dev_public_route_association01[1]: Destruction complete after 0s[0m
[0m[1mmodule.network.aws_route_table.dev_public_rtb: Destroying... [id=rtb-0ebe9542ba1b8b63c][0m[0m
[0m[1mmodule.network.aws_route_table_association.dev_private_route_association01[2]: Destruction complete after 0s[0m
[0m[1mmodule.network.aws_route_table_association.dev_private_route_association01[1]: Destruction complete after 0s[0m
[0m[1mmodule.network.aws_subnet.dev_private_subnets[0]: Destroying... [id=subnet-0d2692e3f50413cb0][0m[0m
[0m[1mmodule.network.aws_subnet.dev_private_subnets[2]: Destroying... [id=subnet-0833f5adf745ed36e][0m[0m
[0m[1mmodule.network.aws_subnet.dev_private_subnets[1]: Destroying... [id=subnet-0729f2e42a973a23d][0m[0m
[0m[1mmodule.network.aws_route_table.dev_private_rtb: Destroying... [id=rtb-051d119075e393d2a][0m[0m
[0m[1mmodule.network.aws_network_acl.dev_backend_nacl: Destruction complete after 0s[0m
[0m[1mmodule.network.aws_network_acl.dev_db_nacl: Destruction complete after 0s[0m
[0m[1mmodule.network.aws_network_acl.dev_frontend_nacl: Destruction complete after 0s[0m
[0m[1mmodule.network.aws_subnet.dev_private_subnets[2]: Destruction complete after 1s[0m
[0m[1mmodule.network.aws_subnet.dev_private_subnets[0]: Destruction complete after 1s[0m
[0m[1mmodule.network.aws_route_table.dev_public_rtb: Destruction complete after 1s[0m
[0m[1mmodule.network.aws_subnet.dev_private_subnets[1]: Destruction complete after 1s[0m
[0m[1mmodule.network.aws_internet_gateway.dev_igw: Destroying... [id=igw-029d331ad13cf3181][0m[0m
[0m[1mmodule.network.aws_route_table.dev_private_rtb: Destruction complete after 1s[0m
[0m[1mmodule.network.aws_nat_gateway.dev_nat: Destroying... [id=nat-07d8818303623fb59][0m[0m
[0m[1mmodule.network.aws_route53_record.dev_route53_record: Still destroying... [id=Z02676911RHIWQ84M65B8_example.com_A, 10s elapsed][0m[0m
[0m[1mmodule.network.aws_route53_record.dev_route53_record: Destruction complete after 10s[0m
[0m[1mmodule.network.aws_route53_zone.dev_route53_zone: Destroying... [id=Z02676911RHIWQ84M65B8][0m[0m
[0m[1mmodule.network.aws_lb.dev_alb: Destroying... [id=arn:aws:elasticloadbalancing:us-east-2:133673781875:loadbalancer/app/QA-alb/ad64e23f0761861a][0m[0m
[0m[1mmodule.network.aws_route53_zone.dev_route53_zone: Destruction complete after 0s[0m
[0m[1mmodule.network.aws_internet_gateway.dev_igw: Still destroying... [id=igw-029d331ad13cf3181, 10s elapsed][0m[0m
[0m[1mmodule.network.aws_nat_gateway.dev_nat: Still destroying... [id=nat-07d8818303623fb59, 10s elapsed][0m[0m
[0m[1mmodule.network.aws_lb.dev_alb: Destruction complete after 1s[0m
[0m[1mmodule.network.aws_security_group.dev_alb_sg: Destroying... [id=sg-0cb0d9b0b204a76b0][0m[0m
[0m[1mmodule.network.aws_internet_gateway.dev_igw: Still destroying... [id=igw-029d331ad13cf3181, 20s elapsed][0m[0m
[0m[1mmodule.network.aws_nat_gateway.dev_nat: Still destroying... [id=nat-07d8818303623fb59, 20s elapsed][0m[0m
[0m[1mmodule.network.aws_security_group.dev_alb_sg: Still destroying... [id=sg-0cb0d9b0b204a76b0, 10s elapsed][0m[0m
[0m[1mmodule.network.aws_security_group.dev_alb_sg: Destruction complete after 17s[0m
[0m[1mmodule.network.aws_internet_gateway.dev_igw: Still destroying... [id=igw-029d331ad13cf3181, 30s elapsed][0m[0m
[0m[1mmodule.network.aws_nat_gateway.dev_nat: Still destroying... [id=nat-07d8818303623fb59, 30s elapsed][0m[0m
[0m[1mmodule.network.aws_internet_gateway.dev_igw: Still destroying... [id=igw-029d331ad13cf3181, 40s elapsed][0m[0m
[0m[1mmodule.network.aws_nat_gateway.dev_nat: Still destroying... [id=nat-07d8818303623fb59, 40s elapsed][0m[0m
[0m[1mmodule.network.aws_internet_gateway.dev_igw: Still destroying... [id=igw-029d331ad13cf3181, 50s elapsed][0m[0m
[0m[1mmodule.network.aws_nat_gateway.dev_nat: Still destroying... [id=nat-07d8818303623fb59, 50s elapsed][0m[0m
[0m[1mmodule.network.aws_internet_gateway.dev_igw: Still destroying... [id=igw-029d331ad13cf3181, 1m0s elapsed][0m[0m
[0m[1mmodule.network.aws_nat_gateway.dev_nat: Still destroying... [id=nat-07d8818303623fb59, 1m0s elapsed][0m[0m
[0m[1mmodule.network.aws_nat_gateway.dev_nat: Destruction complete after 1m1s[0m
[0m[1mmodule.network.aws_subnet.dev_public_subnets[1]: Destroying... [id=subnet-019b3e37356b9a8fc][0m[0m
[0m[1mmodule.network.aws_subnet.dev_public_subnets[0]: Destroying... [id=subnet-029ec349c99f32b78][0m[0m
[0m[1mmodule.network.aws_eip.dev_elastic_ip: Destroying... [id=eipalloc-06ed2d588543a8977][0m[0m
[0m[1mmodule.network.aws_subnet.dev_public_subnets[1]: Destruction complete after 0s[0m
[0m[1mmodule.network.aws_subnet.dev_public_subnets[0]: Destruction complete after 0s[0m
[0m[1mmodule.network.aws_eip.dev_elastic_ip: Destruction complete after 1s[0m
[0m[1mmodule.network.aws_internet_gateway.dev_igw: Destruction complete after 1m7s[0m
[0m[1mmodule.network.aws_vpc.dev_vpc: Destroying... [id=vpc-0a917fb8214d4ce27][0m[0m
[0m[1mmodule.network.aws_vpc.dev_vpc: Destruction complete after 0s[0m
[0m[1m[32m
Destroy complete! Resources: 26 destroyed.
[0m
[Pipeline] }
[Pipeline] // script
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Declarative: Post Actions)
[Pipeline] script
[Pipeline] {
[Pipeline] echo
Terraform operation successful!
[Pipeline] archiveArtifacts
Archiving artifacts
‘*.pem’ doesn’t match anything
No artifacts found that match the file pattern "*.pem". Configuration error?
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

## [Terraform Module](https://github.com/CodeOps-Hub/Terraform-modules/tree/main/wrapperCode/Network-Skeleton-Wrapper-Code/QA-Network-Skeleton-Wrapper-Code)

## [Jenkinsfile](https://github.com/CodeOps-Hub/Jenkinsfile/blob/khushi/networkSkeleton_QA/Wrapper-Code/QA_Env/networkskeleton_QA/Jenkinsfile)

<details>
  <summary>Click here to see Jenkins file</summary>

  ```shell
pipeline {
    agent any
    
    environment {
        AWS_ACCESS_KEY_ID     = credentials('vishal_cred')
        AWS_SECRET_ACCESS_KEY = credentials('vishal_cred')
        TF_CLI_ARGS           = '-input=false'
    }
    
    parameters {
        choice(name: 'ACTION', choices: ['Apply', 'Destroy'], description: 'Choose to apply or destroy the infrastructure')
        string (defaultValue: 'wrapperCode/Network-Skeleton-Wrapper-Code/QA-Network-Skeleton-Wrapper-Code', description: 'define path of wrapper code directory', name: 'WrapperPath')
    }
    
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', credentialsId: 'Khushi_PAT', url: 'https://github.com/CodeOps-Hub/Terraform-modules.git'
            }
        }
        
        stage('Copy Terraform Files') {
            steps {
                // Copy or move specific files from the repository to Jenkins workspace
                sh "cp ${params.WrapperPath}/* ."
            }
        }
        
        stage('Terraform Init') {
            steps {
                script {
                    sh 'terraform init'
                }
            }
        }
        
        stage('Terraform Plan') {
            steps {
                script {
                    sh 'terraform plan'
                }
            }
        }
        
        stage('Review and Approve Apply') {
            when {
                expression { params.ACTION == 'Apply' }
            }
            steps {
                // Prompt for approval before applying changes
                input "Do you want to apply Terraform changes?"
            }
        }
        
        stage('Review and Approve Destroy') {
            when {
                expression { params.ACTION == 'Destroy' }
            }
            steps {
                // Prompt for approval before destroying resources
                input "Do you want to destroy Terraform resources?"
            }
        }
        
        stage('Apply or Destroy') {
            steps {
                script {
                    if (params.ACTION == 'Apply') {
                        sh 'terraform apply -auto-approve'
                    } else if (params.ACTION == 'Destroy') {
                        sh 'terraform destroy -auto-approve'
                    }
                }
            }
        }
    }
    
     post {
        success {
            script {
                    echo 'Terraform operation successful!'
                    archiveArtifacts artifacts: '*.pem', allowEmptyArchive: true
            }
        }
        failure {
            echo 'Terraform operation failed!'
          
        }
    }
}
```
</details>

**This Jenkins pipeline automates the deployment of a NetworkSkeleton_QA Server using Terraform module and Wrapper code. It's configured to perform the following actions:**

### Terraform Deployment Pipeline Overview

| Stage                   | Description                                                                                                                                                                      |
|-------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Checkout**            | Fetches the Terraform code from a GitHub repository branch (`main`). |                                                                                    
| **Copy Terraform Files**    | Copies Frontend-related Terraform configuration files to the Jenkins workspace. |                                                                                                
| **Terraform Init**          | Initializes Terraform in the workspace directory. |                                                                                                                                
| **Terraform Plan**          | Generates a Terraform execution plan to preview the changes. |                                                                                                                     
| **Review and Approve Apply** | Asks for approval before applying Terraform changes if the selected action is "Apply". |                                                                                       
| **Review and Approve Destroy** | Asks for approval before destroying Terraform resources if the selected action is "Destroy". |                                                                            
| **Apply or Destroy**        | Executes Terraform apply or destroy based on the selected action. |                                                                                                               
| **Post**                    | Displays success or failure messages. |                                                                                                                                          
***

## Output

### VPC & it's resources

<img width="800" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/bd03370b-9419-42a2-9c91-831176b8a8d3">

***

### Elastic IP

<img width="800" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/2b642830-7a6e-4c58-a20d-52ce3488b3c0">

***

### NACLs

**Frontend NACL**

<img width="800" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/1bfe075f-c85e-49c2-ab89-668624ec2122">

***

**Backend NACL**

<img width="800" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/74b31c37-f664-4be3-bad3-e2eb6869cda3">

***

**DB NACL**

<img width="800" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/7f538afe-31df-4f56-b25e-e73603188528">

***

### Security Group

<img width="800" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/b18405d2-68e8-4d8c-9944-b9fe037ac518">

***

### Load Balancer

<img width="800" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/ee63527c-bd8a-4815-bc0e-744af1ba910e">

***

### Route53

<img width="800" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/2d563ec3-61ef-4032-b86c-2787f68f4bdc">

***

# Conclusion

In conclusion, our DSL Pipeline offers a powerful solution for creating and managing domain-specific languages, enabling developers to express complex ideas in a concise and understandable manner. By embracing DSLs, organizations can accelerate development cycles, improve collaboration between domain experts and developers, and ultimately deliver higher-quality software solutions.The NetworkSkeleton_QA wrapper code streamlines the setup process, enhances security through standardized configurations, and improves usability by abstracting complex tasks, making it an efficient solution for deploying and managing VPN infrastructures. 

***


## Contact Information
| Name            | Email Address                        |
|-----------------|--------------------------------------|
| Khushi Malhotra | khushi.malhotra.snaatak@mygurukulam.co |

## References

| **Source** | **Description** |
| ---------- | --------------- |
| [**Link**](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Implementation/GenericDoc/Terraform/terraform.md) | Terraform Generic Doc Link. |
| [**Link**](https://developer.hashicorp.com/terraform/language/modules) | Terraform Module Concept. |
| [**Link**](https://medium.com/appgambit/terraform-with-jenkins-pipeline-439babe4095c)  | Jenkins DSL Pipeline Doc reference link. |
