USE test;
CREATE TABLE emp ( empid int, deptid int, fn text, ln text, PRIMARY KEY (empid, deptid));
CREATE TABLE emp2 ( empid int, deptid int, fn text, ln text, PRIMARY KEY (empid, deptid, fn));
CREATE TABLE emp3 ( empid int, deptid int, fn text, ln text, PRIMARY KEY (empid, fn, deptid));

COPY emp (empid, deptid, fn,ln) FROM '~/CLONES/cassandra-example-code-LLP/C3.0/emp.csv' WITH HEADER=True AND DELIMITER='|';
COPY emp2 (empid, deptid, fn,ln) FROM '~/CLONES/cassandra-example-code-LLP/C3.0/emp.csv' WITH HEADER=True AND DELIMITER='|';
COPY emp3 (empid, deptid, fn,ln) FROM '~/CLONES/cassandra-example-code-LLP/C3.0/emp.csv' WITH HEADER=True AND DELIMITER='|';

