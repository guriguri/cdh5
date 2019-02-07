#!/bin/bash
set -x

# start supervisord
/usr/bin/supervisord &

# set oozie
## set env
source /usr/lib/oozie/bin/oozie-env.sh
source /usr/lib/oozie/tomcat-deployment.sh

## set log, etc, ...
install -d -o oozie -g oozie /var/run/oozie
install -d -o oozie -g oozie /var/log/oozie
install -d -o oozie -g oozie /var/tmp/oozie

## create db for oozie
sudo -u oozie /usr/lib/oozie/bin/ooziedb.sh create -run


# Wait for DFS to come out of safe mode
until hdfs dfsadmin -safemode wait
do
    echo "Waiting for HDFS safemode to turn off"
    # force safemode leave
    hdfs dfsadmin -safemode leave
done


# create hdfs file system
## oozie.service.WorkflowAppService.system.libpath of oozie-site.xml 
export OOZIE_SHARELIB_URI=hdfs:///user/oozie/share/lib
LIBS=$(hdfs dfs -ls /user/oozie/share/lib)
if [ ${#LIBS} -ge 1 ]; then
	echo "already exist sharelib"
else
	sudo -u oozie /usr/lib/oozie/bin/oozie-setup.sh sharelib create -fs "${OOZIE_SHARELIB_URI}" -locallib /usr/lib/oozie/oozie-sharelib-yarn
fi

## Create yarn.app.mapreduce.am.staging-dir. Refer to mapred-site.xml.
sudo -u hdfs hdfs dfs -mkdir -p /user/oozie
sudo -u hdfs hdfs dfs -chmod -R 1777 /user/oozie
sudo -u hdfs hdfs dfs -chown oozie:hadoop /user/oozie

## Create the parent directory of yarn.nodemanager.remote-app-log-dir.
## Refer to yarn-site.xml.
sudo -u hdfs hadoop fs -mkdir -p /var/log/hadoop-oozie
sudo -u hdfs hadoop fs -chown yarn:oozie /var/log/hadoop-oozie

# start oozie by daemon
service oozie start
/etc/init.d/daemon oozie &

tail -f `find /var/log -name *.log -or -name *.out`
