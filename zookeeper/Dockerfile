# zookeeper

FROM guriguri/ubuntu-cdh5-base

###########
# install
## perform one apt-get install and one apt-get update
RUN apt-get update -y &&\
	apt-get install -y --no-install-recommends \
	zookeeper-server


###########
# setup
## ZooKeeper (default) data directory
RUN mkdir -p /var/lib/zookeeper &&\
    chown -R zookeeper /var/lib/zookeeper/ &&\
    service zookeeper-server init

COPY start.sh /opt/zookeeper/


###########
# cleanup
## perform cleanup to reduce base image size
RUN apt-get autoremove -y &&\
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/* &&\
    rm -rf /usr/share/doc/* /usr/share/man/* /usr/share/info/* &&\
    find /var | grep '\.log$' | xargs rm -fv


###########
# run
USER root
CMD ["/opt/zookeeper/start.sh"]

EXPOSE 2181
