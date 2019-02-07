#!/bin/bash
set -x

# start supervisord
/usr/bin/supervisord &

# start mysql
service mysql start

# Wait for DFS to come out of safe mode
until hdfs dfsadmin -safemode wait
do
    echo "Waiting for HDFS safemode to turn off"
    # force safemode leave
    hdfs dfsadmin -safemode leave
done

/usr/lib/hive/bin/schematool -dbType mysql -initSchema

# start hive-metastore by daemon
service hive-metastore start
/etc/init.d/daemon hive-metastore &

tail -f `find /var/log -name *.log -or -name *.out`
