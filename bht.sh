#!/bin/bash
apt update && apt install -y unzip jq curl git && mkdir -p /root/bughunting
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip && rm -rf awscliv2.zip
sudo ./aws/install
git clone https://github.com/satyasai1460/BHA.git
git clone https://github.com/netsecurity-as/subfuz
git clone https://github.com/satyasai1460/My-Cool-WordList-For-Fuzz-and-Bugs.git
cp /My-Cool-WordList-For-Fuzz-and-Bugs/fuzz.txt /root
cp /subfuz/subdomain_megalist.txt /root
cp /BHA/s3.txt /root/
cd /BHA && chmod 777 *
cd /BHA && ./go-lang-tool.sh
source ~/.bashrc
cp /BHA/striker /BHA/bhtools /usr/local/bin
cat /BHA/alias.txt >>~/.bashrc
sudo bhtools
echo "* * * * * sudo sh -c 'echo 3 > /proc/sys/vm/drop_caches'" | crontab -
