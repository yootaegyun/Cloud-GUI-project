export LANG=ko_KR.UTF-8
#!/bin/bash

# /etc/manila/manila.conf나 /etc/cinder/nova.conf가 존재하지 않을 시 N/A 처리
if [ ! -e "/etc/manila/manila.conf" ] || [ ! -e "/etc/cinder/nova.conf" ] ; then
  echo "보안설정,OT-47,공유파일 시스템에서 요청 본문 최대 사이즈 설정,상,N/A">> openstack_report.csv
  exit 1
fi

cat /etc/manila/manila.conf | grep -i "osapi_max_request_body_size" >/dev/null 2>&1
if [ $? -ne 0 ] ; then
	echo "보안설정,OT-47,공유파일 시스템에서 요청 본문 최대 사이즈 설정,상,양호">> openstack_report.csv
cat /etc/cinder/nova.conf | grep -i "max_request_body_size" >/dev/null 2>&1
elif [ $? -ne 0 ] ; then
	echo "보안설정,OT-47,공유파일 시스템에서 요청 본문 최대 사이즈 설정,상,양호">> openstack_report.csv
else
	echo "보안설정,OT-47,공유파일 시스템에서 요청 본문 최대 사이즈 설정,상,취약">> openstack_report.csv
fi