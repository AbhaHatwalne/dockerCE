#!/bin/bash
echo "install qing agent"
curl -o agent.tar.gz https://pek3a.qingstor.com/appcenter/developer/packages/app-agent-linux-amd64.tar.gz
tar -xvf agent.tar.gz
cd /opt/app-agent-linux-amd64/
./install.sh
rm -rf agent.tar.gz
cd /opt

echo "instal rsync"
yum install -y rsync

echo "modify ulimit"
mv /etc/security/limits.conf /etc/security/limits.conf_bak
cp /opt/docker_app/data/limits.conf /etc/security


echo "install docker CE"
yum install -y yum-utils device-mapper-persistent-data lvm2

yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

yum makecache fast

yum install -y docker-ce

