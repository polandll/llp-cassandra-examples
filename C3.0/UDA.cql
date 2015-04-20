CREATE TABLE blah4 (a int PRIMARY KEY, b int);
INSERT INTO blah4 (a, b) VALUES (1,1);
INSERT INTO blah4 (a, b) VALUES (2,2);
INSERT INTO blah4 (a, b) VALUES (3,3);

CREATE FUNCTION fstate (a int, b int) RETURNS int LANGUAGE java AS 'return Integer.valueOf(a!=null?a.intValue():0) + b.intValue());';
CREATE FUNCTION ffinal (a int) RETURNS text LANGUAGE java AS 'return a.toString();';
CREATE AGGREGATE inttotext (int) SFUNC fstate STYPE int FINALFUNC ffinal;

SELECT intotext(b) FROM blah4;
SELECT intotext(b) FROM blah4 WHERE a=2;
