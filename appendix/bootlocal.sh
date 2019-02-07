# Note
## create /var/lib/boot2docker/bootlocal.sh # chmod 755
## call flow 
### /etc/inittab -> /etc/rcS -> /etc/init.d/tc-config -> /opt/bootsync.sh -> /opt/bootscript.sh -> /var/lib/boot2docker/bootlocal.sh

sudo cp -rf /var/lib/boot2docker/localtime /etc/localtime

# profile
## for docker
echo "alias docker_ip='docker inspect --format '\''{{ .NetworkSettings.IPAddress }}'\'" >> /home/docker/.profile
echo "alias docker_pid='docker inspect --format '\''{{ .State.Pid }}'\'''" >> /home/docker/.profile
echo "alias goboot2docker='cd /var/lib/boot2docker'" >> /home/docker/.profile   

## for build test
echo "alias docker_base='docker run -it --name base guriguri/ubuntu-cdh5-base /bin/bash'" >> /home/docker/.profile
                                                                                
## for cdh5                                                                     
echo "alias docker_hue='docker exec -it cdh5_hue_1 /bin/bash'" >> /home/docker/.profile
echo "alias docker_hive='docker exec -it cdh5_hiveserver_1 /bin/bash'" >> /home/docker/.profile
echo "alias docker_hivemetastore='docker exec -it cdh5_hivemetastore_1 /bin/bash'" >> /home/docker/.profile
echo "alias docker_clusternode='docker exec -it cdh5_clusternode_1 /bin/bash'" >> /home/docker/.profile
echo "alias docker_mr='docker exec -it cdh5_mapreducehistory_1 /bin/bash'" >> /home/docker/.profile
echo "alias docker_postgres='docker exec -it cdh5_postgres_1 /bin/bash'" >> /home/docker/.profile
echo "alias docker_yarn='docker exec -it cdh5_yarnresourcemanager_1 /bin/bash'" >> /home/docker/.profile
echo "alias docker_hdfsnn='docker exec -it cdh5_hdfsnamenode_1 /bin/bash'" >> /home/docker/.profile
echo "alias docker_zookeeper='docker exec -it cdh5_zookeeper_1 /bin/bash'" >> /home/docker/.profile 
echo "alias docker_dns='docker exec -it cdh5_dns_1 /bin/bash'" >> /home/docker/.profile
echo "alias docker_oozie='docker exec -it cdh5_oozie_1 /bin/bash'" >> /home/docker/.profile
echo "alias docker_mongodb='docker exec -it cdh5_mongodb_1 /bin/bash'" >> /home/docker/.profile
echo "alias docker_es='docker exec -it cdh5_es_1 /bin/bash'" >> /home/docker/.profile
