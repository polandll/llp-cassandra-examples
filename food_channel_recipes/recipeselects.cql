USE test;

SELECT * FROM recipe;
SELECT recipe_name, ingredient_name FROM recipes_by_ingredient WHERE ingredient_name='beef';
SELECT recipe_name, ingredient_name FROM recipes_by_ingredient WHERE ingredient_name='onion';
SELECT recipe_name, category FROM recipes_by_category WHERE category='Easy';
SELECT recipe_name, category FROM recipes_by_category WHERE category='German';
SELECT recipe_name, avg_rating FROM recipes_by_rating WHERE avg_rating=4.0;
SELECT recipe_name, category, avg_rating FROM recipes_by_category_and_rating WHERE category='Mexican' AND avg_rating > 4.1;
SELECT recipe_name, rating, title, body, username FROM reviews_by_recipe WHERE recipe_name='Easy Beef Enchiladas';
SELECT recipe_name, rating, title, body, username FROM reviews_by_user WHERE username='janesmith';
SELECT recipe_name, rating, title, body, username FROM reviews_by_user WHERE username='johndoe';