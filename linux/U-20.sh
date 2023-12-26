#!/bin/bash

if [ -f /etc/xinetd.d/finger ]; then
	if [ "$(cat /etc/xinetd.d/finger | grep disable | awk '{print $3}')" = "yes" ]; then
		echo  "서비스 관리,U-20,Finger 서비스 비활성화,상,양호" >> linux_report.csv
	else
		echo  "서비스 관리,U-20,Finger 서비스 비활성화,상,취약" >> linux_report.csv
	fi
exit
fi

if [ -f /etc/inetd.conf ]; then
	if grep -qE "finger" /etc/inetd.conf; then
		if ! grep -qE '^#.*finger|^finger' /etc/inetd.conf; then
			echo -e "서비스 관리,U-20,Finger 서비스 비활성화,상,양호" >> linux_report.csv
		else
			echo -e "서비스 관리,U-20,Finger 서비스 비활성화,상,취약" >> linux_report.csv
		fi
	fi
exit
fi

if [ ! -f "/etc/xinetd.d/finger" ] && [ ! -f "/etc/inetd.conf" ]; then
	echo  "서비스 관리,U-20,Finger 서비스 비활성화,상,N/A" >> linux_report.csv
fi
