export LANG=ko_KR.UTF-8
#!/bin/bash

# automountd 서비스 데몬 확인
ps -ef | grep automount >/dev/null 2>&1
if [ $? -ne 0 ] ; then
	# automount 서비스가 비활성화 되어 있는 경우
	echo "서비스 관리,U-26,automountd,상,양호">> linux_report.csv
else
	# automount 서비스가 활성화되어 있는 경우
	echo "서비스 관리,U-26,automountd,상,양호">> linux_report.csv
fi
