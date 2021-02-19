#!/bin/bash

# remove previous configuration
sudo rm -rf ~/.oradata

# create directory
mkdir ~/.oradata

# set permissions, oracle in container
sudo chown 54321:54321 ~/.oradata
# give write permissions
sudo chmod -R o+w ~/.oradata

# start container
docker run \
  --name oracle-ee \
  --cap-add=SYS_PTRACE \
  --security-opt seccomp=unconfined \
  -p 1521:1521 \
  -e ORACLE_SID=orcl \
  -e ORACLE_PDB=xe \
  -e ORACLE_PWD=oracle \
  -e ORACLE_CHARACTERSET=UTF8 \
  -v $HOME/.oradata:/opt/oracle/oradata \
  oracle/database:19.3.0-ee
