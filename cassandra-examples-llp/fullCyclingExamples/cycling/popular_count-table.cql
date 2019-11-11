SOURCE '0_create_keyspace.cql';

CREATE TABLE IF NOT EXISTS cycling.popular_count ( id UUID PRIMARY KEY, popularity counter );

// START-batch
BEGIN COUNTER BATCH
UPDATE cycling.popular_count SET popularity = popularity + 1 WHERE id = 6ab09bec-e68e-48d9-a5f8-97e6fb4c9b47;
UPDATE cycling.popular_count SET popularity = popularity + 125 WHERE id = 6ab09bec-e68e-48d9-a5f8-97e6fb4c9b47;
UPDATE cycling.popular_count SET popularity = popularity - 64 WHERE id = 6ab09bec-e68e-48d9-a5f8-97e6fb4c9b47;
APPLY BATCH;
// END-batch

// START-count
UPDATE cycling.popular_count 
SET popularity = popularity + 2 
WHERE id = 6ab09bec-e68e-48d9-a5f8-97e6fb4c9b47;
// END-count