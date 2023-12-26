#!/bin/bash

# grant_priv을 부여 받은 사용자 조회
if mysql -u root -p$pass -e "USE mysql; SELECT host, user, Grant_priv FROM user WHERE Grant_priv='Y'" | grep -q '[^[:space:]]'; then
    echo "계정관리,DY-03,타사용자에 권한 부여 옵션 사용제한,중,취약" >> my-sql_report.csv
else
    echo "계정관리,DY-03,타사용자에 권한 부여 옵션 사용제한,중,양호" >> my-sql_report.csv
fi
