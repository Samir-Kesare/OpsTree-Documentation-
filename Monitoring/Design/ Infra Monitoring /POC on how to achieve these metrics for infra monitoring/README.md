# POC on how to achieve these metrics for infra monitoring

![image](https://github.com/CodeOps-Hub/Documentation/assets/156056570/a54141e8-1336-4b6d-899e-369fe9b9d90f)



|   Author        |  Created on   |  Version   | Last updated by  | Last edited on |
| --------------- | --------------| -----------|----------------- | -------------- |
| **[Samir Kesare](https://github.com/Snatak-SamirKesare)**    | 17-03-2024 |  Version 1 | Samir Kesare    | 17-03-2024  |
***

## Table of Contents 

+ [Introduction](#Introduction)
+ [Pre-requisites](#Pre-requisites)
+ [Steps](#Steps)
+ [Conclusion](#Conclusion)
+ [Contact Information](#contact-information)
+ [References](#References)
***
## Introduction

Effective monitoring of infrastructure ensures that potential issues are identified and addressed proactively, minimizing downtime and optimizing resource utilization. In this Proof of Concept 
(POC), we aim to demonstrate step-by-step instructions for the implementation of infrastructure monitoring.

***

## Pre-requisites

| Prerequisite   | Description                                                        |
|----------------|--------------------------------------------------------------------|
| Jenkins        | Open-source automation server for building, testing, and deploying software. |
| Prometheus     | Monitoring and alerting toolkit designed for reliability and scalability. |
| Node-Exporter | Prometheus exporter for hardware and OS metrics exposed by *NIX kernels. |
| Grafana        | Open-source analytics and visualization platform for monitoring and observability. |

***
## Steps 

### Step1: Setup prometheus

* First of all, let create a dedicated Linux user or sometimes called a system account for Prometheus.

```shell
sudo useradd \
    --system \
    --no-create-home \
    --shell /bin/false prometheus
```

* Let's check the latest version of Prometheus from the download page. And from there we can get latest version from curl or wget.

```shell
wget https://github.com/prometheus/prometheus/releases/download/v2.45.3/prometheus-2.45.3.linux-amd64.tar.gz
tar -xvf prometheus-2.45.3.linux-amd64.tar.gz
sudo mkdir -p /data /etc/prometheus
cd prometheus-2.45.3.linux-amd64/
sudo mv prometheus promtool /usr/local/bin/
sudo mv consoles/ console_libraries/ /etc/prometheus/
sudo mv prometheus.yml /etc/prometheus/prometheus.yml
sudo chown -R prometheus:prometheus /etc/prometheus/ /data/
```

* Verify that you can execute the Prometheus binary by running the following command

```shell
prometheus --version
```

* We're going to use systemd, which is a system and service manager for Linux operating systems. For that, we need to create a systemd unit configuration file.

```shell
sudo vim /etc/systemd/system/prometheus.service
```
```shell
[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target

StartLimitIntervalSec=500
StartLimitBurst=5

[Service]
User=prometheus
Group=prometheus
Type=simple
Restart=on-failure
RestartSec=5s
ExecStart=/usr/local/bin/prometheus \
  --config.file=/etc/prometheus/prometheus.yml \
  --storage.tsdb.path=/data \
  --web.console.templates=/etc/prometheus/consoles \
  --web.console.libraries=/etc/prometheus/console_libraries \
  --web.listen-address=0.0.0.0:9090 \
  --web.enable-lifecycle

[Install]
WantedBy=multi-user.target
```

* Setup prometheus to start automatically and enable the service.

```shell
sudo systemctl enable prometheus
sudo systemctl start prometheus
sudo systemctl status prometheus
```

### Step2: Setup Node Exporter

* First, let's create a system user for Node Exporter by running the following command

```shell
sudo useradd \
    --system \
    --no-create-home \
    --shell /bin/false node_exporter
```

* Use wget command to download binary

```shell
wget https://github.com/prometheus/node_exporter/releases/download/v1.3.1/node_exporter-1.3.1.linux-amd64.tar.gz
tar -xvf node_exporter-1.3.1.linux-amd64.tar.gz
sudo mv \
  node_exporter-1.3.1.linux-amd64/node_exporter \
  /usr/local/bin/
```

* Verify that you can run the binary

```shell
node_exporter --version
```

* Create system file for node_exporter and enable it

```shell
sudo vim /etc/systemd/system/node_exporter.service
```
```shell
[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

StartLimitIntervalSec=500
StartLimitBurst=5

[Service]
User=node_exporter
Group=node_exporter
Type=simple
Restart=on-failure
RestartSec=5s
ExecStart=/usr/local/bin/node_exporter \
    --collector.logind

[Install]
WantedBy=multi-user.target
```

* Enable and start the node_exporter

```shell
sudo systemctl enable node_exporter
sudo systemctl start node_exporter
sudo systemctl status node_exporter
```

### Step 3: Create the Prometheus configuration file to map the node

* To create a static target, you need to add job_name with static_configs

```shell
sudo vim /etc/prometheus/prometheus.yml
```
```shell
...
  - job_name: node_export
    static_configs:
      - targets: ["localhost:9100"]
```

* Since we enabled lifecycle management via API calls, we can reload Prometheus config without restarting the service and causing the downtime.

Before, restarting check if the config is valid.

```shell
promtool check config /etc/prometheus/prometheus.yml
```

* Then, you can use a POST request to reload the config.

```shell
curl -X POST http://localhost:9090/-/reload
```

### Step 4: Install Grafana

* To visualize metrics we can use Grafana. There are many different data sources that Grafana supports, one of them is Prometheus.

* First, let's make sure that all the dependencies are installed.
```shell
sudo apt-get install -y apt-transport-https software-properties-common
```

* Next, add GPG key.
```shell
echo "deb https://packages.grafana.com/oss/deb stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list
```

* After you add the repository, update and install Garafana.
```shell
sudo apt-get update
sudo apt-get -y install grafana
```

* To automatically start the Grafana after reboot, enable the service.
```shell
sudo systemctl enable grafana-server
```

* Then start the Grafana.
```shell
sudo systemctl start grafana-server
```

* To check the status of Grafana, run the following command
```shell
sudo systemctl status grafana-server
```

* Go to http://<ip>:3000 and log in to the Grafana using default credentials. The username is admin, and the password is admin as well.

* When you log in for the first time, you get the option to change the password. Let's use devops123 for the new password.

* To visualize metrics, you need to add a data source first. Click Add data source and select Prometheus. For the URL, enter http://localhost:9090 and click Save and test. You can see Data source is working.

* Usually, in production environments, you would store all the configurations in Git. Let me show you another way to add a data source as a code. Let's remove the data source from UI.

* Create a new datasources.yaml file.
```shell
sudo vim /etc/grafana/provisioning/datasources/datasources.yaml
```
```shell
apiVersion: 1

datasources:
  - name: Prometheus
    type: prometheus
    url: http://localhost:9090
    isDefault: true
```

* Restart Grafana to reload the config.
```shell
sudo systemctl restart grafana-server
```
![Screenshot 2024-03-18 151428](https://github.com/CodeOps-Hub/Documentation/assets/156056570/580184d5-7f7c-4e81-a0ba-1ed8a1733dc4)


### Step 5: Create a sample dashboard to test the configuration.

![Screenshot 2024-03-18 150943](https://github.com/CodeOps-Hub/Documentation/assets/156056570/7dae5ed0-4a8f-4e93-9ad6-23857f4631db)

![Screenshot 2024-03-18 150842](https://github.com/CodeOps-Hub/Documentation/assets/156056570/3cee383f-1752-41e8-a253-bec351d1eee5)

***
## Conclusion

In summary, this document offers a detailed guide for setting up infrastructure monitoring using Prometheus, Grafana, and Node Exporter on an EC2 instance. With basic knowledge of these tools and access to an AWS account, users can effectively implement monitoring solutions to enhance system visibility, identify performance issues, and ensure infrastructure reliability. This proof-of-concept provides a valuable resource for optimizing performance and maintaining overall infrastructure health.

***

## Contact Information

|     Name         | Email  |
| -----------------| ------------------------------------ |
| Samir Kesare    | samir.kesare.snaatak@mygurukulam.co |
***

## References

| Description                                   | References  
| --------------------------------------------  | -------------------------------------------------|
| Dashboard Overview | https://grafana.com/docs/grafana/latest/fundamentals/dashboards-overview/ |
|  Download Prometheus   | https://prometheus.io/download/     |
|  Download Node_Exporter   | https://prometheus.io/download/   |

























