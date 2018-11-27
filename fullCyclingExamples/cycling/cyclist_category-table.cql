// Find cyclists that fit a particular category

source '0_create_keyspace.cql';


// CREATE TABLE CLUSTERING ORDER, PRIMARY KEY: PARTITION KEY + 1 CLUSTERING COLUMN, SIMPLE WHERE QUERY

DROP TABLE IF EXISTS cycling.cyclist_category;

// START-cpartitionkey
CREATE TABLE cycling.cyclist_category (
   category text,
   points int,
   id UUID,
   lastname text,
   PRIMARY KEY (category, points))
WITH CLUSTERING ORDER BY (points DESC);
// END-cpartitionkey


INSERT INTO cycling.cyclist_category (category, points, id, lastname) VALUES ('GC',1269,220844bf-4860-49d6-9a4b-6b5d3a79cbfb,'TIRALONGO');
INSERT INTO cycling.cyclist_category (category, points, id, lastname) VALUES ('One-day-races',367,220844bf-4860-49d6-9a4b-6b5d3a79cbfb,'TIRALONGO');
INSERT INTO cycling.cyclist_category (category, points, id, lastname) VALUES ('Time-trial',182,220844bf-4860-49d6-9a4b-6b5d3a79cbfb,'TIRALONGO');
INSERT INTO cycling.cyclist_category (category, points, id, lastname) VALUES ('Sprint',0,220844bf-4860-49d6-9a4b-6b5d3a79cbfb,'TIRALONGO');
INSERT INTO cycling.cyclist_category (category, points, id, lastname) VALUES ('GC',1324,6ab09bec-e68e-48d9-a5f8-97e6fb4c9b47,'KRUIJSWIJK');
INSERT INTO cycling.cyclist_category (category, points, id, lastname) VALUES ('One-day-races',198,6ab09bec-e68e-48d9-a5f8-97e6fb4c9b47,'KRUIJSWIJK');
INSERT INTO cycling.cyclist_category (category, points, id, lastname) VALUES ('Sprint',39,6ab09bec-e68e-48d9-a5f8-97e6fb4c9b47,'KRUIJSWIJK');
INSERT INTO cycling.cyclist_category (category, points, id, lastname) VALUES ('Time-trial',3,6ab09bec-e68e-48d9-a5f8-97e6fb4c9b47,'KRUIJSWIJK');

// START-rows
RESTRICT ROWS ON cycling.cyclist_category USING category;
// END-rows
