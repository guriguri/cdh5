#!/bin/bash
set -x

# start supervisord
/usr/bin/supervisord &

# Wait for DFS to come out of safe mode
until hdfs dfsadmin -safemode wait
do
    echo "Waiting for HDFS safemode to turn off"
    # force safemode leave
    hdfs dfsadmin -safemode leave
done

# start kafka-server
service kafka-server start

tail -f `find /var/log -name *.log -or -name *.out`
