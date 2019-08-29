-- fix debian bug
-- see /etc/mysql/debian.cnf
UPDATE mysql.user SET PASSWORD = PASSWORD('drGHetfbqGZ9F2KA') WHERE USER = 'debian-sys-maint';

-- root
UPDATE mysql.user SET PASSWORD = PASSWORD('rootpasswd') WHERE USER = 'root';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'rootpasswd' WITH GRANT OPTION;

-- hive metastore
CREATE DATABASE metastore DEFAULT CHARACTER SET UTF8;
GRANT ALL PRIVILEGES ON metastore.* TO 'hive'@'localhost' IDENTIFIED BY 'elephants';
GRANT ALL PRIVILEGES ON metastore.* TO 'hive'@'%' IDENTIFIED BY 'elephants';

-- hue
CREATE DATABASE hue DEFAULT CHARACTER SET UTF8;
GRANT ALL PRIVILEGES ON hue.* TO 'hue'@'localhost' IDENTIFIED BY 'huepasswd';
GRANT ALL PRIVILEGES ON hue.* TO 'hue'@'%' IDENTIFIED BY 'huepasswd';

-- oozie
CREATE DATABASE oozie DEFAULT CHARACTER SET UTF8;
GRANT ALL PRIVILEGES ON oozie.* TO 'oozie'@'localhost' IDENTIFIED BY 'ooziepasswd';
GRANT ALL PRIVILEGES ON oozie.* TO 'oozie'@'%' IDENTIFIED BY 'ooziepasswd';

FLUSH PRIVILEGES;
