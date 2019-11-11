CREATE TABLE test.catfood (
	item_id int,
	brand text,
	flavor text,
	can_price float,
	PRIMARY KEY (item_id, flavor, can_price)
)
	WITH CLUSTERING ORDER BY (flavor ASC, can_price ASC);

