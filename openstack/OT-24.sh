#!/bin/bash

if [ ! -d "/etc/manila" ]; then
  echo "암호화,OT-24,공유 파일 시스템 인증을 위한 TLS 활성화,상,N/A" >> openstack_report.csv
  exit
fi

auth_url=$(grep -Po "(?<=^\[keystone_authtoken\]\nauth_url = ).*" /etc/manila/manila.conf)
identify_url=$(grep -Po "(?<=^\[keystone_authtoken\]\nidentify_url = ).*" /etc/manila/manila.conf)

if [[ $auth_url == https://* ]]; then
	if [[ $identify_url == https://* ]]; then
    		echo "암호화,OT-24,공유 파일 시스템 인증을 위한 TLS 활성화,상,양호" >> openstack_report.csv
	else 
		echo "암호화,OT-24,공유 파일 시스템 인증을 위한 TLS 활성화,상,양호" >> openstack_report.csv
	fi
else
    echo "암호화,OT-24,공유 파일 시스템 인증을 위한 TLS 활성화,상,취약" >> openstack_report.csv
fi
