#!/bin/bash

if [ ! -d "/etc/manila" ]; then
  echo "암호화,OT-25,TLS를 이용한 공유 파일 시스템과 Compute 통신,상,N/A" >> openstack_report.csv
exit
fi

nova_api_insecure=$(grep -Po "(?<=^\[DEFAULT\]\nnova_api_insecure = ).*" /etc/manila/manila.conf)

if [[ $nova_api_insecure == False* ]]; then
    echo "암호화,OT-25,TLS를 이용한 공유 파일 시스템과 Compute 통신,상,양호" >> openstack_report.csv
else
    echo "암호화,OT-25,TLS를 이용한 공유 파일 시스템과 Compute 통신,상,취약" >> openstack_report.csv
fi
