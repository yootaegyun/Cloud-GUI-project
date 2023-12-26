#!/bin/bash

# my.cnf 파일 경로 설정
my_cnf_path="/etc/mysql/my.cnf"

# my.cnf 파일이 없는 경우
if [ ! -f "$my_cnf_path" ]; then
  echo "my.cnf file not found. Vulnerable." >> /home/gyun/Desktop/sc/my-sql_report.csv
  exit
fi

# my.cnf 파일 접근 권한 확인 설정
# 파일의 권한을 변수에 할당, 640 이하면 양호
my_cnf_path=$(stat -c "%a" "$my_cnf_path")
if [ "$my_cnf_path" -le "640" ]; then
  result="양호"
else
  result="취약"
fi

#결과를 csv 파일에 저장
echo "보안설정,DY-06,환경설정 파일 접근 권한,중,$result" >> my-sql_report.csv
