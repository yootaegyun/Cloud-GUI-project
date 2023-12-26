export LANG=ko_KR.UTF-8
#!/bin/bash

# /etc/keystone/keystone.conf나 /etc/keystone/keystone-paste.ini 존재하지 않을 시 N/A 처리
if [ ! -e "/etc/keystone/keystone.conf" ] || [ ! -e "/etc/keystone/keystone-paste.ini" ] ; then
  echo "보안설정,OT-31,admin 토큰 비활성화,상,N/A">> openstack_report.csv
  exit 1
fi

cat /etc/keystone/keystone.conf | grep -i "admin_token" >/dev/null 2>&1
if [ $? -ne 1 ] ; then
	cat /etc/keystone/keystone-paste.ini | grep -i "AdminTokenAuthMiddleware" >/dev/null 2>&1
	if [ $? -ne 1 ] ; then
		# /etc/keystone/keystone.conf 파일에서 [DEFAULT] 섹션의 admin_token이 비활성화 되어 있고, /etc/keystone/keystone-paste.ini 파일에서 [filter:admin_token_auth] 섹션의 AdminTokenAuthMiddleware가 제거되어 있는 경우
		echo "보안설정,OT-31,admin 토큰 비활성화,상,양호">> openstack_report.csv
	else
		# /etc/keystone/keystone.conf 파일에서 [DEFAULT] 섹션의 admin_token이 활성화 되어 있고, /etc/keystone/keystone-paste.ini 파일에서 [filter:admin_token_auth] 섹션의 AdminTokenAuthMiddleware가 존재하는 경우
		echo "보안설정,OT-31,admin 토큰 비활성화,상,취약">> openstack_report.csv
fi
fi