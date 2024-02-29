# Documentation of Standalone VM Module




![image](https://github.com/CodeOps-Hub/Documentation/assets/156644891/26b5654a-2e78-47f8-8f33-327ec58d02fa)





|   Authors        |  Created on   |  Version   | Last updated by | Last edited on |
| -----------------| --------------| -----------|---------------- | -------------- |
| Nidhi bhardwaj   |  28 Feb 2024  |     v1     | Nidhi Bhardwaj  | 28 Feb 2024    |


***

# Table of Contents

1. [Introduction](#Introduction)

2. [Terraform Modules](#Terraform-Modules)

3. [Resources](#Resources)

4. [Tags](#Tags)

5. [Inputs](#Inputs)

6. [Output](#Output)

7. [Usage](#Usage)

8. [Terraform Execution](#Terraform-Execution)

9. [Conclusion](#Conclusion)

10. [Contact Information](#Contact-Information)

11. [References](#References)

***

# Introduction 

In the realm of cloud computing, particularly within the expansive infrastructure of Amazon Web Services (AWS), the concept of virtualization plays a pivotal role in enabling scalability, efficiency, and flexibility for businesses worldwide. Among the myriad components that compose AWS's ecosystem, the Virtual Machine (VM) module stands out as a foundational pillar, offering a standalone environment where users can deploy and manage their applications and workloads with autonomy and precision. This module encapsulates the essence of virtualization, providing users with the ability to create, customize, and operate virtual instances of computing resources within the AWS cloud infrastructure. 


***


# Terraform Modules


Terraform modules serve as fundamental building blocks within the Terraform infrastructure as code (IaC) framework, enabling users to encapsulate and reuse configuration logic across different projects and environments. Essentially, a Terraform module is a collection of resources and associated configuration files that define a specific piece of infrastructure, such as a virtual machine, network, or application. By organizing infrastructure components into modular units, users can achieve greater abstraction, maintainability, and scalability in their infrastructure provisioning workflows. Modules promote code reusability, simplifying the management of complex infrastructure setups and facilitating collaboration among teams. Additionally, Terraform modules support parameterization, allowing users to customize module behavior through input variables and outputs, further enhancing flexibility and adaptability. With Terraform modules, organizations can streamline their infrastructure provisioning processes, promote best practices, and accelerate the deployment of reliable and consistent infrastructure across their cloud environments.



**Terraform Module to create Virtual Machine in AWS**

Tools Used

Terraform: Version 1.12.29

Aws Version 4.66



***

# Resources 


|Name	|Type |
|-----|------|
|aws_iam_instance_profile.this	|resource|
|aws_iam_role.this	|resource|
|aws_iam_role_policy_attachment .this|	resource|
|aws_instance.ignore_ami	|resource|
|aws_instance.this|	resource|
|aws_spot_instance_request.this|	resource|
|aws_iam_policy_document.assume_role_policy|	data source|
|aws_partition.current|	data source|
|aws_ssm_parameter.this	|data source|



***

# Tags

+ Tags are assigned to resources with name variables as prefixes.

+ Additional tags can be assigned by tag variables as defined above.


***

# Inputs

|Name	|Description	|Type	|Default	Required|
|-----|-------------|-----|-------|
|ami|	ID of AMI to use for the instance|	string|	null	|no|
|ami_ssm_parameter	|SSM parameter name for the AMI ID. For Amazon Linux AMI SSM parameters see reference|	string	|"/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"|	no|
|associate_public_ip_address	|Whether to associate a public IP address with an instance in a VPC	|bool	|null	|no|
|availability_zone|	AZ to start the instance in|	string	|null	 |no |
|capacity_reservation_specification	|Describes an instance's Capacity Reservation targeting option |	any	{}	|no|
|cpu_core_count	|Sets the number of CPU cores for an instance|	number	|null |	no|
|cpu_credits	|The credit option for CPU usage (unlimited or standard)|	string|	null	|no|
|cpu_options|	Defines CPU options to apply to the instance at launch| time.|	any	{}	|no|
|cpu_threads_per_core	Sets| the number of CPU threads per core for an instance (has no effect unless cpu_core_count is also set)	|number	|null	| no|
|create |	Whether to create an instance	|bool	|true	| no|
|create_iam_instance_profile |	Determines whether an IAM instance profile is created or to use an existing IAM instance profile	| bool |	false |	no|
|iam_instance_profile	|IAM Instance Profile to launch the instance with. Specified as the name of the Instance Profile|	string |	null	|no|
|iam_role_description	|Description of the role|	string|	null|	no|
|iam_role_name|	Name to use on IAM role created|	string	|null	|no|
|iam_role_path	|IAM role path	|string	|null	|no|
|iam_role_permissions_boundary|	ARN of the policy that is used to set the permissions boundary for the IAM role |	string	| null	| no|
iam_role_policies	Policies attached to the IAM role	map(string)	{}	no
|iam_role_tags|	A map of additional tags to add to the IAM role/profile created	map| (string)|	{}	no|
|iam_role_use_name_prefix	|Determines whether the IAM role name (iam_role_name or name) is used as a prefix	| bool	|true	|no|
|ignore_ami_changes|	Whether changes to the AMI ID changes should be ignored by Terraform. Note - changing this value will result in the replacement of the instance|	bool|	false|

***

# Output


|Name	|Description|
|-----|-----------|
|AMI|	AMI ID that was used to create the instance|
|arn	|The ARN of the instance|
|availability_zone|	The availability zone of the created instance|
|capacity_reservation_specification|	Capacity reservation specification of the instance|
|ebs_block_device|	EBS block device information|
|ephemeral_block_device	|Ephemeral block device information|
|iam_instance_profile_arn |	ARN assigned by AWS to the instance profile|
|iam_instance_profile_id	|Instance profile's ID |
|iam_instance_profile_unique |	Stable and unique string identifying the IAM instance profile|
|iam_role_arn	|The Amazon Resource Name (ARN) specifying the IAM role|
|iam_role_name|	The name of the IAM role|
|iam_role_unique_id	| Stable and unique string identifying the IAM role |
|id	| The ID of the instance |
|instance_state	| The state of the instance|
|ipv6_addresses	| The IPv6 address assigned to the instance, if applicable|
|outpost_arn	|The ARN of the Outpost the instance is assigned to|
|password_data	|Base-64 encoded encrypted password data for the instance. Useful for getting the administrator password for instances running Microsoft Windows. This attribute is only exported if get_password_data is true|
|primary_network_interface_id |	The ID of the instance's primary network interface|
|private_dns |	The private DNS name assigned to the instance. Can only be used inside the Amazon EC2, and only available if you've enabled DNS hostnames for your VPC|
|private_ip	| The private IP address assigned to the instance|
|public_dns	| The public DNS name assigned to the instance. For EC2-VPC, this is only available if you've enabled DNS hostnames for your VPC|
|public_ip|	The public IP address assigned to the instance, if applicable. NOTE: If you are using an aws_eip with your instance, you should refer to the EIP's address directly and not use public_ip as this field will change after the EIP is attached|


***



# Usage

**Create a new Virtual Machine using module**

```module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "single-instance"

  instance_type          = "t2.micro"
  key_name               = "user1"
  monitoring             = true
  vpc_security_group_ids = ["sg-12345678"]
  subnet_id              = "subnet-eddcdzz4"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
```




***


# Make an encrypted AMI for use


```provider "aws" {
  region = "us-west-2"
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["679593333241"]

  filter {
    name   = "name"
    values = ["ubuntu-minimal/images/hvm-ssd/ubuntu-focal-20.04-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_ami_copy" "ubuntu_encrypted_ami" {
  name              = "ubuntu-encrypted-ami"
  description       = "An encrypted root ami based off ${data.aws_ami.ubuntu.id}"
  source_ami_id     = data.aws_ami.ubuntu.id
  source_ami_region = "eu-west-2"
  encrypted         = true

  tags = { Name = "ubuntu-encrypted-ami" }
}

data "aws_ami" "encrypted-ami" {
  most_recent = true

  filter {
    name   = "name"
    values = [aws_ami_copy.ubuntu_encrypted_ami.id]
  }

  owners = ["self"]
}
```

***

# Terraform Execution:



**To initialize Terraform**





```terraform init```




**To execute Terraform Plan**



```terraform plan```




**To apply Terraform changes**



```terraform apply```



# Conclusion


In conclusion, the standalone VM module presents a compelling solution for organizations seeking flexibility, portability, cost-efficiency, scalability, interoperability, and security in their virtualized environments. By decoupling virtualization from specific hypervisors or cloud platforms, this module offers users the freedom to deploy virtual machines across diverse hardware configurations without vendor lock-in. Its portability enables seamless migration of virtualized workloads across different environments, promoting agility and adaptability.


# Contact Information

|  Name                     |        	Email Address         |
| ------------              | --------------------------------|
| Nidhi Bhardwaj            | nidhi.bhardwaj.snaatak@mygurukulam.co   |




# References

| Title                                      | URL                                           |
|--------------------------------------------|-----------------------------------------------|
|Documentation|https://registry.terraform.io/modules/terraform-aws-modules/ec2-instance/aws/latest|
|Docs |https://github.com/OT-CLOUD-KIT/terraform-aws-vpc/blob/master/README.md|


