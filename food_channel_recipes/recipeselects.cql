USE test;

SELECT * FROM recipe;
SELECT recipe_name FROM recipes_by_ingredient WHERE ingredient_name='beef';
SELECT recipe_name FROM recipes_by_ingredient WHERE ingredient_name='onion';
SELECT recipe_name FROM recipes_by_category WHERE category='Easy';
SELECT recipe_name FROM recipes_by_category WHERE category='German';
SELECT recipe_name, rating, title, body, username FROM reviews_by_recipe WHERE recipe_name='Easy Beef Enchiladas';
SELECT recipe_name, rating, title, body, username FROM reviews_by_author WHERE username='janesmith';
SELECT recipe_name, rating, title, body, username FROM reviews_by_author WHERE username='johndoe';