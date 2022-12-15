#!/bin/bash
sudo apt update #Nodejs Dependencies
sudo apt install nodejs -y
sudo apt install npm -y
sudo npm install pm2 -g && pm2 update -y
sudo apt install net-tools -y

sudo apt update -y
sudo apt install ruby wget -y
cd /home/ubuntu
wget https://aws-codedeploy-us-west-2.s3.region-identifier.amazonaws.com/latest/install
sudo chmod +x ./install
sudo ./install auto

sudo apt update -y
sudo mkdir /tmp/cwa
cd /tmp/cwa
sudo wget https://s3.amazonaws.com/amazoncloudwatch-agent/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb
sudo dpkg -i -E ./amazon-cloudwatch-agent.deb





