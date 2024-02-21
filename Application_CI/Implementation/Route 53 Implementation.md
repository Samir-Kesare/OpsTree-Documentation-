# Route 53 implementation



![image](https://github.com/CodeOps-Hub/Documentation/assets/156644891/aaa2bb4c-2296-4620-a24f-aabd5d05432f)








| Author                                                           | Created on  | Version    | Last Updated by | Last Updated on |
| ---------------------------------------------------------------- | ----------- | ---------- | --------------- | --------------- |
| Nidhi Bhardwaj                                                    | 20-02-2024  | 1.0        | Nidhi Bhardwaj   | 20-02-2024      |




# Table of content 

1. [Introduction](#Introduction)
2. [Prerequisites](#Prerequisites)
3. [Steps](#Steps)
4. [Conclusion](#Conclusion) 
5. [References](#References)
6. [Contact Information](#Contact-Information)


# Introduction 

Amazon Route 53 is a highly available and scalable Domain Name System (DNS) web service. You can use Route 53 to perform three main functions in any combination: domain registration, DNS routing, and health checking.



# Prerequisites 

Before you begin, ensure that you have:

1. AWS account credentials with sufficient permissions to create hosted zone in XYZ.com

2. Access to go daddy account as our domain is from go daddy




# Steps


**Step 1**





![image](https://github.com/CodeOps-Hub/Documentation/assets/156644891/c0cdb81f-7d3c-4217-9aa4-ffec7b8ca1a7)



Go to route 53 dashboard and select “hosted zones“




**Step 2**



![image](https://github.com/CodeOps-Hub/Documentation/assets/156644891/0d6b26a7-5b57-468d-810d-288a8765c745)



Now in create hosted zone, give a name and description. In type select “Public hosted zone”. and click on this button. 




**Step 3**




![image](https://github.com/CodeOps-Hub/Documentation/assets/156644891/5a191e74-7f7a-46fa-a3d0-730302f0d8f0)





Now. Our hosted zone has been created. 


**Step 4**




![Screenshot from 2024-02-21 17-29-51](https://github.com/CodeOps-Hub/Documentation/assets/156644891/f072ff1d-c5f6-4d1e-9e9a-324333d87f25)





Next, go inside the hosted zone and click on “Create record“. 




**Step 5**





![image](https://github.com/CodeOps-Hub/Documentation/assets/156644891/4e810e80-3132-4143-a49a-a38c5c1be4be)




 Fill in all the required details such as Name, Type, Alias, TTL seconds, Value, etc. Click the Create Record option. Create one more record for some other region so that there will be two records with the same domain name pointing to different IP addresses with your selected routing policy.


***


# Conclusion


Amazon Route 53 is a powerful tool for managing domain registration and traffic routing in AWS. Its global DNS capabilities, routing policies, and integration with AWS services make it a versatile solution. The step-by-step procedure discussed here demonstrates how to effectively use Route 53 to route internet traffic to a Virtual Private Cloud (VPC), ensuring a secure and reliable web service.




# Contact Information

|     Name         | Email  |
| -----------------| ------------------------------------ |
| Nidhi Bhardwaj    | nidhi.bhardwaj.snaatak@mygurukulam.co |




# References 


| Description                  | References  |
| ------------------------ | ---------------------------------------------|
|https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/CreatingHostedZone.html|officaial documentation |
|https://k21academy.com/amazon-web-services/aws-solutions-architect/aws-route-53/|Setup Document|
