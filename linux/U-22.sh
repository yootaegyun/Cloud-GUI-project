#!/bin/bash

ls /etc/xinetd.d/rsc* >/dev/null 2>&1
if  [ $? != 0 ] ; then 
	echo ''
else
	for i in 'ls /etc/xinetd.d/rsc*'
	do
		if [ "cat &i | grep disable | awk '{print $3}'" = yes] ; then
			resultA="양호"
		else
			resultA="취약"
		fi
	done
fi


ls /etc/xinetd.d/rlogin* >/dev/null 2>&1
if  [ $? != 0 ] ; then 
	echo ''
else
	for i in 'ls /etc/xinetd.d/rlogin*'
	do
		if [ "cat &i | grep disable | awk '{print $3}'" = yes] ; then
			resultB="양호"
		else
			resultB="취약"
		fi
	done
fi


ls /etc/xinetd.d/rexec* >/dev/null 2>&1
if  [ $? != 0 ] ; then 
	echo ''
else
	for i in 'ls /etc/xinetd.d/rexec*'
	do
		if [ "cat &i | grep disable | awk '{print $3}'" = yes] ; then
			resultC="양호"
		else
			resultC="취약"
		fi
	done
fi

if [  -d "/etc/xinetd.d" ]; then
	if [[ $resultA == "취약" || $resultB == "취약" || $resultC == "취약" ]]; then
  	echo "서비스 관리,U-22,r 계열 서비스 비활성화,상,양호" >> linux_report.csv
	else
  	echo  "서비스 관리,U-22,r 계열 서비스 비활성화,상,취약" >> linux_report.csv
	fi
fi


ls /etc/inetd.conf* >/dev/null 2>&1
if  [ $? != 0 ] ; then 
	echo ''
else
	for i in 'ls /etc/inetd.conf*'
	do
		if grep -qE "rsh|rlogin|rexec" /etc/inetd.conf; then
			if [ "cat &i | grep disable | awk '{print $3}'" = yes] ; then
				echo -e "서비스 관리,U-22,r 계열 서비스 비활성화,상,양호" >> linux_report.csv
			else
				echo -e "서비스 관리,U-22,r 계열 서비스 비활성화,상,취약" >> linux_report.csv
			fi
		else
			echo -e "서비스 관리,U-22,r 계열 서비스 비활성화,상,양호" >> linux_report.csv
		fi
	done
fi

if [ ! -d "/etc/xinetd.d" ] && [ ! -f "/etc/inetd.conf" ] ; then
	echo  "서비스 관리,U-22,r 계열 서비스 비활성화,상,N/A" >> linux_report.csv
exit
fi
