# dns 

FROM ubuntu:trusty

###########
# install
## perform one apt-get install and one apt-get update
RUN apt-get update -y &&\
	apt-get install -y --no-install-recommends \
	dnsmasq


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
CMD ["dnsmasq", "--no-daemon"]
