#!/bin/bash

# 컨테이너 목록 조회
container_list=$(docker ps -q --all)

# 초기 상태: 양호
result="양호"

# 컨테이너별 User 확인
for container_id in $container_list; do
  user=$(docker inspect --format="{{ .Id }}: User={{ .Config.User }}" $container_id)
  if [[ "$user" == *": User="* ]]; then
    user_value="${user#*: User=}"
    if [[ -n "$user_value" ]]; then
      result="취약"
      break
    fi
  fi
done

echo "컨테이너 이미지 및 빌드 파일,DO-25,root가 아닌 user로 컨테이너 실행,중,$result" >> docker_report.csv
