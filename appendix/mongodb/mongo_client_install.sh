#!/bin/bash

if [ -f /usr/local/bin/mongo ]; then
	echo "already exist /usr/local/bin/mongo"
	mongo -version
else
	tar xvfz mongo.tgz -C /usr/local/bin
	echo ">>>>> install /usr/local/bin/mongo # v2.4.9"
fi
