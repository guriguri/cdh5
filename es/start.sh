#!/bin/bash
set -x

# start supervisord
/usr/bin/supervisord &

# start elasticsearch, kibana by daemon
service elasticsearch start
service kibana start
/etc/init.d/daemon elasticsearch &
/etc/init.d/daemon kibana &

tail -f `find /var/log -name *.log -or -name *.out`
