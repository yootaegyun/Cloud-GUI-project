#!/bin/bash

# world writable 파일 검색
result=""
if [[ $(find / -xdev -type f -perm -o+w 2>/dev/null) ]]; then
  # 취약한 경우
  result="취약"
else
  # 양호한 경우
  result="양호"
fi

# 결과에 따라 리포트 파일에 추가
if [ "$result" == "양호" ]; then
  echo "파일 및 디렉토리 관리,U-16,world writable 파일 점검,상,$result" >> linux_report.csv
elif [ "$result" == "취약" ]; then
  echo "파일 및 디렉토리 관리,U-16,world writable 파일 점검,상,$result" >> linux_report.csv
else
  echo "파일 및 디렉토리 관리,U-16,world writable 파일 점검,상,N/A" >> linux_report.csv
fi
