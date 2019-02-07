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
		"readWriteAnyDatabase"]
})
EOSQL
