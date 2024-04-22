# Proof of Concept (POC) of Open Telemetry

|   Authors        |  Created on   |  Version   | Last updated by | Last edited on |
| -----------------| --------------| -----------|---------------- | -------------- |
| Aakash Tripathi   | 21 April 2024   |     v1     | Aakash Tripathi     | 21 April 2024    |



## Table of Contents
+ [Introduction](#Introduction)
+ [Pre-requisites](#pre-requisites)
+ [POC:Instrumentation](#poc-instrumentation)
+ [POC: Automatic Instrumentation](#poc--automatic-instrumentation)
+ [Conclusion](#conclusion)
+ [Contact Information](#contact-information)
+ [References](#references)

***

## Introduction 

OpenTelemetry is an open-source observability framework that facilitates the instrumentation, collection, and export of telemetry data such as traces, metrics, and logs from distributed systems. It standardizes instrumentation across languages and frameworks, enabling developers to gain insights into the performance and behavior of their applications in cloud-native environments.

We will be performing a POC where we establish how we can instrument a simple Java application automatically, in such a way that traces, metrics, and logs are emitted to the console. We will also see how to perform automatic instrumentation of a simple java app. 

## Pre-requisites 
- Java JDK 17+, due to the use of Spring Boot 3; Java 8+ otherwise
- Gradle

## Setting Up Java Application 

1. The following example uses a basic Spring Boot application. 

To begin, set up an environment in a new directory called `java-simple`. Within that directory, create a file called `build.gradle.kts` with the following content:

```java
plugins {
  id("java")
  id("org.springframework.boot") version "3.0.6"
  id("io.spring.dependency-management") version "1.1.0"
}

sourceSets {
  main {
    java.setSrcDirs(setOf("."))
  }
}

repositories {
  mavenCentral()
}

dependencies {
  implementation("org.springframework.boot:spring-boot-starter-web")
}
```

2. In that same folder, create a file called `DiceApplication.java` and add the following code to the file:

```java
package otel;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.Banner;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class DiceApplication {
  public static void main(String[] args) {
    SpringApplication app = new SpringApplication(DiceApplication.class);
    app.setBannerMode(Banner.Mode.OFF);
    app.run(args);
  }
}
```
  Create another file called `RollController.java` and add the following code to the file:

```java
package otel;

import java.util.Optional;
import java.util.concurrent.ThreadLocalRandom;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class RollController {
  private static final Logger logger = LoggerFactory.getLogger(RollController.class);

  @GetMapping("/rolldice")
  public String index(@RequestParam("player") Optional<String> player) {
    int result = this.getRandomNumber(1, 6);
    if (player.isPresent()) {
      logger.info("{} is rolling the dice: {}", player.get(), result);
    } else {
      logger.info("Anonymous player is rolling the dice: {}", result);
    }
    return Integer.toString(result);
  }

  public int getRandomNumber(int min, int max) {
    return ThreadLocalRandom.current().nextInt(min, max + 1);
  }
}
```

3. Build and run the application with the following command, then open http://<your-ip>:8080/rolldice in your web browser to ensure it is working.

```shell
gradle assemble
java -jar ./build/libs/java-simple.jar
```
![Screenshot 2024-04-21 192926](https://github.com/CodeOps-Hub/Documentation/assets/156056344/f7cf0fbd-2dc0-4475-a46c-0ece2ee60a63)

## POC: Instrumentation 

Now, we’ll use a Java agent to automatically instrument the application at launch time. 

1. Download `opentelemetry-javaagent.jar` from [Releases](https://github.com/open-telemetry/opentelemetry-java-instrumentation/releases) of the opentelemetry-java-instrumentation repository. The JAR file contains the agent and all automatic instrumentation packages:

```shell
curl -L -O https://github.com/open-telemetry/opentelemetry-java-instrumentation/releases/latest/download/opentelemetry-javaagent.jar
```

2. Set and export variables that specify the Java agent JAR and a console exporter, using a notation suitable for your shell/terminal environment — we illustrate a notation for bash-like shells:

```shell
export JAVA_TOOL_OPTIONS="-javaagent:home/ubuntu/opentelemetry-javaagent.jar" \
  OTEL_TRACES_EXPORTER=logging \
  OTEL_METRICS_EXPORTER=logging \
  OTEL_LOGS_EXPORTER=logging \
  OTEL_METRIC_EXPORT_INTERVAL=15000
```
![Screenshot 2024-04-22 211708](https://github.com/CodeOps-Hub/Documentation/assets/156056344/ced0f110-c6e1-49f6-b3aa-3206bb7b13a5)

3. Run your Application

```shell
$ java -jar ./build/libs/java-simple.jar
```
![Screenshot 2024-04-22 211716](https://github.com/CodeOps-Hub/Documentation/assets/156056344/42a1faf2-6a5c-4f62-88c7-22137f1a4ec6)


4. From another terminal, send a request using `curl`:

```shell
curl localhost:8080/rolldice
```
![Screenshot 2024-04-22 212137](https://github.com/CodeOps-Hub/Documentation/assets/156056344/ea958cf3-9c90-4b9c-ba83-1d91fea5b7e4)


5. Stop the server process.

At step 4, you should have seen trace & log output from the server and client that looks something like this (trace output is line-wrapped for convenience):

```
[otel.javaagent 2024-04-21 14:07:17:871 +0000] [PeriodicMetricReader-1] INFO
io.opentelemetry.exporter.logging.LoggingMetricExporter - Received a collection
 of 19 metrics for export.
[otel.javaagent 2024-04-21 14:07:17:871 +0200] [PeriodicMetricReader-1] INFO
io.opentelemetry.exporter.logging.LoggingMetricExporter - metric:
ImmutableMetricData{resource=Resource{schemaUrl=
https://opentelemetry.io/schemas/1.19.0, attributes={host.arch="aarch64",
host.name="OPENTELEMETRY", os.description="Mac OS X 13.3.1", os.type="darwin",
process.command_args=[/bin/java, -jar, java-simple.jar],
process.executable.path="/bin/java", process.pid=64497,
process.runtime.description="Homebrew OpenJDK 64-Bit Server VM 20",
process.runtime.name="OpenJDK Runtime Environment",
process.runtime.version="20", service.name="java-simple",
telemetry.auto.version="1.25.0", telemetry.sdk.language="java",
telemetry.sdk.name="opentelemetry", telemetry.sdk.version="1.25.0"}},
instrumentationScopeInfo=InstrumentationScopeInfo{name=io.opentelemetry.runtime-metrics,
version=1.25.0, schemaUrl=null, attributes={}},
name=process.runtime.jvm.buffer.limit, description=Total capacity of the buffers
in this pool, unit=By, type=LONG_SUM, data=ImmutableSumData{points=
[ImmutableLongPointData{startEpochNanos=1682350405319221000,
epochNanos=1682350465326752000, attributes=
{pool="mapped - 'non-volatile memory'"}, value=0, exemplars=[]},
ImmutableLongPointData{startEpochNanos=1682350405319221000,
epochNanos=1682350465326752000, attributes={pool="mapped"},
value=0, exemplars=[]},
ImmutableLongPointData{startEpochNanos=1682350405319221000,
epochNanos=1682350465326752000, attributes={pool="direct"},
value=8192, exemplars=[]}], monotonic=false, aggregationTemporality=CUMULATIVE}}
...

```

At step 5, when stopping the server, you should see an output of all the metrics collected (metrics output is line-wrapped and shortened for convenience):

```
[otel.javaagent 2024-04-21 14:07:17:871 +0000] [Thread-0] INFO io.opentelemetry.exporter.logging.LoggingMetricExporter - metric: ImmutableMetricData{resource=Resource{schemaUrl=https://opentelemetry.io/schemas/1.24.0, attributes={host.arch="amd64", host.name="ip-172-31-56-69", os.description="Linux 6.5.0-1014-aws", os.type="linux", process.command_args=[/usr/lib/jvm/java-17-openjdk-amd64/bin/java, -jar, ./build/libs/java-simple.jar], process.executable.path="/usr/lib/jvm/java-17-openjdk-amd64/bin/java", process.pid=5285, process.runtime.description="Private Build OpenJDK 64-Bit Server VM 17.0.10+7-Ubuntu-122.04.1", process.runtime.name="OpenJDK Runtime Environment", process.runtime.version="17.0.10+7-Ubuntu-122.04.1", service.instance.id="382aff2d-c929-4e18-b254-6afb3d39f09e", service.name="java-simple", telemetry.distro.name="opentelemetry-java-instrumentation", telemetry.distro.version="2.3.0", telemetry.sdk.language="java", telemetry.sdk.name="opentelemetry", telemetry.sdk.version="1.37.0"}}, instrumentationScopeInfo=InstrumentationScopeInfo{name=io.opentelemetry.tomcat-10.0, version=2.3.0-alpha, schemaUrl=null, attributes={}}, name=http.server.request.duration, description=Duration of HTTP server requests., unit=s, type=HISTOGRAM, data=ImmutableHistogramData{aggregationTemporality=CUMULATIVE, points=[ImmutableHistogramPointData{getStartEpochNanos=1713708233324210425, getEpochNanos=1713708437869834176, getAttributes={http.request.method="GET", http.response.status_code=200, http.route="/rolldice", network.protocol.version="1.1", url.scheme="http"}, getSum=0.20277690899999998, getCount=2, hasMin=true, getMin=0.003931107, hasMax=true, getMax=0.198845802, getBoundaries=[0.005, 0.01, 0.025, 0.05, 0.075, 0.1, 0.25, 0.5, 0.75, 1.0, 2.5, 5.0, 7.5, 10.0], getCounts=[1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0], getExemplars=[]}]}}

```

## POC : Automatic Instrumentation

Automatic instrumentation with Java uses a Java agent JAR that can be attached to any Java 8+ application. It dynamically injects bytecode to capture telemetry from many popular libraries and frameworks. It can be used to capture telemetry data at the “edges” of an app or service, such as inbound requests, outbound HTTP calls, database calls, and so on. 

### Setup 

1. Download opentelemetry-javaagent.jar from Releases of the opentelemetry-java-instrumentation repository and place the JAR in your preferred directory. The JAR file contains the agent and instrumentation libraries.

2. Add -javaagent:path/to/opentelemetry-javaagent.jar and other config to your JVM startup arguments and launch your app:

```shell
java -javaagent:/home/ubuntu/opentelemetry-javaagent.jar -Dotel.service.name=simpledice -jar ./build/libs/java-simple.jar
```

![Screenshot 2024-04-22 212917](https://github.com/CodeOps-Hub/Documentation/assets/156056344/38a59b6c-e1d7-4db6-8e9d-c1eb23022b5e)

### Configuring the agent

The agent is highly configurable.
One option is to pass configuration properties via the -D flag. In this example, a service name and Zipkin exporter for traces are configured:

```shell
java -javaagent:/home/ubuntu/opentelemetry-javaagent.jar \
     -Dotel.service.name=simpledice \
     -Dotel.traces.exporter=zipkin \
     -jar ./build/libs/java-simple.jar
```

Now you can observe the traces from the java app on Zipkin 

![Screenshot 2024-04-21 201951](https://github.com/CodeOps-Hub/Documentation/assets/156056344/e7a01d00-d618-4850-8de2-32b5c66bd6be)

***

## Conclusion

OpenTelemetry serves as a unified solution for collecting logs, traces, and metrics across diverse environments and services. It enables seamless integration with various vendors and platforms by providing standardized instrumentation libraries and exporters. Through its flexible architecture, developers can easily instrument their applications to capture telemetry data, which can then be exported to different monitoring and observability platforms, including cloud providers, APM (Application Performance Monitoring) tools, and logging services. This interoperability empowers organizations to leverage their preferred monitoring solutions while maintaining consistency and compatibility across their entire infrastructure stack. Ultimately, OpenTelemetry fosters a more comprehensive understanding of system behavior and performance, facilitating effective troubleshooting, optimization, and monitoring in complex distributed environments.


## Contact Information

|Aakash Tripathi                 | aakash.tripathi.snaatak@mygurukulam.co                                                                                      
|---------------------------------|------------------------------------------------------------|

***
## References

| Title                                      | URL                                           |
|--------------------------------------------|-----------------------------------------------|
| Open Telemetry Docs           | https://opentelemetry.io/docs/  |
| Instrumentation          |  https://opentelemetry.io/docs/languages/java/getting-started/|
|Automatic Instrumentation | https://opentelemetry.io/docs/languages/java/automatic/
***
