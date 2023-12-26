#!/bin/bash

# /etc/shadow 파일이 있는지 확인
# 파일이 없는 경우 기록 후 스크립트 종료
if [ ! -f /etc/shadow ]; then
  echo "/etc/shadow file not found. Vulnerable" >> linux_report.csv
  exit 1
fi

# /etc/passwd 파일의 두 번째 필드에 "x"가 있는지 확인
# 실제 패스워드 정보는 /etc/shadow 파일에 저장, "x"일 경우, 분리해놓은 것으로 양호로 판단
if grep -q "^[^:]*:[x!]" /etc/passwd; then
  result="양호"

else
  result="취약"

fi


# 결과를 csv 파일에 저장
echo "계정관리,U-05,패스워드 파일 보호,상,$result" >> linux_report.csv
