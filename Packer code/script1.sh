#!/bin/bash
#NodeJS Dependencies
sudo apt update
sudo apt install net-tools -y
curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt install gcc make -y
sudo apt install nodejs -y
sudo npm install pm2@latest -g

# AmazonCloudWatch Agent
sudo apt update -y
sudo mkdir /tmp/cwa
cd /tmp/cwa
sudo wget https://s3.amazonaws.com/amazoncloudwatch-agent/linux/amd64/latest/AmazonCloudWatchAgent.zip -O AmazonCloudWatchAgent.zip
sudo apt install -y unzip
sudo unzip -o AmazonCloudWatchAgent.zip
sudo ./install.sh
sudo mkdir -p /usr/share/collectd/
sudo touch /usr/share/collectd/types.db 
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:/opt/aws/amazon-cloudwatch-agent/bin/config.json -s
/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -m ec2 -a status
# { 
# "status": "running", 
# "starttime": "2020-06-07T10:04:41+00:00", 
# "version": "1.245315.0" 
# }
systemctl status amazon-cloudwatch-agent.service

#AmazonCodeDeploy Agent
sudo apt update -y
sudo apt install ruby wget -y
cd /home/ubuntu
wget https://aws-codedeploy-ca-central-1.s3.ca-central-1.amazonaws.com/latest/install
sudo chmod +x ./install
sudo ./install auto

cd /home/ubuntu
git clone 
ls
cd node-express-realworld-example-app/
sudo npm install