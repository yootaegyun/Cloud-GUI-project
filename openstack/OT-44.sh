export LANG=ko_KR.UTF-8
#!/bin/bash

# etc/cinder/cinder.conf 존재하지 않을 시 N/A 처리
if [ ! -e "/etc/cinder/cinder.conf" ] || [ ! -e "/etc/cinder/nova.conf" ] ; then
  echo "보안설정,OT-44,블록 스토리지 볼륨 암호화,상,N/A">> openstack_report.csv
  exit 1
fi

cat /etc/cinder/cinder.conf | grep -i "api_class" >/dev/null 2>&1
if [ $? -ne 0 ] ; then
	echo "보안설정,OT-44,블록 스토리지 볼륨 암호화,상,양호">> openstack_report.csv
cat /etc/cinder/nova.conf | grep -i "api_class" >/dev/null 2>&1
elif [ $? -ne 0 ] ; then
	echo "보안설정,OT-44,블록 스토리지 볼륨 암호화,상,양호">> openstack_report.csv
else
	echo "보안설정,OT-44,블록 스토리지 볼륨 암호화,상,취약">> openstack_report.csv
fi
