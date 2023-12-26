#!/bin/bash

if [ ! -f "/etc/nova/nova.conf" ]; then
  echo "암호화,OT-18,Compute 인증을 위한 보안프로토콜 사용,상,N/A" >> openstack_report.csv
exit
fi

auth_url=$(grep -Po "(?<=^\[keystone_authtoken\]\nauth_url = ).*" /etc/nova/nova.conf)

if [[ $auth_url == https://* ]]; then
    echo "암호화,OT-18,Compute 인증을 위한 보안프로토콜 사용,상,양호" >> openstack_report.csv
else
    echo "암호화,OT-18,Compute 인증을 위한 보안프로토콜 사용,상,취약" >> openstack_report.csv
fi

