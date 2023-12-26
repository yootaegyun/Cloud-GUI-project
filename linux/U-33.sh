#!/bin/bash


# DNS 서비스 확인
if [ $(ps -ef | grep named | grep -v grep | wc -l) -eq 0 ]; then
  # DNS 서비스 미사용
  result="양호"
else
  # DNS 서버 사용
  # 버전 확인
  bind_version=$(named -v | grep BIND | awk '{print $2}')

  # 최신 버전인지 확인
  latest_version=$(apt-cache showpkg bind9 | grep '^Version' | awk '{print $2}' | sort -V | tail -n1)

  if [ -n "$latest_version" ] && [ $(apt-get update > /dev/null 2>&1 && apt-cache policy bind9 | grep Installed | awk '{print $2}' | grep -c "$latest_version") -eq 1 ]; then
  # 최신일때
    result="양호"
  else
    # 최신이 아닐때
    result="취약"
  fi
fi

echo "서비스 관리,U-33,DNS 보안 버전 패치,상,$result" >> linux_report.csv