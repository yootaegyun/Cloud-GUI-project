#!/bin/bash

# SUID/SGID 파일 검색
if [[ $(find / -xdev -user root -type f \( -perm -4000 -o -perm -2000 \) 2>/dev/null) ]]; then
  # 양호한 경우
  echo "파일 및 디렉토리 관리,U-14,SUID SGID Sticy bit 설정 파일 점검,상,양호" >> linux_report.csv
else
  # 취약한 경우
  echo "파일 및 디렉토리 관리,U-14,SUID SGID Sticy bit 설정 파일 점검,상,취약" >>  linux_report.csv
fi

if [ $? -ne 0 ]; then
  echo "파일 및 디렉토리 관리,U-14,SUID SGID Sticy bit 설정 파일 점검,상,N/A" >> linux_report.csv
fi
