#!/bin/bash

# SMTP 확인
if ps -ef | grep -v grep | grep -q sendmail; then
    # SMTP 서비스 사용
    if cat /etc/mail/sendmail.cf | grep -q "restrictqrun"; then
        # 실행 방지 적용
        result="양호"
    else
        # 실행 방지 미적용
        result="취약"
    fi
else
    # SMTP 서비스 미사용
    result="양호"
fi

echo "서비스 관리,U-32,일반사용자의 Sendmail 실행 방지,상,$result" >> linux_report.csv