# mapreduce-history

FROM guriguri/ubuntu-cdh5-base

###########
# install
## perform one apt-get install and one apt-get update
## Cloudera says install both of these one "one host". We're not going to use
## the yarn proxy server just yet.
RUN apt-get update -y &&\
	apt-get install -y --no-install-recommends \
    hadoop-mapreduce-historyserver hadoop-yarn-proxyserver


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
    find /var | grep '\.log$' | xargs rm -v


###########
# run
USER root
CMD ["/opt/hadoop-docker/start.sh"]

# ports exposed in sequence
# mapreduce.jobhistory.address
# mapreduce.jobhistory.admin.address
# mapreduce.jobhistory.webapp.address
# mapreduce.jobhistory.webapp.https.address
EXPOSE 10020 10033 19888 19890
