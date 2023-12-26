#!/bin/bash

# auditd가 설치되었는지 확인합니다
if ! dpkg -s auditd &> /dev/null
then
    echo "Host설정,DO-07,docker.socket audit 설정,상,N/A" >> docker_report.csv

  exit
fi

# docker.socket 파일의 경로를 확인합니다
docker_socket_path=$(systemctl show -p FragmentPath docker.socket | cut -d'=' -f2)

# docker.socket 파일의 감사 설정을 확인합니다
audit_enabled=$(grep "$docker_socket_path" /etc/audit/audit.rules)

if [ -n "$audit_enabled" ]; then
  result="양호"
else
  result="취약"
fi

echo "Host설정,DO-07,docker.socket audit 설정,상,$result" >> docker_report.csv
