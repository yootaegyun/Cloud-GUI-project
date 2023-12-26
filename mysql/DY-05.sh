#!/bin/bash

# my.cnf 파일 경로
my_cnf_path="/etc/mysql/my.cnf"

# my.cnf 파일에서 user 설정값 추출
MYSQL_USER=$(grep "^user" ${my_cnf_path} | awk -F= '{print $2}' | tr -d ' ')

# MySQL 데몬이 root 계정으로 실행중인지 확인
if [ "$(ps -ef | grep mysqld | grep -c "user=root")" -gt 0 ]; then
    result="취약"
else
    result="양호"
fi

# 결과를 csv 파일에 저장
echo "보안설정,DY-05,root 권한으로 서버 구동 제한,상,$result" >> my-sql_report.csv
