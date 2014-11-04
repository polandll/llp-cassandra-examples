USE test;

CREATE TABLE videolist (
	title text,
	url text,
	rating int,
	PRIMARY KEY (title,url)
);
