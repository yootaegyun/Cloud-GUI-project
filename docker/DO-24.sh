#!/bin/bash

# 파일 경로 확인
debian_file_path="/etc/default/docker"
redhat_file_path="/etc/sysconfig/docker"

# 접근 권한 확인
result=""

# Debian 계열 파일 접근 권한 확인
if [[ -f "$debian_file_path" ]]; then
  debian_permission=$(stat -c %a "$debian_file_path")
else
  result="N/A"
fi

# RedHat 계열 파일 접근 권한 확인
if [[ -f "$redhat_file_path" ]]; then
  redhat_permission=$(stat -c %a "$redhat_file_path")
else
  result="N/A"
fi

# 결과 값 설정
if [[ -z "$result" ]]; then
  if [[ $debian_permission -le 644 || $redhat_permission -le 644 ]]; then
    result="양호"
  else
    result="취약"
  fi
fi

# 결과 출력
echo "도커 데몬 설정 파일,DO-24,/etc/default.docker 파일 접근권한 설정,상,$result" >> docker_report.csv