#!/bin/bash

# 컨테이너 목록 조회
container_list=$(docker ps --quiet --all)

# 결과 초기화
result="양호"

# 컨테이너별 PIDs cgroup 제한 설정 확인
for container_id in $container_list; do
  pids_limit=$(docker inspect --format '{{ .Id }}:PidsLimit={{ .HostConfig.PidsLimit }}' $container_id)

  if [[ "$pids_limit" == *"PidsLimit=0"* ]] || [[ "$pids_limit" == *"PidsLimit=-1"* ]]; then
    result="취약"
    break
  fi
done

echo "컨테이너 런타임,DO-30,PIDs cgroup 제한,상,$result" >> docker_report.csv