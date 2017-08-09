#!/bin/bash
systemctl daemon-reload
#if [ -d /var/lib/docker ]
#then
#  rsync -aqxP /var/lib/docker/ /data
#fi
mkdir -p /data/docker_data
systemctl start docker
rsync -aqxP /var/lib/docker/ /data/var/lib/docker
systemctl restart docker