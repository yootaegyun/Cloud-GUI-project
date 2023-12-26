#!/bin/bash

#패스워드가 사용자 이름과 같은 경우 또는 패스워드가 Null인 경우를 확인합니다

if mysql -u root -p$pass -e  "USE mysql;
SELECT host, user FROM user WHERE authentication_string='' OR authentication_string=user;" | grep -q '[^[:space:]]'; then
    echo "계정관리,DY-02,취약한 패스워드 사용제한,상,취약" >> my-sql_report.csv
else
    echo "계정관리,DY-02,취약한 패스워드 사용제한,상,양호" >> my-sql_report.csv
fi

