echo "remove & load file ============="
hadoop fs -mkdir -p /user/test/tmp
hadoop fs -rm -r /user/test/tmp/passwd
hadoop fs -put passwd /user/test/tmp/
echo ""

echo "create table ==================="
beeline -u jdbc:hive2://hiveserver.cdh5-local:10000 -n test --silent=true -e "CREATE TABLE IF NOT EXISTS userinfo ( uname STRING, pswd STRING, uid INT, gid INT, fullname STRING, hdir STRING, shell STRING ) ROW FORMAT DELIMITED FIELDS TERMINATED BY ':' STORED AS TEXTFILE;"
echo ""

echo "load data ======================"
beeline -u jdbc:hive2://hiveserver.cdh5-local:10000 -n test --silent=true -e "LOAD DATA INPATH '/user/test/tmp/passwd' OVERWRITE INTO TABLE userinfo;"
echo ""

echo "select ========================="
beeline -u jdbc:hive2://hiveserver.cdh5-local:10000 -n test --silent=true -e "SELECT uname, fullname, hdir FROM userinfo ORDER BY uname;" 
echo ""
