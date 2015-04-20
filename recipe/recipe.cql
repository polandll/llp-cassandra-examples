USE test;

CREATE TABLE recipe (
	recipe_name text,
	ingredient_name text,
	amount text,
	instructions text STATIC,
	PRIMARY KEY (recipe_name, ingredient_name)
);

COPY recipe (recipe_name, ingredient_name, amount) FROM 'recipe_entries.csv' WITH HEADER=True AND DELIMITER='|';
