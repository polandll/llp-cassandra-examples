USE test;

CREATE TABLE recipe_by_ingredient (
	recipe_name text,
	ingredient_name text,
	amount text,
	instructions text STATIC,
	PRIMARY KEY (ingredient_name, amount, recipe_name)
);

COPY recipe_by_ingredient (recipe_name, ingredient_name, amount) FROM 'recipe_entries.csv' WITH HEADER=True AND DELIMITER='|';