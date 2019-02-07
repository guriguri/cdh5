#!/bin/bash
set -x

# start supervisord
/usr/bin/supervisord &

# start mongodb by daemon
service mongodb start
/etc/init.d/daemon mongodb &

sleep 5

/root/mongodb-init.sh

tail -f `find /var/log -name *.log -or -name *.out`
