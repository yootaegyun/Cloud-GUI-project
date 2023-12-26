#!/bin/bash

if [ ! -f "/var/run/docker.sock" ]; then
  echo "도커 데몬 설정 파일,DO-20,/var/run/docker.sock 접근권한 설정,상,N/A" >> docker_report.csv
exit
fi

docker_permission=$(stat -c %a /var/run/docker.sock)

if [[ $docker_permission -le 660 ]]; then
  docker_status="양호"
else
  docker_status="취약"
fi

echo "도커 데몬 설정 파일,DO-20,/var/run/docker.sock 접근권한 설정,상,$docker_status" >> docker_report.csv
