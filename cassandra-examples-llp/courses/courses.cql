USE test;
CREATE TABLE courses (
	name text,
	instructor text,
	location text, 
	PRIMARY KEY(name, instructor)
);


COPY courses (name,location,instructor) FROM 'courses_entries.csv' WITH HEADER=True;