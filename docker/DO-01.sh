#!/bin/bash

# Docker 설치 유무 확인
if [ ! $(which docker) ]; then
  echo "Docker is not installed. Please install Docker."
  exit 1
fi

# Docker 버전 확인
docker_version=$(docker version --format '{{.Server.Version}}')

# 알려진 취약점 존재 여부 확인
if echo "$docker_version" | grep -qE "^1\.13|^17\.03|^17\.06|^17\.09\.0|^18\.03\.0-ce"; then
  result="취약"
else
  result="양호"
fi

# 결과를 csv 파일에 저장
echo "구분,진단코드,진단항목,취약도,점검결과" > docker_report.csv
echo "Host설정,DO-01,도커 최신 패치 적용,상,$result" >> docker_report.csv
