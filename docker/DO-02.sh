#!/bin/bash

# 도커 그룹 이름 설정
docker_group="dockerroot"

# 도커 그룹에 속한 사용자 계정 조회
docker_users=$(getent group "$docker_group" | cut -d: -f4)

# 도커 그룹에 불필요한 사용자가 존재하지 않는 경우
if [ -z "$docker_users" ]; then
  result="양호"
else
  # root 및 dockerroot 그룹에 속한 사용자 계정 동시 조회
  root_users=$(getent group root | cut -d: -f4)
  all_docker_users=$(echo "$docker_users,$root_users" | tr ',' '\n' | sort -u | tr '\n' ',' | sed 's/,$//')

  # 도커 그룹에 불필요한 사용자가 존재하는 경우
  if [ "$all_docker_users" != "$docker_users" ]; then
    result="취약"
  else
    result="양호"
  fi
fi

# 결과를 csv 파일에 저장
echo "Host설정,DO-02,도커 그룹에 불필요한 사용자 제거,중,$result" >> docker_report.csv
