#!/bin/bash

# neutron.conf 파일 경로 설정
neutron_conf_path="/etc/neutron/neutron.conf"

# neutron.conf 파일이 없는 경우
if [ ! -f "$neutron_conf_path" ]; then
  echo "neutron.conf file not found. Vulnerable." >> openstack_report.csv
  exit
fi

# neutron.conf 파일에서 use_ssl 설정값 추출
use_ssl=$(grep "^use_ssl" ${neutron_conf_path} | awk -F= '{print $2}' | tr -d ' ')

# use_ssl 매개변수 확인
if [ "$use_ssl" = "True" ]; then
    result="양호"
else
    result="취약"
fi

# 결과를 csv 파일에 저장
echo "암호화,OT-29,Neutron API 서버의 TLS 활성화,상,$result" >> openstack_report.csv
