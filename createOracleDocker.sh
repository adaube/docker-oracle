#!/bin/bash

# navigate to projects
cd ~/projects

# clone the oracle docker image repo
git clone https://github.com/oracle/docker-images.git

# download oracle 19.3c binaries into the build location:
# ~/projects/docker-images/OracleDatabase/SingleInstance/dockerfiles/19.3.0/LINUX.X64_193000_db_home.zip

# download oracle 18c binaries into the build location:
# ~/projects/docker-images/OracleDatabase/SingleInstance/dockerfiles/18.4.0/oracle-database-xe-18c-1.0-1.x86_64.rpm


# run docker image build script
#~/projects/docker-images/OracleDatabase/SingleInstance/dockerfiles/buildDockerImage.sh -v 19.3.0 -e
~/projects/docker-images/OracleDatabase/SingleInstance/dockerfiles/buildDockerImage.sh -v 18.4.0 -x

# data persistance
mkdir -p $HOME/.oradata
# this is uid of oracle (inside the container)
sudo chown 54321:54321 ~/.oradata

# start the container, ee
#docker run -d --rm \
#  --name oracle-ee \
#  --shm-size=1g \
#  -p 1521:1521 \
#  -e ORACLE_SID=ORCLCDB \
#  -v $HOME/oradata:/opt/oracle/oradata \
#  oracle/database:19.3.0-ee
docker run -d --rm \
  --name oracle-xe \
  -p 1521:1521 -p 5500:5500 \
  -e ORACLE_PWD=oracle \
  -v $HOME/.oradata:/opt/oracle/oradata \
  oracle/database:18.4.0-xe

# copy files to docker container
#docker cp 20_FLEXCUBE.dmp oracle-ee:/opt/oracle/oradata
#docker cp 16_FLEXCUBE.dmp oracle-ee:/opt/oracle/oradata
#docker cp 20_ULTIMUS_NYDATA.dmp oracle-ee:/opt/oracle/oradata
# make changes to user and tablespace
docker exec -it oracle-ee bash -c "source /home/oracle/.bashrc; sqlplus /nolog"
--  SQL >
conn / as sysdba
alter session set "_ORACLE_SCRIPT"= true;
drop tablespace NY_DATA including contents;  -- if exists
drop user NYDATA cascade;  -- if exists
create directory impdp_dump_dir as '/opt/oracle/oradata';
create tablespace NY_DATA datafile 'test.dbf' size 100m autoextend on next 100 m;
create user NYDATA identified by NYDATA DEFAULT TABLESPACE "NY_DATA" TEMPORARY TABLESPACE "TEMP";
# import database dump
# docker exec -it oracle-ee impdp \'/ as sysdba\' schemas=NYDATA exclude=constraint, ref_constraint, index TABLE_EXISTS_ACTION=replace directory=impdp_dump_dir dumpfile=16_FLEXCUBE.dmp
# docker exec -it oracle-ee impdp \'/ as sysdba\' schemas=NYDATA exclude=constraint, ref_constraint, index TABLE_EXISTS_ACTION=append directory=impdp_dump_dir dumpfile=16_FLEXCUBE.dmp
# docker exec -it oracle-ee impdp \'/ as sysdba\' schemas=NYDATA exclude=constraint, ref_constraint, index directory=impdp_dump_dir dumpfile=20_FLEXCUBE.dmp
# docker exec -it oracle-ee imp \'/ as sysdba\' full=Y file=/opt/oracle/oradata/20_ULTIMUS_NYDATA.dmp
