# Setup Redis Instances Manually

|   Author        |  Created on   |  Version   | Last updated by  | Last edited on |
| --------------- | --------------| -----------|----------------- | -------------- |
| Khushi Malhotra |  13 Feb 2024  |  Version 1 | Khushi Malhotra  | 13 Feb 2024    |
***

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/f1234fc1-cc02-495e-8cd7-756a11548bb8)


# Table of Contents
- [Introduction](https://github.com/CodeOps-Hub/Documentation/blob/main/Infra/Manual/Redis_Setup/Instances/README.md#introduction)
- [Pre-requisites](https://github.com/CodeOps-Hub/Documentation/blob/main/Infra/Manual/Redis_Setup/Instances/README.md#pre-requisites)
- [Flow Diagram](https://github.com/CodeOps-Hub/Documentation/blob/main/Infra/Manual/Redis_Setup/Instances/README.md#flow-diagram)
- [Setup Redis Manually](https://github.com/CodeOps-Hub/Documentation/blob/main/Infra/Manual/Redis_Setup/Instances/README.md#setup-redis-manually)
- [Conclusion](https://github.com/CodeOps-Hub/Documentation/blob/main/Infra/Manual/Redis_Setup/Instances/README.md#conclusion)
- [Contact Information](https://github.com/CodeOps-Hub/Documentation/blob/main/Infra/Manual/Redis_Setup/Instances/README.md#contact-information)
- [Resources and References](https://github.com/CodeOps-Hub/Documentation/blob/main/Infra/Manual/Redis_Setup/Instances/README.md#resources-and-references)
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
| [Security Group](https://github.com/CodeOps-Hub/Documentation/blob/main/Infra/Manual/Redis_Setup/Security_Group/README.md)   | 
***

# Flow Diagram 
![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/0f8dadce-c10a-4336-aece-4a29872716d4)

***

# Setup Redis Manually

## Installing Redis
**Step-1** Launch 3 EC2 Instances
- Sign in to the AWS Management Console.
- Go to the EC2 dashboard.
- Launch a new EC2 instance.
- Instance type - t2.medium.
- Auto assign Public IP `disabled`

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/d069233b-fe50-41fb-bfaf-641e45b6b3be)



**Step-2** [Security Group Configuration](https://github.com/CodeOps-Hub/Documentation/blob/main/Infra/Manual/Redis_Setup/Security_Group/README.md)
- Create 3 security group.
- Inbound Rules

| Rule                 | Port(s)   | Protocol | Source                        |
|----------------------|-----------|----------|-------------------------------|
| SSH                  | 22        | TCP      | 20.0.0.0/28                  |
| Redis Default Port   | 6379      | TCP      | Backend-sg  |
| Redis Default Port   | 6379      | TCP      | 10.0.1.0/24 |
| Redis Cluster Bus Node to Node    | 16379     | TCP      | 10.0.1.0/24  |


- Outbound Rules

| Outbound Rule        | Port/Protocol | Destination       |
|----------------------|---------------|-------------------|
| Allow All Traffic    | All           | 0.0.0.0/0         |

**Step-3** Connect to your EC2 Instances
- Once the instance is running, connect to it using SSH from `master-jenkins` server.
![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/79d874c7-719d-4cea-8e6e-3e812f5a56f9)

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/3eb11497-7650-4b49-81e2-df89a159576e)

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/228a4fc5-e934-470f-9aec-a730d4091226)

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/48c958b5-a687-49a9-8a8f-000079dbc808)



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
![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/d92af4b3-42d0-4447-8eb4-20e2ca289890)


- Configure Redis Instances on each server
  1. Edit the Redis configuration file in each server:
```shell
sudo nano /etc/redis/redis.conf
```
  2. Find the line `bind 127.0.0.1` and replace it with `bind <server1_IP>`. Replace `<server1_IP>` with the private IP address of the servers.

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/cb13735c-992f-4249-bf7b-4a322cd0f2bc)

  3. Find the line `protected-mode yes` and change it to `protected-mode no` to allow external connections.
  4. Fnd the line `port 6379` and uncomment it.

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/40113e47-e117-4712-9e47-a2d7e5fa4e2e)

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/a922906d-371c-4d9d-a985-1c676ce3d93b)


  5. Find the line `cluster-enabled no` and change it to `cluster-enabled yes`.
  6. Find the line `cluster-config-file nodes-6379.conf` and uncomment it.
  7. Find the line `cluster-node-timeout 150000` and uncomment it.

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/5cbbdded-d55a-4180-a395-993c77dc380d)

  5. Save and close the file.

**Step-5** Restart Redis Service
- Restart the Redis service on each server to apply the configuration changes
```shell
sudo systemctl restart redis-server
```
```Shell
sudo systemctl status redis-server
```

**Step-6** Verify Configuration
- Check that Redis is running and listening on the correct IP addresses and ports.
```Shell
sudo netstat -tuln | grep 6379
```
![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/10dda0be-c9c3-4d1e-9ad9-78450fafae32)

**Step-7** To check the logs of each Redis node for error messages or warnings, you'll typically need to access the log files generated by Redis.
- Using tail: If you want to monitor the log file in real-time for new entries, you can use the tail command with the -f option.
```shell
tail -f /var/log/redis/redis-server.log
```
If this Warning message is displayed on your screen.

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/32f3b869-8ac5-48fb-b84b-5fe79838d69c)

