#!/bin/bash
if [ ! -d "/data/var/lib/docker/containers" ]
then
  exit 0
fi
mkdir -p /data/docker_data
