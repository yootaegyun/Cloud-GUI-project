#!/bin/bash

# 파일 경로 확인
debian_file_path="/etc/default/docker"
redhat_file_path="/etc/sysconfig/docker"

# 소유자 및 소유 그룹 확인
debian_ownership=""
redhat_ownership=""

# Debian 계열 파일 소유권 확인
if [[ -f "$debian_file_path" ]]; then
  debian_ownership=$(stat -c %U:%G "$debian_file_path")
fi

# RedHat 계열 파일 소유권 확인
if [[ -f "$redhat_file_path" ]]; then
  redhat_ownership=$(stat -c %U:%G "$redhat_file_path")
fi

# 결과 값 설정
if [[ -z "$debian_ownership" && -z "$redhat_ownership" ]]; then
  result="N/A"
else
  if [[ $debian_ownership == "root:root" || $redhat_ownership == "root:root" ]]; then
    result="양호"
  else
    result="취약"
  fi
fi

# 결과 출력
echo "도커 데몬 설정 파일,DO-23,/etc/default.docker 파일 소유권 설정,상,$result" >> docker_report.csv
