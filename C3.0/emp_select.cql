USE test;

SELECT * from emp;
SELECT * from emp2;
SELECT * from emp3;

SELECT * from emp WHERE empid = 1;
SELECT * from emp2 WHERE empid = 1;
SELECT * from emp3 WHERE empid = 1;

SELECT * from emp WHERE empid = 1 AND deptid IN (10,12);
SELECT * from emp2 WHERE empid = 1 AND deptid IN (10,12);
SELECT * from emp3 WHERE empid = 1 AND deptid IN (10,12);

SELECT * from emp WHERE empid = 1 AND (deptid, fn) IN ((10,'jane'),(12,'jane'));
SELECT * from emp2 WHERE empid = 1 AND (deptid, fn) IN ((10,'jane'),(12,'jane'));
SELECT * from emp3 WHERE empid = 1 AND (deptid, fn) IN ((10,'jane'),(12,'jane'));
