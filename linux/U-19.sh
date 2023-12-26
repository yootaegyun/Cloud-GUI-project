#!/bin/bash

crontab_owner=$(stat -c %U /etc/crontab)
crontab_permission=$(stat -c %a /etc/crontab)

if [[ $crontab_owner == "root" && $crontab_permission -le 640 ]]; then
  crontab_status="양호"
else
  crontab_status="취약"
fi

echo -e "파일 및 디렉토리 관리,U-19,cron 파일 소유자 및 권한 설정,상,$crontab_status" >> linux_report.csv
