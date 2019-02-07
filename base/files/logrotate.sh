#!/bin/bash

# backup and truncate
FILES=`find /var/log -name *.log -or -name *.out`
for file in $FILES; do
        echo "backup, cp $file $file.`date +%Y%m%d_%H%M%S`"
        cp $file $file.`date +%Y%m%d_%H%M%S`

        echo "truncate, $file"
        echo "" > $file
done

# remove 
DAYS=2
RM_FILES=`find /var/log -ctime +${DAYS} -name *.log -or -ctime ${DAYS} -name *.out`
for file in $RM_FILES; do
        echo "rm -rf $file"
        rm -rf $file
done
