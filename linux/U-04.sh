#!/bin/bash

# /etc/login.defs 파일에서 패스워드 최대 사용 기간의 설정 값을 확인
# PASS_MAX_DAYS 값에 해당하는 라인을 찾아서 awk 이용하여 값 추출 후 password_max_age 변수에 저장
password_max_age=$(grep "^PASS_MAX_DAYS" /etc/login.defs | awk '{print $2}')

# 패스워드 최대 사용 기간이 90일 이내로 설정되어 있는 경우 양호
if [[ $password_max_age -le 90 ]]; then
    result="양호"
else
    result="취약"
fi

# 결과를 csv 파일에 저장
echo "계정관리,U-04,패스워드 최대 사용 기간 설정,중,$result" >> linux_report.csv
