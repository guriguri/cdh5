-- sqoop
CREATE DATABASE sqoop DEFAULT CHARACTER SET UTF8;
GRANT ALL PRIVILEGES ON sqoop.* TO 'sqoop'@'localhost' IDENTIFIED BY 'sqooppasswd';
GRANT ALL PRIVILEGES ON sqoop.* TO 'sqoop'@'%' IDENTIFIED BY 'sqooppasswd';
FLUSH PRIVILEGES;

USE sqoop;
-- for import 
CREATE TABLE userinfo_import (id INT, name VARCHAR(20));
INSERT INTO userinfo_import (id, name) VALUES (1, "may");
INSERT INTO userinfo_import (id, name) VALUES (2, "kei");
INSERT INTO userinfo_import (id, name) VALUES (3, "jane");

-- for export 
CREATE TABLE userinfo_export (id INT, name VARCHAR(20));
COMMIT;
