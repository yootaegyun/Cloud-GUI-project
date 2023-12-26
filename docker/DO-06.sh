#!/bin/bash

# auditd가 설치되었는지 확인합니다
if ! dpkg -s auditd &> /dev/null
then
    echo "Host설정,DO-06,docker.service audit 설정,상,N/A" >> docker_report.csv

  exit
fi

# 도커 서비스 파일 경로
docker_service_path="/lib/systemd/system/docker.service"

# docker.service 파일이 있는지 확인합니다
if [ ! -f $docker_service_path ]; then
  result="취약"
else
  # docker.service 파일의 감사 설정을 확인합니다
  audit=$(grep -i "audit" $docker_service_path)
  if [ -z "$audit" ]; then
    result="취약"
  else
   # 감사 규칙 파일 내용 확인
    audit_rule=$(grep -i "docker.service" /etc/audit/audit.rules)
    if [ -z "$audit_rule" ]; then
      result="취약"
    else
      result="양호"
    fi
  fi
fi

echo "Host설정,DO-06,docker.service audit 설정,상,$result" >> docker_report.csv
