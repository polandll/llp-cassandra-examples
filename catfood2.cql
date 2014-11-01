USE test;
CREATE TABLE catfood2 (
	item_id int,
	brand text,
	flavor text,
	can_price float,
	PRIMARY KEY (flavor, can_price, brand)
)
	WITH CLUSTERING ORDER BY (can_price ASC, brand ASC)
;
COPY catfood2 (item_id, brand, flavor, can_price) FROM 'catfood_entries.csv' WITH HEADER=True AND DELIMITER='|';