USE test;

COPY recipe
	(recipe_name, avg_rating, prep_time, cook_time, directions, category, amount_ingredient)
FROM 'recipes_entries.csv'
WITH HEADER = 'true' AND DELIMITER = '|';

COPY recipes_by_ingredient 
	(ingredient_name, recipe_name, amount, avg_rating, prep_time, cook_time, directions, category)
FROM 'recipes_by_ingredient_entries.csv'
WITH HEADER = 'true' AND DELIMITER = '|';

COPY recipes_by_category 
	(category, recipe_name, avg_rating, prep_time, cook_time, directions, amount_ingredient)
FROM 'recipes_by_category_entries.csv'
WITH HEADER = 'true' AND DELIMITER = '|';

COPY recipes_by_rating
	(avg_rating, recipe_name, prep_time, cook_time, directions, amount_ingredient, category)
FROM 'recipes_by_rating_entries.csv'
WITH HEADER = 'true' AND DELIMITER = '|';

COPY recipes_by_category_and_rating
(recipe_name, avg_rating, prep_time, cook_time, directions, category, amount_ingredient)
FROM 'recipes_by_category_and_rating_entries.csv'
WITH HEADER = 'true' AND DELIMITER = '|';

COPY reviews_by_recipe
	(recipe_name, reviewid, rating, title, body, username, email)
FROM 'reviews_by_recipe_entries.csv'
WITH HEADER = 'true' AND DELIMITER = '|';

COPY reviews_by_user
	(recipe_name, reviewid, rating, title, body, username, email)
FROM 'reviews_by_user_entries.csv'
WITH HEADER = 'true' AND DELIMITER = '|';
