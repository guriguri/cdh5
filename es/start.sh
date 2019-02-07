#!/bin/bash
set -x

# start supervisord
/usr/bin/supervisord &

tail -f `find /var/log -name *.log -or -name *.out`
