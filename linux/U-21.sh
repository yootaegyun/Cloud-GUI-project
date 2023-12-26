#!/bin/bash

# /etc/passwd 파일 확인
if [ -f "/etc/passwd" ]; then
    if grep -q "^ftp:" "/etc/passwd"; then
        echo "서비스 관리,U-21,Anonymous FTP 비활성화,상,취약" >> linux_report.csv
    else
        echo "서비스 관리,U-21,Anonymous FTP 비활성화,상,양호" >> linux_report.csv
    fi
exit
fi

# /etc/proftpd/proftpd.conf 파일 확인
if [ -f "/etc/proftpd/proftpd.conf" ]; then
    if grep -q "UserAlias" "/etc/proftpd/proftpd.conf" && ! grep -q "^#" "/etc/proftpd/proftpd.conf" | grep -q "UserAlias"; then
        echo "서비스 관리,U-21,Anonymous FTP 비활성화,상,취약" >> linux_report.csv
    else
        echo "서비스 관리,U-21,Anonymous FTP 비활성화,상,양호" >> linux_report.csv
    fi
exit
fi

# /etc/vsftpd/vsftpd.conf 파일 확인		
if [ -f "/etc/vsftpd/vsftpd.conf" ]; then
    if grep -q "anonymous_enable=Yes" "/etc/vsftpd/vsftpd.conf"; then
        echo "서비스 관리,U-21,Anonymous FTP 비활성화,상,취약" >> linux_report.csv
    else
        echo "서비스 관리,U-21,Anonymous FTP 비활성화,상,양호" >> linux_report.csv
    fi
exit
fi

if [ ! -f "/etc/passwd" ] && [ ! -f "/etc/proftpd/proftpd.conf" ] && [ ! -f "/etc/vsftpd/vsftpd.conf" ]; then
	echo  "서비스 관리,U-21,Anonymous FTP 비활성화,상,N/A" >> linux_report.csv
fi
