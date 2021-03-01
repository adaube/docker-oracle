#!/bin/bash

# remove previous configuration
sudo rm -rf ~/.oradata

# create directory
mkdir ~/.oradata

# set permissions, oracle in container
sudo chown 54321:54321 ~/.oradata
# give write permissions
sudo chmod -R o+w ~/.oradata

# start container (ee)
docker run \
  --name oracle-ee \
  -p 1521:1521 \
  -p 5500:5500 \
  -e ORACLE_SID=ORCLCDB \
  -e ORACLE_PDB=ORCLPDB1 \
  -e ORACLE_PWD=oracle \
  -e ORACLE_CHARACTERSET=WE8MSWIN1252 \
  -v $HOME/.oradata:/opt/oracle/oradata \
  oracle/database:19.3.0-ee
