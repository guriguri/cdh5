# guriguri/ubuntu-cdh5-base

# reference https://github.com/tilakpatidar/cdh5
FROM ubuntu:trusty

###########
# add repository
## cdh5
COPY files/cloudera.list /etc/apt/sources.list.d/cloudera.list
COPY files/cloudera.pref /etc/apt/preferences.d/cloudera.pref

## python
COPY files/python.list /etc/apt/sources.list.d/python.list

## openjdk
COPY files/openjdk-r-ppa-trusty.list /etc/apt/sources.list.d/openjdk-r-ppa-trusty.list

## fix GPG error
### cdh
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 327574EE02A818DD
### kafka
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 5BB92C09DB82666C
### java
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EB9B1D8886F44E2A


###########
# install
## perform one apt-get install and one apt-get update
RUN apt-get update -y &&\
    apt-get install -y --no-install-recommends \
	software-properties-common language-pack-ko language-pack-ko-base \
	supervisor wget telnet unzip patch \
	openssh-server openssh-client \
	mysql-client libmysql-java \
	openjdk-8-jdk hadoop-client 

## set space for configuration files
RUN mkdir -p /etc/hadoop/cluster-conf
RUN update-alternatives --install /etc/hadoop/conf hadoop-conf /etc/hadoop/cluster-conf 50
RUN update-alternatives --set hadoop-conf /etc/hadoop/cluster-conf


###########
# setup
## for localtime
ADD files/localtime /etc/localtime

## daemon
ADD files/daemon.sh /etc/init.d/daemon
RUN chmod 755 /etc/init.d/daemon
RUN chown root:root /etc/init.d/daemon

## hive
ADD files/hive-site.xml /etc/hive/conf/hive-site.xml

## sshd
### for running sshd in ubuntu trusty
### see https://github.com/docker/docker/issues/5704
RUN mkdir /var/run/sshd
RUN echo 'root:secretpasswd' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
### passwordless ssh
RUN yes | ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key
RUN yes | ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key
### fix the 254 error code
RUN sed -i "/^[^#]*UsePAM/ s/.*/#&/" /etc/ssh/sshd_config
RUN echo "UsePAM no" >> /etc/ssh/sshd_config
RUN echo "Port 2122" >> /etc/ssh/sshd_config

## ssh
ADD files/ssh_config /root/.ssh/config
RUN chmod 600 /root/.ssh/config
RUN chown root:root /root/.ssh/config
RUN yes | ssh-keygen -q -N "" -t rsa -f /root/.ssh/id_rsa
RUN cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys

## cron and logrotate.sh
ADD files/logrotate.sh /root/logrotate.sh
RUN chmod 755 /root/logrotate.sh
RUN echo "0 0 * * * /root/logrotate.sh >> /root/logrotate.log" >> /var/spool/cron/crontabs/root
RUN crontab -l | crontab

## for supervisor
ADD files/supervisord.conf /etc/supervisor/conf.d/
ADD files/sshd.conf /etc/supervisor/conf.d/
ADD files/cron.conf /etc/supervisor/conf.d/

## java
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64


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
CMD ["/usr/bin/supervisord"]

EXPOSE 22
