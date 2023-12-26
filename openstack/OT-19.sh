#!/bin/bash

if [ ! -f "/etc/nova/nova.conf" ]; then
  echo "암호화,OT-19,Nova와 Glance의 안전한 통신,상,N/A" >> openstack_report.csv
exit
fi

auth_url=$(grep -Po "(?<=^\[glance\]\nauth_url = ).*" /etc/nova/nova.conf)

if [[ $auth_url == https://* ]]; then
    echo "암호화,OT-19,Nova와 Glance의 안전한 통신,상,양호" >> openstack_report.csv
else
    echo "암호화,OT-19,Nova와 Glance의 안전한 통신,상,취약" >> openstack_report.csv
fi
