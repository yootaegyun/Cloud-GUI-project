export LANG=ko_KR.UTF-8
#!/bin/bash

# /etc/manila/manila.conf 존재하지 않을 시 N/A 처리
if [ ! -e "/etc/manila/manila.conf" ]; then
  echo "보안설정,OT-46,공유파일 시스템 인증을 위한 오픈스택 Identity 사용,상,N/A">> openstack_report.csv
  exit 1
fi

TMP=$(cat /etc/manila/manila.conf | grep -i "auth_strategy | awk '{print $3}')
if [ $TMP  == 'keystone' ] ; then
	echo "보안설정,OT-46,공유파일 시스템 인증을 위한 오픈스택 Identity 사용,상,양호">> openstack_report.csv
else
	echo "보안설정,OT-46,공유파일 시스템 인증을 위한 오픈스택 Identity 사용,상,취약">> openstack_report.csv
fi
