#!/bin/bash

if [ -f "/etc/openstack-dashboard/local_settings.py" ]; then
	if [ "$(cat /etc/openstack-dashboard/local_settings.py | grep SECURE_PROXY_SSL_HEAEDER | awk '{print $3}')" = "HTTP_X_FORWARDED_PROTO, https" ]; then
		echo "암호화,OT-17,Dashboard의 SECURE_PROXY_SSL_HEAEDER 설정,상,양호" >> openstack_report.csv
	else
		echo "암호화,OT-17,Dashboard의 SECURE_PROXY_SSL_HEAEDER 설정,상,취약" >> openstack_report.csv
	fi
exit
fi

if [ -f "/etc/openstack-dashboard/local_settings" ]; then
	if [ "$(cat /etc/openstack-dashboard/local_settings | grep SECURE_PROXY_SSL_HEAEDER | awk '{print $3}')" = "HTTP_X_FORWARDED_PROTO, https" ]; then
		echo "암호화,OT-17,Dashboard의 SECURE_PROXY_SSL_HEAEDER 설정,상,양호" >> openstack_report.csv
	else
		echo "암호화,OT-17,Dashboard의 SECURE_PROXY_SSL_HEAEDER 설정,상,취약" >> openstack_report.csv
	fi
exit
fi

if [ ! -f "/etc/openstack-dashboard/local_settings" ] && [ ! -f "/etc/openstack-dashboard/local_settings.py" ]; then
	echo "암호화,OT-17,Dashboard의 SECURE_PROXY_SSL_HEAEDER 설정,상,N/A" >> openstack_report.csv
exit
fi
