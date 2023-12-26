#!/bin/bash

FILES=( "/etc/keystone/keystone.conf" \
        "/etc/keystone/keystone-paste.ini" \
        "/etc/keystone/policy.json" \
        "/etc/keystone/logging.conf" \
        "/etc/keystone/ssl/certs/signing_cert.pem" \
        "/etc/keystone/ssl/private/signing_key.pem" \
        "/etc/keystone/ssl/certs/ca.pem" )

VULN=false
found_file=false

# 검사 파일 존재 확인
for file in "${FILES[@]}"; do
    if [[ -e "$file" ]]; then
        found_file=true
        break
    fi
done

if [[ "$found_file" == false ]]; then
    echo "[OT-02] N/A: No files to check."
		if [ -e "openstack_report.csv" ]; then
			echo "파일 권한 관리,OT-02,Identity 설정파일 접근권한 설정,상,N/A" >> openstack_report.csv
			echo "[OT-02] Report generated."
		else
			echo "구분,진단 코드,진단 항목,취약도,점검 결과" > openstack_report.csv
			echo "파일 권한 관리,OT-02,Identity 설정파일 접근권한 설정,상,N/A" >> openstack_report.csv
			echo "[OT-02] Report generated."
		fi
    exit 1
fi

for FILEPATH in "${FILES[@]}"
do
    if [ -e "$FILEPATH" ]; then
        PERMISSIONS=$(stat -c '%a' "$FILEPATH")
        if [ "$PERMISSIONS" -ge 640 ]; then
            echo "[OT-02] $FILEPATH is safe"
        else
            echo "[OT-02] $FILEPATH is vulnerable"
            VULN=true
        fi
    fi
done

# VULN 값에 따라 취약 / 양호 레포트 작성.
if [ "$VULN" = true ]; then
    REPORT="파일 권한 관리,OT-02,Identity 설정파일 접근권한 설정,상,취약"
else
    REPORT="파일 권한 관리,OT-02,Identity 설정파일 접근권한 설정,상,양호"
fi

# 파일이 존재하면 이어서 작성, 존재하지 않으면 보고서 헤더 작성 후 레포트 작성.
if [ -e "openstack_report.csv" ]; then
    echo "$REPORT" >> openstack_report.csv
    echo "[OT-02] Report generated."
else
    echo "구분,진단 코드,진단 항목,취약도,점검 결과" > openstack_report.csv
    echo "$REPORT" >> openstack_report.csv
    echo "[OT-02] Report generated."
fi

exit 0
