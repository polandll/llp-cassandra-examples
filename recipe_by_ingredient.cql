USE test;

CREATE TABLE recipe_by_ingredient (
	recipe_name text,
	ingredient_name text,
	amount text,
	instructions text,
	PRIMARY KEY (ingredient_name, recipe_name)
);

COPY recipe_by_ingredient (recipe_name, ingredient_name, amount) FROM 'recipe_entries.csv' WITH HEADER=True AND DELIMITER='|';
