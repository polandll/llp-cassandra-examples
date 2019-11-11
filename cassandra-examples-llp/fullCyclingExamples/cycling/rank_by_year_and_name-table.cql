source '0_create_keyspace.cql';

DROP TABLE IF EXISTS cycling.rank_by_year_and_name;

// Store race information by year and race name using a COMPOSITE PARTITION KEY

// START-compositepk
CREATE TABLE cycling.rank_by_year_and_name (
   race_year int,
   race_name text,
   cyclist_name text,
   rank int,
   PRIMARY KEY ((race_year, race_name), rank) );
// END-compositepk

INSERT INTO cycling.rank_by_year_and_name (race_year, race_name, cyclist_name, rank) VALUES (2015, 'Tour of Japan - Stage 4 - Minami > Shinshu', 'Benjamin PRADES', 1);
INSERT INTO cycling.rank_by_year_and_name (race_year, race_name, cyclist_name, rank) VALUES (2015, 'Tour of Japan - Stage 4 - Minami > Shinshu', 'Adam PHELAN', 2);
INSERT INTO cycling.rank_by_year_and_name (race_year, race_name, cyclist_name, rank) VALUES (2015, 'Tour of Japan - Stage 4 - Minami > Shinshu', 'Thomas LEBAS', 3);
INSERT INTO cycling.rank_by_year_and_name (race_year, race_name, cyclist_name, rank) VALUES (2014, 'Tour of Japan - Stage 4 - Minami > Shinshu', 'Benjamin PRADES', 3);
INSERT INTO cycling.rank_by_year_and_name (race_year, race_name, cyclist_name, rank) VALUES (2014, 'Tour of Japan - Stage 4 - Minami > Shinshu', 'Daniel MARTIN', 1);
INSERT INTO cycling.rank_by_year_and_name (race_year, race_name, cyclist_name, rank) VALUES (2014, 'Tour of Japan - Stage 4 - Minami > Shinshu', 'Johan Esteban CHAVES', 2);
INSERT INTO cycling.rank_by_year_and_name (race_year, race_name, cyclist_name, rank) VALUES (2015, 'Giro d''Italia - Stage 11 - Forli > Imola', 'Ilnur ZAKARIN', 1);
INSERT INTO cycling.rank_by_year_and_name (race_year, race_name, cyclist_name, rank) VALUES (2015, 'Giro d''Italia - Stage 11 - Forli > Imola', 'Carlos BETANCUR', 2);
INSERT INTO cycling.rank_by_year_and_name (race_year, race_name, cyclist_name, rank) VALUES (2014, '4th Tour of Beijing', 'Phillippe GILBERT', 1);
INSERT INTO cycling.rank_by_year_and_name (race_year, race_name, cyclist_name, rank) VALUES (2014, '4th Tour of Beijing', 'Daniel MARTIN', 2);
INSERT INTO cycling.rank_by_year_and_name (race_year, race_name, cyclist_name, rank) VALUES (2014, '4th Tour of Beijing', 'Johan Esteban CHAVES', 3);
INSERT INTO cycling.rank_by_year_and_name (race_year, race_name, cyclist_name, rank) VALUES (2014, '4th Tour of Beijing', 'Phillippe GILBERT', 1);
INSERT INTO cycling.rank_by_year_and_name (race_year, race_name, cyclist_name, rank) VALUES (2014, '4th Tour of Beijing', 'Daniel MARTIN', 2);
INSERT INTO cycling.rank_by_year_and_name (race_year, race_name, cyclist_name, rank) VALUES (2014, '4th Tour of Beijing', 'Johan Esteban CHAVES', 3);

// Show all inserted data
SELECT *  FROM cycling.rank_by_year_and_name ;

// Query by partition
// START-partlimit
SELECT * 
FROM cycling.rank_by_year_and_name 
PER PARTITION LIMIT 2;
// END-partlimit

// START-dropindex
DROP INDEX IF EXISTS cycling.rank_idx ;
// END-dropindex

//START-createindex
CREATE INDEX rank_idx ON cycling.rank_by_year_and_name (rank);
//END-createindex

// Select rank - filter on a clustering column 

// START-selectrank
SELECT * FROM cycling.rank_by_year_and_name WHERE rank=1;
// END-selectrank