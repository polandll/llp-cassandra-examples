CREATE KEYSPACE test WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : 2 };

USE test;

COPY p_catfood (item_id, brand, type,flavor, can_price, can_volume) FROM '~/cassandra-example-code-LLP/PRACTICUM/p_catfood_entries.csv' WITH HEADER=True AND DELIMITER='|';
