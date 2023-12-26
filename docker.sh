#!/bin/bash

# 실행할 스크립트 파일들을 배열에 추가
scripts=(DO-01.sh DO-02.sh DO-03.sh DO-04.sh DO-05.sh DO-06.sh DO-07.sh DO-08.sh DO-09.sh DO-10.sh DO-11.sh DO-12.sh DO-13.sh DO-14.sh DO-15.sh DO-16.sh DO-17.sh DO-18.sh DO-19.sh DO-20.sh DO-21.sh DO-22.sh DO-23.sh DO-24.sh DO-25.sh DO-26.sh DO-27.sh DO-28.sh DO-29.sh DO-30.sh DO-31.sh DO-32.sh)

# 배열에 추가한 스크립트 파일들을 차례대로 실행
for script in "${scripts[@]}"
do
    bash "./docker/$script"
    echo "[$script] execution completed."
done