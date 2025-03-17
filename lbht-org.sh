#!/bin/bash
apt update && apt install -y unzip jq curl git && mkdir -p /root/bughunting
cd /root && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
cd /root && unzip awscliv2.zip && rm -rf awscliv2.zip
cd /root && sudo ./aws/install
cd /root && git clone https://github.com/satyasai1460/BHA.git
cd /root && git clone https://github.com/netsecurity-as/subfuz
cd /root && git clone https://github.com/satyasai1460/My-Cool-WordList-For-Fuzz-and-Bugs.git
cp /root/My-Cool-WordList-For-Fuzz-and-Bugs/fuzz.txt /root
cp /root/subfuz/subdomain_megalist.txt /root
cp /root/BHA/s3.txt /root/
cd /root/BHA && chmod 777 *
cd /root/BHA && ./go-lang-tool.sh
source ~/.bashrc
cp /root/BHA/striker /root/BHA/bhtools /usr/local/bin
cat /root/BHA/alias.txt >>~/.bashrc
sudo bhtools
echo "* * * * * sudo sh -c 'echo 3 > /proc/sys/vm/drop_caches'" | crontab -
