# Key performance metrics in Database Monitoring

|   Author        |  Created on   |  Version   | Last updated by  | Last edited on |
| --------------- | --------------| -----------|----------------- | -------------- |
| Khushi Malhotra |  07 Feb 2024  |  Version 1 | Khushi Malhotra  | 13 Feb 2024    |

![image](https://github.com/CodeOps-Hub/Documentation/assets/79625874/1aac5b1e-9629-456a-a5bc-70a6442ab7d2)

## Table of Contents
+ [Introduction](#Introduction)
+ [Why we need Database Monitoring?](#Why-we-need-Database-Monitoring?)
+ [Key Database Performance Metrics You Must Track Regularly](#Key-Database-Performance-Metrics-You-Must-Track-Regularly)
  + [Transaction Rate](#Transaction-Rate)
  + [Queries per Second](#Queries-per-Second)
  + [Data volume per second](#Data-volume-per-second)
  + [Locks](#Locks)
  + [Database Connections](#Database-Connections)
  + [Response Time](#Response-Time)
  + [Deadlocks](#Deadlocks)
+ [Tools for Database Monitoring](#Tools-for-Database-Monitoring)
+ [Best practice](#Best-practice)
+ [Conclusion](#Conclusion)
+ [Contact Information](#contact-information)
+ [References](#References)

## Introduction
Key performance metrics in database monitoring are crucial for optimizing database performance and ensuring smooth operations.
Monitoring key metrics in database management is essential for ensuring optimal performance, identifying potential issues and making informed decisions regarding system resources. Several key metrics play a crucial role in this monitoring process, each providing unique insights into the database's health and efficiency. Let's explore some of these key metrics:
***

## Why we need Database Monitoring?

Database monitoring is crucial for organizations to ensure optimal performance, data integrity, and security. Here are some key reasons why database monitoring is essential:

| Key Points                               | Description                                                                                                                                                                                          |
|------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Performance Optimization**                 | Monitoring database performance allows organizations to identify bottlenecks, optimize queries, and allocate resources efficiently to enhance overall system performance.                            |
| **Issue Identification and Resolution**      | By tracking key metrics, database monitoring helps in identifying and addressing performance issues promptly, minimizing downtime, and ensuring uninterrupted operations.                    |
| **Resource Utilization**                     | Monitoring database resources like memory usage, CPU performance, and disk space helps in optimizing resource allocation, preventing overutilization, and ensuring smooth operations.          |
| **Security and Compliance**                  | Database monitoring tools provide features for auditing, tracking user activity, detecting unauthorized access attempts, and ensuring data protection to meet regulatory requirements and maintain data security. |
| **Proactive Maintenance**                    | Database monitoring enables proactive maintenance by alerting teams to potential issues before they impact operations, reducing mean time to recovery (MTTR), and enhancing system reliability. |

***

## Key Database Performance Metrics You Must Track Regularly

| Key Points               | Description                                                                                                                                                                                                                      |
|--------------------------|----------------------------------------------------------------------------------------------------------------------------------------|
| **Transactions per Second (TPS)** | This is a common unit, particularly for transactional databases, indicating the number of transactions processed per second. |                                                                         |                               |                                                                                                                              |
| **Queries per Second (QPS)**      | Often used interchangeably with TPS, especially for analytical databases, representing the number of queries executed per second.    |                                                                 |                               |                                                                                                                                      |
| **Data volume per second**        | Data volume per second refers to the amount of data processed by a system within a one-second timeframe.   |      
|                               |                                                                                                                                       |
| **Locks**                         | Controls access to a resource, allowing only one transaction to modify or access it at a time.               |
|                               |                                                                                                                          |
| **Database Connections**          | Refers to active and concurrent connections between clients or applications and a database. |
|                               |                                                                                                                          |
| **Response Time**                 | Duration for query execution and result return, critical for performance assessment.   |
|                               |                                                                                                                          |
| **Deadlocks**                     | Occur when transactions mutually block each other due to holding locks needed by the other transaction, leading to system standstill.|


                                                                                  
### Transaction Rate

| Key Points             | Description                                                                                                              |
|------------------------|--------------------------------------------------------------------------------------------------------------------------|
| **Focus**                  | Emphasizes the system's capacity to handle workload.                                                                    |
| **Logical Unit of Work**   | A transaction represents a set of database operations treated as a single unit.                                         |

**ACID Properties**

| Key Points   | Description                                                                                                            |
|--------------|------------------------------------------------------------------------------------------------------------------------|
| **Atomicity**    | Ensures all operations within a transaction are executed completely or not at all.                                    |
| **Consistency**  | Guarantees the database transitions to a valid and consistent state after a transaction completes.                    |
| **Isolation**    | Maintains data integrity by preventing operations in one transaction from affecting data accessed by other concurrent transactions. |
| **Durability**   | Committed transactions are persisted permanently, ensuring data remains intact even in case of system failures.         |


### Queries per Second


| Key Points           | Description                                                                                                                                       |
|----------------------|---------------------------------------------------------------------------------------------------------------------------------------------------|
| **Unit**                 | Expressed as queries per second. Represents the database's capacity to handle queries within a second.                                            |
| **Importance**           | - Workload Assessment: Higher QPS indicates increased demand on the database. - Performance Monitoring: Helps identify periods of high activity and potential bottlenecks. |
| **Monitoring Benefits**  | - Evaluates database efficiency: Helps ensure the database is handling queries effectively. |
|                          | - Ensures responsiveness: Identifies potential slowdowns or delays in query processing. |
|                          | - Proactive identification of issues: Allows for adjustments and scaling to prevent performance degradation. |

### Data volume per second 

| Key Points         | Description                                                                                                                                |
|--------------------|--------------------------------------------------------------------------------------------------------------------------------------------|
| **Unit**               | Data volume per second is typically expressed in bytes per second (B/s) or its larger counterparts like megabytes per second (MB/s), gigabytes per second (GB/s), or even terabytes per second (TB/s) depending on the data volume being handled. |
| **Complementary Metric** | While data volume per second offers a raw measure of data flow, it's often used in conjunction with other performance metrics like throughput (TPS/QPS) to gain a more comprehensive picture of system performance.   |


### Locks

| Key Points         | Description                                                                                                                             |
|--------------------|-----------------------------------------------------------------------------------------------------------------------------------------|
| **Data Integrity**     | Crucial for data integrity, preventing conflicts and inconsistencies from simultaneous access.                                         |
| **Concurrency**        | Manages concurrent access, ensuring transactions don't interfere. Monitoring lock acquisition offers resource usage insights.            |
| **Contention**         | Identifies contention issues where transactions compete for resources. Enables optimization or transaction strategy adjustment.         |
| **Deadlock Prevention** | Detects potential deadlocks, preventing system stalling.                                                                                |

### Database Connections

| Key Points         | Description                                                                                                                                |
|--------------------|--------------------------------------------------------------------------------------------------------------------------------------------|
| **Capacity Assessment** | Crucial for evaluating the database's ability to handle concurrent requests and understanding current load.                                 |
| **max_connections**    | Configurable parameter setting the maximum active sessions a PostgreSQL database can support.                                           |
| **Efficiency**         | Recommended to keep active connections below 90% of max_connections for efficient operation.                                             |

### Response Time

| Key Points             | Description                                                                                                                                |
|------------------------|--------------------------------------------------------------------------------------------------------------------------------------------|
| **Measurement Unit**       | Typically in milliseconds (ms) or seconds, measures query submission to result retrieval time.                                           |
| **Query Execution**        | Directly reflects query efficiency; lower response time indicates faster processing and database responsiveness.                          |
| **Performance Indicators** | High response times suggest performance issues like poorly optimized queries or inefficient indexing.                                      |
| **Influencing Factors**    | - Query Complexity: Complex queries may lengthen response time.                                                                            |
|                        | - Indexing: Inefficient or missing indexes affect response time.                                                                           |
|                        | - Hardware Resources: Adequate CPU, memory, and disk I/O improve response time.                                                            |

### Deadlocks

| Key Points              | Description                                                                                                                                                        |
|-------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Blocked Transactions**   | Each transaction holds a resource with a lock and waits to acquire additional locked resources, creating a circular dependency.                                   |
| **Circular Dependency**    | The core characteristic of a deadlock is the circular waiting condition. Transaction A is waiting for a resource held by Transaction B, and Transaction B is waiting for a resource held by Transaction A. This circular dependency forms a deadlock. |
| **Resolution Mechanisms**  | - Timeouts: Transactions may give up and release locks if resources aren't obtained within a specified time.                              |
|                            | - Detection and Resolution: Database systems detect deadlocks and may cancel involved transactions to break the deadlock.                 |

## Tools for Database Monitoring 
| Tool          | Description                                                                                                                                                                                                                                  |
|---------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Prometheus**    | Prometheus is an open-source monitoring and alerting toolkit designed for reliability and scalability. It collects metrics from monitored targets by scraping HTTP endpoints, allowing for flexible and powerful querying. It is often used in conjunction with Grafana for visualization and alerting. |
| **Grafana**       | Grafana is an open-source analytics and monitoring solution that allows you to query, visualize, alert on, and understand your metrics. It supports various data sources, including Prometheus, and offers a rich set of visualization options, including graphs, charts, and tables. Grafana is highly customizable, making it suitable for creating dashboards tailored to specific monitoring needs. |
| **Datadog**       | Datadog is a cloud-based monitoring and analytics platform that provides infrastructure monitoring, application performance monitoring (APM), and log management. It supports a wide range of integrations and provides comprehensive visibility into the performance and health of your infrastructure and applications. Datadog offers features such as anomaly detection, distributed tracing, and customizable dashboards. |
| **AppDynamics**   | AppDynamics is an application performance monitoring (APM) solution that provides real-time insights into the performance of your applications and infrastructure. It automatically discovers and maps application dependencies, allowing you to quickly identify performance bottlenecks and optimize application performance. AppDynamics offers features such as code-level diagnostics, business transaction monitoring, and end-user monitoring. |


## Best practice

| Step                                | Description                                                                                                                                         |
|-------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------|
| **1. Choose Meaningful Metrics**       | - Align with app functionality and user experience. - Consider database type (e.g., MySQL, PostgreSQL) and its specific metrics. - Include a balanced mix:   - Resource usage (CPU, memory, disk I/O) - Throughput (QPS, TPS) - Database-specific metrics (locks, waits) - Operational metrics (active users, errors) |
| **2. Set Baselines and Alerts**        | - Track historical data to establish performance benchmarks. - Define acceptable ranges and trigger alerts for abnormal values.                           |
| **3. Leverage Monitoring Tools**       | - Use built-in functionalities offered by most databases. - Explore advanced tools for deeper insights, historical analysis, and visualizations.         |
| **4. Proactive Analysis and Optimization** | - Investigate alerts promptly to identify root causes. - Analyze how metrics correlate to pinpoint bottlenecks. - Perform regular performance tuning (e.g., indexing, caching) to improve efficiency. |

## Conclusion

Monitoring key metrics is vital for PostgreSQL database health. Metrics like QPS, Transaction Rate, Locks, Disk I/O, Connections, Response Time, Deadlocks, CPU Usage, and Memory Usage provide insights into workload, efficiency, and potential issues. Proactive monitoring, using tools like Prometheus and Grafana, ensures early issue detection, scalability planning, and overall system health. This approach enables informed decision-making, contributing to optimal PostgreSQL database performance.

## Contact Information
| Name            | Email Address                        |
|-----------------|--------------------------------------|
| Khushi Malhotra | khushi.malhotra.snaatak@mygurukulam.co |

## References

| Description                                   | References  
| --------------------------------------------  | -------------------------------------------------|
| Key Metrics | https://blogs.manageengine.com/application-performance-2/appmanager/2020/04/27/key-metrics-for-postgresql-performance-monitoring.html |
| Metrics | https://ubiq.co/analytics-blog/key-database-performance-metrics-must-track-regularly/ |
| Types of Metrics | https://scoutapm.com/blog/database-performance-metrics |
