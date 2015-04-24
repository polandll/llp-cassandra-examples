CREATE OR REPLACE FUNCTION %s(state double, val double) RETURNS double LANGUAGE javascript AS "string";

EXAMPLE: CREATE FUNCTION sum (a bigint, b bigint) AS my.company.Functions.sum2

UPDATE FUNCTION sum (a bigint, b bigint) AS my.company.Functions.sum3;

CREATE TABLE blah3 (key int PRIMARY KEY, val double);
INSERT INTO blah3 (key, val) VALUES (1, 1.0);
INSERT INTO blah3 (key, val) VALUES (2, 2.0);
INSERT INTO blah3 (key, val) VALUES (3, 3.0);

CREATE FUNCTION fSin ( input double) RETURNS double LANGUAGE java AS 'return Double.valueOf(Math, sin(input, doubleValue()));';
CREATE FUNCTION fSin ( input double) RETURNS double LANGUAGE java AS fSin.java;

SELECT key,val fSin(val) FROM blah3;
SELECT key,val fSin(val) FROM test.blah3;

DROP FUNCTION [IF EXISTS] fSin;
