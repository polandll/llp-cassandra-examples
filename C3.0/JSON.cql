// JSON examples for C* 3.0 doc update

//CREATE TABLE has nothing different

CREATE TABLE foo (a int, b int, c int, d int, PRIMARY KEY (a, b));
CREATE TABLE foo2 (c1 int, c2 float, c3 map<int,timestamp>, PRIMARY KEY (a));

INSERT INTO foo JSON '{"a" : 0, "b" : 0, "c" : 0, "d" : 0}';
// inserts NULL for d?
INSERT INTO foo JSON '{"a" : 1, "b" : 1, "c" : 1}';
// next doesn't work- the insertion of the INSERT KEYWORD VALUES cannot be present
INSERT INTO foo JSON (a, b, c) VALUES '{"a" : 2, "b" : 2, "c" : 2}';

INSERT INTO foo2 JSON '{"c1" : 3, "c2" : 4.5, "c3" : {"6" : "2015-04-13", "7" : "2015-04-15"}}';

UPDATE foo SET "c" = 3 WHERE a = 2 AND b = 2;

SELECT * FROM foo; 
SELECT JSON a, b FROM foo;
SELECT * FROM foo2;
SELECT JSON * FROM foo2;

ALTER TABLE foo DROP "d";
// MUST ADD TYPE, but table will store column as text no matter what is used
ALTER TABLE foo ADD e int;

ALTER TABLE foo RENAME "c" TO "d";

DELETE "c" FROM foo WHERE "a" = 1 AND "d" = 2;
