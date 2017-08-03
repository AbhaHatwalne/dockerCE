#!/bin/bash
systemctl daemon-reload
rsync -aqxP /var/lib/docker/ /data

systemctl start docker