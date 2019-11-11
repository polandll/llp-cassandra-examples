CREATE KEYSPACE IF NOT EXISTS cycling WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : 1 };
USE cycling;
DROP TABLE IF EXISTS cycling.race_starts;

// create a table with a frozen list of ints
// START-frozenlist
CREATE TABLE cycling.race_starts (cyclist_name text PRIMARY KEY, rnumbers FROZEN<LIST<int>>);
// END-frozenlist   
    
// View created table
DESCRIBE TABLE cycling.race_starts;

// Create index
// START-fullindex
CREATE INDEX rnumbers_idx ON cycling.race_starts (FULL(rnumbers));
// END-fullindex

// Insert data
INSERT INTO cycling.race_starts (cyclist_name, rnumbers) VALUES ('John DEGENKOLB', [39,7,14]);

// Select data with WHERE clause
// START-selectrnumbers
SELECT * FROM cycling.race_starts WHERE rnumbers = [39,7,14];
// END-selectrnumbers
