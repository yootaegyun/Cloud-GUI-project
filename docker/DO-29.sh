#!/bin/bash

# 컨테이너 목록 조회
container_list=$(docker ps -q)

# 결과 초기화
result="양호"

# 컨테이너별 포트 매핑 상태 확인
for container_id in $container_list; do
  port_mapping=$(docker inspect --format '{{ .Id }}:Ports={{ .NetworkSettings.Ports }}' $container_id)

  if [[ "$port_mapping" == *"0.0.0.0:0->"* ]]; then
    result="취약"
    break
  fi
done

echo "컨테이너 런타임,DO-29,컨테이너에 privileged 포트 매핑 금지,중,$result" >> docker_report.csv