USE default;

INSERT OVERWRITE DIRECTORY '${output}'
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
SELECT uname, fullname, hdir FROM userinfo ORDER BY uname