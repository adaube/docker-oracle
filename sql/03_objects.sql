ALTER SESSION SET CONTAINER = ORCLPDB1;
ALTER SESSION SET CURRENT_SCHEMA = test_user;

CREATE TABLE test_table (
  id     NUMBER(5) NOT NULL PRIMARY KEY
);
