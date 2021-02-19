#!/bin/bash

# clone the oracle docker image repo
git clone https://github.com/oracle/docker-images.git

# download oracle 18c binaries into the build location (requires oracle account)
# ~/projects/docker-images/OracleDatabase/SingleInstance/dockerfiles/18.4.0/oracle-database-xe-18c-1.0-1.x86_64.rpm

# run docker image build script (relative to git repo root)
./docker-images/OracleDatabase/SingleInstance/dockerfiles/buildDockerImage.sh -v 18.4.0 -x
