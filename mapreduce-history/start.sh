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


# Wait for resource manager to come alive on its standard port
until nc -z -w5 yarnresourcemanager.cdh5-local 8032
do
    echo "Waiting for YARN ResourceManager to become available"
    sleep 1
done

# start hadoop-mapreduce-historyserver by daemon
service hadoop-mapreduce-historyserver start
/etc/init.d/daemon hadoop-mapreduce-historyserver &

tail -f `find /var/log -name *.log -or -name *.out`
