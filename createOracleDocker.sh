#!/bin/bash

# clone the oracle docker image repo
git clone https://github.com/oracle/docker-images.git

# download oracle 18c binaries into the build location (requires oracle account)
# ~/projects/docker-images/OracleDatabase/SingleInstance/dockerfiles/18.4.0/oracle-database-xe-18c-1.0-1.x86_64.rpm

# run docker image build script (relative to git repo root)
./docker-images/OracleDatabase/SingleInstance/dockerfiles/buildDockerImage.sh -v 18.4.0 -x

# data persistance
mkdir -p $HOME/.oradata
# this is uid of oracle (inside the container)
sudo chown 54321:54321 ~/.oradata

# import database dump
# docker exec -it oracle-ee impdp \'/ as sysdba\' schemas=NYDATA exclude=constraint, ref_constraint, index TABLE_EXISTS_ACTION=replace directory=impdp_dump_dir dumpfile=16_FLEXCUBE.dmp
# docker exec -it oracle-ee impdp \'/ as sysdba\' schemas=NYDATA exclude=constraint, ref_constraint, index TABLE_EXISTS_ACTION=append directory=impdp_dump_dir dumpfile=16_FLEXCUBE.dmp
# docker exec -it oracle-ee impdp \'/ as sysdba\' schemas=NYDATA exclude=constraint, ref_constraint, index directory=impdp_dump_dir dumpfile=20_FLEXCUBE.dmp
# docker exec -it oracle-ee imp \'/ as sysdba\' full=Y file=/opt/oracle/oradata/20_ULTIMUS_NYDATA.dmp
