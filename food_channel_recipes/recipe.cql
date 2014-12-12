USE test;

CREATE TABLE recipe (
	recipe_name text,
	avg_rating float,
	prep_time int,
	cook_time int,
	directions text,
	category list<text>,
	amount_ingredient map<text,text>,
	PRIMARY KEY (recipe_name)
);

CREATE TABLE recipes_by_ingredient (
	ingredient_name text,
	recipe_name text,
	amount text,
	avg_rating float,
	prep_time int,
	cook_time int,
	directions text,
	category list<text>,
	PRIMARY KEY (ingredient_name, recipe_name)
);

CREATE TABLE recipes_by_category (
	category text,
	recipe_name text,
	amount_ingredient map<text,text>,
	avg_rating float,
	prep_time int,
	cook_time int,
	directions text,
	PRIMARY KEY (category, recipe_name)
);

CREATE TABLE recipes_by_rating (
	avg_rating float,
	recipe_name text,
	prep_time int,
	cook_time int,
	amount_ingredient map<text,text>,
	directions text,
	category list<text>,
	PRIMARY KEY (avg_rating, recipe_name)
);

CREATE TABLE recipes_by_category_and_rating (
	recipe_name text,
	avg_rating float,
	prep_time int,
	cook_time int,
	directions text,
	category text,
	amount_ingredient map<text,text>,
	PRIMARY KEY (category, avg_rating)
);

CREATE TABLE reviews_by_recipe (
	recipe_name text,
	reviewid timestamp,
	rating int,
	title text,
	body text,
	username text,
	email text,
	PRIMARY KEY(recipe_name, reviewid)
);

CREATE TABLE reviews_by_user (
	username text,
	reviewid timestamp,
	recipe_name text,
	rating int,
	title text,
	body text,
	email text,
	PRIMARY KEY(username, reviewid)
);	