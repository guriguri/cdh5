DOCKER_MACHINE_NAME=cdh5

#VIRTUALBOX_MEMORY=8000
ifeq (, $(VIRTUALBOX_MEMORY))
	VIRTUALBOX_MEMORY=8000
endif

#DAEMON_ON=on|off
ifeq (off, $(DAEMON_ON))
	DAEMON_FLAG=
else 
	DAEMON_FLAG=-d
endif

DOCKER_MACHINE_IP=$$(docker-machine ip ${DOCKER_MACHINE_NAME})
FILES=$(wildcard docker-compose*.yml)
DOCKER_COMPOSE_FILES=$(foreach file, ${FILES}, -f ${file})
DOCKER_NETWORK_NAME=${DOCKER_MACHINE_NAME}-local

help:
	@echo ""
	@echo "Targets"
	@echo " common:"
	@echo "   help (default)"
	@echo ""
	@echo " docker-machine:"
	@echo "   create remove create-network remove-network start stop ssh env-init"
	@echo ""
	@echo " docker images:"
	@echo "   build-all build-base build-[SERVICE_NAME]"
	@echo ""
	@echo " docker-compose:"
	@echo "   status remove-volume"
	@echo "   hdfs-up hdfs-down hdfs-start hdfs-stop"
	@echo "   hive-up hive-down hive-start hive-stop"
	@echo "   oggre-up oggre-down oggre-start oggre-stop"
	@echo "   mongodb-up mongodb-down mongodb-start mongodb-stop"
	@echo "   es-up es-down es-start es-stop"
	@echo ""
	@echo " test:"
	@echo "   test-all test-mr test-hive test-oozie test-sqoop test-mongodb test-es"
	@echo ""
	@echo "Environment"
	@echo "   DOCKER_MACHINE_NAME=${DOCKER_MACHINE_NAME}"

help-hadoop:
	@echo "Notes for hadoop"
	@echo "  append /etc/hosts to route"
	@echo "    ${DOCKER_MACHINE_IP} hdfsnamenode.${DOCKER_NETWORK_NAME} hiveserver.${DOCKER_NETWORK_NAME} hivemetastore.${DOCKER_NETWORK_NAME} yarnresourcemanager.${DOCKER_NETWORK_NAME} mapreducehistory.${DOCKER_NETWORK_NAME} hue.${DOCKER_NETWORK_NAME} clusternode.${DOCKER_NETWORK_NAME} oozie.${DOCKER_NETWORK_NAME}"
	@echo ""
	@echo "  append ~/.bashrc to access on hadoop in local"
	@echo "    export HADOOP_CONF_DIR=$(PWD)/conf/cluster-conf"
	@echo "    export HADOOP_USER_NAME=guriguri # custom user name for hdfs, optional"
	@echo "    export OOZIE_CLIENT_OPTS=-Duser.name=guriguri # custom user name for oozie, optional"
	@echo ""

help-mongodb:
	@echo "Notes for mongodb"
	@echo "  append /etc/hosts to route"
	@echo "    ${DOCKER_MACHINE_IP} mongodb.${DOCKER_NETWORK_NAME}"
	@echo ""

help-es:
	@echo "Notes for es"
	@echo "  append /etc/hosts to route"
	@echo "    ${DOCKER_MACHINE_IP} es.${DOCKER_NETWORK_NAME}"
	@echo ""

create:
	docker-machine create --driver=virtualbox --virtualbox-memory ${VIRTUALBOX_MEMORY} ${DOCKER_MACHINE_NAME}
	@echo "Notes"
	@echo "  add shared folder of vm(${DOCKER_MACHINE_NAME})"
	@echo "    path: $(PWD)"
	@echo ""

remove:
	@echo "please enter below a command"
	@echo "  docker-machine rm ${DOCKER_MACHINE_NAME}"
	@echo ""

