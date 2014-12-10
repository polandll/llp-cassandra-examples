USE test;

CREATE TABLE cuisine (
	cuisine text,
	meal_name text,
	type text,
	recipes list<text>,
	PRIMARY KEY (cuisine, meal_name)
);

COPY cuisine (meal_name, cuisine, type, recipes) FROM 'meal_entries.csv' WITH HEADER=True AND DELIMITER='|';
