#!/bin/bash

# manila.conf 파일 경로
manila_conf="/etc/manila/manila.conf" 

# manila.conf 파일이 없는 경우
if [ ! -f "$manila_conf" ]; then
  echo "암호화,OT-26,TLS를 이용한 공유 파일 시스템과 네트워킹연결,상,N/A" >> openstack_report.csv
  exit
fi

# neutron_api_insecure 설정값 추출
neutron_api_insecure=$(grep "^neutron_api_insecure" ${manila_conf} | awk -F= '{print $2}' | tr -d ' ')

# neutron_api_insecure 값이 False인 경우 양호, True인 경우 취약
if [ "$neutron_api_insecure" == "False" ]; then
  result="양호"
else
  result="취약"
fi

# 결과를 csv 파일에 저장
echo "암호화,OT-26,TLS를 이용한 공유 파일 시스템과 네트워킹연결,상,$result" >> openstack_report.csv
