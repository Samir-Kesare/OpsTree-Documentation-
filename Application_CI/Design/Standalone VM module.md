# Documentation of Standalone VM Module


|   Authors        |  Created on   |  Version   | Last updated by | Last edited on |
| -----------------| --------------| -----------|---------------- | -------------- |
| Nidhi bhardwaj   |  28 Feb 2024  |     v1     | Nidhi Bhardwaj  | 28 Feb 2024    |


***

# Table of Contents

1. [Introduction](#Introduction)

2. [Terraform Modules](#Terraform-Modules)

3. [Parameters to pass](#Parameters-to-pass)

4. [Tags](#Tags)

5. [Inputs](#Inputs)

6. [Usage](#Usage)

7. [Terraform Execution](#Terraform-Execution)

8. [Conclusion](#Conclusion)

9. [Contact Information](#Contact-Information)

10. [References](#References)

***

# Introduction 

This is a Terraform custom standalone module to create a Virtual Machine in Azure Cloud. In the background, it creates Resource Group, Virtual Network, Subnet, Public IP, Network Interface Controller, Security Group and Virtual Machine.


***


# Terraform Modules

**Terraform Module to create Virtual Machine in Microsoft Azure**

Tools Used

Terraform: Version 1.12.29

Aws Version 4.66



***

# Parameters to pass


|Parameters	|Need |	Description|
|----------|---------|-----------|
|source	|(Required)	|source of this module|
|base_name|	(Required)|	Base Name of all the resources being created|
|location|	(Required)	|Location of all the resources being created|
|size_vm|	(Required)|	Configuration of the VM|
|os_disk_size|	(Required)|	Size of the VM|
|os_profile_username|	(Required)	|Username of the VM|
|os_profile_password	|(Required)	|Password to login to VM|
|creator	|(Optional)	|tag a creator|



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
|capacity_reservation_specification	|Describes an instance's Capacity Reservation targeting option |	any	{}	no
cpu_core_count	Sets the number of CPU cores for an instance	number	null	no
cpu_credits	The credit option for CPU usage (unlimited or standard)	string	null	no
cpu_options	Defines CPU options to apply to the instance at launch time.	any	{}	no
cpu_threads_per_core	Sets the number of CPU threads per core for an instance (has no effect unless cpu_core_count is also set)	number	null	no
create	Whether to create an instance	bool	true	no
create_iam_instance_profile	Determines whether an IAM instance profile is created or to use an existing IAM instance profile	bool	false	no


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
|Documentation|https://registry.terraform.io/modules/iankesh/virtual-machine-standalone/azure/latest?tab=outputs|
|Docs |https://github.com/OT-CLOUD-KIT/terraform-aws-vpc/blob/master/README.md|


