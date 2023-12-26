#!/bin/bash

if [ ! -d "/etc/keystone" ]; then
  echo "암호화,OT-16,PKI토근의 강력한 해시 알고리즘 사용,상,N/A" >> openstack_report.csv
exit
fi

if [ -f "/etc/keystone/keystone.conf" ]; then
	if [ "$(cat /etc/keystone/keystone.conf | grep provider | awk '{print $3}')" = "fernet" ]; then
		echo "암호화,OT-16,PKI토근의 강력한 해시 알고리즘 사용,상,양호" >> openstack_report.csv
	elif [ "$(cat /etc/keystone/keystone.conf | grep hash_algorithm | awk '{print $3}')" = "Sha256" ]; then
		echo "암호화,OT-16,PKI토근의 강력한 해시 알고리즘 사용,상,양호" >> openstack_report.csv
	else
		echo "암호화,OT-16,PKI토근의 강력한 해시 알고리즘 사용,상,취약" >> openstack_report.csv
	fi
fi
