USE test;

CREATE TABLE recipe (
	recipe_name text,
	ingredient_name text,
	instructions text,
	ingredient_amount map<text,text>,
	PRIMARY KEY (recipe_name, ingredient_name)
);

COPY recipe (recipe_name, ingredient_name, instructions, ingredient_amount) FROM 'recipe_entries.csv' WITH HEADER=True AND DELIMITER='|';re