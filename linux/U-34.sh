#!/bin/bash

FILE=/etc/named.conf

# DNS 서비스 확인
if [ $(ps -ef | grep named | grep -v grep | wc -l) -eq 0 ]; then
	# DNS 서비스 미사용
	result="양호"
else
	# DNS 서버 사용
	# 파일 유무/허용벙위 확인
	if [ -f $FILE ] ; then
		cat $FILE | grep 'allow-transfer' >/dev/null	#허용버위 확인
		if [ $? == 0 ] ; then
			result="양호"
		else
			result="취약"
		fi
	else
		result="취약"
	fi
fi

echo "서비스 관리,U-34,DNS ZoneTransfer 설정,상,$result" >> linux_report.csv