create-network: remove-network
	@echo ">>>>> create docker network ${DOCKER_NETWORK_NAME}"
	@if [ "$$(docker network ls | grep ${DOCKER_NETWORK_NAME})" = "" ]; then \
		 docker network create -d bridge \
		 	--subnet=172.20.0.0/16 --gateway 172.20.0.1 \
			--ip-range=172.20.0.0/16 \
			${DOCKER_NETWORK_NAME}; fi
	@if [ ! -d "/etc/resolver" ]; then \
	   	sudo mkdir /etc/resolver; fi
	@DOCKER_HOST_IP=$$(docker-machine ip ${DOCKER_MACHINE_NAME}); \
		echo "nameserver $${DOCKER_HOST_IP}" | sudo tee /etc/resolver/${DOCKER_NETWORK_NAME}; \
		sudo route -n add -net 172.20.0.0 $${DOCKER_HOST_IP}

remove-network:
	@echo ">>>>> remove network config"
	@if [ "$$(docker network ls | grep ${DOCKER_NETWORK_NAME})" != "" ]; then \
		docker network remove ${DOCKER_NETWORK_NAME}; fi
	sudo rm -rf /etc/resolver/${DOCKER_NETWORK_NAME}
	@sudo route -n delete 172.20.0.0

start:
	docker-machine start ${DOCKER_MACHINE_NAME}
	make create-network

stop:
	docker-machine stop ${DOCKER_MACHINE_NAME}
	make remove-network

ssh:
	docker-machine ssh ${DOCKER_MACHINE_NAME}

env-init:
	docker-machine scp appendix/bootlocal.sh ${DOCKER_MACHINE_NAME}:/var/lib/boot2docker
	docker-machine scp base/files/localtime ${DOCKER_MACHINE_NAME}:/var/lib/boot2docker

status: 
	@eval $$(docker-machine env ${DOCKER_MACHINE_NAME}); \
	   	docker-compose ${DOCKER_COMPOSE_FILES} ps

build-all:
	@eval $$(docker-machine env ${DOCKER_MACHINE_NAME}); \
	   	cd base && ./build.sh && cd .. && \
	   	docker-compose ${DOCKER_COMPOSE_FILES} build

build-base:
	@eval $$(docker-machine env ${DOCKER_MACHINE_NAME}); \
	   	cd base && ./build.sh

build-%:
	@eval $$(docker-machine env ${DOCKER_MACHINE_NAME}); \
	   	docker-compose ${DOCKER_COMPOSE_FILES} build $*

test-all: test-mr test-hive test-oozie test-sqoop test-mongodb test-es

test-mr: 
	cd test/mr && ./mr.sh

test-hive: 
	cd test/hive && ./hive.sh

test-oozie: 
	cd test/oozie && ./oozie.sh

test-sqoop: 
	cd test/sqoop && ./sqoop.sh

test-mongodb: 
	cd test/mongodb && ./mongodb.sh

test-es: 
	cd test/es && ./es.sh

remove-volume:
	@echo ">>>>> remove volatile volumes of ${DOCKER_MACHINE_NAME}"
	@eval $$(docker-machine env ${DOCKER_MACHINE_NAME}); \
	   	if [ "$$(docker volume ls -q | grep -v ${DOCKER_MACHINE_NAME})" != "" ]; then \
	   	docker volume rm $$(docker volume ls -q | grep -v ${DOCKER_MACHINE_NAME}); fi

hdfs-up: 
	@echo ">>>>> $@"
	@eval $$(docker-machine env ${DOCKER_MACHINE_NAME}); \
	   	docker-compose up ${DAEMON_FLAG}
	@make help-hadoop

hdfs-down: 
	@echo ">>>>> $@"
	@eval $$(docker-machine env ${DOCKER_MACHINE_NAME}); \
	   	docker-compose down 
	@make remove-volume

hdfs-start: 
	@echo ">>>>> $@"
	@eval $$(docker-machine env ${DOCKER_MACHINE_NAME}); \
	   	docker-compose start

hdfs-stop: 
	@echo ">>>>> $@"
	@eval $$(docker-machine env ${DOCKER_MACHINE_NAME}); \
	   	docker-compose stop

hive-up: 
	@echo ">>>>> $@"
	@eval $$(docker-machine env ${DOCKER_MACHINE_NAME}); \
	   	docker-compose -f docker-compose.yml \
			-f docker-compose.hive.yml \
			up ${DAEMON_FLAG}
	@make help-hadoop

