#!/bin/bash

# 컨테이너 네트워크 제한이 적용되는지 확인합니다
if docker network ls --quiet | xargs docker network inspect --format "{{ .Name}}: {{ .Options }}" | grep "com.docker.network.bridge.enable_ip_masquerade=false" >/dev/null; then
    result="양호"
else
    result="취약"
fi

# 결과를 csv 파일에 저장
echo "도커 데몬 설정,DO-09,default bridge를 통한 컨테이너 간 네트워크 트래픽 제한,상,$result" >> docker_report.csv
