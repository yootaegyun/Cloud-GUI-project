#!/bin/bash

# Default bridge docker0 사용 여부 확인
docker0_interface=$(ip link show docker0)

if [[ -z "$docker0_interface" ]]; then
  result="양호"
else
  result="취약"
fi

echo "컨테이너 런타임,DO-31,도커의 default bridge docker0 사용 제한,하,$result" >> docker_report.csv
