
# Proof of Concept (POC) for Java Base Application

![image](https://github.com/avengers-p7/Documentation/assets/156056709/b2fc8037-4207-4dd1-b2f1-5c9882dda5d4)

| **Author**           | **Created On** | **Last Updated** | **Document Version** |
| -------------------- | -------------- | ---------------- | -------------------- |
| **Parasharam Desai** | 01-02-2024     | 04-02-2024       | V1.1                 |


## Introduction 

The Proof of Concept (POC) focuses on demonstrating the bug analysis process for a Java-based application. The project under consideration is the "salary-api" from the [OT-MICROSERVICES repository](https://github.com/OT-MICROSERVICES/salary-api.git).

	Repository Link: [OT-MICROSERVICES](https://github.com/OT-MICROSERVICES/salary-api.git)
 

![image](https://github.com/Parasharam-DevOps/Avenger-P7/assets/132131379/e4437f15-a559-43a4-9367-eb7aecca1f78)

## Prerequisites

**Java Version 17** (mentioned in pom.xml)  

![image](https://github.com/Parasharam-DevOps/Avenger-P7/assets/132131379/3a93c93a-5008-418e-b2f5-ff7e1ef1bef4)

**Maven** - As it simplifies the process of managing project dependencies, including testing dependencies.

**Spotbug** - As it's a library on which the project's bug tests is depended on. 

## Steps

### Cloning a Java App

Within the directory, make a clone of the repository.

	mkdir snaatak-P7
	cd snaatak
	git clone https://github.com/OT-MICROSERVICES/salary-api.git


### Install Java 17 and Maven

As the salary code is Java-based, it is designed to be compatible with Java version 17. It is advisable to install Maven, a crucial tool for managing and building Java projects.

	sudo apt update
	sudo apt install openjdk-17-jdk
	sudo apt install maven


### Add the Spotbug dependency in pom.xml file.

        <plugin>
          <groupId>com.github.spotbugs</groupId>
          <artifactId>spotbugs-maven-plugin</artifactId>
          <version>4.8.2.0</version>
          <dependencies>
            <dependency>
              <groupId>com.github.spotbugs</groupId>
              <artifactId>spotbugs</artifactId>
              <version>4.8.3</version>
            </dependency>
          </dependencies>
        </plugin>

![image](https://github.com/Parasharam-DevOps/Avenger-P7/assets/132131379/be28309d-4765-42a8-91e5-36fc945e2e3d)

### Integrate Find Security Bugs into spotbugs-maven-plugin

To integrate Find Security Bugs into SpotBugs plugin, you can configure your pom.xml like below:


              <plugin>
                  <groupId>com.github.spotbugs</groupId>
                  <artifactId>spotbugs-maven-plugin</artifactId>
                  <version>4.8.2.0</version>
                  <configuration>
                      <includeFilterFile>spotbugs-security-include.xml</includeFilterFile>
                      <excludeFilterFile>spotbugs-security-exclude.xml</excludeFilterFile>
                      <plugins>
                          <plugin>
                              <groupId>com.h3xstream.findsecbugs</groupId>
                              <artifactId>findsecbugs-plugin</artifactId>
                              <version>1.12.0</version>
                          </plugin>
                      </plugins>
                  </configuration>
              </plugin>

![image](https://github.com/Parasharam-DevOps/Avenger-P7/assets/132131379/e7ab5723-42ac-4d9e-a671-36f1fbf90781)


### 	Analyze Code with SpotBugs:

 mvn spotbugs:check

![Screenshot from 2024-01-25 17-37-43](https://github.com/avengers-p7/Documentation/assets/156056709/0f95dfad-9ac8-421f-8d9c-f781417ee3ca)


### Generate SpotBugs Reports: 
This command will generate an html report. After running this command, generate various types of reports, such as HTML and XML: (target/spotbugs.html)(target/spotbugsXml.xml).

	mvn spotbugs:spotbugs

![Screenshot from 2024-01-25 17-39-09](https://github.com/avengers-p7/Documentation/assets/156056709/004480a3-3a20-4d80-88f7-bb3f3c0251e2)


![image](https://github.com/avengers-p7/Documentation/assets/156056444/a635b5d3-db83-45db-99f5-5315e6dfa819)

**To See XML Report :** [Click Here](https://github.com/avengers-p7/Documentation/blob/main/Application_CI/Design/03-%20Java%20CI%20checks/spotbugsXml.xml) 
 
 
# Conclusion

In conclusion, the Proof of Concept showcased effective bug analysis practices for the Java-based "salary-api" application. By leveraging Java 17, Maven, and SpotBugs with Find Security Bugs integration, the POC demonstrated a systematic approach to identify and address potential issues in the codebase.

The outlined steps, from repository cloning to SpotBugs report generation, provide a clear roadmap for bug analysis. Additionally, the recommendation of SonarQube emphasizes its role in enhancing code reliability, security, and maintainability.

Adopting these practices empowers development teams to proactively address potential issues, ensuring the delivery of high-quality and secure software.


# Resources and References

| Description                                      | References  
| ------------------------------------------------- | ------------------------------------------------------------------- |
| Documentation Template                           | [Link](https://github.com/OT-MICROSERVICES/documentation-template/wiki/Application-Template) |
| SpotBugs Maven Plugin – Usage                           | [Link](https://spotbugs.github.io/spotbugs-maven-plugin/usage.html#:~:text=To%20generate%20the%20SpotBugs%20report,xml%20.&text=Then%2C%20execute%20the%20site%20plugin%20to%20generate%20the%20report.) |
| Usage Guide                           | [Link](https://github.com/find-sec-bugs/find-sec-bugs/wiki/Maven-configuration) |
