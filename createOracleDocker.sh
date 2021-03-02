#!/bin/bash

# 1. clone the oracle docker image repo (git clone https://github.com/oracle/docker-images.git)

# 2. download oracle 19c binaries into the build location (requires oracle account)

# 3. run docker image build script (relative to git repo root)
cd /home/"$USER"/projects/docker-images/OracleDatabase/SingleInstance/dockerfiles || exit
./buildContainerImage.sh -v 19.3.0 -e
