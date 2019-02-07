#!/bin/bash

SQOOP_PKG=sqoop-1.4.7
SQOOP_TGZ=${SQOOP_PKG}.bin__hadoop-2.6.0.tar.gz
SQOOP_LINK=/usr/local/sqoop
SQOOP_HOME=/usr/local/${SQOOP_PKG}


# download
echo ">>>>> download ${SQOOP_TGZ}"
wget http://archive.apache.org/dist/sqoop/1.4.7/${SQOOP_TGZ}
tar xvfz ${SQOOP_TGZ}
rm -rf ${SQOOP_TGZ}


# install
cd ${SQOOP_PKG}*
echo ">>>>> install ${SQOOP_HOME} and link ${SQOOP_LINK}"
rm -rf ${SQOOP_LINK} ${SQOOP_HOME}
mkdir -p ${SQOOP_HOME}
cp -r bin conf lib ${SQOOP_HOME}
cp -r ${SQOOP_PKG}.jar ${SQOOP_HOME}
ln -s ${SQOOP_HOME} ${SQOOP_LINK}

# install mysql-connector
MYSQL_CONNECTOR=mysql-connector-java-5.1.47.jar
echo ">>>>> install ${MYSQL_CONNECTOR} ${SQOOP_LINK}/lib"
cp ../${MYSQL_CONNECTOR} ${SQOOP_LINK}/lib


echo ""
echo " export PATH=\"${SQOOP_LINK}/bin:\${PATH}\""
echo ""
echo " Set path to where bin/hadoop is available"
echo "  if brew install hadoop on osx"
echo "   export HADOOP_HOME=/usr/local/Cellar/hadoop/2.8.0/libexec"
echo ""

# delete download file
echo ">>>>> delete download file"
cd ..
rm -rf ${SQOOP_PKG}*
