USE test;

CREATE TABLE statictest2 (
	k text,
	s text,
	i int,
	PRIMARY KEY (k, i)
);
INSERT INTO statictest (k, s, i) VALUES ('k', 'first', 0);
INSERT INTO statictest (k, s, i) VALUES ('k', 'second', 1);