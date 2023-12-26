#!/bin/bash
 
# mysql.user 테이블 접근이 가능한 사용자 조회
user_access=$(mysql -u root -p$pass -e "SELECT user FROM mysql.user WHERE user='root';" | grep -o 'root')

# 해당 사용자가 존재하면 권한을 확인
if [ "$user_access" == "root" ]; then
  # root 사용자의 권한 확인
  user_priv=$(mysql -e "SELECT * FROM mysql.user WHERE user='root' AND host='localhost';" | grep -o 'ALL PRIVILEGES')

  if [ "$user_priv" == "ALL PRIVILEGES" ]; then
    result="양호"
  else
    result="취약"
  fi
else
  # 해당 사용자가 없으면 취약
  result="취약"
fi
 
# 결과를 csv 파일에 저장


# 결과를 csv 파일에 저장
echo "계정관리,DY-04,DB 사용자 계정 정보 테이블 접근 권한,중,$result" >> my-sql_report.csv
