USE test;

CREATE TABLE meal (
	meal_name text,
	cuisine text,
	type text,
	recipes list<text>,
	PRIMARY KEY (meal_name, cuisine, type)
);

CREATE INDEX meals_by_cuisine ON meal (cuisine);
CREATE INDEX meals_by_type ON meal (type);
CREATE INDEX recipes_in_meal ON meal (recipes);

COPY meal (meal_name, cuisine, type, recipes) FROM 'meal_entries.csv' WITH HEADER=True AND DELIMITER='|';
