export LANG=ko_KR.UTF-8
#!/bin/bash

TMP=$(cat /etc/apache2/apache2.conf  | grep "LimitRequestBody" | awk '{print $2}' )

if [ -n $TMP ] ; then
	echo "보안설정,AP-04,파일 업로드 및 다운로드 제한,상,양호">> apache_report.csv
else
	echo "보안설정,AP-04,파일 업로드 및 다운로드 제한,상,취약">> apache_report.csv
fi