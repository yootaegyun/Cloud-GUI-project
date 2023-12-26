#!/bin/bash

# 실행할 스크립트 파일들을 배열에 추가
scripts=(DY-01.sh DY-02.sh DY-03.sh DY-04.sh DY-05.sh DY-06.sh DY-07.sh DY-08.sh DY-09.sh)

pass=$1
export pass

# 배열에 추가한 스크립트 파일들을 차례대로 실행
for script in "${scripts[@]}"
do
    bash "./mysql/$script"
    echo "[$script] execution completed."
done