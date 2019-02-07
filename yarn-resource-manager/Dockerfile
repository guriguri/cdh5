# yarn-resource-manager

FROM guriguri/ubuntu-cdh5-base

###########
# install
## perform one apt-get install and one apt-get update
RUN apt-get update -y &&\
	apt-get install -y --no-install-recommends \
	hadoop-yarn-resourcemanager


###########
# setup
## Refer to yarn-site.xml
## RUN mkdir -p /var/lib/hadoop-hdfs/cache/hdfs/dfs/name
## RUN chown -R hdfs:hdfs /var/lib/hadoop-hdfs/cache/hdfs/dfs/name

COPY start.sh /opt/hadoop-docker/

###########
# cleanup
## perform cleanup to reduce base image size
RUN apt-get autoremove -y &&\
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/* &&\
    rm -rf /usr/share/doc/* /usr/share/man/* /usr/share/info/* &&\
    find /var | grep '\.log$' | xargs rm -v


###########
# run
USER root
CMD ["/opt/hadoop-docker/start.sh"]

# exposed ports in sequence
# yarn.resourcemanager.address
# yarn.resourcemanager.scheduler.address
# yarn.resourcemanager.resource-tracker.address
# yarn.resourcemanager.admin.address
# yarn.resourcemanager.webapp.address
# yarn.resourcemanager.webapp.https.address
EXPOSE 8032 8030 8031 8033 8088 8090
