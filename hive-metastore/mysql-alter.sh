#!/bin/bash

MYSQL_ALTER_DONE_FILE="/etc/hive/conf/mysql-alter-done"

if [ -f "${MYSQL_ALTER_DONE_FILE}" ]; then
	echo "already alter."
	exit -1
fi

# alter
mysql -uhive -pelephants < /root/mysql-alter.sql

# disable migration.sh
touch ${MYSQL_ALTER_DONE_FILE} 
