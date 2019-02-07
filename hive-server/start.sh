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

# start hive-webhcat-server, hive-server2 by daemon
service hive-webhcat-server start
service hive-server2 start
/etc/init.d/daemon hive-webhcat-server &
/etc/init.d/daemon hive-server2 &

tail -f `find /var/log -name *.log -or -name *.out`
