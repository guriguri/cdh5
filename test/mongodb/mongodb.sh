#!/bin/bash

echo ">>>>> create user"
mongo mongodb.cdh5-local/admin -u admin -p adminpasswd<<-EOSQL
use test

db.addUser({
    user: 'test',
    pwd: 'testpasswd',
    roles: [
 		"dbAdmin",
		"readWrite"
	]
})
EOSQL

echo ">>>>> create userinfo"
mongo mongodb.cdh5-local/test -u test -p testpasswd<<-EOSQL
db.userinfo.insert([
	{"name": "Park",  "age": 20},
	{"name": "Kim", "age": 30}
]) 
EOSQL

echo ">>>>> read userinfo"
mongo mongodb.cdh5-local/test -u test -p testpasswd<<-EOSQL
db.userinfo.find()
db.userinfo.find({"name": {\$in : ["Kim"]}})
db.userinfo.find({"name": "Park"})
EOSQL

echo ">>>>> update userinfo"
mongo mongodb.cdh5-local/test -u test -p testpasswd<<-EOSQL
db.userinfo.update({"name": "Park"}, {name: "Lee"})
db.userinfo.find()
db.userinfo.update({"name": "Lee"}, {\$set : {age: 40}})
db.userinfo.find()
EOSQL

echo ">>>>> delete userinfo"
mongo mongodb.cdh5-local/test -u test -p testpasswd<<-EOSQL
db.userinfo.remove({name: "Lee"})
db.userinfo.find()
EOSQL

echo ">>>>> drop userinfo"
mongo mongodb.cdh5-local/test -u test -p testpasswd<<-EOSQL
db.userinfo.drop()
show collections
EOSQL

echo ">>>>> drop user"
mongo mongodb.cdh5-local/admin -u admin -p adminpasswd<<-EOSQL
use test
db.removeUser("test")
db.system.users.find()
EOSQL
