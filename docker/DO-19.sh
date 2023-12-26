#!/bin/bash

if [ ! -e "/var/run/docker.sock" ]; then
  echo "도커 데몬 설정 파일,DO-19,/var/run/docker.sock 파일 소유권 설정,상,N/A" >> docker_report.csv
exit
fi

docker_owner=$(stat -c %U:%G /var/run/docker.sock)

if [[ $docker_owner == "root:docker"  ]]; then
  docker_status="양호"
else
  docker_status="취약"
fi

echo "도커 데몬 설정 파일,DO-19,/var/run/docker.sock 파일 소유권 설정,상,$docker_status" >> docker_report.csv
