export LANG=ko_KR.UTF-8
#!/bin/bash

# ypserv이나 ypbind이나 ypxfrd이나 rpc.yppasswdd이나 rpc.ypupdated가 포함되지 않은 행의 2번째 6번째 열 출력
TMP=$(mktemp)
ps -ef | egrep "ypserv|ypbind|ypxfrd|rpc.yppasswdd|rpc.ypupdated" | grep -v "grep" | awk '{print $2,$6}'> $TMP

#문자열 길이가 0이 아니면 참
if [ -n $TMP ] ; then
	# "NIS, NIS+ 서비스가 구동 중이지 않을 경우
	echo "서비스 관리,U-28,NIS NIS+ 점검,상,양호">> linux_report.csv
else
	# "NIS, NIS+ 서비스가 구동 중일 경우
	echo "서비스 관리,U-28,NIS NIS+ 점검,상,취약">> linux_report.csv
fi