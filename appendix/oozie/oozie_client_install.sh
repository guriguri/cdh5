#!/bin/bash

OOZIE_PKG=oozie-4.1.0
OOZIE_TGZ=${OOZIE_PKG}.tar.gz
OOZIE_LINK=/usr/local/oozie
OOZIE_HOME=/usr/local/${OOZIE_PKG}


# download
echo ">>>>> download ${OOZIE_TGZ}"
wget http://archive.apache.org/dist/oozie/4.1.0/${OOZIE_TGZ}
tar xvfz ${OOZIE_TGZ}
rm -rf ${OOZIE_TGZ}

# build
echo ">>>>> build ${OOZIE_PKG}"
cd ${OOZIE_PKG}
bin/mkdistro.sh -DskipTests -Dmaven.javadoc.skip=true -Dcheckstyle.skip=true site

# install
echo ">>>>> install ${OOZIE_HOME} and link ${OOZIE_LINK}"
rm -rf ${OOZIE_LINK} ${OOZIE_HOME}
mv distro/target/${OOZIE_PKG}-distro/${OOZIE_PKG} ${OOZIE_HOME}
ln -s ${OOZIE_HOME} ${OOZIE_LINK}

echo ""
echo " export PATH=\"${OOZIE_LINK}/bin:\${PATH}\""
echo ""

# delete build directory
echo ">>>>> delete build directory"
cd ..
rm -rf ${OOZIE_PKG}
