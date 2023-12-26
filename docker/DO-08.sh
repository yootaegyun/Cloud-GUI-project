#!/bin/bash

# auditd가 설치되었는지 확인합니다
if ! dpkg -s auditd &> /dev/null
then
    echo "Host설정,DO-08,/etc/default/docker audit 설정,상,N/A" >> docker_report.csv

  exit
fi

else
    # 도커에 대한 감사 규칙이 있는지 확인합니다
    if grep -q "/etc/default/docker" /etc/audit/audit.rules
    then
        result="양호"
    else
        result="취약"
    fi
fi

# 결과를 csv 파일에 저장
echo "Host설정,DO-08,/etc/default/docker audit 설정,상,$result" >> docker_report.csv
