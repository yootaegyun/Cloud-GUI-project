export LANG=ko_KR.UTF-8
#!/bin/bash

if showmount -e localhost &>/dev/null; then
	# nfs 서버에 등록된 서비스 목록을 확인해서 nfs 행으로 시작하는 문자열을 두번째 열 만 출력
	CHECK1=$(systemctl list-unit-files nfs-server.service | grep ^nfs | awk '{print $2}')
	HOSTNAME=$(hostname)
	#  hostname 된 디렉토리에서 'everyone' 문자열이 있는 줄수
	CHECK2=$(showmount -e $HOSTNAME | grep everyone | wc -l)
	if [ $CHECK1 == 'disabled' ] || [ $CHECK2 = 0 ]; then
		echo "서비스 관리,U-25,NFS 접근통제,상,양호">> linux_report.csv
	else	
		echo "서비스 관리,U-25,NFS 접근통제,상,취약">> linux_report.csv
	fi
else
	echo "서비스 관리,U-25,NFS 접근통제,상,N/A">> linux_report.csv
  	exit 1
fi