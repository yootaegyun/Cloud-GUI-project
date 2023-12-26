#!/bin/bash

if [ ! -f "/etc/glance/glance-api.conf" ]; then
  echo "암호화,OT-23,이미지 스토리지 서비스 인증을 위한 TLS 활성화,상,N/A" >> openstack_report.csv
exit
fi

auth_url=$(grep -Po "(?<=^\[keystone_authtoken\]\nauth_url = ).*" /etc/glance/glance-api.conf)

if [[ $auth_url == https://* ]]; then
    echo "암호화,OT-23,이미지 스토리지 서비스 인증을 위한 TLS 활성화,상,양호" >> openstack_report.csv
else
    echo "암호화,OT-23,이미지 스토리지 서비스 인증을 위한 TLS 활성화,상,취약" >> openstack_report.csv
fi

