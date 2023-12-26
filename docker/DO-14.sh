#!/bin/bash

if [ ! -f "/lib/systemd/system/docker.service" ]; then
  echo "도커 데몬 설정 파일,DO-14,docker.service 파일 접근권한 설정,상,N/A" >> docker_report.csv
exit
fi

docker_permission=$(stat -c %a /lib/systemd/system/docker.service)

if [[ $docker_permission -le 644 ]]; then
  docker_status="양호"
else
  docker_status="취약"
fi

echo "도커 데몬 설정 파일,DO-14,docker.service 파일 접근권한 설정,상,$docker_status" >> docker_report.csv
