#!/bin/bash

DIRECTORY=`dirname $0`
DIRECTORY=$(realpath $DIRECTORY)

# start container (ee)
docker run --rm \
  --name oracle-ee \
  -p 1521:1521 \
  -p 5500:5500 \
  -e ORACLE_CHARACTERSET=WE8MSWIN1252 \
  --shm-size=1g \
  -v $HOME/.oradata:/opt/oracle/oradata \
  -v ${DIRECTORY}/sql:/docker-entrypoint-initdb.d/setup \
  oracle/database:19.3.0-ee