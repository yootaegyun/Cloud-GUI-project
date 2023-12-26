#!/bin/bash

if [ ! -f "/etc/nova/nova.conf" ]; then
  echo "암호화,OT-22,cinder와 glance의 TLS 통신,상,N/A" >> openstack_report.csv
exit
fi

glance_api_servers=$(grep -Po "(?<=^\[DEFAULT\]\nglance_api_servers = ).*" /etc/nova/nova.conf)

if [[ $glance_api_servers == https://* ]]; then
    echo "암호화,OT-22,cinder와 glance의 TLS 통신,상,양호" >> openstack_report.csv
else
    echo "암호화,OT-22,cinder와 glance의 TLS 통신,상,취약" >> openstack_report.csv
fi
