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


# Create yarn.app.mapreduce.am.staging-dir. Refer to mapred-site.xml.
sudo -u hdfs hdfs dfs -mkdir -p /user/history
sudo -u hdfs hdfs dfs -chmod -R 1777 /user/history
sudo -u hdfs hdfs dfs -chown mapred:hadoop /user/history

# Create the parent directory of yarn.nodemanager.remote-app-log-dir.
# Refer to yarn-site.xml.
sudo -u hdfs hadoop fs -mkdir -p /var/log/hadoop-yarn
sudo -u hdfs hadoop fs -chown yarn:mapred /var/log/hadoop-yarn

# start hadoop-yarn-resourcemanager by daemon
service hadoop-yarn-resourcemanager start
/etc/init.d/daemon hadoop-yarn-resourcemanager &

tail -f `find /var/log -name *.log -or -name *.out`
