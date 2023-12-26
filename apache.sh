#!/bin/bash

# 실행할 스크립트 파일들을 배열에 추가
scripts=(AP-01.sh AP-02.sh AP-03.sh AP-04.sh AP-05.sh AP-06.sh AP-07.sh)

# 배열에 추가한 스크립트 파일들을 차례대로 실행
for script in "${scripts[@]}"
do
    bash "./apache/$script"
    echo "[$script] execution completed."
done