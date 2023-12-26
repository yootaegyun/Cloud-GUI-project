#!/bin/bash

# 실행할 스크립트 파일들을 배열에 추가
scripts=(OT-01.sh OT-02.sh OT-03.sh OT-04.sh OT-05.sh OT-06.sh OT-07.sh OT-08.sh OT-09.sh OT-10.sh OT-11.sh OT-12.sh OT-13.sh OT-14.sh OT-15.sh OT-16.sh OT-17.sh OT-18.sh OT-19.sh OT-20.sh OT-21.sh OT-22.sh OT-23.sh OT-24.sh OT-25.sh OT-26.sh OT-27.sh OT-28.sh OT-29.sh OT-30.sh OT-31.sh OT-32.sh OT-33.sh OT-34.sh OT-35.sh OT-36.sh OT-37.sh OT-38.sh OT-39.sh OT-40.sh OT-41.sh OT-42.sh OT-43.sh OT-44.sh OT-45.sh OT-46.sh OT-47.sh)

# 배열에 추가한 스크립트 파일들을 차례대로 실행
for script in "${scripts[@]}"
do
    bash "./openstack/$script"
    echo "[$script] execution completed."
done