<img src="logo.jpeg" alt="AO Security Posture Logo" width="200" height="200">

# AO Security Posture 

This is a Docker-based environment designed to help users learn and experiment with tools related to security posture assessment and penetration testing. **This project is for educational purposes only and must be used ethically with proper authorization.**

---

## **Setup Instructions**

### **1. Build the Docker Image**
To build the Docker image from the Dockerfile:
```bash
docker build -t security-posture-docker-image .
```

### **2. Rebuild the Image Without Cache and place a Platform **
To rebuild the image and ignore cached layers:
```bash
docker build --no-cache -t security-posture-docker-image .
docker build --no-cache --platform=linux/amd64 -t security-posture-docker-image .
```

### **3. Run a Container from the Image**
To start a container interactively:
```bash
docker run -it --name ao security-posture-docker-image
docker run -it --platform=linux/amd64 --name ao security-posture-docker-image
```

### **4. Start Docker in Detached Mode**
To start a container in detached mode:
```bash
docker run -dit --platform=linux/amd64 --name ao security-posture-docker-image
```

### **5. Enter the Running Container**
To access the running container:
```bash
docker exec -it ao /bin/bash
```

### **6. Run a Specific Command Inside the Image**
To run a specific command (e.g., `httprobe`):
```bash
docker run --rm security-posture-docker-image httprobe -h
```

### **7. Execute Commands Outside the Container**
To execute a command on a running container (e.g., `cdncheck`):
```bash
docker exec -it ao cdncheck -i test.com -j -o /home/reports/test.com-cdncheck.json
```

### **8. Remove a Container**
To stop and remove the container:
```bash
docker stop ao
```
```bash
docker rm ao
```

---

## **Included Tools**

### **Reconnaissance Tools**

1. **Naabu**
   - **Category**: Port Scanning
   - **Description**: Fast and reliable port scanner supporting SYN/CONNECT/UDP scans.
   - **Link**: [Naabu on GitHub](https://github.com/projectdiscovery/naabu)

2. **Httprobe**
   - **Category**: HTTP/HTTPS Probing
   - **Description**: Probes domains for working HTTP and HTTPS servers.
   - **Link**: [Httprobe on GitHub](https://github.com/tomnomnom/httprobe)

3. **CDNCheck**
   - **Category**: Information Gathering
   - **Description**: Identifies technologies associated with DNS/IP network addresses.
   - **Link**: [CDNCheck on GitHub](https://github.com/projectdiscovery/cdncheck)

4. **WafW00f**
   - **Category**: WAF Detection
   - **Description**: Identifies and fingerprints Web Application Firewall (WAF) products.
   - **Link**: [WafW00f on GitHub](https://github.com/EnableSecurity/wafw00f)

5. **Katana**
   - **Category**: Web Crawling
   - **Description**: Fast crawler for headless and non-headless crawling.
   - **Link**: [Katana on GitHub](https://github.com/projectdiscovery/katana)

6. **Dirsearch**
   - **Category**: Web Path Brute-Forcing
   - **Description**: An advanced web path brute-forcer.
   - **Link**: [Dirsearch on GitHub](https://github.com/maurosoria/dirsearch)

---

### **Subdomain Enumeration Tools**

1. **Amass**
   - **Category**: Subdomain Enumeration
   - **Description**: Performs external asset discovery using open-source information gathering.
   - **Link**: [Amass on GitHub](https://github.com/owasp-amass/amass)

2. **Subfinder**
   - **Category**: Subdomain Discovery
   - **Description**: Returns valid subdomains for websites using passive online sources.
   - **Link**: [Subfinder on GitHub](https://github.com/projectdiscovery/subfinder)

3. **Assetfinder**
   - **Category**: Subdomain Discovery
   - **Description**: Finds domains and subdomains related to a given domain.
   - **Link**: [Assetfinder on GitHub](https://github.com/tomnomnom/assetfinder)

4. **Sub.sh**
   - **Category**: Subdomain Enumeration
   - **Description**: A script to detect subdomains using various methods and tools.
   - **Link**: [Sub.sh on GitHub](https://github.com/cihanmehmet/sub.sh)

---

### **Vulnerability Assessment Tools**

1. **Nuclei**
   - **Category**: Application Vulnerability Assessment
   - **Description**: Customizable vulnerability scanner using YAML templates.
   - **Link**: [Nuclei on GitHub](https://github.com/projectdiscovery/nuclei)

2. **CloudSploit**
   - **Category**: Cloud Security Posture Management
   - **Description**: Detects misconfigurations in cloud infrastructure accounts.
   - **Link**: [CloudSploit on GitHub](https://github.com/aquasecurity/cloudsploit)

3. **Trivy**
   - **Category**: Infrastructure Vulnerability Assessment
   - **Description**: Security scanner for containers, file systems, Git repositories, and more.
   - **Link**: [Trivy on GitHub](https://github.com/aquasecurity/trivy)

4. **TruffleHog3**
   - **Category**: Repository Vulnerability Assessment
   - **Description**: Scans Git repositories for secrets and sensitive data.
   - **Link**: [TruffleHog3 on GitHub](https://github.com/feeltheajf/trufflehog3)

5. **Dependency-Check**
   - **Category**: Dependency Vulnerability Assessment
   - **Description**: Detects vulnerabilities in project dependencies.
   - **Link**: [Dependency-Check on GitHub](https://github.com/jeremylong/DependencyCheck)

---

## **Learning Intention**

This project is intended to promote a better understanding of security posture tools and techniques. **Please use this environment responsibly and only with proper authorization.**

---

## **Acknowledgments**

This project includes open-source tools from various developers and communities who have contributed significantly to improving cybersecurity. Special thanks to their efforts and commitment to the field.

---

Let me know if you need any further modifications or additions to the README!
