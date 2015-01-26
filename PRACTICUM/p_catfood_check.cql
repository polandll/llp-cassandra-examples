CREATE KEYSPACE test WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : 2 };

USE test;

CREATE TABLE p_catfood (
   item_id int,
   brand text,
   type text,
   flavor text,
   can_price float,
   can_volume float,  
   PRIMARY KEY (flavor, can_price, brand)
) WITH CLUSTERING ORDER BY (can_price ASC, brand ASC);

COPY p_catfood (item_id, brand, type,flavor, can_price, can_volume) FROM 'p_catfood_entries.csv' WITH HEADER=True AND DELIMITER='|';
CAPTURE '~/cassandra-example-code-LLP/PRACTICUM/output.txt'
SELECT brand,type,can_price FROM p_catfood WHERE flavor='chicken' AND can_price > 1.25 AND can_price < 1.55;
