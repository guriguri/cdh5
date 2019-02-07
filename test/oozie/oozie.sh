#!/bin/bash

echo ">>>>> upload workflow data"
hadoop fs -rm -r /tmp/test/test-workflow
hadoop fs -mkdir -p /tmp/test
hadoop fs -put test-workflow /tmp/test/
echo ""

if [ "${OOZIE_URL}" = "" ]; then
	OOZIE_URL="http://oozie.cdh5-local:11000/oozie"
fi

echo ">>>>> run job"
oozie job -oozie ${OOZIE_URL} -config job.properties -run
echo ""
