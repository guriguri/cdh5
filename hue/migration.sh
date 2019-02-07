#!/bin/bash

MIGRATION_DONE_FILE="/etc/hue/conf/migration-done"

if [ -f "${MIGRATION_DONE_FILE}" ]; then
	echo "already be migrated."

	# disable migration.sh
	chmod 644 /root/migration.sh

	exit -1
fi

# migration
cd /usr/lib/hue
source build/env/bin/activate
hue syncdb --noinput
hue migrate
deactivate

# disable migration.sh
chmod 644 /root/migration.sh
touch ${MIGRATION_DONE_FILE} 
