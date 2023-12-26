export LANG=ko_KR.UTF-8
#!/bin/bash

# etc/cinder/cinder.conf 존재하지 않을 시 N/A 처리
if [ ! -e "/etc/cinder/cinder.conf" ]; then
  echo "보안설정,OT-42,안전한 환경에서의 NAS 운영,상,N/A" >> openstack_report.csv
  exit 1
fi

TMP1=$(cat /etc/cinder/cinder.conf | grep -i "nas_secure_file_permission" | awk '{print $3}')
TMP2=$(cat /etc/cinder/cinder.conf | grep -i "nas_secure_file_operations" | awk '{print $3}')
if [ $TMP1 == 'auto' ] ; then
	if [ $TMP2 == 'auto' ] ; then
		echo "보안설정,OT-42,안전한 환경에서의 NAS 운영,상,양호">> openstack_report.csv
	else
		echo "보안설정,OT-42,안전한 환경에서의 NAS 운영,상,취약">> openstack_report.csv
	fi
else
	echo "보안설정,OT-42,안전한 환경에서의 NAS 운영,상,N/A">> openstack_report.csv
fi