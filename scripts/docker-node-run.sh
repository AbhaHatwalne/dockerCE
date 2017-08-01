#!/bin/bash
{{$docker_reg_location :=getv "/env/docker_reg_location"}}
{{$docker_user :=getv "/env/docker_user"}}
{{$docker_pwd :=getv "/env/docker_pwd"}}
{{$docker_image :=getv "/env/docker_image"}}
{{$docker_tag :=getv "/env/docker_tag"}}
{{$docker_ns :=getv "/env/docker_ns"}}
{{$docker_port :=getv "/env/docker_port"}}
{{if eq $docker_reg_location "qingcloud"}}
docker login -u {{$docker_user}} -p {{$docker_pwd}} dockerhub.qingcloud.com
docker pull dockerhub.qingcloud.com/{{$docker_user}}/{{$docker_image}}:{{$docker_tag}} &
pull_pid=$!
wait pull_pid
docker run -d -e TZ=Asia/Shanghai -p {{$docker_port}} dockerhub.qingcloud.com/{{$docker_user}}/{{$docker_image}}:{{$docker_tag}}
{{else}}
docker login -u {{$docker_user}} -p {{$docker_pwd}}
docker pull {{$docker_image}}:{{$docker_tag}} &
pull_pid=$!
wait pull_pid
docker run -d -e TZ=Asia/Shanghai -p {{$docker_port}} {{$docker_image}}:{{$docker_tag}}
{{end}}