USE test;

CREATE TABLE recipes_in_meal (
	meal_name text,
	recipes list<text>,
	PRIMARY KEY (meal_name)
);

COPY recipes_in_meal (meal_name, recipes) FROM 'recipes_in_meal_entries.csv' WITH HEADER=True AND DELIMITER='|';
