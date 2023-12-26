#!/bin/bash

if [ ! -f "/lib/systemd/system/docker.socket" ]; then
  echo "도커 데몬 설정 파일,DO-15,docker.socket 소유권 설정,상,N/A" >> docker_report.csv
exit
fi

docker_owner=$(stat -c %U:%G /lib/systemd/system/docker.socket)

if [[ $docker_owner == "root:root"  ]]; then
  docker_status="양호"
else
  docker_status="취약"
fi

echo "도커 데몬 설정 파일,DO-15,docker.socket 소유권 설정,상,$docker_status" >> docker_report.csv
