#!/bin/bash

# 컨테이너 목록 조회
container_list=$(docker ps -q --all)

# 결과 초기화
result="양호"

# 컨테이너별 UsernsMode 확인
for container_id in $container_list; do
  userns_mode=$(docker inspect --format='{{ .Id }}:UsernsMode={{ .HostConfig.UsernsMode }}' $container_id)

  if [[ "$userns_mode" == *"UsernsMode="* && "$userns_mode" != *"UsernsMode="*:* ]]; then
    result="취약"
    break
  fi
done


echo "컨테이너 런타임,DO-32,호스트의 user namespaces 공유 제한,하,$result" >> docker_report.csv
