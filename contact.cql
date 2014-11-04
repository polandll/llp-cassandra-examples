USE test;
CREATE TABLE contact (
	firstname text,
	lastname text,
	state text,
	age int,
	PRIMARY KEY(firstname,lastname,state)
);

COPY contact (firstname,lastname,state) FROM 'contact_entries.csv';