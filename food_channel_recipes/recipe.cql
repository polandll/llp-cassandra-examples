USE test;

CREATE TABLE recipe (
	recipe_name text,
	avg_rating int,
	prep_time int,
	cook_time int,
	directions text,
	category list<text,text>,
	PRIMARY KEY (recipe_name)
);

CREATE TABLE recipes_by_ingredient (
	ingredient_name text,
	recipe_name text,
	amount text,
	avg_rating int,
	prep_time int,
	cook_time int,
	directions text,
	category list<text,text>,
	PRIMARY KEY (ingredient_name, recipe_name)
);

CREATE TABLE recipes_by_category (
	category text,
	recipe_name text,
	amount_ingredient map<text,text>,
	avg_rating int,
	prep_time int,
	cook_time int,
	directions text,
	PRIMARY KEY (category, recipe_name)
);

CREATE TABLE reviews_by_recipe (
	recipe_name text,
	reviewid timeuuid,
	rating int,
	title text,
	body text,
	username text,
	email text,
	PRIMARY KEY(recipe_name, reviewid)
);

CREATE TABLE reviews_by_author (
	username text,
	reviewid timeuuid,
	recipe_name text,
	rating int,
	title text,
	body text,
	username text,
	email text,
	PRIMARY KEY(author, reviewid)
);	


COPY recipe (recipe_name, avg_rating, prep_time, cook_time, directions, category) FROM 'recipe_food_entries.csv' WITH HEADER=True AND DELIMITER='|';