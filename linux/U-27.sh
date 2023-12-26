export LANG=ko_KR.UTF-8
#!/bin/bash

# /etc/xinetd.d/rstatd 존재하지 않을 시 N/A 처리
if [ ! -e "/etc/xinetd.d/rstatd" ] || [ ! -e "/etc/inetd.conf" ] ; then
  echo "서비스 관리,U-27,RPC 서비스 확인,상,N/A">> linux_report.csv
  exit 1
fi

if [ -f /etc/xinetd.d/rstatd ] ; then
cat /etc/xinetd.d/rstatd >/dev/null 2>&1
if [ $? -ne 0 ] ; then
	# 불필요한 RPC 서비스가 비활성화 되어 있는 경우
	echo "서비스 관리,U-27,RPC 서비스 확인,상,양호">> linux_report.csv
else
	# 불필요한 RPC 서비스가 활성화 되어 있는 경우
	echo "서비스 관리,U-27,RPC 서비스 확인,상,취약">> linux_report.csv
fi
fi

if [ -f /etc/inetd.conf ] ; then
cat /etc/inetd.conf >/dev/null 2>&1
if [ $? -ne 0 ] ; then
	# 불필요한 RPC 서비스가 비활성화 되어 있는 경우
	echo "서비스 관리,U-27,RPC 서비스 확인,상,양호">> linux_report.csv
else
	# 불필요한 RPC 서비스가 활성화 되어 있는 경우
	echo "서비스 관리,U-27,RPC 서비스 확인,상,취약">> linux_report.csv
fi
fi
