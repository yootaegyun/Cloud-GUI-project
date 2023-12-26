export LANG=ko_KR.UTF-8
#!/bin/bash

# /etc/mail/sendmail.cf 존재하지 않을 시 N/A 처리
if [ ! -e "/etc/mail/sendmail.cf" ]; then
  echo "서비스 관리,U-30,Sendmail 버전 점검,상,N/A">> linux_report.csv
  exit 1
fi

# /etc/mail/sendmail.cf에서 DZ가 포함된 문자열
VERSION=$(mktemp)
cat /etc/mail/sendmail.cf | grep DZ > $VERSION
if [ $VERSION == 8.15.2 ] ; then
	# Sendmail 버전을 정기적으로 점검하고, 최신 버전 패치를 했을 경우
	echo "서비스 관리,U-30,Sendmail 버전 점검,상,양호">> linux_report.csv
else
	# Sendmail 버전을 정기적으로 점검하지 않거나, 최신 버전 패치가 되어 있지 않은 경우
	echo "서비스 관리,U-30,Sendmail 버전 점검,상,취약">> linux_report.csv
fi