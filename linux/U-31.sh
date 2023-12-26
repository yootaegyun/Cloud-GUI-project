#!/bin/bash

# SMTP 사용여부
if ps -ef | grep sendmail | grep -v "grep" > /dev/null; then
    # SMTP 사용할때 릴레이 제한 설정 확인
    if cat /etc/mail/sendmail.cf | grep "R$ \*" | grep "Relaying denied" > /dev/null; then
        # 릴레이 제한 설정 O
        result="양호"
    else
        # 릴레이 제한 설정 X
        result="취약"
    fi
else
    # SMTP 미사용
    result="양호"
fi

# 저장

echo "서비스 관리,U-31,스팸 메일 릴레이 제한,상,$result" >> linux_report.csv