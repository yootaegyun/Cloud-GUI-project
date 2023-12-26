export LANG=ko_KR.UTF-8
#!/bin/bash

# etc/glance 존재하지 않을 시 N/A 처리
if [ ! -e "/etc/glance/glance-api.conf" ] || [ ! -e "/etc/glance/glance-registry.conf" ]; then
  echo "보안설정,OT-45,이미지 스토리지 서비스 인증을 위한 keystone 설정,상,N/A">> openstack_report.csv
  exit 1
fi

TMP1=$(cat /etc/glance/glance-api.conf | grep -i "auth_strategy" | awk '{print $3}')
TMP2=$(cat /etc/glance/glance-registry.conf | grep -i "auth_strategy" | awk '{print $3}')
if [[ $TMP1 == 'keystone' ]] ; then
	if [[ $TMP2 == 'keystone' ]] ; then
		echo "보안설정,OT-45,이미지 스토리지 서비스 인증을 위한 keystone 설정,상,양호">> openstack_report.csv
else
	echo "보안설정,OT-45,이미지 스토리지 서비스 인증을 위한 keystone 설정,상,취약">> openstack_report.csv
fi
fi