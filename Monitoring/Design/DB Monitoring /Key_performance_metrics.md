# Key performance metrics in Database Monitoring

|   Author        |  Created on   |  Version   | Last updated by  | Last edited on |
| --------------- | --------------| -----------|----------------- | -------------- |
| Khushi Malhotra |  07 Feb 2024  |  Version 1 | Khushi Malhotra  | 13 Feb 2024    |

## Introduction
Key performance metrics in database monitoring are crucial for optimizing database performance and ensuring smooth operations.
Monitoring key metrics in database management is essential for ensuring optimal performance, identifying potential issues and making informed decisions regarding system resources. Several key metrics play a crucial role in this monitoring process, each providing unique insights into the database's health and efficiency. Let's explore some of these key metrics:

## Key Database Performance Metrics You Must Track Regularly
**Database Throughput**
Database throughput is one of the most important database performance metrics. It is the volume of work done by your database server over a unit of time such as per second, or per hour. It is usually measured as number of queries executed per second.
Focuses on processing speed: Throughput emphasizes the database's capacity to handle incoming requests and complete operations.
Measured in various units:

| Key Points               | Description                                                                                                                                                                                                                      |
|--------------------------|----------------------------------------------------------------------------------------------------------------------------------------|
| Transactions per Second (TPS) | This is a common unit, particularly for transactional databases, indicating the number of transactions processed per second. |                                                                             
|                               |                                                                                                                              |
| Queries per Second (QPS)      | Often used interchangeably with TPS, especially for analytical databases, representing the number of queries executed per second.    |                                                                     
|                               |                                                                                                                                      |
| Data volume per second        | Data volume per second refers to the amount of data processed by a system within a one-second timeframe.   |      
|                               |                                                                                                                                       |
| Locks                         | Controls access to a resource, allowing only one transaction to modify or access it at a time.               |
|                               |                                                                                                                          |
| Database Connections          | Refers to active and concurrent connections between clients or applications and a database. |
|                               |                                                                                                                          |
| Response Time                 | Duration for query execution and result return, critical for performance assessment.   |
|                               |                                                                                                                          |
| Deadlocks                     | Occur when transactions mutually block each other due to holding locks needed by the other transaction, leading to system standstill.|


                                                                                  
### Transaction Rate

**Definition:** Measures the frequency at which the database completes transactions within a specific time period, typically expressed as Transactions per Second (TPS).

**Focus:** Emphasizes the system's capacity to handle workload.

**Logical Unit of Work:** A transaction represents a set of database operations treated as a single unit.

**ACID Properties**

| Key Points   | Description                                                                                                            |
|--------------|------------------------------------------------------------------------------------------------------------------------|
| Atomicity    | Ensures all operations within a transaction are executed completely or not at all.                                    |
| Consistency  | Guarantees the database transitions to a valid and consistent state after a transaction completes.                    |
| Isolation    | Maintains data integrity by preventing operations in one transaction from affecting data accessed by other concurrent transactions. |
| Durability   | Committed transactions are persisted permanently, ensuring data remains intact even in case of system failures.         |


### Queries per Second (QPS)


| Key Points           | Description                                                                                                                                       |
|----------------------|---------------------------------------------------------------------------------------------------------------------------------------------------|
| Unit                 | Expressed as queries per second. Represents the database's capacity to handle queries within a second.                                            |
| Importance           | - Workload Assessment: Higher QPS indicates increased demand on the database. - Performance Monitoring: Helps identify periods of high activity and potential bottlenecks. |
| Monitoring Benefits  | - Evaluates database efficiency: Helps ensure the database is handling queries effectively. |
|                      | - Ensures responsiveness: Identifies potential slowdowns or delays in query processing. |
|                      | - Proactive identification of issues: Allows for adjustments and scaling to prevent performance degradation. |

### Data volume per second 

| Key Points         | Description                                                                                                                                |
|--------------------|--------------------------------------------------------------------------------------------------------------------------------------------|
| Unit               | Data volume per second is typically expressed in bytes per second (B/s) or its larger counterparts like megabytes per second (MB/s), gigabytes per second (GB/s), or even terabytes per second (TB/s) depending on the data volume being handled. |
| Complementary Metric | While data volume per second offers a raw measure of data flow, it's often used in conjunction with other performance metrics like throughput (TPS/QPS) to gain a more comprehensive picture of system performance.   |


### Locks

| Key Points         | Description                                                                                                                             |
|--------------------|-----------------------------------------------------------------------------------------------------------------------------------------|
| Data Integrity     | Crucial for data integrity, preventing conflicts and inconsistencies from simultaneous access.                                         |
| Concurrency        | Manages concurrent access, ensuring transactions don't interfere. Monitoring lock acquisition offers resource usage insights.            |
| Contention         | Identifies contention issues where transactions compete for resources. Enables optimization or transaction strategy adjustment.         |
| Deadlock Prevention | Detects potential deadlocks, preventing system stalling.                                                                                |

### Database Connections

| Key Points         | Description                                                                                                                                |
|--------------------|--------------------------------------------------------------------------------------------------------------------------------------------|
| Capacity Assessment | Crucial for evaluating the database's ability to handle concurrent requests and understanding current load.                                 |
| max_connections    | Configurable parameter setting the maximum active sessions a PostgreSQL database can support.                                           |
| Efficiency         | Recommended to keep active connections below 90% of max_connections for efficient operation.                                             |

### Response Time

| Key Points             | Description                                                                                                                                |
|------------------------|--------------------------------------------------------------------------------------------------------------------------------------------|
| Measurement Unit       | Typically in milliseconds (ms) or seconds, measures query submission to result retrieval time.                                           |
| Query Execution        | Directly reflects query efficiency; lower response time indicates faster processing and database responsiveness.                          |
| Performance Indicators | High response times suggest performance issues like poorly optimized queries or inefficient indexing.                                      |
| Influencing Factors    | - Query Complexity: Complex queries may lengthen response time. - Indexing: Inefficient or missing indexes affect response time. - Hardware Resources: Adequate CPU, memory, and disk I/O improve response time. |

### Deadlocks

| Key Points              | Description                                                                                                                                                        |
|-------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Blocked Transactions   | Each transaction holds a resource with a lock and waits to acquire additional locked resources, creating a circular dependency.                                   |
| Circular Dependency    | The core characteristic of a deadlock is the circular waiting condition. Transaction A is waiting for a resource held by Transaction B, and Transaction B is waiting for a resource held by Transaction A. This circular dependency forms a deadlock. |
| Resolution Mechanisms  | - Timeouts: Transactions may give up and release locks if resources aren't obtained within a specified time. - Detection and Resolution: Database systems detect deadlocks and may cancel involved transactions to break the deadlock.                 |

