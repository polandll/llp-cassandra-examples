source '0_create_keyspace.cql';

DROP TABLE IF EXISTS cycling.cyclist_races;

// Find all races for a particular cyclist
// CREATE TYPE - User-Defined Type, race
// CREATE TABLE WITH LIST, SIMPLE PRIMARY KEY
SOURCE 'race-type.cql';

CREATE TABLE cycling.cyclist_races (
  id UUID PRIMARY KEY,
  lastname text,
  firstname text,
  races list<FROZEN <race>> );

source 'cyclist_races-table-data.cql';

ALTER TABLE cycling.cyclist_races 
  ADD completed list<text>;
