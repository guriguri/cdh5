# oozie

FROM guriguri/ubuntu-cdh5-base

###########
# install
## perform one apt-get install and one apt-get update
RUN apt-get update -y &&\
	apt-get install -y --no-install-recommends \
	oozie &&\
	ln -s /usr/share/java/mysql-connector-java.jar /var/lib/oozie/mysql-connector-java.jar

COPY start.sh /opt/hadoop-docker/


###########
# setup
RUN cp /etc/oozie/conf/oozie-site.xml /etc/oozie/conf/oozie-site.xml.org
ADD files/oozie-site.xml /etc/oozie/conf/oozie-site.xml
ADD files/ext-2.2.zip /usr/lib/oozie/libext
RUN unzip /usr/lib/oozie/libext/ext-2.2.zip -d /usr/lib/oozie/libext
RUN rm -rf /usr/lib/oozie/libext/ext-2.2.zip


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

# oozie.http.port
EXPOSE 11000
