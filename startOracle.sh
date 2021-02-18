#!/bin/bash

# start container
docker run --rm --name oracle-xe \
  --shm-size=1g \
  -p 1521:1521 -p 5500:5500 \
  -e ORACLE_SID=ORCLCDB -e ORACLE_PDB=XE -e ORACLE_PWD=oracle -e ORACLE_CHARACTERSET=AL32UTF8 \
  -v $HOME/.oradata:/opt/oracle/oradata \
  oracle/database:18.4.0-xe
