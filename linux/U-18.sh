#!/bin/bash

# CSV 파일 경로
csv_file="$HOME/ip_port.csv"

# CSV 파일 존재 확인
if [ ! -f "$csv_file" ]; then
  echo "파일 및 디렉토리 관리,U-18,접속 IP 및 포트 제한,상,N/A" >> linux_report.csv
  exit 1
fi

# CSV 파일 읽기
while IFS=, read -r ip_number port_number; do
  # /etc/hosts.deny 파일에 ALL: ALL 설정이 되어 있는지 확인
  if grep -q "^[[:space:]]*ALL[[:space:]]*:[[:space:]]*ALL[[:space:]]*$" /etc/hosts.deny; then
    result="취약"
  else
    # iptables가 설치되어 있는지 확인
    if ! [ -x "$(command -v iptables)" ]; then
      echo "파일 및 디렉토리 관리,U-18,접속 IP 및 포트 제한,상,N/A" >&2
      exit 1
    fi

    # 특정 호스트를 허용하는 iptables 규칙이 있는지 확인
    if iptables -C INPUT -m state --state NEW -m tcp -p tcp -s $ip_number --dport $port_number -j ACCEPT &> /dev/null; then
      result="양호"
    else
      result="취약"
    fi
  fi

  # 결과를 csv 파일에 저장
  echo "파일 및 디렉토리 관리,U-18,접속 IP 및 포트 제한,상,$result" >> linux_report.csv
done < "$csv_file"
