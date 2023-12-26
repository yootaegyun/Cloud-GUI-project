#!/bin/bash

if [ ! -d "/etc/docker" ]; then
  echo "도커 데몬 설정 파일,DO-18,/etc/docker 디렉터리 접근권한 설정,상,N/A" >> docker_report.csv
exit
fi

docker_permission=$(stat -c %a /etc/docker)

if [[ $docker_permission -le 755 ]]; then
  docker_status="양호"
else
  docker_status="취약"
fi

echo "도커 데몬 설정 파일,DO-18,/etc/docker 디렉터리 접근권한 설정,상,$docker_status" >> docker_report.csv
