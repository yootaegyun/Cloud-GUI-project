
#!/bin/bash

# 잠금 임계값이 /etc/pam.d/common-auth 파일에 설정되어 있는지 확인
lockout_threshold=$(grep -Po '(?<=deny=)[0-9]*' /etc/pam.d/common-auth)

# 계정 잠금 임계값이 설정되어 있지 않거나 5 이하의 값으로 설정되어 있지 않은 경우
# 잠금 임계값이 설정되어 있지 않은 경우 변수가 빈 문자열을 취약한 상태로 판단
if [[ -z $lockout_threshold ]]; then
  result="취약"
else
  if (( $lockout_threshold <= 5 )); then
    result="양호"
  else
    result="취약"
  fi
fi

# 결과를 csv 파일에 저장
echo "계정관리,U-03,계정 잠금 임계값 설정,상,$result" >> linux_report.csv
