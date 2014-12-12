USE test;

CREATE TABLE recipes_by_category_static (
	category text,
	recipe_name text,
	amount_ingredient map<text,text>,
	avg_rating float,
	prep_time int,
	cook_time int,
	directions text STATIC,
	PRIMARY KEY (category, recipe_name)
);

COPY recipes_by_category_static 
	(category, recipe_name, avg_rating, prep_time, cook_time, directions, amount_ingredient)
FROM 'recipes_by_category_static_entries.csv'
WITH HEADER = 'true' AND DELIMITER = '|';