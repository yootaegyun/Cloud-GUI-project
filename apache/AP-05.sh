export LANG=ko_KR.UTF-8
#!/bin/bash

cat /etc/apache2/apache2.conf | grep Indexes >/dev/null 2>&1

if [ -z $? ] ; then
	echo "접근관리,AP-05,디렉터리 리스팅 제거,상,양호">> apache_report.csv
else
	echo "접근관리,AP-05,디렉터리 리스팅 제거,상,취약">> apache_report.csv
fi
