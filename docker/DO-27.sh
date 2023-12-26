
#!/bin/bash

# SELinux 보안옵션 확인
selinux_enabled=$(ps -ef | grep docker | grep selinux-enabled)

# 결과 값 설정
if [[ -z "$selinux_enabled" ]]; then
  result="N/A"
else
  if [[ -n $(echo "$selinux_enabled" | grep "selinux=1") ]]; then
    result="양호"
  else
    result="취약"
  fi
fi

echo "컨테이너 런타임,DO-27,컨테이너 SELinux 보안 옵션 설정,중,$result" >> docker_report.csv