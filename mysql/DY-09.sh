#!/bin/bash

# 진단기준:
# 양호 - 최신 버전 패치가 되어있는 경우
# 취약 - 최신 버전 패치가 되어있지 않은 경우

# 진단방법:
# MYSQL 버전 확인 후 최신 패치 적용
# mysql> use mysql;
# mysql> SELECT @@version

# 조치방법:
# 데이터베이스에 대한 최신의 버전을 확인 후 업그레이드 및 패치 수행
# 버그 패치 릴리즈 사이트 : http://downloads.mysql.com/archives
# 버그 현황 사이트 : http://bugs.mysql.com/bugstats.php

echo "패치 및 로그관리,DY-09,최신 패치 적용,상,N/A" >> my-sql_report.csv
