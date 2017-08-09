#!/bin/bash
docker_user=$1
docker_pwd=$2
docker_url=$3

function docker_login(){
  docker login -u $docker_user -p $docker_pwd $docker_url
}
function verify_login(){
  login_attempt=3
  login_succeed=false
  while [ "$login_attempt" -gt 0 ]
  do
    if docker_login
    then
      login_succeed=true
      break
    else
      login_attempt=$[$login_attempt-1]
    fi
  done
  if [ $login_succeed == "false" ]
  then
    #echo "fail to login"
    exit 1
  fi
}