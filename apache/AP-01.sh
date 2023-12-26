export LANG=ko_KR.UTF-8
#!/bin/bash

echo "구분,진단코드,진단항목,취약도,점검결과" > apache_report.csv

TMP=$(grep -i 'DocumentRoot' /etc/apache2/sites-available/000-default.conf | awk '{print $2}')
if [ $TMP == '/var/apache2/htdocs' ] ; then
	echo "보안설정,AP-01,웹 서비스 영역의 분리,상,양호">> apache_report.csv
else
	echo "보안설정,AP-01,웹 서비스 영역의 분리,상,취약">> apache_report.csv
fi