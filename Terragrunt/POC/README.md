
# Proof of Concept (POC) of Terragrunt

|   Authors        |  Created on   |  Version   | Last updated by | Last edited on |
| -----------------| --------------| -----------|---------------- | -------------- |
| Vidhi Yadav      | 13 March 2024   |     v1     | Vidhi Yadav     | 13 March 2024    |


## Table of Contents
+ [Introduction](#Introduction)
+ [Flow Diagram](#flow-diagram-of-poc)
+ [Proof of Concept](#Pre-requisite)
+ [Conclusion](#conclusion)
+ [Contact Information](#contact-information)
+ [References](#references)

***
## Introduction 

Terragrunt serves as a powerful complement to Terraform, enhancing its capabilities and simplifying infrastructure management. By leveraging Terragrunt alongside Terraform, users can achieve greater modularity, flexibility, and consistency in their infrastructure configurations.

For a comprehensive explanation and a thorough exploration of Terragrunt, kindly refer to the following [link](https://github.com/CodeOps-Hub/Documentation/blob/main/Terragrunt/Documentation/README.md#best-practices).

***


***
## Flow Diagramo of POC

<img width="1535" alt="Screenshot 2024-03-13 at 9 12 34 PM" src="https://github.com/CodeOps-Hub/Documentation/assets/156056349/0b29d791-3e94-42ab-aeba-8e01594788f9">

***

## Proof of Concept (PoC)
### Pre-requisites
|   Tool        |  Description   |
| -----------------| --------------|
| OWASP ZAP (version: 2.14)     | Tool required to perform DAST   |   


### 1. Setup Terragrunt

* Visit zap [website](https://www.zaproxy.org/docs/) and check the different installation packages for different OS

* Run the following command to download zap linux package using `wget`, then to extract the package.

```
wget https://github.com/zaproxy/zaproxy/releases/download/v2.14.0/ZAP_2.14.0_Linux.tar.gz
tar -xf ZAP_2.14.0_Linux.tar.gz
```

### 2. Run ZAP
* Now, to run our zap for analysis process.  Now running zap via zap.sh via -cmd or in daemon mode as it run the zap in Cli mode as shown below

```
<path to zap.sh> -port <port_no> -cmd -quickurl <url of website>
```

* <path to zap.sh> This is the executable file for OWASP ZAP
* The -port specifies the port on which ZAP will listen.
* -cmd indicates that the command should be executed in command-line mode.
* The -quickurl flag followed by the <url_of_website> parameter starts ZAP with the specified target URL.

### 3. Scanning API url

* The API and ZAP tool have been deployed on a virtual server. It has been ensured that the API is functioning correctly, and we can now proceed with the testing phase. For this process the following command was used:

```
/home/ubuntu/ZAP_2.14.0/zap.sh -cmd -quickurl http://34.69.125.44:8080/swagger-ui/index.html -port 8082 -quickout /home/ubuntu/zap_reports/results.html
```

### 4. Verify Reports 

* Navigate to the location where you saved your reports. Locate the generated `.html` reports. Ensure that vulnerabilities are correctly identified.

<img width="803" alt="Screenshot 2024-02-04 at 4 22 43 PM" src="https://github.com/avengers-p7/Documentation/assets/156056349/69a921ca-55c2-4640-9519-94538bf1bf94">

* The reports include information about the risk level and the number of alerts categorized. Following this overview, the reports provide specific details on each alert, presenting the alert name along with a concise description

<img width="1332" alt="Screenshot 2024-02-04 at 4 17 10 PM" src="https://github.com/avengers-p7/Documentation/assets/156056349/ab99ce71-b473-4632-acd2-09143560b548">

***
## Conclusion

* In conclusion, ZAP to check the security of our Java application, and it helped us find and fix some problems. But, it's important to know that keeping the application secure is an ongoing task. The information we got from this test is like a good starting point to make the application even more secure. It is advised to treat these findings seriously and implement appropriate remediation measures for overall security of our application.

* Since, security risks are always changing, it's really important to keep paying attention and regularly test and fix any issues in our applications. This ongoing effort is key to making sure our application stays strong and secure.

***
## Contact Information

|Vidhi Yadav                     | vidhi.yadhav.snaatak@mygurukulam.co                                                                                      
|---------------------------------|------------------------------------------------------------|

***
## References

| Title                                      | URL                                           |
|--------------------------------------------|-----------------------------------------------|
| Official Terraform documentation          |     |





