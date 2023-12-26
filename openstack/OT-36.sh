export LANG=ko_KR.UTF-8
#!/bin/bash

# etc/openstack-dashboard 존재하지 않을 시 N/A 처리
if [ ! -e "/etc/openstack-dashboard" ]; then
  echo "보안설정,OT-36,Dashboard의 PASSWORD_AUTOCOMPLE 설정,상,N/A">> openstack_report.csv
  exit 1
fi

if [ -f /etc/openstack-dashboard/local_settings.py ] ; then
	cat /etc/openstack-dashboard/local_settings.py | grep -i "PASSWORD_AUTOCOMPLET" >/dev/null 2>&1
	if [ $? -ne 1 ] ; then
		# /etc/openstack-dashboard/local_settings.py 파일에서 PASSWORD_AUTOCOMPLE 매개변수가 False로 되어 있는 경우
		echo "보안설정,OT-36,Dashboard의 PASSWORD_AUTOCOMPLET 설정,상,양호">> openstack_report.csv
	else
		# /etc/openstack-dashboard/local_settings.py 파일에서 PASSWORD_AUTOCOMPLE 매개변수가 True로 되어 있는 경우
		echo "보안설정,OT-36,Dashboard의 PASSWORD_AUTOCOMPLET 설정,상,취약">> openstack_report.csv
elif [ -f etc/openstack-dashboard/local_settings ] ; then
	cat /etc/openstack-dashboard/local_settings | grep -i "PASSWORD_AUTOCOMPLET" >/dev/null 2>&1
	if [ $? -ne 1 ] ; then
		# /etc/openstack-dashboard/local_settings 파일에서 PASSWORD_AUTOCOMPLE 매개변수가 False로 되어 있는 경우
		echo "보안설정,OT-36,Dashboard의 PASSWORD_AUTOCOMPLET 설정,상,양호">> openstack_report.csv
	else
		# /etc/openstack-dashboard/local_settings 파일에서 PASSWORD_AUTOCOMPLE 매개변수가 True로 되어 있는 경우
		echo "보안설정,OT-36,Dashboard의 PASSWORD_AUTOCOMPLET 설정,상,취약">> openstack_report.csv
fi
fi
fi