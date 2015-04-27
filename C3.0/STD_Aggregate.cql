// Aggregate functions can only be called on a COLUMN
// Can't do SELECT a, b, avg(val) FROM blah5;

CREATE TABLE blah5 (key int PRIMARY KEY, val double);
INSERT INTO blah5 (key, val) VALUES (1, 1.0);
INSERT INTO blah5 (key, val) VALUES (2, 4.0);
INSERT INTO blah5 (key, val) VALUES (3, 8.0);
SELECT avg(val) FROM blah5;
SELECT avg(val), sum(val) FROM blah5;
SELECT avg(val), sum(val) FROM blah5 WHERE key=1;

// ALL FUNCTIONS
SELECT avg(val), sum(val), max(val), min(val), count(val) FROM blah5;

// Example I used in cql/cql_using/useQueryStdAggregate.dita
CREATE TABLE scores (user text, game_number int, game_score int, PRIMARY KEY (user, game_number));
INSERT INTO scores (user, game_number, game_score) VALUES ('rahul', 1, 100);
INSERT INTO scores (user, game_number, game_score) VALUES ('rahul', 2, 150);
INSERT INTO scores (user, game_number, game_score) VALUES ('rahul', 3, 00);
SELECT avg(game_score) FROM scores WHERE user='rahul';
