export LANG=ko_KR.UTF-8
#!/bin/bash

# echo "구분,진단코드,진단항목,취약도,점검결과"> openstack_report.csv

# /etc/keystone/keystone.conf 존재하지 않을 시 N/A 처리
if [ ! -e "/etc/keystone/keystone.conf" ]; then
	echo "보안설정,OT-30,Identity 서비스 max_request_body_size 설정,상,N/A">> openstack_report.csv
	exit 1
fi

TMP=$(mktemp)
cat /etc/keystone/keystone.conf | grep -i "max_request_body_size" > $TMP

if [ -n $TMP ] ; then
	# /etc/keystone/keystone.conf 파일에서 max_request_body_size가 기본값(114688) 또는 적절한 값으로 설정되어 있는 경우
	echo "보안설정,OT-30,Identity 서비스 max_request_body_size 설정,상,양호">> openstack_report.csv
else
	# /etc/keystone/keystone.conf 파일에서 max_request_body_size가 설정되어 있지 않은 경우
	echo "보안설정,OT-30,Identity 서비스 max_request_body_size 설정,상,취약">> openstack_report.csv
fi