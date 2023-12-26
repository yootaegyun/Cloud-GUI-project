#!/bin/bash

# manila.conf 파일 경로 설정
manila_conf_path="/etc/manila/manila.conf" 

# manila.conf 파일이 없는 경우
if [ ! -f "$manila_conf_path" ]; then
  echo "암호화,OT-27,TLS를 이용한 공유 파일 시스템과 블록 스토리지 서비스와의 연결,상,N/A" >> openstack_report.csv
  exit
fi

# cinder_api_insecure 설정값 추출
cinder_api_insecure=$(grep "^cinder_api_insecure" $manila_conf_path | awk -F= '{print $2}' | tr -d ' ')

# cinder_api_insecure 값이 False 인 경우
if [ "$cinder_api_insecure" == "False" ]; then
  result="양호"
else
  result="취약"
fi

# 결과를 csv 파일에 저장
echo "암호화,OT-27,TLS를 이용한 블록 스토리지와의 연결 보안 설정,중,$result" >> openstack_report.csv
