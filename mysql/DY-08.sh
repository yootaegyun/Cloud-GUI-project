#!/bin/bash

# General log 설정 확인
general_log=$(mysql -u root -p$pass -e "show variables like 'general_log%';" | grep -c "general_log.*ON\|general_log.*1")
# Slow Query 설정 확인
slow_query_log=$(mysql -u root -p$pass -e "show variables like 'slow_query_log%';" | grep -c "slow_query_log.*ON")

if [ $general_log -eq 1 ]; then
  if [ $slow_query_log -eq 1 ]; then
    result="양호"
  else
    result="취약"
fi
else
  result="취약"
fi

echo "패치 및 로그관리,DY-08,로그 활성화,상,$result" >> my-sql_report.csv