#!/bin/bash

# --disable-legacy-registry 옵션이 사용 가능한지 확인합니다
ps -ef | grep docker | grep -- --disable-legacy-registry > /dev/null
if [ $? -eq 0 ]; then
  result="양호"
else
 # /etc/default/docker에서 --disable-legacy-registry 옵션이 구성되어 있는지 확인합니다
  grep -- "--disable-legacy-registry" /etc/default/docker > /dev/null
  if [ $? -eq 0 ]; then
    result="양호"
  else
    result="취약"
  fi
fi

echo "도커 데몬 설정,DO-11,legacy registry (v1) 비활성화,하,$result" >> docker_report.csv 
