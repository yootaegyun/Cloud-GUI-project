export LANG=ko_KR.UTF-8
#!/bin/bash

# etc/cinder/cinder.conf 존재하지 않을 시 N/A 처리
if [ ! -e "/etc/cinder/cinder.conf" ]; then
  echo "보안설정,OT-43,블록 스토리지 서비스에서 요청 본문 최대 크기 설정,상,N/A">> openstack_report.csv
  exit 1
fi

cat /etc/cinder/cinder.conf | grep -i "osapi_max_request_body_size" >/dev/null 2>&1
if [ $? -ne 0 ] ; then
	echo "보안설정,OT-43,블록 스토리지 서비스에서 요청 본문 최대 크기 설정,상,양호">> openstack_report.csv
cat /etc/cinder/cinder.conf | grep -i "max_request_body_size"
elif [ $? -ne 0 ] ; then
	echo "보안설정,OT-43,블록 스토리지 서비스에서 요청 본문 최대 크기 설정,상,양호">> openstack_report.csv
else
	echo "보안설정,OT-43,블록 스토리지 서비스에서 요청 본문 최대 크기 설정,상,취약">> openstack_report.csv
fi
