export LANG=ko_KR.UTF-8
#!/bin/bash

cat /etc/apache2/apache2.conf | grep FollowSymLinks >/dev/null 2>&1

if [ -z $? ] ; then
	echo "보안설정,AP-03,링크 사용금지,상,양호">> apache_report.csv
else
	echo "보안설정,AP-03,링크 사용금지,상,취약">> apache_report.csv
fi
