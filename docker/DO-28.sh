#!/bin/bash

# 컨테이너 목록 조회
container_list=$(docker ps --quiet)

# SSH 사용 여부 초기화
ssh_enabled=false

# 모든 컨테이너의 SSH 사용 여부 확인
for container_id in $container_list; do
  ssh_status=$(docker exec $container_id sh -c "service ssh status > /dev/null 2>&1")
  
  if [[ $? -eq 0 ]]; then
    ssh_enabled=true
    break
  fi
done

# 결과 값 설정
if [[ $ssh_enabled == true ]]; then
  result="취약"
else
  result="양호"
fi

echo "컨테이너 런타임,DO-28,컨테이너에서 ssh 사용 금지,상,$result" >> docker_report.csv