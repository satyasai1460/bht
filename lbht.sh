#!/bin/bash

# Log file location
LOG_FILE="/tmp/bht.log"

# Start logging both stdout and stderr
exec > >(tee -a "$LOG_FILE") 2>&1

echo "=== Script started at $(date) ==="

# Update and install dependencies
echo "[*] Updating packages and installing dependencies..."
apt update && apt install -y unzip jq curl git

# Create working directory
mkdir -p /root/bughunting

# Download AWS CLI
echo "[*] Downloading AWS CLI..."
cd /root && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

# Unzip and install AWS CLI
echo "[*] Installing AWS CLI..."
cd /root && unzip awscliv2.zip && rm -rf awscliv2.zip
cd /root && sudo ./aws/install

# Clone repositories
echo "[*] Cloning repositories..."
cd /root && git clone https://github.com/satyasai1460/BHA.git
cd /root && git clone https://github.com/netsecurity-as/subfuz
cd /root && git clone https://github.com/satyasai1460/My-Cool-WordList-For-Fuzz-and-Bugs.git

# Copy important files
echo "[*] Copying wordlists and files..."
cp /root/My-Cool-WordList-For-Fuzz-and-Bugs/fuzz.txt /root
cp /root/subfuz/subdomain_megalist.txt /root
cp /root/BHA/s3.txt /root/

# Set permissions and run scripts
echo "[*] Setting permissions and running BHA tools setup..."
cd /root/BHA && chmod 777 *
cd /root/BHA && ./go-lang-tool.sh

# Update bashrc and reload
echo "[*] Updating bashrc..."
cat /root/BHA/alias.txt >>~/.bashrc
source ~/.bashrc

# Move executables
echo "[*] Moving executables to /usr/local/bin..."
cp /root/BHA/striker /root/BHA/bhtools /usr/local/bin

# Start bhtools
echo "[*] Running bhtools..."
sudo bhtools

# Add cron job for dropping caches
echo "[*] Adding cron job to drop caches every minute..."
echo "* * * * * sudo sh -c 'echo 3 > /proc/sys/vm/drop_caches'" | crontab -

echo "=== Script finished at $(date) ==="
