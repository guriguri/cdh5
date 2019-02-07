# cluster-node 

FROM guriguri/ubuntu-cdh5-base

###########
# install
## perform one apt-get install and one apt-get update
RUN apt-get update -y &&\
	apt-get install -y --no-install-recommends \
    hadoop-hdfs-datanode hadoop-mapreduce hadoop-yarn-nodemanager


###########
# setup
## hdfs
RUN mkdir -p /var/lib/hadoop-hdfs/cache/hdfs/dfs/data &&\
    chown -R hdfs:hdfs /var/lib/hadoop-hdfs/cache/hdfs/dfs/data &&\
    mkdir -p /var/lib/hadoop-yarn/cache/nm-local-dir &&\
    chown -R yarn:yarn /var/lib/hadoop-yarn/cache/nm-local-dir &&\
    mkdir -p /var/log/hadoop-yarn/containers &&\
    chown -R yarn:yarn /var/log/hadoop-yarn/containers

COPY start.sh /opt/hadoop-docker/


###########
# cleanup
## perform cleanup to reduce image size
RUN apt-get autoremove -y &&\
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/* &&\
    rm -rf /usr/share/doc/* /usr/share/man/* /usr/share/info/* &&\
    find /var | grep '\.log$' | xargs rm -fv


###########
# run
USER root
CMD ["/opt/hadoop-docker/start.sh"]

#ports exposed in sequence
# dfs.datanode.address
# dfs.datanode.address (Secure)
# dfs.datanode.http.address
# dfs.datanode.https.address
# dfs.datanode.http.address (Secure)
# dfs.datanode.ipc.address
# mapreduce.shuffle.port (created by the YARN NodeManager?)
EXPOSE 50010 1004 50075 50475 1006 50020 13562
