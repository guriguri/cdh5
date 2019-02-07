# elasticsearch

FROM guriguri/ubuntu-cdh5-base

###########
# install
## perform one apt-get install and one apt-get update
RUN apt-get update -y &&\
	apt-get install -y --no-install-recommends \
	apt-transport-https &&\
	add-apt-repository -y "deb https://artifacts.elastic.co/packages/6.x/apt stable main" &&\
	apt-key adv --keyserver keyserver.ubuntu.com --recv-keys D27D666CD88E42B4 &&\
	apt-get update -y &&\
	apt-get install -y --no-install-recommends \
	elasticsearch kibana

ADD start.sh /opt/hadoop-docker/start.sh


###########
# setup
RUN cp /etc/elasticsearch/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml.org
ADD files/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml
RUN cp /etc/kibana/kibana.yml /etc/kibana/kibana.yml.org
ADD files/kibana.yml /etc/kibana/kibana.yml

## for supervisor
ADD files/elasticsearch.conf /etc/supervisor/conf.d/
ADD files/kibana.conf /etc/supervisor/conf.d/


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
#VOLUME ["/var/lib/elasticsearch", "/var/lib/kibana"]

# Expose ports.
# - 9200: es's rest
# - 9300: es's transport.tcp.port
# - 5601: kibana
EXPOSE 9200 9300 5601
