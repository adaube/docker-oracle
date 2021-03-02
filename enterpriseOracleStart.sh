#!/bin/bash

DIRECTORY=`dirname $0`
DIRECTORY=$(realpath $DIRECTORY)

# start container (ee)
docker run --rm \
  --name oracle-ee \
  -p 1521:1521 \
  -p 5500:5500 \
  -e ORACLE_SID=ORCLCDB \
  -e ORACLE_PDB=ORCLPDB1 \
  -e ORACLE_PWD=oracle \
  -e ORACLE_CHARACTERSET=WE8MSWIN1252 \
  -v $HOME/.oradata:/opt/oracle/oradata \
  oracle/database:19.3.0-ee
