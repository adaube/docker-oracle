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
docker run --rm \
  --name oracle-xe \
  -p 1521:1521 -p 5500:5500 \
  -v $HOME/.oradata:/opt/oracle/oradata \
  oracle/database:18.4.0-xe
