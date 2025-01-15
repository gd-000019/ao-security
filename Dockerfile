# Use Ubuntu as the base image
FROM ubuntu:22.04

# Set environment variables to avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Update and install required dependencies
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    python3 \
    python3-pip \
    nmap \
    libpcap-dev \
    build-essential \
    bash \
    unzip \
    npm \
    jq \
    parallel \
    && apt-get clean

# Add aocli script to the image
RUN pip3 install -r requirements.txt
COPY aocli.py /usr/local/bin/aocli.py
RUN chmod +x /usr/local/bin/aocli.py && ln -s /usr/local/bin/aocli.py /usr/local/bin/aocli

# Install wafw00f
RUN pip3 install wafw00f

# Install knock
RUN pip install knock-subdomains

# Install trufflehog3
RUN pip install trufflehog3

# Install dirsearch
RUN pip3 install dirsearch

# Install Go (download and set up environment variables)
RUN curl -LO https://go.dev/dl/go1.21.1.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go1.21.1.linux-amd64.tar.gz && \
    rm go1.21.1.linux-amd64.tar.gz

# Set Go environment variables
ENV GOPATH=/root/go
ENV PATH=$GOPATH/bin:/usr/local/go/bin:$PATH

# Install Amass
RUN go install -v github.com/owasp-amass/amass/v4/cmd/amass@latest && \
    ln -s /root/go/bin/amass /usr/local/bin/amass

# Install osmedeus
RUN go install -v github.com/j3ssie/osmedeus@latest  && \
    ln -s /root/go/bin/osmedeus /usr/local/bin/osmedeus

# Install subfinder
RUN go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest && \
    ln -s /root/go/bin/subfinder /usr/local/bin/subfinder

# Install assetfinder
RUN go install -v github.com/tomnomnom/assetfinder@latest && \
    ln -s /root/go/bin/assetfinder /usr/local/bin/assetfinder

# Install sub.sh
RUN git clone https://github.com/cihanmehmet/sub.sh.git /opt/sub.sh && \
    chmod +x /opt/sub.sh/sub.sh && \
    cd /opt/sub.sh && \
    ln -s /opt/sub.sh/sub.sh /usr/local/bin/subsh

# Install katana
RUN go install github.com/projectdiscovery/katana/cmd/katana@latest && \
    ln -s /root/go/bin/katana /usr/local/bin/katana

# Install nuclei
RUN go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest && \
    ln -s /root/go/bin/nuclei /usr/local/bin/nuclei

# Install dalfox
RUN go install github.com/hahwul/dalfox/v2@latest && \
    ln -s /root/go/bin/dalfox /usr/local/bin/dalfox

# Install gowitness
RUN go install github.com/sensepost/gowitness@latest && \
ln -s /root/go/bin/gowitness /usr/local/bin/gowitness

# Install httpx
RUN go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest && \
    ln -s /root/go/bin/httpx /usr/local/bin/httpx

# Install cloudsploit
RUN git clone https://github.com/aquasecurity/cloudsploit.git /opt/cloudsploit && \
    cd /opt/cloudsploit && \
    npm install && \
    ln -s /opt/cloudsploit/index.js /usr/local/bin/cloudsploit



# Install DependencyCheck
RUN wget https://github.com/jeremylong/DependencyCheck/releases/download/v8.4.0/dependency-check-8.4.0-release.zip -O dependency-check.zip && \
    unzip dependency-check.zip -d /opt/dependency-check && \
    ln -s /opt/dependency-check/bin/dependency-check.sh /usr/local/bin/dependency-check && \
    rm dependency-check.zip

# Install trivy
RUN curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh -s -- -b /usr/local/bin

# Create a reports folder with appropriate permissions
RUN mkdir -p /home/reports && chmod 777 /home/reports


# Set the entry point for interactive use of the tools
ENTRYPOINT ["/bin/bash"]
