#!/bin/bash
output=$(netstat -tnlp | grep -i httpd | grep 443)

if echo "$output" | grep -q "LISTEN" && ! echo "$output" | grep -q "tcp6"; then
    echo "암호화,OT-15,Identity TLS 활성화,상,양호" >> openstack_report.csv
else
    echo "암호화,OT-15,Identity TLS 활성화,상,취약" >> openstack_report.csv
fi
