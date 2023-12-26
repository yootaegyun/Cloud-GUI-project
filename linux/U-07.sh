#!/bin/bash

CODE="U-07"
VULN=false

# 소유자나 그룹이 없는 파일 및 디렉터리 검색
search_result=$(find / -nouser -o -nogroup 2> /dev/null)

# 검색 결과 출력
if [ -z "$search_result" ]; then
	echo "[$CODE] OK: No files or directories without owners or groups found."
else
	echo "[$CODE] VULN: Files or directories without owners or groups:"
	echo "$search_result"
	VULN=true
fi

# VULN 값에 따라 취약 / 양호 레포트 작성.
if [ "$VULN" = true ]; then
    REPORT="파일 및 디렉토리 관리,$CODE,파일 및 디렉터리 소유자 설정,상,취약"
else
    REPORT="파일 및 디렉토리 관리,$CODE,파일 및 디렉터리 소유자 설정,상,양호"
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
