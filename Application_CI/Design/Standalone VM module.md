# Documentation of Standalone VM Module


|   Authors        |  Created on   |  Version   | Last updated by | Last edited on |
| -----------------| --------------| -----------|---------------- | -------------- |
| Nidhi bhardwaj   |  28 Feb 2024  |     v1     | Nidhi Bhardwaj  | 28 Feb 2024    |


# Table of Contents

1.[Introduction](#Introduction)
2.[Terraform Modules](#Terraform-Modules)
3.[Parameters to pass](#Parameters-to-pass)
4.[Tags](#Tags)
5.[Inputs](#Inputs)
6.[Usage](#Usage)
7.[Terraform Execution](#Terraform-Execution)
8.[Conclusion](#Conclusion)
9.[Contact Information](#Contact-Information)
10.[References](#References)


# Introduction 

This is a Terraform custom standalone module to create a Virtual Machine in Azure Cloud. In the background, it creates Resource Group, Virtual Network, Subnet, Public IP, Network Interface Controller, Security Group and Virtual Machine.


***


# Terraform Modules

**Terraform Module to create Virtual Machine in Microsoft Azure**

Tools Used

Terraform: Version 0.12.29

Azurerm provider: Version v2.20.0


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



# Tags

Tags are assigned to resources with name variables as prefixes.

Additional tags can be assigned by tag variables as defined above.


# Inputs

|Name	|Description	|Type	|Default	Required|
|-----|-------------|-----|-------|
|name	|The sting name append in tags |string	|"opstree"|	yes|
|cidr_block	|The CIDR block for the VPC.| The default value is a valid CIDR	|string	|"10.0.0.0/24"|	no|
|instance_tenancy|	A tenancy option for instances launched into the VPC	|string	|"default"	|no|
|enable_dns_support	|A dns support for instances launched into the VPC|	boolean	|"true"	|no|
|enable_dns_hostnames|	A dns hostname for instances launched into the VPC	|boolean|	"false"	|no|
|enable_classiclink	|A dns classiclink for instances launched into the VPC|	boolean	|"false"	|no|
|enable_igw_publicRouteTable_PublicSubnets_resource|	This variable is used to create IGW, Public Route Table and Public Subnets	|boolean|	"True"	|no|
|enable_nat_privateRouteTable_PrivateSubnets_resource	|This variable is used to create NAT, Private Route Table and Private Subnets|	boolean|	"True"|	no|
|enable_public_web_security_group_resource|	This variable is to create Web Security Group	|boolean	|"True"	|no|
|Default|enable_pub_alb_resource|	This variable is to create ALB|	boolean	|"True"	|no|
|enable_aws_route53_zone_resource	|This variable is to create Route 53 Zone	|boolean	|"True"	|no|

# Usage:

**Create a new Virtual Machine using module**

```provider "azure" {
  version = "=2.20.0"
  features {}
}

module "az_virtual_machine" {
  source              = "../../terraform-azure-virtual-machine-standalone"
  base_name           = "Nidhi"
  size_vm             = "Standard_D2_v2"
  os_disk_size        = "30"
  image_publisher     = "Canonical"
  image_offer         = "UbuntuServer"
  image_version       = "latest"
  image_sku           = "18.04-LTS"
  os_profile_username = "devops"
  os_profile_password = "Devops123456789"
  location            = "westeurope"
  creator             = "Nidhi"
}```





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


