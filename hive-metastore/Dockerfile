# hive-metastore

FROM guriguri/ubuntu-cdh5-base

###########
# install
## perform one apt-get install and one apt-get update
## using mysql for metastore
RUN apt-get update -y &&\
    apt-get install -y --no-install-recommends \
	hive hive-metastore &&\
    ln -s /usr/share/java/mysql-connector-java.jar /usr/lib/hive/lib/mysql-connector-java.jar

ADD mysql-init.sql /root/mysql-init.sql

## mysql
RUN DEBIAN_FRONTEND=noninteractive \
	apt-get install -y --no-install-recommends \
	mysql-server &&\
  sed -i 's/^\(bind-address\s.*\)/# \1/' /etc/mysql/my.cnf &&\
  sed -i 's/^\(log_error\s.*\)/# \1/' /etc/mysql/my.cnf &&\
  echo "mysqld_safe &" > /tmp/config &&\
  echo "mysqladmin --silent --wait=30 ping || exit 1" >> /tmp/config &&\
  echo "mysql < /root/mysql-init.sql" >> /tmp/config &&\
  bash /tmp/config &&\
  rm -f /tmp/config

ADD start.sh /opt/hadoop-docker/start.sh


###########
# cleanup
## perform cleanup to reduce base image size
RUN apt-get autoremove -y &&\
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/* &&\
    rm -rf /usr/share/doc/* /usr/share/man/* /usr/share/info/* &&\
    find /var | grep '\.log$' | xargs rm -vf


###########
# run
USER root
WORKDIR /data
CMD ["/opt/hadoop-docker/start.sh"]

## Define mountable directories.
#VOLUME ["/etc/mysql", "/var/lib/mysql"]
VOLUME ["/etc/mysql"]

# Exposed ports in sequence.
# MySQL port
# Hive Metastore port
EXPOSE 3306 9083
