# Setup Auto Scaling for Salary API

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/96dc6672-d14f-41f4-8f2f-7d6642840df2)

| Author                                                           | Created on  | Version    | Last Updated by | Last Updated on |
| ---------------------------------------------------------------- | ----------- | ---------- | --------------- | --------------- |
| **[Harshit Singh](https://github.com/Panu-S-Harshit-Ninja-07)**  | 23-02-2024  | 1.0        | Harshit Singh   | 23-02-2024      |

***
## Table of Contents
1. [Introduction](#Introduction)
2. [Pre-requisites](#Pre-requisites)
3. [Steps to setup Auto Scaling](#Steps-to-setup-Auto-Scaling)
4. [Output](#Output)
5. [Conclusion](#Conclusion)
6. [Contact Information](#Contact-Information)
7. [References](#References)

***

## Introduction_
**Amazon EC2 Auto Scaling**_ helps you ensure that you have the correct number of Amazon EC2 instances available to handle the load for your application. You create collections of EC2 instances, called _**Auto Scaling groups**_. 

You can specify the minimum number of instances in each Auto Scaling group, and Amazon EC2 Auto Scaling ensures that your group never goes below this size. You can specify the maximum number of instances in each Auto Scaling group, and Amazon EC2 Auto Scaling ensures that your group never goes above this size. If you specify the desired capacity, either when you create the group or at any time thereafter, Amazon EC2 Auto Scaling ensures that your group has this many instances. 

If you specify scaling policies, then Amazon EC2 Auto Scaling can launch or terminate instances as demand on your application increases or decreases.

_**AWS Auto Scaling**_ monitors your applications and automatically adjusts capacity to maintain steady, predictable performance at the lowest possible cost.

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/a2d2437d-3c76-44a1-b0b8-d38128cc9888)

***

## Pre-requisites
* Access to the AWS Management Console or AWS CLI with appropriate permissions.

* Understanding of your application's [network requirements](https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Design/09-%20Cloud%20Infra%20Design/Cloud-Infra-Design-Dev.md).

***
## Steps to setup Auto Scaling
### Step 1: Create AMI image of Salary API instance 
 1. Open the Amazon EC2 console at https://console.aws.amazon.com/ec2/ .
 
 2. Select `Dev-salary-API` instance, go to `Actions --> Image and templates --> Create image`

    ![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/e41c4d4e-0182-4cce-9bfe-ef1e1a4c9994)

 3. Enter **Name** and **Description** of image.

    ![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/374d4dcb-c5ba-41e9-ac70-522d3d790a08)

 4. Choose **Create image**

    ![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/df708075-3eac-4177-864d-ef1da9fcfaab)

It may take a few minutes for the AMI to be created. After it is created, it will appear in the **AMIs view** in AWS Explorer. To display this view, double-click the Amazon EC2 | AMIs node in AWS Explorer. To see your AMIs, from the Viewing drop-down list, choose **Owned By Me**. You may need to choose **Refresh** to see your AMI. When the AMI first appears, it may be in a **pending state**, but after a few moments, it transitions to an **available state**.

### Step 2: Create Launch Template

1. Open the Amazon EC2 console at https://console.aws.amazon.com/ec2/.

2. In the navigation pane, choose Launch Templates, and then choose Create launch template.
   
   ![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/215beaa4-fb86-4ea9-a8a1-72822cb94767)

3. For **Launch template name**, enter a descriptive name for the launch template. For **Template version description**, provide a brief description of this version of the launch template.

   ![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/bd57c86a-f302-4557-a5e3-18f6411f8d03)

4. **Application and OS Images (Amazon Machine Image)**
    Select the AMI that was created earlier.
    
    ![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/2d7b1d82-ff9a-4dfa-b4f8-f1a9f8fd4f91)

5. **Instance type and Key Pair (login)**
    Select required instance type and key pair.

    ![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/d9255c62-52da-4bac-bc90-1a3047c93b45)

6.  **Network settings**
    Configure the network settings, as necessary.

    ![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/75a56513-f805-48bb-831b-0dbf2d230d10)

7. Choose **Create Launch Template**
   
   ![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/71a89854-78ab-461b-b507-2192d785955a)

### Step 3: Create an Auto Scaling group using a launch template

1. Open the Amazon EC2 console at https://console.aws.amazon.com/ec2/, and choose **Auto Scaling Groups** from the navigation pane.

2. On the navigation bar at the top of the screen, choose the same **AWS Region** that you used when you created the **launch template**.

3. Choose **Create an Auto Scaling group**.

   ![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/8a8cdb98-9104-45ce-a8c9-d1ba4d2afe9f)

4. On the Choose launch template or configuration page, do the following:

   a. For Auto Scaling group name, enter a **name** for your Auto Scaling group.

   b. For **Launch template**, choose an existing launch template.

   c. For **Launch template version**, choose whether the Auto Scaling group uses the default, the latest, or a specific version of the launch template when scaling out.

   d. Verify that your launch template supports all of the options that you are planning to use, and then choose **Next**.

   ![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/1c0f77b2-42a4-4d06-8343-140634aa7f55)

6. On the **Choose instance** launch options page, if you're not using multiple instance types, you can skip the Instance type requirements section to use the EC2 instance type that is specified in    the launch template.

   a. Under Network, for VPC, choose a **VPC**. The Auto Scaling group must be created in the same VPC as the security group you specified in your launch template.

   b. For **Availability Zones and subnets**, choose one or more subnets in the specified VPC. Use subnets in multiple Availability Zones for high availability. For more information, see   Considerations when choosing VPC subnets.

   c. Choose **Next** to continue to the next step.

   ![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/54805492-8318-46d4-85ab-7b4a1f28d67b)

7. On the **Configure advanced** options page, configure the following options, and then choose **Next**:
   To register your Amazon EC2 instances with a load balancer, choose an existing **load balancer --> select load balancer target group**(`Dev-salary-tg`).

   ![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/a302cda7-a41c-449a-a30e-2e9627353e53)

8. On the **Configure group size** and scaling policies page, configure the following options, and then choose Next:

   Under **Group size**, for **Desired capacity**, enter the initial number of instances to launch.

   In the Scaling section, under Scaling limits, if your new value for Desired capacity is greater than Min desired capacity and Max desired capacity, the Max desired capacity is automatically     increased to the new desired capacity value. You can change these limits as needed. For more information, see Set scaling limits for your Auto Scaling group.

   ![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/1969e3a5-4ab2-4fd1-91c6-a12d3e523156)

9 (Optional) To receive notifications, for **Add notification**, configure the notification, and then choose Next. For more information, see Amazon SNS notification options for Amazon EC2 Auto Scaling.

10. To add tags, choose **Add tag**, provide a tag key and value for each tag, and then choose Next. For more information, see Tag Auto Scaling groups and instances.

    ![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/d01dfa54-cca6-447c-ae8f-ac3bc51aecc4)

11. On the **Review** page, choose **Create Auto Scaling group**.

    ![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/79ed826c-9308-4205-8731-2becf8133c61)
***
## Output
![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/8b5d8369-bd3d-4ee5-b5d9-40641a85ca3a)

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/0a8fdff2-1bdd-4476-a7c2-30bacea8d901)

***
## Conclusion

Amazon EC2 Auto Scaling manages your application's scalability by organizing instances into groups. It adjusts instance counts based on demand, offering features like health monitoring, custom checks, and load balancing. Simple steps help create Auto Scaling groups for dynamic scaling, optimizing performance and costs.

***
## Contact Information

|     Name         | Email  |
| -----------------| ------------------------------------ |
| Harshit Singh    | harshit.singh.snaatak@mygurukulam.co |
***

## References

| Description                                   | References  
| --------------------------------------------  | -------------------------------------------------|
| Documentation Template | https://github.com/OT-MICROSERVICES/documentation-template/wiki/Application-Template |
| Dev Infra Design      | https://github.com/CodeOps-Hub/Documentation/blob/main/Application_CI/Design/09-%20Cloud%20Infra%20Design/Cloud-Infra-Design-Dev.md |
| Launch Template | https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/create-launch-template.html |
| Auto Scaling Group | https://docs.aws.amazon.com/autoscaling/ec2/userguide/create-asg-launch-template.html |
