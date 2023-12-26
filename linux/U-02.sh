#!/bin/bash

# /etc/pam.d/common-password 또는 /etc/security/pwquality.conf 파일이 있는지 확인
# 둘 다 존재하지 않으면 스크립트는 오류 메시지를 출력하고 종료
if [[ ! -f "/etc/pam.d/common-password" ]] && [[ ! -f "/etc/security/pwquality.conf" ]]; then
  echo "ERROR: /etc/pam.d/common-password and /etc/security/pwquality.conf files not found!"
  exit 1
fi

# 암호 요구 사항 기본값 8과 3
minlen=8
minclass=3

# /etc/security/pwquality.conf 파일에서 암호 요구 사항 확인
if [[ -f "/etc/security/pwquality.conf" ]]; then
  # minlen 매개 변수 확인
  if grep -q "^minlen" /etc/security/pwquality.conf; then
    minlen=$(grep "^minlen" /etc/security/pwquality.conf | awk '{print $2}')
  fi

  # minclass 매개 변수 확인
  if grep -q "^minclass" /etc/security/pwquality.conf; then
    minclass=$(grep "^minclass" /etc/security/pwquality.conf | awk '{print $2}')
  fi
fi

# /etc/pam.d/common-password 파일에서 암호 요구 사항 확인
# password.*pam_pwquality.so 패턴 검색 매개 변수가 없으면 기본값 8과 3 사용
if [[ -f "/etc/pam.d/common-password" ]]; then
  # 암호 복잡성 요구 사항 확인
  if grep -q "password.*pam_pwquality.so" /etc/pam.d/common-password; then
    if grep -q "minlen=[0-9]\+" /etc/pam.d/common-password; then
      minlen=$(grep "minlen=[0-9]\+" /etc/pam.d/common-password | awk -F= '{print $2}')
    fi

    if grep -q "minclass=[0-9]\+" /etc/pam.d/common-password; then
      minclass=$(grep "minclass=[0-9]\+" /etc/pam.d/common-password | awk -F= '{print $2}')
    fi
  fi
fi

# 암호 요구 사항을 확인
if [[ $minlen -ge 8 ]] && [[ $minclass -ge 3 ]]; then
  result="양호"
else
  result="취약"
fi

# 결과를 csv 파일에 저장
echo "계정관리,U-02,패스워드 복잡성 설정,상,$result" >> linux_report.csv
