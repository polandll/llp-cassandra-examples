USE test;

CREATE TABLE meal_by_cuisine (
	cuisine text,
	meal_name text,
	type text,
	recipes list<text>,
	PRIMARY KEY (cuisine, meal_name)
);

COPY meal_by_cuisine (meal_name, cuisine, type, recipes) FROM 'meal_entries.csv' WITH HEADER=True AND DELIMITER='|';
