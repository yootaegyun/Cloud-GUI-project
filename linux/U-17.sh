#!/bin/bash
# rsh,rlogin, rexec (login, shell, exec) 서비스 사용 여부 확인 [ $(systemctl is-enabled sshd)=="enabled" ] || 

if [ "$(systemctl is-enabled rlogin 2>/dev/null)" != 0 -a "$(systemctl is-enabled rlogin 2>/dev/null)" = "enabled" ] || [ "$(systemctl is-enabled rsh 2>/dev/null)" != 0 -a "$(systemctl is-enabled rsh 2>/dev/null)" = "enabled" ] || [ "$(systemctl is-enabled rexec 2>/dev/null)" != 0 -a "$(systemctl is-enabled rexec 2>/dev/null)" = "enabled" ]; then
    resultA="취약"
else
    resultA="양호"
fi

# hosts.eqiv 파일 소유자가 root 또는 해당 계정인 경우 : 양호
if [ -f "/etc/hosts.eqiv" ] & [ -f "$HOME/rhosts" ]; then
      if [ "$(stat -c %U /etc/hosts.eqiv)" = "root" ] || [ "$(stat -c %U /etc/hosts.eqiv)" = "$(whoami)" ]; then
          if [ "$(stat -c %U $HOME/rhosts)" = "root" ] || [ "$(stat -c %U $HOME/rhosts)" = "$(whoami)" ]; then
              resultB="양호"
          
          else
              resultB="취약"
          fi
      else
        resultB="취약"
      fi
else
     resultB="양호"
fi


# /etc/hosts.eqiv 및  $HOME/rhosts 파일 권한 확인

if [ -f "/etc/hosts.eqiv" ] & [ -f "$HOME/rhosts" ]; then
       if [ "$(stat -c '%a' /etc/hosts.eqiv)" -le 600 ]; then
                if [ "$(stat -c '%a' $HOME/rhosts)" -le 600 ]; then
                    resultC="양호"
                else
                    resultC="취약"
                fi
       else
              resultC="취약"
       fi
else
     resultC="양호"
fi

#  + 설정 여부
if [ -f "/etc/hosts.eqiv" ] & [ -f "$HOME/rhosts" ]; then
      if [ "$(grep -c "^+" /etc/hosts.equiv)" -eq 0 ]; then
                if [ "$(grep -c "^+" $HOME/rhosts)" -eq 0 ]; then
                    resultD="양호"
                else
                    resultD="취약"     
                fi  
      else
           resultD="취약"
      fi
else
      resultD="양호"  
fi

if [[ $resultA == "취약" || $resultB == "취약" || $resultC == "취약" || $resultD == "취약" ]]; then
  echo "파일 및 디렉토리 관리,U-17,\$HOME/.rhosts hosts.equiv 사용금지,상,취약" >> linux_report.csv
else
  echo "파일 및 디렉토리 관리,U-17,\$HOME/.rhosts hosts.equiv 사용금지,상,양호" >> linux_report.csv
fi


