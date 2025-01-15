# AO Security Posture Project

<img src="logo.jpeg" alt="AO Security Posture Logo" width="200" height="200">

This project provides a Docker-based environment for running multiple security tools for reconnaissance, subdomain enumeration, and vulnerability assessment. It is designed for ethical use and learning purposes only.

---

## **Setup Instructions**

### **1. Build the Docker Image**
To build the Docker image from the Dockerfile:
```bash
docker build -t ao-security-posture --platform=linux/amd64 .
```
Adding the `--platform=linux/amd64` flag ensures compatibility on systems like macOS running on ARM architecture (e.g., Apple M1/M2 chips).

### **2. Rebuild the Image Without Cache**
To rebuild the image and ignore cached layers:
```bash
docker build --no-cache -t ao-security-posture --platform=linux/amd64 .
```

### **3. Run the Container**
To start a container interactively:
```bash
docker run -it --name ao-security-container ao-security-posture
```

To start the container in detached mode:
```bash
docker run -dit --name ao-security-container ao-security-posture
```

### **4. Enter the Container**
To access the running container:
```bash
docker exec -it ao-security-container /bin/bash
```

### **5. Run Tools or Scripts**
To run a specific tool directly, for example, `httprobe`:
```bash
docker run --rm ao-security-posture httprobe -h
```

To execute commands from outside the container:
```bash
docker exec -it ao-security-container cdncheck -i api.safeops.io -j -o /home/reports/api.safeops.io-cdncheck.json
```

### **6. Use the AO CLI**
The `aocli.py` script is included for streamlined scanning. It runs domain-related tools and aggregates their outputs into a single JSON file.

#### **Usage**
```bash
aocli -d example.com -o /home/reports/output.json
```
Options:
- `-d`: Specify the domain to scan.
- `-o`: Specify the output file for aggregated results (default: `/home/reports/aggregated_output.json`).
- `--exclude`: Exclude specific tools from the scan (e.g., `--exclude nuclei subfinder`).

---

## **Tools Included**

### **Reconnaissance Tools**
1. **Naabu**: Port scanning tool ([GitHub](https://github.com/projectdiscovery/naabu)).
2. **Httprobe**: HTTP/HTTPS probing ([GitHub](https://github.com/tomnomnom/httprobe)).
3. **CDNCheck**: DNS/IP network technology detection ([GitHub](https://github.com/projectdiscovery/cdncheck)).
4. **WafW00f**: Web Application Firewall detection ([GitHub](https://github.com/EnableSecurity/wafw00f)).
5. **Katana**: Web crawler ([GitHub](https://github.com/projectdiscovery/katana)).
6. **Dirsearch**: Web path brute-forcer ([GitHub](https://github.com/maurosoria/dirsearch)).

### **Subdomain Enumeration Tools**
1. **Amass**: Subdomain discovery ([GitHub](https://github.com/owasp-amass/amass)).
2. **Subfinder**: Passive subdomain discovery ([GitHub](https://github.com/projectdiscovery/subfinder)).
3. **Assetfinder**: Subdomain finder ([GitHub](https://github.com/tomnomnom/assetfinder)).
4. **Sub.sh**: Subdomain detection script ([GitHub](https://github.com/cihanmehmet/sub.sh)).

### **Vulnerability Assessment Tools**
1. **Nuclei**: Vulnerability scanner ([GitHub](https://github.com/projectdiscovery/nuclei)).
2. **CloudSploit**: Cloud configuration security scanner ([GitHub](https://github.com/aquasecurity/cloudsploit)).
3. **Trivy**: Security scanner for infrastructure ([GitHub](https://github.com/aquasecurity/trivy)).
4. **TruffleHog3**: Repository vulnerability scanner ([GitHub](https://github.com/feeltheajf/trufflehog3)).
5. **Dependency-Check**: Dependency vulnerability scanner ([GitHub](https://github.com/jeremylong/DependencyCheck)).

---

## **Advanced Examples**

### **Running with Custom Scans**
To exclude specific tools while scanning:
```bash
aocli -d example.com -o /home/reports/output.json --exclude subfinder nuclei
```

### **Running Individual Tools**
Run `nuclei` directly:
```bash
docker exec -it ao-security-container nuclei -u example.com -json -o /home/reports/example-nuclei.json
```

Run `subfinder` directly:
```bash
docker exec -it ao-security-container subfinder -d example.com -o /home/reports/example-subfinder.json
```

---

## **Learning Intent**
This project is built for learning and demonstrating capabilities in security posture assessment. Use it responsibly and ethically.

---

## **Acknowledgments**
Special thanks to all open-source contributors whose tools make this project possible.

---

