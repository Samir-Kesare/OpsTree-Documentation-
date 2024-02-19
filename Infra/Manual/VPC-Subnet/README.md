# Create VPC and subnets for Dev Environment

| **Author**           | **Created On** | **Last Updated** | **Document Version** |
| -------------------- | -------------- | ---------------- | -------------------- |
| **Parasharam Desai** | 29-01-2024     | 19-02-2024       | V1                   |

## Introduction

This documentation provides a step-by-step guide on creating CIDR blocks and subnets within an Amazon Virtual Private Cloud (VPC) in AWS. CIDR blocks define the IP address range for your VPC, and subnets help organize and manage the allocation of IP addresses within that range.

## Prerequisites

- Access to the AWS Management Console or AWS CLI with appropriate permissions.
- Basic understanding of networking concepts, IP addressing, and subnetting.

## Steps

### Creating CIDRs for VPC

1. **Access the AWS Management Console**
   
   * Navigate to the AWS Management Console and sign in to your AWS account.

2. **Open the VPC Dashboard**
   
   * In the AWS Management Console, go to the Services dropdown.
   * Under the "Networking & Content Delivery" section, select VPC.
   * ![VPC Dashboard](https://github.com/CodeOps-Hub/Documentation/assets/156056709/34957e67-171d-4e4e-b7c7-acabfb4e6096)

3. **Create a New VPC**
   
   * Click on the Create VPC button.
   * Enter a name for your VPC.
   * Define the IPv4 CIDR block for your VPC. For example, 10.0.0.0/16.
   * Choose whether to enable IPv6 CIDR block.
   * Set any additional configurations such as DNS resolution and DNS hostnames.
   * Click Create VPC.
   * ![Create VPC](https://github.com/CodeOps-Hub/Documentation/assets/156056709/64979124-b435-41b3-8066-9da8387c1822)

### Creating Subnets within the VPC

1. **Navigate to Subnets**
   
   * In the VPC Dashboard, select Subnets from the left navigation pane.
   * Click Create Subnet.
   * ![Create Subnet](https://github.com/CodeOps-Hub/Documentation/assets/156056709/91b5ff3d-ac45-4a87-835f-41903a1f12c4)

2. **Create a Subnet**
   
   * Enter a name for your subnet.
   * Select the VPC that you created in the previous steps.
   * Define the IPv4 CIDR block for the subnet. Ensure it falls within the VPC CIDR range.
   * Choose the availability zone for the subnet.
   * Set any additional configurations, such as route table associations and network ACLs.
   * Click Create Subnet.
   * ![Create Subnet](https://github.com/CodeOps-Hub/Documentation/assets/156056709/4b563a06-a926-41dc-aa4b-2161b90999e5)
   * ![Subnet Configuration](https://github.com/CodeOps-Hub/Documentation/assets/156056709/9ffbf5c5-8561-4d8d-a2f9-4d30cfd53563)

3. **Repeat for Additional Subnets**
   
   * Repeat the subnet creation process for each availability zone and segment your VPC based on your application's architecture and security requirements.

## Conclusion

Creating CIDRs and subnets within your AWS VPC is a foundational step in designing a secure and scalable network architecture. Ensure that your CIDR blocks and subnet designs align with your application's needs and adhere to best practices for networking in AWS.

## Contact Information

| Name               | Email Address                               |
| ------------------ | ------------------------------------------- |
| Parasharam Desai   | parasharam.desai.snaatak@mygurukulam.co    |

---

## Resources and References

| Description           | References                                                        |
| --------------------- | ----------------------------------------------------------------- |
| Documentation Template | [Link](https://github.com/OT-MICROSERVICES/documentation-template/wiki/Application-Template) |
| Dev Infra Design      | [Link](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Design/09-%20Cloud%20Infra%20Design/Cloud-Infra-Design-Dev.md) |
