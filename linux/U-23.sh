#!/bin/bash

ls /etc/xinetd.d/echo* >/dev/null 2>&1
if  [ $? != 0 ] ; then 
	echo ''
else
	for i in 'ls /etc/xinetd.d/echo*'
	do
		if [ "cat &i | grep disable | awk '{print $3}'" = yes] ; then
			resultA="양호"
		else
			resultA="취약"
		fi
	done
fi


ls /etc/xinetd.d/discard* >/dev/null 2>&1
if  [ $? != 0 ] ; then 
	echo ''
else
	for i in 'ls /etc/xinetd.d/discard*'
	do
		if [ "cat &i | grep disable | awk '{print $3}'" = yes] ; then
			resultB="양호"
		else
			resultB="취약"
		fi
	done
fi


ls /etc/xinetd.d/daytime* >/dev/null 2>&1
if  [ $? != 0 ] ; then 
	echo ''
else
	for i in 'ls /etc/xinetd.d/daytime*'
	do
		if [ "cat &i | grep disable | awk '{print $3}'" = yes] ; then
			resultC="양호"
		else
			resultC="취약"
		fi
	done
fi

ls /etc/xinetd.d/chargen* >/dev/null 2>&1
if  [ $? != 0 ] ; then 
	echo ''
else
	for i in 'ls /etc/xinetd.d/chargen*'
	do
		if [ "cat &i | grep disable | awk '{print $3}'" = yes] ; then
			resultD="양호"
		else
			resultD="취약"
		fi
	done
fi

if [  -d "/etc/xinetd.d" ]; then
	if [[ $resultA == "취약" || $resultB == "취약" || $resultC == "취약" || $resultD == "취약" ]]; then
  	echo -e "서비스 관리,U-23,DOS 공격에 취약한 서비스 비활성화,상,양호" >> linux_report.csv
	else
  	echo -e "서비스 관리,U-23,DOS 공격에 취약한 서비스 비활성화,상,취약" >> linux_report.csv
	fi
exit
fi


ls /etc/inetd.conf* >/dev/null 2>&1
if  [ $? != 0 ] ; then 
	echo ''
else
	for i in 'ls /etc/inetd.conf*'
	do
		if grep -qE "echo|discard|daytime|chargen" /etc/inetd.conf; then
			if ! grep -qE '^#.*rsh|^#.*rlogin|^#.*rexec|^rsh|^rlogin|^rexec' /etc/inetd.conf; then
				echo -e "서비스 관리,U-23,DOS 공격에 취약한 서비스 비활성화,상,양호" >> linux_report.csv
			else
				echo -e "서비스 관리,U-23,DOS 공격에 취약한 서비스 비활성화,상,취약" >> linux_report.csv
			fi
		else
			echo -e "서비스 관리,U-23,DOS 공격에 취약한 서비스 비활성화,상,양호" >> linux_report.csv
		fi
	done
exit
fi


if [ ! -d "/etc/xinetd.d" ] && [ ! -f "/etc/inetd.conf" ] ; then
	echo  "서비스 관리,U-23,DOS 공격에 취약한 서비스 비활성화,상,N/A" >> linux_report.csv
exit
fi
