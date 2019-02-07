# mongodb

FROM guriguri/ubuntu-cdh5-base

###########
# install
## perform one apt-get install and one apt-get update
RUN apt-get update -y && \
	apt-get install -y --no-install-recommends \
	mongodb

ADD start.sh /opt/hadoop-docker/start.sh


###########
# setup
RUN cp /etc/mongodb.conf /etc/mongodb.conf.org
ADD files/mongodb.conf /etc/mongodb.conf
ADD files/mongodb.patch /root/mongodb.patch
ADD files/mongodb-init.sh /root/mongodb-init.sh
RUN chmod 755 /root/mongodb-init.sh
RUN cd /etc/init.d && patch -p0 < /root/mongodb.patch


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

# Define mountable directories.
#VOLUME ["/var/lib/mongodb"]

# Expose ports.
# - 27017: process
# - 28017: http
EXPOSE 27017
EXPOSE 28017
