# Setup Redis Instances Manually

|   Author        |  Created on   |  Version   | Last updated by  | Last edited on |
| --------------- | --------------| -----------|----------------- | -------------- |
| Khushi Malhotra |  13 Feb 2024  |  Version 1 | Khushi Malhotra  | 13 Feb 2024    |
***

# Introduction
Redis can be used as a database, cache, streaming engine, message broker, and more.
Redis Cluster provides a way to run a Redis installation where data is automatically sharded across multiple Redis nodes. Redis Cluster also provides some degree of availability during partitions—in practical terms, the ability to continue operations when some nodes fail or are unable to communicate.
So, with Redis Cluster, you get the ability to:
- Automatically split your dataset among multiple nodes.
- Continue operations when a subset of the nodes are experiencing failures or are unable to communicate with the rest of the cluster.

# Pre-requisites
| Tool         |  Instance Type  |
|--------------|-----------------|
| AWS Instance | t2.medium       |

| Tool         | Command |
|--------------|---------|
| netstat      | `sudo apt install net-tools`|

| Security Protocol | 
|-------------------|
| Security Group    | 

# Setup Redis Manually
***
## Installing Redis
**Step-1** Launch 3 EC2 Instances
- Sign in to the AWS Management Console.
- Go to the EC2 dashboard.
- Launch a new EC2 instance using an Ubuntu Server AMI (Amazon Machine Image).
- Instance type - t2.medium

**Step-2** Security Group Configuration
- Create 3 new security group.

**Step-3** Connect to your EC2 Instances
- Once the instance is running, connect to it using SSH. The private key associated with the key pair selected at launch will be required.

**Step-4** Install Redis on Each Server
- Update the package index
```Shell
  sudo apt update
```
- Install Redis server
```shell
sudo apt install redis-server
```
- To check whether Redis is running on your server, you can use the following command
```Shell
sudo systemctl status redis-server
```
- Configure Redis Instances
  1. Edit the Redis configuration file in each server:
```shell
sudo nano /etc/redis/redis.conf
```
  2. Find the line `bind 127.0.0.1` and replace it with `bind <server1_IP>`. Replace `<server1_IP>` with the private IP address of the servers.
  3. Find the line `protected-mode yes` and change it to `protected-mode no` to allow external connections.
  4. Find the line `cluster-enabled no` and change it to `cluster-enabled yes`.
  5. Save and close the file.
**Step-5** Restart Redis Service
- Restart the Redis service on each server to apply the configuration changes
```shell
sudo systemctl restart redis-server
```
**Step-6** Verify Configuration
- Check that Redis is running and listening on the correct IP addresses and ports.
```Shell
sudo netstat -tuln | grep 6379
```





