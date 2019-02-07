#!/bin/bash
set -x

# start supervisord
/usr/bin/supervisord &

# start zookeeper by daemon
service zookeeper-server start
/etc/init.d/daemon zookeeper-server &

tail -f `find /var/log -name *.log -or -name *.out`
