#!/bin/bash
#is_running=`docker ps | awk '{print $1}' | grep -v 'none' | grep -iv 'container'`
#echo $is_running
if docker ps | awk '{print $1}' | grep -v 'none' | grep -iv 'container'
then
  #echo "0"
  exit 0
else
  #echo "1"
  exit 1
fi