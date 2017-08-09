#!/bin/bash

node_type=$1

apt-get update

apt-get install -y \
    linux-image-extra-$(uname -r) \
    linux-image-extra-virtual

apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
apt-get update
apt-get install -y docker-ce
groupadd docker
usermod -aG docker $USER

cd /opt
echo "install qing agent"
curl -o agent.tar.gz https://pek3a.qingstor.com/appcenter/developer/packages/app-agent-linux-amd64.tar.gz
tar -xvf agent.tar.gz
cd /opt/app-agent-linux-amd64/
./install.sh
rm -rf /opt/agent.tar.gz
cd /opt

cat << EOF > /etc/sysctl.conf
vm.max_map_count=262144
fs.file-max=200000
fs.inotify.max_user_watches=1048576
EOF

sysctl -p

sudo systemctl disable docker

sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config

echo "modify ulimit"
mv /etc/security/limits.conf /etc/security/limits.conf_bak
cp /opt/docker_app/data/limits.conf /etc/security

tar -xvf dockerCE.tar.gz

if [ $node_type=="docker" ]
then
  cp -r /opt/dockerCE/code/docker-node/* /etc/confd/
  cp -r /opt/dockerCE/script/*.sh /opt/docker/bin/
  cp -r /opt/dockerCE/script/docker-node/*.sh /opt/docker/bin/
  chmod +x /opt/docker/bin/*.sh
else
  cp -r /opt/dockerCE/code/client-node/* /etc/confd/
  cp -r /opt/dockerCE/script/*.sh /opt/docker/bin/
  cp -r /opt/dockerCE/script/client-node/*.sh /opt/docker/bin/
  chmod +x /opt/docker/bin/*.sh
fi
