#!/bin/bash

# 점검 파일 경로
FILES=( "/etc/keystone/keystone.conf" \
        "/etc/keystone/keystone-paste.ini" \
        "/etc/keystone/policy.json" \
        "/etc/keystone/logging.conf" \
        "/etc/keystone/ssl/certs/signing_cert.pem" \
        "/etc/keystone/ssl/private/signing_key.pem" \
        "/etc/keystone/ssl/certs/ca.pem" )

OWNER="keystone"
GROUP="keystone"
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
    echo "[OT-01] N/A: No files to check."
		if [ -e "openstack_report.csv" ]; then
			echo "파일 권한 관리,OT-01,Identity 설정파일 소유권 설정,상,N/A" >> openstack_report.csv
			echo "[OT-01] Report generated."
		else
			echo "구분,진단 코드,진단 항목,취약도,점검 결과" > openstack_report.csv
			echo "파일 권한 관리,OT-01,Identity 설정파일 소유권 설정,상,N/A" >> openstack_report.csv
			echo "[OT-01] Report generated."
		fi
    exit 1
fi


for FILEPATH in "${FILES[@]}"
do
    if [ -e "$FILEPATH" ]; then # 파일이 존재하면 작동함.
        # 오너와 그룹이 모두 keystone이면 safe, 아니면 vuln.
        if [[ "$(stat -c '%U' "$FILEPATH")" == "$OWNER" && "$(stat -c '%G' "$FILEPATH")" == "$GROUP" ]]; then
            echo "[OT-01] $FILEPATH is safe"
        else
            echo "[OT-01] $FILEPATH is vulnerable"
            VULN=true
        fi
    fi
done

# VULN 값에 따라 취약 / 양호 레포트 작성.
if [ "$VULN" = true ]; then
    REPORT="파일 권한 관리,OT-01,Identity 설정파일 소유권 설정,상,취약"
else
    REPORT="파일 권한 관리,OT-01,Identity 설정파일 소유권 설정,상,양호"
fi

# 파일이 존재하면 이어서 작성, 존재하지 않으면 보고서 헤더 작성 후 레포트 작성.
if [ -e "openstack_report.csv" ]; then
    echo "$REPORT" >> openstack_report.csv
    echo "[OT-01] Report generated."
else
    echo "구분,진단코드,진단항목,취약도,점검결과" > openstack_report.csv
    echo "$REPORT" >> openstack_report.csv
    echo "[OT-01] Report generated."
fi

exit 0