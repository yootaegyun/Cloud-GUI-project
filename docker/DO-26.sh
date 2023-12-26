#!/bin/bash

# Docker 컨텐츠 신뢰성 설정 확인
docker_content_trust=$(echo $DOCKER_CONTENT_TRUST)

# 결과 값 설정
if [[ "$docker_content_trust" == "1" ]]; then
  result="양호"
else
  result="취약"
fi

echo "컨테이너 이미지 및 빌드 파일,DO-26,도커를 위한 컨텐츠 신뢰성 활성화,중,$result" >> docker_report.csv