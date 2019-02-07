# hue

FROM guriguri/ubuntu-cdh5-base

###########
# install
## perform one apt-get install and one apt-get update
RUN apt-get update -y &&\
	apt-get install -y --no-install-recommends \
    hue\
    hue-beeswax\
    hue-common\
    hue-doc\
    hue-hbase\
    hue-impala\
    hue-pig\
    hue-plugins\
    hue-rdbms\
    hue-search\
    hue-security\
    hue-server\
    hue-spark\
    hue-sqoop\
    hue-zookeeper


###########
# setup
COPY start.sh /opt/hadoop-docker/
COPY migration.sh /root/migration.sh


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

# Hue Server
EXPOSE 8888
