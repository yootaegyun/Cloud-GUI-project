#!/bin/bash

if [[ -z $(docker ps --quiet --all) ]]; then
	echo "도커 데몬 설정,DO-12,추가 권한 획득으로부터 컨테이너 제한,상,N/A" >> docker_report.csv
	exit 0
fi

if docker ps --quiet --all | xargs docker inspect --format '{{ .Id }}: SecurityOpt={{ .HostConfig.SecurityOpt }}' | grep -q "SecurityOpt=<no value>"; then
  echo "도커 데몬 설정,DO-12,추가 권한 획득으로부터 컨테이너 제한,상,양호" >> docker_report.csv
else
  echo "도커 데몬 설정,DO-12,추가 권한 획득으로부터 컨테이너 제한,상,취약" >> docker_report.csv
fi
