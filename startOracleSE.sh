#!/bin/bash

# connection url: jdbc:oracle:thin:@localhost:1521/ORCLPDB1?oracle.net.disableOob=true
DIRECTORY=`dirname $0`
DIRECTORY=$(realpath $DIRECTORY)

docker run \
  --name oracle-se2 \
  -p 1521:1521 \
  -p 5500:5500 \
  --shm-size=1g \
  -v ${DIRECTORY}/sql:/docker-entrypoint-initdb.d/setup \
  oracle/database:19.3.0-se2
