export LANG=ko_KR.UTF-8
#!/bin/bash

# etc/openstack-dashboard 존재하지 않을 시 N/A 처리
if [ ! -e "/etc/openstack-dashboard" ]; then
  echo "보안설정,OT-37,Dashboard의 DISABLE_PASSWORD_REVEAL 설정,상,N/A">> openstack_report.csv
  exit 1
fi

if [ -f /etc/openstack-dashboard/local_settings.py ] ; then
	cat /etc/openstack-dashboard/local_settings.py | grep -i "DISABLE_PASSWORD_REVEAL" >/dev/null 2>&1
	if [ $? -ne 0 ] ; then
		# /etc/openstack-dashboard/local_settings.py 파일에서 DISABLE_PASSWORD_REVEAL 매개변수가 True로 되어 있는 경우
		echo "보안설정,OT-37,Dashboard의 DISABLE_PASSWORD_REVEAL 설정,상,양호">> openstack_report.csv
	else
		# /etc/openstack-dashboard/local_settings.py 파일에서 DISABLE_PASSWORD_REVEAL 매개변수가 False로 되어 있는 경우
		echo "보안설정,OT-37,Dashboard의 DISABLE_PASSWORD_REVEAL 설정,상,취약">> openstack_report.csv
elif [ -f etc/openstack-dashboard/local_settings ] ; then
	cat /etc/openstack-dashboard/local_settings | grep -i "DISABLE_PASSWORD_REVEAL" >/dev/null 2>&1
	if [ $? -ne 0 ] ; then
		# /etc/openstack-dashboard/local_settings 파일에서 DISABLE_PASSWORD_REVEAL 매개변수가 True로 되어 있는 경우
		echo "보안설정,OT-37,Dashboard의 DISABLE_PASSWORD_REVEAL 설정,상,양호">> openstack_report.csv
	else
		# /etc/openstack-dashboard/local_settings 파일에서 DISABLE_PASSWORD_REVEAL 매개변수가 False로 되어 있는 경우
		echo "보안설정,OT-37,Dashboard의 DISABLE_PASSWORD_REVEAL 설정,상,취약">> openstack_report.csv
fi
fi
fi