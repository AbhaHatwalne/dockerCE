#!/bin/bash
if [ ! -d "/data/containers" ]
then
  exit 0
fi
mkdir -p /data/docker_data
