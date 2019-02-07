#!/bin/bash
if [ "${SQOOP_DB_URL}" = "" ]; then
	SQOOP_DB_URL=jdbc:mysql://hivemetastore.cdh5-local:3306/sqoop
fi
if [ "${SQOOP_DB_USERNAME}" = "" ]; then
	SQOOP_DB_USERNAME=sqoop
fi
if [ "${SQOOP_DB_PASSWORD}" = "" ]; then
	SQOOP_DB_PASSWORD=sqooppasswd
fi
MAPPER_NUM=1

WORK_DIR="/tmp/test/sqoop"

echo ">>>>> init work directory" 
hadoop fs -rm -r ${WORK_DIR}


echo ">>>>> import"
# default target-dir is ${USER_PATH}/${TABLE_NAME}
sqoop import --connect ${SQOOP_DB_URL} \
	--username ${SQOOP_DB_USERNAME} --password ${SQOOP_DB_PASSWORD} \
	--table userinfo_import \
	--target-dir ${WORK_DIR}/userinfo_import \
	-m ${MAPPER_NUM}
hadoop fs -cat ${WORK_DIR}/userinfo_import/part-m-00000
rm userinfo_import.java


echo ">>>>> export"
# default target-dir is ${USER_PATH}/${TABLE_NAME}
sqoop export --connect ${SQOOP_DB_URL} \
	--username ${SQOOP_DB_USERNAME} --password ${SQOOP_DB_PASSWORD} \
	--table userinfo_export \
	--export-dir ${WORK_DIR}/userinfo_import \
	-m ${MAPPER_NUM}
rm userinfo_export.java
