#!/bin/bash
result="양호"
not_found="N/A"

# 사용자 및 시스템 시작 파일, 환경 파일 검사
for dir in /etc/profile.d /etc/bashrc /etc/csh.cshrc /etc/csh.login /etc/csh.logout /etc/profile /etc/bash.bashrc /etc/environment /etc/security/limits.conf /etc/sysctl.conf /home/*
do
  # 해당 디렉토리가 존재하면
  if [[ -d "$dir" ]]; then
    # 해당 디렉토리 내 파일 검사
    for file in $(find "$dir" -type f)
    do
      # 파일 소유자, 권한 검사
      owner=$(stat -c '%U' "$file")
      mode=$(stat -c '%a' "$file")

      # 권한이 644이 아니거나 root 또는 해당 계정이 아닌 경우
      if [[ "$mode" != "644" || "$owner" != "root" && "$owner" != "${dir##*/}" ]]; then
        # 취약한 경우
        result="취약"
        break 2
      fi
    done
  else
      result="$not_found"
  fi
done

# 결과에 따라 리포트 파일에 추가
echo "파일 및 디렉토리 관리,U-15,사용자 시스템 시작파일 및 환경파일 소유자 및 권한 설정,상,$result" >> linux_report.csv
