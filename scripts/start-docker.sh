#!/bin/bash
systemctl daemon-reload
if [ -d /var/lib/docker ]
then
  rsync -aqxP /var/lib/docker/ /data
fi
systemctl start docker