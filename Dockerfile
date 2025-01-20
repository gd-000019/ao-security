# Use Alpine as the base image
FROM debian:bullseye-slim

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV GOPATH=/root/go
ENV PATH=$GOPATH/bin:/usr/local/go/bin:/opt/venv/bin:$PATH

# Update and install required dependencies
RUN apt-get update && apt-get install -y \
    bash \
    curl \
    wget \
    git \
    python3 \
    python3-pip \
    python3-venv \
    nmap \
    libpcap-dev \   
    jq \
    gawk \
    build-essential \
    parallel \
    bind9-dnsutils \
    unzip \
    chromium \
    npm && \
    apt-get clean

# Create a Python virtual environment and install Python dependencies
COPY requirements.txt /requirements.txt
RUN python3 -m venv /opt/venv && \
    . /opt/venv/bin/activate && \
    pip install --upgrade pip && \
    pip install -r /requirements.txt && \
    deactivate

# Add custom CLI script to the image
COPY aocli.py /usr/local/bin/aocli
RUN chmod +x /usr/local/bin/aocli
# Remove chars
RUN sed -i 's/\r$//' /usr/local/bin/aocli

# Install additional Python tools
RUN pip3 install wafw00f knock-subdomains trufflehog3 dirsearch

# Install Go (and set up environment variables)
RUN curl -LO https://go.dev/dl/go1.21.1.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go1.21.1.linux-amd64.tar.gz && \
    rm go1.21.1.linux-amd64.tar.gz

# Install Go-based tools
RUN go install -v github.com/owasp-amass/amass/v4/cmd/amass@latest && \
    go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest && \
    go install -v github.com/tomnomnom/assetfinder@latest && \
    go install -v github.com/projectdiscovery/katana/cmd/katana@latest && \
    go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest && \
    go install github.com/hahwul/dalfox/v2@latest && \
    go install github.com/sensepost/gowitness@latest && \
    go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest && \
    go install -v github.com/j3ssie/osmedeus@latest && \
    ln -s /root/go/bin/* /usr/local/bin/

# Install Sudomy
RUN git clone --recursive https://github.com/screetsec/Sudomy.git /opt/Sudomy && \
    python3 -m pip install -r /opt/Sudomy/requirements.txt && \
    cp /opt/Sudomy/sudomy.conf /usr/local/bin/sudomy.conf && \
    cp /opt/Sudomy/sudomy.api.dist /usr/local/bin/sudomy.api && \
    ln -s /opt/Sudomy/sudomy /usr/local/bin/sudomy

# Install Node.js tools
RUN npm install -g wappalyzer wscat

# Install additional tools and utilities
RUN git clone https://github.com/cihanmehmet/sub.sh.git /opt/sub.sh && \
    chmod +x /opt/sub.sh/sub.sh && \
    ln -s /opt/sub.sh/sub.sh /usr/local/bin/subsh && \
    git clone https://github.com/aquasecurity/cloudsploit.git /opt/cloudsploit && \
    cd /opt/cloudsploit && \
    npm install && \
    ln -s /opt/cloudsploit/index.js /usr/local/bin/cloudsploit && \
    wget https://github.com/jeremylong/DependencyCheck/releases/download/v8.4.0/dependency-check-8.4.0-release.zip -O dependency-check.zip && \
    unzip dependency-check.zip -d /opt/dependency-check && \
    ln -s /opt/dependency-check/bin/dependency-check.sh /usr/local/bin/dependency-check && \
    rm dependency-check.zip

# Install Trivy
RUN curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh -s -- -b /usr/local/bin

# Create a reports folder with appropriate permissions
RUN mkdir -p /home/reports && chmod 777 /home/reports

# Set entry point
ENTRYPOINT ["/bin/bash"]
