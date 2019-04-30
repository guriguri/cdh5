#!/bin/bash

DOCKER_MACHINE_NAME="cdh5"

# zookeeper
VBoxManage controlvm "${DOCKER_MACHINE_NAME}" natpf1 "zookeeper-01,tcp,,2181,,2181"

# hdfsnamenode
VBoxManage controlvm "${DOCKER_MACHINE_NAME}" natpf1 "hdfsnamenode-01,tcp,,8020,,8020"
VBoxManage controlvm "${DOCKER_MACHINE_NAME}" natpf1 "hdfsnamenode-02,tcp,,50070,,50070"

# clusternode
VBoxManage controlvm "${DOCKER_MACHINE_NAME}" natpf1 "clusternode-01,tcp,,8042,,8042"
VBoxManage controlvm "${DOCKER_MACHINE_NAME}" natpf1 "clusternode-02,tcp,,50010,,50010"
VBoxManage controlvm "${DOCKER_MACHINE_NAME}" natpf1 "clusternode-03,tcp,,50075,,50075"
VBoxManage controlvm "${DOCKER_MACHINE_NAME}" natpf1 "clusternode-10,tcp,,50200,,50200"
VBoxManage controlvm "${DOCKER_MACHINE_NAME}" natpf1 "clusternode-11,tcp,,50201,,50201"
VBoxManage controlvm "${DOCKER_MACHINE_NAME}" natpf1 "clusternode-12,tcp,,50202,,50202"
VBoxManage controlvm "${DOCKER_MACHINE_NAME}" natpf1 "clusternode-13,tcp,,50203,,50203"
VBoxManage controlvm "${DOCKER_MACHINE_NAME}" natpf1 "clusternode-14,tcp,,50204,,50204"
VBoxManage controlvm "${DOCKER_MACHINE_NAME}" natpf1 "clusternode-15,tcp,,50205,,50205"
VBoxManage controlvm "${DOCKER_MACHINE_NAME}" natpf1 "clusternode-16,tcp,,50206,,50206"
VBoxManage controlvm "${DOCKER_MACHINE_NAME}" natpf1 "clusternode-17,tcp,,50207,,50207"
VBoxManage controlvm "${DOCKER_MACHINE_NAME}" natpf1 "clusternode-18,tcp,,50208,,50208"
VBoxManage controlvm "${DOCKER_MACHINE_NAME}" natpf1 "clusternode-19,tcp,,50209,,50209"
VBoxManage controlvm "${DOCKER_MACHINE_NAME}" natpf1 "clusternode-20,tcp,,50210,,50210"

# yarnresourcemanager
VBoxManage controlvm "${DOCKER_MACHINE_NAME}" natpf1 "yarnresourcemanager-01,tcp,,8030,,8030"
VBoxManage controlvm "${DOCKER_MACHINE_NAME}" natpf1 "yarnresourcemanager-02,tcp,,8031,,8031"
VBoxManage controlvm "${DOCKER_MACHINE_NAME}" natpf1 "yarnresourcemanager-03,tcp,,8032,,8032"
VBoxManage controlvm "${DOCKER_MACHINE_NAME}" natpf1 "yarnresourcemanager-04,tcp,,8033,,8033"
VBoxManage controlvm "${DOCKER_MACHINE_NAME}" natpf1 "yarnresourcemanager-05,tcp,,8088,,8088"

# hivemetastore
VBoxManage controlvm "${DOCKER_MACHINE_NAME}" natpf1 "hivemetastore-01,tcp,,3306,,3306"
VBoxManage controlvm "${DOCKER_MACHINE_NAME}" natpf1 "hivemetastore-02,tcp,,9083,,9083"

# mapreducehistory
VBoxManage controlvm "${DOCKER_MACHINE_NAME}" natpf1 "mapreducehistory-01,tcp,,10020,,10020"
VBoxManage controlvm "${DOCKER_MACHINE_NAME}" natpf1 "mapreducehistory-02,tcp,,19888,,19888"

# hue
VBoxManage controlvm "${DOCKER_MACHINE_NAME}" natpf1 "hue-01,tcp,,8888,,8888"

# hiveserver
VBoxManage controlvm "${DOCKER_MACHINE_NAME}" natpf1 "hiveserver-01,tcp,,10000,,10000"
VBoxManage controlvm "${DOCKER_MACHINE_NAME}" natpf1 "hiveserver-02,tcp,,10002,,10002"
VBoxManage controlvm "${DOCKER_MACHINE_NAME}" natpf1 "hiveserver-03,tcp,,50111,,50111"

# mongodb
VBoxManage controlvm "${DOCKER_MACHINE_NAME}" natpf1 "mongodb-01,tcp,,27017,,27017"
VBoxManage controlvm "${DOCKER_MACHINE_NAME}" natpf1 "mongodb-02,tcp,,28017,,28017"

# oozie
VBoxManage controlvm "${DOCKER_MACHINE_NAME}" natpf1 "oozie-01,tcp,,11000,,11000"

# es
VBoxManage controlvm "${DOCKER_MACHINE_NAME}" natpf1 "es-01,tcp,,9200,,9200"
VBoxManage controlvm "${DOCKER_MACHINE_NAME}" natpf1 "es-02,tcp,,5601,,5601"

# kafka
#VBoxManage controlvm "${DOCKER_MACHINE_NAME}" natpf1 "kafka-01,tcp,,9092,,9092"
