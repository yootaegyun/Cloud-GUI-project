#!/bin/bash

# mysql_report.csv 파일을 생성하거나 덮어쓰기 합니다.
echo "구분,진단코드,진단항목,취약도,점검결과" > my-sql_report.csv

# mysql에 접속하여 user 테이블에서 불필요한 계정이 있는지 확인합니다.
# 불필요한 계정이 있는 경우 취약하다는 결과를 출력합니다.
# 불필요한 계정이 없는 경우 양호하다는 결과를 출력합니다.
if mysql -u root -p$pass -e "USE mysql; SELECT host, user FROM user WHERE user NOT IN ('mysql.sys','root','mysql.session','mysql.infoschema');" | grep -q '[^[:space:]]'; then
    echo "계정관리,DY-01,불필요한 계정 제거,중,취약" >> my-sql_report.csv
else
    echo "계정관리,DY-01,불필요한 계정 제거,중,양호" >> my-sql_report.csv
fi
