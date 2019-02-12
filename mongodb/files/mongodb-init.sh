#!/bin/bash
set -e

USERNAME="admin"
PASSWORD="adminpasswd"

mongo <<-EOSQL 
use admin

db.addUser({
	user: '${USERNAME}',
	pwd: '${PASSWORD}',
	roles: [
		"userAdminAnyDatabase",
		"dbAdminAnyDatabase",
		"clusterAdmin",
		"readWriteAnyDatabase"
	]
})
EOSQL


# modified roles on mongodb v2.4.9
# see: https://docs.mongodb.com/v2.4/reference/user-privileges/#roles

#db.system.users.update(
#	{"user": "admin"},
#	{$set:
#		{ "roles":
#			[
#				"userAdminAnyDatabase",
#				"dbAdminAnyDatabase",
#				"clusterAdmin",
#				"readWriteAnyDatabase"
#			]
#		}
#	}
#)
