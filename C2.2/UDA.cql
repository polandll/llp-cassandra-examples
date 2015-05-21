CREATE TABLE blah4 (a int PRIMARY KEY, b int);
INSERT INTO blah4 (a, b) VALUES (1,1);
INSERT INTO blah4 (a, b) VALUES (2,2);
INSERT INTO blah4 (a, b) VALUES (3,3);

CREATE FUNCTION fstate (a int, b int) RETURNS int LANGUAGE java AS 'return Integer.valueOf(a!=null?a.intValue():0) + b.intValue());';
CREATE FUNCTION ffinal (a int) RETURNS text LANGUAGE java AS 'return a.toString();';
CREATE AGGREGATE inttotext (int) SFUNC fstate STYPE int FINALFUNC ffinal;

SELECT inttotext(b) FROM blah4;
SELECT inttotext(b) FROM blah4 WHERE a=2;

INITCOND = 'foo'; //NEED TO CREATE AN EXAMPLE WITH THIS

CREATE TABLE int_nums (first int, second int));
INSERT INTO int_nums (first, second) VALUES (1,1);
INSERT INTO int_nums (first, second) VALUES (2,4);
INSERT INTO int_nums (first, second) VALUES (3,9);
INSERT INTO int_nums (first, second) VALUES (4,16);

SELECT intToText(second) FROM int_nums;

