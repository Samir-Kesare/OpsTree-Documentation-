![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/a47cad5d-6cd6-45d9-810a-3f94e2f49a27)# Setup Auto Scaling for Salary API
![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/96dc6672-d14f-41f4-8f2f-7d6642840df2)

| Author                                                           | Created on  | Version    | Last Updated by | Last Updated on |
| ---------------------------------------------------------------- | ----------- | ---------- | --------------- | --------------- |
| **[Harshit Singh](https://github.com/Panu-S-Harshit-Ninja-07)**  | 22-02-2024  | 1.0        | Harshit Singh   | 22-02-2024      |

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

   ![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/a189770f-e324-4cd5-a699-c5f6a0d47d3c)

6. On the **Choose instance** launch options page, if you're not using multiple instance types, you can skip the Instance type requirements section to use the EC2 instance type that is specified in    the launch template.

   a. Under Network, for VPC, choose a **VPC**. The Auto Scaling group must be created in the same VPC as the security group you specified in your launch template.

   b. For **Availability Zones and subnets**, choose one or more subnets in the specified VPC. Use subnets in multiple Availability Zones for high availability. For more information, see   Considerations when choosing VPC subnets.

   c. Choose **Next** to continue to the next step.

   ![image](https://github.com/CodeOps-Hub/Documentation/assets/156056444/54805492-8318-46d4-85ab-7b4a1f28d67b)

7. On the Configure advanced options page, configure the following options, and then choose Next:
   To register your Amazon EC2 instances with a load balancer, choose an existing load balancer().
8. 

Or, you can accept the rest of the defaults, and choose Skip to review.

(Optional) 

For more information, see Use Elastic Load Balancing to distribute traffic across the instances in your Auto Scaling group. To create a new load balancer, follow the procedure in Configure an Application Load Balancer or Network Load Balancer from the Amazon EC2 Auto Scaling console.

(Optional) For Health checks, Additional health check types, select Turn on Elastic Load Balancing health checks.

(Optional) For Health check grace period, enter the amount of time, in seconds. This is how long Amazon EC2 Auto Scaling needs to wait before checking the health status of an instance after it enters the InService state. For more information, see Set the health check grace period for an Auto Scaling group.

Under Additional settings, Monitoring, choose whether to enable CloudWatch group metrics collection. These metrics provide measurements that can be indicators of a potential issue, such as number of terminating instances or number of pending instances. For more information, see Monitor CloudWatch metrics for your Auto Scaling groups and instances.

For Enable default instance warmup, select this option and choose the warm-up time for your application. If you are creating an Auto Scaling group that has a scaling policy, the default instance warmup feature improves the Amazon CloudWatch metrics used for dynamic scaling. For more information, see Set the default instance warmup for an Auto Scaling group.

(Optional) On the Configure group size and scaling policies page, configure the following options, and then choose Next:

Under Group size, for Desired capacity, enter the initial number of instances to launch.

In the Scaling section, under Scaling limits, if your new value for Desired capacity is greater than Min desired capacity and Max desired capacity, the Max desired capacity is automatically increased to the new desired capacity value. You can change these limits as needed. For more information, see Set scaling limits for your Auto Scaling group.

For Automatic scaling, choose whether you want to create a target tracking scaling policy. You can also create this policy after your create your Auto Scaling group.

If you choose Target tracking scaling policy, follow the directions in Create a target tracking scaling policy to create the policy.

For Instance maintenance policy, choose whether you want to create an instance maintenance policy. You can also create this policy after your create your Auto Scaling group. Follow the directions in Set an instance maintenance policy to create the policy.

Under Instance scale-in protection, choose whether to enable instance scale-in protection. For more information, see Use instance scale-in protection.

(Optional) To receive notifications, for Add notification, configure the notification, and then choose Next. For more information, see Amazon SNS notification options for Amazon EC2 Auto Scaling.

(Optional) To add tags, choose Add tag, provide a tag key and value for each tag, and then choose Next. For more information, see Tag Auto Scaling groups and instances.

On the Review page, choose Create Auto Scaling group.




## Output

***
## Conclusion

This document offers a streamlined approach to implementing listener rules for load balancers within AWS. By understanding the significance of load balancing and the benefits provided by AWS Load Balancer, users can effectively optimize their application's performance, availability, and scalability. The step-by-step instructions provided in the document enable users to configure target groups, register targets, set up a load balancer and listener, and conduct thorough testing. This process ensures efficient traffic management, enhancing the overall reliability and responsiveness of applications hosted on AWS infrastructure.

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
