CREATE TABLE test.catfood2 (
	item_id int,
	brand text,
	flavor text,
	can_price float,
	PRIMARY KEY (flavor, can_price, brand)
)
	WITH CLUSTERING ORDER BY (can_price ASC, brand ASC);
