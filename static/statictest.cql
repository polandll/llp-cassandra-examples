USE test;

CREATE TABLE statictest (
	k text,
	s text STATIC,
	i int,
	PRIMARY KEY (k, i)
);
INSERT INTO statictest (k, s, i) VALUES ('k', 'first', 0);
INSERT INTO statictest (k, s, i) VALUES ('k', 'second', 1);