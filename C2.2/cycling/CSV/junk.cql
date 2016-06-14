CREATE TABLE IF NOT EXISTS cycling.cyclist_category ( category text, points int, id int, lastname text, PRIMARY KEY (category, points, id)) WITH CLUSTERING ORDER BY (points DESC);
COPY cycling.cyclist_category FROM '~/CLONES/cassandra-examples/C2.2/cycling/csv/cyclist_category.csv' WITH HEADER='true' AND DELIMITER='|';
SELECT * FROM cycling.cyclist_category;
SELECT lastname, points FROM cycling.cyclist_category WHERE category = 'One-day-races';