hive-down: 
	@echo ">>>>> $@"
	@eval $$(docker-machine env ${DOCKER_MACHINE_NAME}); \
	   	docker-compose -f docker-compose.yml \
			-f docker-compose.hive.yml \
			down 
	@make remove-volume

hive-start: 
	@echo ">>>>> $@"
	@eval $$(docker-machine env ${DOCKER_MACHINE_NAME}); \
	   	docker-compose -f docker-compose.yml \
			-f docker-compose.hive.yml \
			start

hive-stop: 
	@echo ">>>>> $@"
	@eval $$(docker-machine env ${DOCKER_MACHINE_NAME}); \
	   	docker-compose -f docker-compose.yml \
			-f docker-compose.hive.yml \
			stop

oggre-up: 
	@echo ">>>>> $@"
	@eval $$(docker-machine env ${DOCKER_MACHINE_NAME}); \
	   	docker-compose -f docker-compose.yml \
			-f docker-compose.hive.yml \
		   	-f docker-compose.oggre.yml \
		   	-f docker-compose.mongodb.yml \
		   	-f docker-compose.es.yml \
			up ${DAEMON_FLAG}
	@make help-hadoop
	@make help-mongodb
	@make help-es

oggre-down: 
	@echo ">>>>> $@"
	@eval $$(docker-machine env ${DOCKER_MACHINE_NAME}); \
	   	docker-compose -f docker-compose.yml \
			-f docker-compose.hive.yml \
			-f docker-compose.oggre.yml \
		   	-f docker-compose.mongodb.yml \
		   	-f docker-compose.es.yml \
			down 
	@make remove-volume

oggre-start: 
	@echo ">>>>> $@"
	@eval $$(docker-machine env ${DOCKER_MACHINE_NAME}); \
	   	docker-compose -f docker-compose.yml \
			-f docker-compose.hive.yml \
			-f docker-compose.oggre.yml \
		   	-f docker-compose.mongodb.yml \
		   	-f docker-compose.es.yml \
			start

oggre-stop: 
	@echo ">>>>> $@"
	@eval $$(docker-machine env ${DOCKER_MACHINE_NAME}); \
	   	docker-compose -f docker-compose.yml \
			-f docker-compose.hive.yml \
			-f docker-compose.oggre.yml \
		   	-f docker-compose.mongodb.yml \
		   	-f docker-compose.es.yml \
			stop

mongodb-up: 
	@echo ">>>>> $@"
	@eval $$(docker-machine env ${DOCKER_MACHINE_NAME}); \
	   	docker-compose -f docker-compose.mongodb.yml \
			up ${DAEMON_FLAG}
	@make help-mongodb

mongodb-down: 
	@echo ">>>>> $@"
	@eval $$(docker-machine env ${DOCKER_MACHINE_NAME}); \
	   	docker-compose -f docker-compose.mongodb.yml \
			down 

mongodb-start: 
	@echo ">>>>> $@"
	@eval $$(docker-machine env ${DOCKER_MACHINE_NAME}); \
	   	docker-compose -f docker-compose.mongodb.yml \
			start

mongodb-stop: 
	@echo ">>>>> $@"
	@eval $$(docker-machine env ${DOCKER_MACHINE_NAME}); \
	   	docker-compose -f docker-compose.mongodb.yml \
			stop

es-up: 
	@echo ">>>>> $@"
	@eval $$(docker-machine env ${DOCKER_MACHINE_NAME}); \
	   	docker-compose -f docker-compose.es.yml \
			up ${DAEMON_FLAG}
	@make help-es

es-down: 
	@echo ">>>>> $@"
	@eval $$(docker-machine env ${DOCKER_MACHINE_NAME}); \
	   	docker-compose -f docker-compose.es.yml \
			down 

es-start: 
	@echo ">>>>> $@"
	@eval $$(docker-machine env ${DOCKER_MACHINE_NAME}); \
	   	docker-compose -f docker-compose.es.yml \
			start

es-stop: 
	@echo ">>>>> $@"
	@eval $$(docker-machine env ${DOCKER_MACHINE_NAME}); \
	   	docker-compose -f docker-compose.es.yml \
			stop
