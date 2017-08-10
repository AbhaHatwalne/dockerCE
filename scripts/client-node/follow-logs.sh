#!/bin/bash
docker ps | awk '{print $1}' | grep -v 'none' | grep -iv 'container' | xargs -n1 docker logs --follow
