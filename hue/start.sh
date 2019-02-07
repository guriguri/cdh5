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

# hue's mysql
if [ -x "/root/migration.sh" ]; then
	/root/migration.sh
fi

sudo -u hdfs hdfs dfs -mkdir /user/hue
sudo -u hdfs hdfs dfs -chmod -R 1777 /user/hue
sudo -u hdfs hdfs dfs -chown hue:hadoop /user/hue

# start hue by daemon
service hue start
/etc/init.d/daemon hue &

tail -f `find /var/log -name *.log -or -name *.out`
