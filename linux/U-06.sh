#!/bin/bash

# PATH 환경변수 값
path_value=$(echo $PATH)

# PATH 값에 "."이 맨 앞이나 중간에 포함 확인
# "."이 맨 앞이나 중간에 포함되어 있는지를 확인
if [[ $path_value == *.:* || $path_value == *:.* || $path_value == .* ]]; then
    result="취약"
else
    result="양호" 
fi

# 결과를 csv 파일에 저장
echo -e "파일 및 디렉토리 관리,U-06,root 홈 패스 디렉터리 권한 및 패스 설정,상,$result" >> linux_report.csv
