#!/bin/bash

# Check the value of nova_api.insecure in the [DEFAULT] section of /etc/cinder/cinder.conf
insecure=$(sudo grep -Po '^nova_api.insecure\s*=\s*\K.*' /etc/cinder/cinder.conf)

# Check if insecure is set to False
if [ "$insecure" == "False" ]; then
    result="양호" 
else
    result="취약" 
fi

echo "암호화,OT-21,cinder와 nova의 TLS 통신,상,$result" >> openstack_report.csv
