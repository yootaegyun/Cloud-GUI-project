#!/bin/bash

CODE="U-12"
VULN=false
FILEPATH="/etc/rsyslog.conf"

# 검사할 파일이 존재하는지 확인
if [ ! -e "$FILEPATH" ]; then
    echo "[$CODE] N/A: $FILEPATH does not exist."
		if [ -e "linux_report.csv" ]; then
			echo "파일 및 디렉토리 관리,$CODE,/etc/(r)syslog.conf 파일 소유자 및 권한 설정,상,N/A" >> linux_report.csv
			echo "[$CODE] Report generated."
		else
			echo "구분,진단 코드,진단 항목,취약도,점검 결과" > linux_report.csv
			echo "파일 및 디렉토리 관리,$CODE,/etc/(r)syslog.conf 파일 소유자 및 권한 설정,상,N/A" >> linux_report.csv
			echo "[$CODE] Report generated."
		fi
    exit 1
fi

# 파일의 소유자가 root인지 확인
if [ "$(stat -c '%U' "$FILEPATH")" != "root" ]; then
	echo "[$CODE] VULN: The owner of $FILEPATH is not root."
	VULN=true
fi

# 파일의 권한이 644 이하인지 확인
if [ "$(stat -c '%a' "$FILEPATH")" -gt 644 ]; then
	echo "[$CODE] VULN: The permissions of $FILEPATH are not 644 or less."
	VULN=true
fi

# 취약점이 발견되지 않았을 경우 메시지 출력
if [ "$VULN" = false ]; then
    echo "[$CODE] OK: No vulnerability found"
fi

# VULN 값에 따라 취약 / 양호 레포트 작성.
if [ "$VULN" = true ]; then
    REPORT="파일 및 디렉토리 관리,$CODE,/etc/(r)syslog.conf 파일 소유자 및 권한 설정,상,취약"
else
    REPORT="파일 및 디렉토리 관리,$CODE,/etc/(r)syslog.conf 파일 소유자 및 권한 설정,상,양호"
fi

# 파일이 존재하면 이어서 작성, 존재하지 않으면 보고서 헤더 작성 후 레포트 작성.
if [ -e "linux_report.csv" ]; then
    echo "$REPORT" >> linux_report.csv
    echo "[$CODE] Report generated."
else
    echo "구분,진단 코드,진단 항목,취약도,점검 결과" > linux_report.csv
    echo "$REPORT" >> linux_report.csv
    echo "[$CODE] Report generated."
fi

exit 0
