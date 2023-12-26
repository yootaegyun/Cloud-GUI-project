#!/bin/bash

# Docker 인증 플러그인이 사용되도록 설정되었는지 확인합니다
if ps -ef | grep -v grep | grep "dockerd.*--authorization-plugin"; then
    result="양호"
else
    result="취약"
fi

# 'docker search' 명령에 인증이 필요한지 확인합니다
if docker search hello-world >/dev/null 2>&1; then
    result="취약"
fi

echo "도커 데몬 설정,DO-10,도커 클라이언트 인증 활성화,상,$result" >> docker_report.csv 
