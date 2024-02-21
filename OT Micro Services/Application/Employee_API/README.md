
# Purpose
Employee REST API is a golang based microservice which is responsible for all the employee related transactions in the [OT-Microservices](https://github.com/OT-MICROSERVICES). This application is completely platform independent and can be run on any kind of platform.

Supported features in the applications are:-

* Gin REST API for web transactions
* ScyllaDB as primary database for storing information
* Redis as a cache management system for quick response
* Swagger integration for the documentation of the API


***

# Key Components  

| Tool/Software | Usage  |
| ------------- | --------------------------------------------------------- | 
| `Spring boot` | based web framework, which uses Tomcat as a web server.  | 
| `ScyllaDB`    | is used as the primary database for storing all the employee data. |
| `Redis`       | as cache manager to store the cache response.|
| `migrate`     | Database migration |

***
# System Requirements

| System Requirement              |           Minimum                        |
|-----------------------------------|--------------------------------------------|
| Processor/Instance Type           |             Dual Core/t2.medium            | 
| RAM                               |               4GB                          |
| Disk Space                        |               16GB                         |            
| OS Required (Linux Distributions) | Ubuntu 20.04 LTS, Debian, or CentOS 7/8    |

***
# Ports
## Inbound Ports 

|   Port        |    Description    |
| ----------    |    -----------    |
|    8080       |   Employee  API port       | 

## Outbound Port

|   Port        |    Description    |
| ----------    |    -----------    |
|    9042       |    Scylla DB      |
|    6379       |    Redis          |

## Others

|   Port        |    Description    |
| ----------    |    -----------    |
|    22         |    SSH            |


***

# Architecture
![image](https://github.com/avengers-p7/Documentation/assets/156056570/f42b5db5-f38a-4348-879e-bc6222dd4f3b)


***

# Pre-requisites

The application doesn't have any specific pre-requisites except the database connectivity. Additionally, we can add Redis as cache system but it's not part of the mandatory setup.

For running the application, we need following things configured:

- **[ScyllaDB](https://www.scylladb.com/)**
- **[Redis](https://redis.io/)**
- **[Migrate](https://github.com/golang-migrate/migrate)**
- **[Java 17](https://www.digitalocean.com/community/tutorials/how-to-install-java-with-apt-on-ubuntu-22-04)**
- **[migrate](https://github.com/golang-migrate/migrate)**

***

# Step-by-step installation 
## Step1: Installation of software Dependencies
### Install ScyllaDB
1. Install a repo file and add the ScyllaDB APT repository to your system.
```shell
sudo mkdir -p /etc/apt/keyrings
``` 
```shell
sudo gpg --homedir /tmp --no-default-keyring --keyring /etc/apt/keyrings/scylladb.gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys d0a112e067426ab2
``` 
```shell
sudo wget -O /etc/apt/sources.list.d/scylla.list http://downloads.scylladb.com/deb/debian/scylla-5.4.list
``` 
2. Install ScyllaDB packages
```shell
sudo apt-get update
sudo apt-get install -y scylla
``` 
3. (Ubuntu only) Set Java 17
```shell
sudo apt-get update
sudo apt-get install -y openjdk-17-jre-headless
sudo update-java-alternatives --jre-headless -s java-1.17.0-openjdk-amd64
``` 
### Configure ScyllaDB
1. Configure the following parameters in the /etc/scylla/scylla.yaml configuration file.
![image](https://github.com/avengers-p7/Documentation/assets/156056570/9b388749-a06c-44d7-ac1a-3f6d7544baf8)

* seeds - The IP address of the first node. Other nodes will use it as the first contact point to discover the cluster topology when joining the cluster.
![image](https://github.com/avengers-p7/Documentation/assets/156056570/2b60281a-c83b-4961-8385-a766b79e140c)

* listen_address - The IP address that ScyllaDB uses to connect to other nodes in the cluster.
![image](https://github.com/avengers-p7/Documentation/assets/156056570/40742ac4-1a8c-4dc0-b96c-78174c388d35)

* rpc_address - The IP address of the interface for client connections (Thrift, CQL).
![image](https://github.com/avengers-p7/Documentation/assets/156056570/cc89b710-afeb-4d90-8ba4-0f95496f8a17)

2. Run the scylla_setup script to tune the system settings and determine the optimal configuration.
```shell
sudo scylla_setup
``` 
![image](https://github.com/avengers-p7/Documentation/assets/156056570/5578323a-5e7f-4152-a1fe-597cf32f7d80)
keep adding yes..

* The script invokes a set of [scripts](https://opensource.docs.scylladb.com/stable/getting-started/system-configuration.html#system-configuration-scripts) to configure several operating system settings; for example, it sets RAID0 and XFS filesystem.

* The script runs a short (up to a few minutes) benchmark on your storage and generates the /etc/scylla.d/io.conf configuration file. When the file is ready, you can start ScyllaDB. ScyllaDB will not run without XFS or io.conf file.

* You can bypass this check by running ScyllaDB in [developer mode](https://opensource.docs.scylladb.com/stable/getting-started/installation-common/dev-mod.html). We recommend against enabling developer mode in production environments to ensure ScyllaDB’s maximum performance.

3. Run ScyllaDB as a service (if not already running).
```shell
sudo systemctl start scylla-server
``` 
![image](https://github.com/avengers-p7/Documentation/assets/156056570/57561593-3592-442a-ac80-7de0f79eae17)

4. Run cqlsh

```shell
cqlsh private_ip
cqlsh > CREATE KEYSPACE IF NOT EXISTS employee_db
  WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1};
cqlsh > exit
``` 

### Install Migrate

```shell
curl -s https://packagecloud.io/install/repositories/golang-migrate/migrate/script.deb.sh | sudo bash
sudo apt-get update
sudo apt-get install migrate
``` 
### Install JQ (JSON processor)

```shell
sudo apt install jq
``` 
### Install Golang

Now that you have your link ready, first confirm that you’re in the home directory:
```shell
cd ~
``` 
use curl to retrieve the tarball
```shell
curl -OL https://golang.org/dl/go1.21.6.linux-amd64.tar.gz
``` 
To verify the integrity of the file you downloaded, run the sha256sum command and pass it to the filename as an argument:
```shell
sha256sum go1.21.6.linux-amd64.tar.gz
``` 
use tar to extract the tarball
```shell
sudo tar -C /usr/local -xvf go1.21.6.linux-amd64.tar.gz
``` 
set paths in your environment.
```shell
sudo vim ~/.profile
``` 
Then, add the following information to the end of your file:
```shell
export PATH=$PATH:/usr/local/go/bin
``` 
Next, refresh your profile by running the following command:
```shell
source ~/.profile
``` 
After, check if you can execute go commands by running go version:
```shell
go version
``` 
![image](https://github.com/avengers-p7/Documentation/assets/156056570/1aa72444-e300-414e-b7d7-83301bd140fa)

***
Best Practices for API security
Always use TLS: Use HTTPS to encrypt data transmitted between clients and the API server. This helps prevent man-in-the-middle attacks. Obtain and install an SSL certificate for your domain.

Use OAuth for SSO: Nearly every app will need to associate some private data with a single person. That means user accounts, and that means logging in and logging out. SSO allows users to verify themselves with a trusted third party (e.g., Google, Microsoft Azure, AWS) via token exchange to access a resource.
***
# Troubleshoot 

### Error 

![image](https://github.com/avengers-p7/Documentation/assets/156056570/a9ae885b-2ecc-4b55-afdf-3833989ede13)

### Solution

Insert below data 

{
    "id": "OT-010",
    "name": "Samir Kesare",
    "designation": "DevOps",
    "department": "Technology",
    "joining_date": "2023-10-24",
    "address": "bhilai",
    "office_location": "Hyderabad",
    "status": "Current Employee",
    "email": "samirkesare@gmail.com",
    "phone_number": "8347755757"
}
![image](https://github.com/avengers-p7/Documentation/assets/156056570/517929e8-0eb3-4f6a-9e58-bbbbc28d1da2)


# Endpoints Information

| **Endpoint**                     | **API Method** | **Description**                                                                                      |
|----------------------------------|------------|------------------------------------------------------------------------------------------------------|
| /metrics                         | GET        | Application healthcheck and performance metrics are available on this endpoint     |
| /api/v1/employee/health          | GET        | Endpoint for providing shallow healthcheck information about application health and readiness   |
| /api/v1/employee/health/detail   | GET        | Endpoint for providing detailed health check about dependencies as well like - ScyllaDB and Redis  |
| /api/v1/employee/create          | POST       | Data creation endpoint which accepts certain JSON body to add employee information in database     |
| /api/v1/employee/search          | GET        | Endpoint for searching data information using the params in the URL |                                
| /api/v1/employee/search/all      | GET        | Endpoint for searching all information across the system    |
| /api/v1/employee/search/location | GET        | Application endpoint for getting the count and information of location |
| /swagger/index.html              | GET        | Swagger endpoint for the application API documentation and their data models |


***

# Contact Information

| Samir Kesare                    | samir.kesare.snaatak@mygurukulam.co                                                                                  
|---------------------------------|------------------------------------------------------------|

***

# References


|     Description                  | References  
| ---------------------------------| ------------------------------------------------------------------- |
|     Documentation Template       | https://github.com/OT-MICROSERVICES/documentation-template/wiki/Application-Template |
|     Salary Documentation         | https://github.com/OT-MICROSERVICES/employee-api/blob/main/README.md |  

