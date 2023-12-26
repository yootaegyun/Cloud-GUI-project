#!/bin/bash

ps -ef | grep nfsd > /dev/null 2>&1

if [ $? -eq 0 ]; then
          echo "서비스 관리,U-24,NFS 서비스 비활성화,상,취약" >> linux_report.csv
else
          echo "서비스 관리,U-24,NFS 서비스 비활성화,상,양호" >> linux_report.csv
fi
