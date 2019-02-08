#!/bin/sh

echo ">>>>> PUT index" 
curl -X PUT \
-H 'Content-Type: application/json' \
-d '{ "name" : "Test User" }' \
http://es.cdh5-local:9200/test_index/user/1?pretty=true -v

echo ">>>>> GET index" 
curl http://es.cdh5-local:9200/test_index/user/1?pretty=true -v

echo ">>>>> DELETE index" 
curl -X DELETE \
http://es.cdh5-local:9200/test_index?pretty=true -v
