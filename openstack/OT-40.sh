export LANG=ko_KR.UTF-8
#!/bin/bash

# etc/nova/nova.conf 존재하지 않을 시 N/A 처리
if [ ! -e "/etc/nova/nova.conf" ]; then
  echo "보안설정,OT-40,Compute의 인증을 위한 keystone 사용,상,N/A">> openstack_report.csv
  exit 1
fi

TMP=$(mktemp)
cat /etc/nova/nova.conf | grep -i "auth_strategy" | awk '{print $3}' > $TMP
if [ $TMP == 'keystone' ] ; then
	echo "보안설정,OT-40,Compute의 인증을 위한 keystone 사용,상,양호">> openstack_report.csv
else
	echo "보안설정,OT-40,Compute의 인증을 위한 keystone 사용,상,취약">> openstack_report.csv
fi
