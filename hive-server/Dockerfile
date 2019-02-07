# hive-server

FROM guriguri/ubuntu-cdh5-base

###########
# install
## perform one apt-get install and one apt-get update
RUN apt-get update -y &&\
	apt-get install -y --no-install-recommends \
    hive-server2 hive-webhcat-server


###########
# setup
COPY start.sh /opt/hadoop-docker/


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
CMD ["/opt/hadoop-docker/start.sh"]

# ports exposed in sequence
# hive.server2.thrift.port
# templeton.port
EXPOSE 10000 10002 50111
