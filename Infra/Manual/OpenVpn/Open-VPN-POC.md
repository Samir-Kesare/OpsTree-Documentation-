# POC on OpenVPN

<img width="300" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/962c6922-0507-4f62-a686-509622c886ab">

***

| **Author** | **Created On** | **Last Updated** | **Document Version** |
| ---------- | -------------- | ---------------- | -------------------- |
| **Shreya Jaiswal** | **19 Feb 2024** | **19 Feb 2024** | **v1** |

***

# Table of Contents
+ [Introduction](#Introduction)
+ [Pre-requisites](#Pre-requisites)
+ [OpenVPN Setup](#OpenVPN-Setup)
+ [Result](#Result)
+ [Conclusion](#Conclusion)
+ [Contact Information](#Contact-Information)
+ [References](#References)

***

# Introduction

This Proof of Concept (PoC) documentation aims to provide a comprehensive guide for setting up and testing OpenVPN on an Ubuntu Server environment. OpenVPN is a widely-used open-source VPN (Virtual Private Network) solution known for its robust security features and flexibility. 

***

# Pre-requisites

| **Pre-requisite** | **Description** |
| ----------------- | --------------- |
| **Root Access or Administrative Privileges** | You'll need administrative access to the server to install packages, modify system settings, and configure firewall rules. |
| **Network Connectivity** | Verify that the server has stable internet connectivity with sufficient bandwidth for VPN traffic. Consider factors like upstream and downstream speeds, latency, and any bandwidth limitations. |
| **Firewall Configuration** | Ensure that firewall rules allow traffic on the necessary ports for OpenVPN. By default, OpenVPN uses UDP port 1194. |

***

# OpenVPN Setup

## Launching EC2 Instance

### Step-1 First, launch an `EC2 Instance`, access the EC2 dashboard, Click on `Launch Instance.`

![Screenshot 2024-02-19 133820](https://github.com/CodeOps-Hub/Documentation/assets/156057205/45575af6-697e-4fd2-9b5d-cd5aa43338ae)

***

### Step-2 Choose an appropriate name for the instance and choose `Ubuntu AMI`

![Screenshot 2024-02-19 133937](https://github.com/CodeOps-Hub/Documentation/assets/156057205/6b269d7d-2aec-4a8a-8b91-90f2d9ff693a)

***

### Step-3 Select the instance type as `t2-micro`. Generate a key pair with an appropriate name. 

![Screenshot 2024-02-19 134047](https://github.com/CodeOps-Hub/Documentation/assets/156057205/fcf83314-e725-4e8d-a43d-297856398546)

***

### Step-4 In the network settings, pick a VPC; in this case, choose the `Management-VPC`. Choose a subnet , preferably a `public subnet`. Enable `auto-assign IP`.Navigate to the security group settings. Ensure that `port 1194` is open if using UDP (default for OpenVPN). 

![Screenshot 2024-02-19 134343](https://github.com/CodeOps-Hub/Documentation/assets/156057205/f33b7660-2e08-4571-97f3-fcee10d8dfa7)

***

### Step-5 Leave other settings as default for now. Finally click on `launch instance`. That's it, we have successfully launched the `instance`.

![Screenshot 2024-02-19 134504](https://github.com/CodeOps-Hub/Documentation/assets/156057205/c87c30c3-40dc-4ec9-b0e0-ea46568b7389)

***

## Configuring OpenVPN

### Step-1 Let's set up our OpenVPN server. Start by updating your system packages using the below commands.

```shell
sudo apt update
sudo apt upgrade -y
```

<img width="937" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/938be885-f051-4735-8006-080ab6b90bcf">

***

### Step-2  We'll use this script to install and configure the OpenVPN server. To get the script, run the following command mentioned below.

```shell
wget https://raw.githubusercontent.com/angristan/openvpn-install/master/openvpn-install.sh
```
<img width="943" alt="image" src="https://github.com/CodeOps-Hub/Documentation/assets/156057205/a12347e5-1b61-4246-bf77-c3223ef5255c">

***

### Step-3 Grant the script necessary (execution) permission by running the below command.

```shell

```
***

### Step-4 Execute the script with the following command.

```shell

```

***

### Step-5 As soon as the script runs, it will pose below given questions. 

**The first question verifies your Linux machine's IP address. Press Enter if it's correct; otherwise, press any other key. it will automatically detect your IP address; press enter to continue.**




**The script will then inquire about enabling IPv6 connectivity. You can stick with the default option and press enter.**


**You'll be prompted to choose a port. The default is 1194, but you can either stick with it or specify a different one. Note that you'll need to open this chosen port in your firewall, a step we'll cover later.**


**Another question will ask whether to use TCP or UDP. Simply press Enter to select UDP.**


**Following that, the script will inquire about your DNS resolver preference. I suggest opting for Google, which is option 9.**


**Finally, there's a query about customizing encryption settings. Once again, go with the default option, which is "no," and press Enter.**


**Press enter at the next prompt to start the process of applying the settings and installing the required certificates.**


**Provide the name of the client that will establish a connection with our VPN server. Subsequently, you will be prompted to indicate your preference regarding the use of a password for the client. opt for option 2 and input your desired password.**


**Enter the password. The configuration process is complete. OpenVPN now generates a file for each user you create.**


**To add additional clients, revoke an existing client, or uninstall OpenVPN, rerun the script, and it will provide you with the respective options.**


**This file, containing all the necessary configuration details, has been generated for connecting to the VPN server.**


***

## Assuming the client has received the files, we will proceed to establish the connection.

### Step-1 Navigate to the settings and click on the plus sign in the Network settings, as illustrated in the picture below.


***

### Step-2 Select the "Import File" option.


***

### Step-3 Choose the necessary OVPN file for importing.

***

### Step-4 After importing the file, you will encounter the interface provided below. Click on the "add" button.

***

### Step-5 Upon observing, you will notice that the file has been successfully added. Click the toggle button to establish a connection with your VPN server. 

***

### Step-6 After successfully authenticating with the password, we will be connected to the VPN network.

***

 ## Alternatively, we can connect to the VPN server from a Linux client using below command.
 
 ```shell

```

***

# Result


***

# Conclusion

In conclusion, this Proof of Concept (PoC) documentation has provided a detailed overview of deploying OpenVPN on Ubuntu Server for establishing secure remote access. Through the installation and configuration steps outlined in this documentation, users can successfully set up a functional OpenVPN server and initiate secure VPN connections.

***

# Contact Information

| **Name** | **Email Address** |
| -------- | ----------------- |
| **Shreya Jaiswal** | shreya.jaiswal.snaatak@mygurukulam.co |

***

# References

| **Source** | **Description** |
| ---------- | --------------- |
| [Link](https://www.youtube.com/watch?v=jmTtvxgspbk) | Video Reference for OpenVPN Setup |
| [Link](https://surfshark.com/blog/what-is-openvpn) | Reference Link for understanding the concept of OpenVPN |



