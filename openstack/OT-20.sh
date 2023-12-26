#!/bin/bash

# Check if auth_uri starts with https:// and insecure is set to false
auth_uri=$(grep -E "^auth_uri" /etc/cinder/cinder.conf | awk -F= '{print $2}' | tr -d '[:space:]')
insecure=$(grep -E "^insecure" /etc/cinder/cinder.conf | awk -F= '{print $2}' | tr -d '[:space:]')

if [[ $auth_uri == https://* ]] && [[ $insecure == false ]]; then
  result="양호"
else
  result="취약"
fi

#결과를 csv 파일에 저장합니다

echo "암호화,OT-20,블록 스토리지 서비스 인증을 위한 TLS 활성화,상,$result" >> openstack_report.csv
