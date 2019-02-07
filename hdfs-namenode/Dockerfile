# hdfs-namenode

FROM guriguri/ubuntu-cdh5-base

###########
# install
## perform one apt-get install and one apt-get update
RUN apt-get update -y &&\
	apt-get install -y --no-install-recommends \
	hadoop-hdfs-namenode


###########
# setup
## hdfs
RUN mkdir -p /var/lib/hadoop-hdfs/cache/hdfs/dfs/name &&\
    chown -R hdfs:hdfs /var/lib/hadoop-hdfs/cache/hdfs/dfs/name

## We need skeleton configs to format the namenode
COPY ["conf.skeleton", "/etc/hadoop/cluster-conf"]

## Before starting the NameNode for the first time you need to format the file system.
RUN service hadoop-hdfs-namenode init

COPY start.sh /opt/hadoop-docker/

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
CMD ["/opt/hadoop-docker/start.sh"]

# ports exposed in sequence
# fs.defaultFS
# dfs.namenode.servicerpc-address
# dfs.namenode.http-address (HTTP)
# dfs.namenode.https-address (HTTPS)
EXPOSE 8020 8022 50070 50470
