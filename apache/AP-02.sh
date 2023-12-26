export LANG=ko_KR.UTF-8
#!/bin/bash

TMP1=$(ls /etc/apache2/ | grep manual)
TMP2=$(ls /etc/apache2/ | grep cgi-bin)

if [ $TMP1 -n ] || [ $TMP2 -n] ; then
	echo "보안설정,AP-02,불필요한 파일 제거,상,취약">> apache_report.csv
else
	echo "보안설정,AP-02,불필요한 파일 제거,상,양호">> apache_report.csv
fi
