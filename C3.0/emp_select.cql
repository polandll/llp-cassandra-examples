USE test;

SELECT * from emp;
SELECT * from emp2;
SELECT * from emp3;

SELECT * from emp WHERE empid = 1;
SELECT * from emp2 WHERE empid = 1;
SELECT * from emp3 WHERE empid = 1;

SELECT * from emp WHERE empid = 1 AND deptid IN (10,12);
SELECT * from emp2 WHERE empid = 1 AND deptid IN (10,12);
// Next one does not work, because deptid is preceded by fn as a clustering column
SELECT * from emp3 WHERE empid = 1 AND deptid IN (10,12);

// Next one does not work, because multi-column relations can only be applied to clustering columns, and fn is not a CC
SELECT * from emp WHERE empid = 1 AND (deptid, fn) IN ((10,'jane'),(12,'jane'));
// THIS one DOES WORK
SELECT * from emp2 WHERE empid = 1 AND (deptid, fn) IN ((10,'jane'),(12,'jane'));
// Next one does not work, because deptid and fn are in wrong order
SELECT * from emp3 WHERE empid = 1 AND (deptid, fn) IN ((10,'jane'),(12,'jane'));
// This one DOES WORK
SELECT * from emp3 WHERE empid = 1 AND (fn, deptid) IN (('jane',10),('jane',12));

// for docs
PAGING OFF;
SELECT * FROM emp WHERE empID IN (1, 5) ORDER BY deptID DESC;
SELECT * FROM emp WHERE empID IN (1, 5) ORDER BY deptID ASC;
SELECT * FROM emp WHERE empID IN (1, 3, 5, 6) AND (deptid, first_name) IN ((15, 'jane'), (10, 'jane'));
SELECT * FROM emp WHERE empID IN (1, 3, 5, 6) AND (deptid, first_name) >((10, 'ja');