This warning suggests that the overcommit_memory setting is not optimized for Redis, which may cause issues with background saves under low memory conditions. It's recommended to follow the instructions provided in the warning message to adjust the overcommit_memory setting.
you can run the command directly without persisting it
```shell
sysctl vm.overcommit_memory=1
```
After making this change, it's advisable to restart the Redis service for the new configuration to take effect. You can do this using the following command
```shell
sudo systemctl restart redis-server
```
Check the connectivitiy between each instances.
```shell
redis -h <Server_IP> -p <port>
```
![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/22929390-5cb9-47b6-87b3-eaf331022605)

**Step-8** Create the Redis Cluster:
- On Server 1, run the following command to create the Redis cluster
```shell
redis-cli --cluster create <server1_IP>:6379 <server2_IP>:6379 <server3_IP>:6379 --cluster-replicas 0
```
![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/063ea520-032f-45c2-80ec-d37fe452a7d4)
![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/c26d3757-d11a-4c09-9df9-38cbeaa7952b)
![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/4ddb5bdc-9900-462f-b809-52f7ec377c05)


**Step-9** Check Cluster info 
- To check the status and information of your Redis cluster, you can use the redis-cli tool with the cluster command.
```shell
redis-cli -h <node_IP_address> -p <port_number>
```
```shell
cluster info
```
```shell
cluster nodes
```
![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/27a7b1e6-75a9-4ecd-abfc-0759b2365196)
![image](https://github.com/CodeOps-Hub/Documentation/assets/156056460/0ec17369-925c-4ad9-b5e9-350ad327cb31)


### Cluster has been created successfully

# Conclusion
Redis installation and Redis cluster manually in a well-planned and secure manner, ensuring reliability, performance, and scalability for your applications.

# Contact Information
| Name            | Email Address                        |
|-----------------|--------------------------------------|
| Khushi Malhotra | khushi.malhotra.snaatak@mygurukulam.co |

# Resources and References 
| Reference | Link |
|-----------|------|
| Redis Refernce Doc | https://github.com/CodeOps-Hub/Documentation/blob/main/OT%20Micro%20Services/Software/Redis/README.md |
| Security Group | [Ports Defining](https://github.com/CodeOps-Hub/Documentation/blob/main/Infra/Manual/Redis_Setup/Security_Group/README.md)
| Redis cluster | [Redis official document](https://redis.io/docs/management/scaling/) |
| Configuring the clusters | [stackoverflow](https://stackoverflow.com/questions/39568561/how-to-solve-redis-cluster-waiting-for-the-cluster-to-join-issue)|
| Redis Specification | [Specification redis doc](https://redis.io/docs/reference/cluster-spec/)|









