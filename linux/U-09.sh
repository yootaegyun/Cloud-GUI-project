#!/bin/bash

CODE="U-09"
VULN=false

# /etc/shadow가 없는 경우 비정상 종료
if [[ ! -e "/etc/shadow" ]]; then
    echo "[$CODE] N/A: /etc/shadow does not exist."
		if [ -e "linux_report.csv" ]; then
			echo "파일 및 디렉토리 관리,$CODE,/etc/shadow 파일 소유자 및 권한 설정,상,N/A" >> linux_report.csv
			echo "[$CODE] Report generated."
		else
			echo "구분,진단 코드,진단 항목,취약도,점검 결과" > linux_report.csv
			echo "파일 및 디렉토리 관리,$CODE,/etc/shadow 파일 소유자 및 권한 설정,상,N/A" >> linux_report.csv
			echo "[$CODE] Report generated."
		fi
    exit 1
fi

# /etc/shadow 파일의 소유자가 root인지 확인
if [ "$(stat -c '%U' /etc/shadow)" != "root" ]; then
	echo "[$CODE] VULN: The owner of /etc/shadow is not root."
	VULN=true
fi

# /etc/shadow 파일의 권한이 400 이하인지 확인
if [ "$(stat -c '%a' /etc/shadow)" -gt 400 ]; then
	echo "[$CODE] VULN: The permissions of /etc/shadow are not 400 or less."
	VULN=true
fi

# 취약점이 발견되지 않았을 경우 메시지 출력
if [ "$VULN" = false ]; then
    echo "[$CODE] OK: No vulnerability found"
fi

# VULN 값에 따라 취약 / 양호 레포트 작성.
if [ "$VULN" = true ]; then
    REPORT="파일 및 디렉토리 관리,$CODE,/etc/shadow 파일 소유자 및 권한 설정,상,취약"
else
    REPORT="파일 및 디렉토리 관리,$CODE,/etc/shadow 파일 소유자 및 권한 설정,상,양호"
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
